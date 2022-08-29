COMBAT_TURN = 0;
CURRENT_UNIT = "none";

THREAD_LIMIT = 50;
THREAD_STATE = 0;
THREAD_FINISHER = THREAD_LIMIT;

NO_COST = 0;
FREE_MANA = 99;

TRIGGER_LIMIT_PER_COMBAT = {
    ["RedHeavenHero01"]=-1,
    ["Maeve"]=-1,
    ["Jeddite"]=-1,
    ["Minasli"]=-1,
    ["Rissa"]=-1,
    ["Gles"]=-1,
    ["Straker"]=-1,
    ["Giovanni"]=-1,
    ["Sheltem"]=-1,
    ["Calid2"]=-1,
    ["Agrael"]=-1,
    ["Deleb"]=-1,
} -- -1 means no limit

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function RandomCreature(side, seed)
    local creatures = GetUnits(side,CREATURE);
    local stacks = length(creatures);
    local target = 0;
    if stacks >= 2 then target = random(0,stacks-1,seed) end;
    return creatures[target];
end;

function Wait()
    sleep(1);
    THREAD_FINISHER = THREAD_FINISHER - 1;
    -- print("Thread finisher = "..THREAD_FINISHER);
    if THREAD_FINISHER == 0 then THREAD_STATE = 1 end;
end;

function SetMana(unit,mana)
    repeat
        SetUnitManaPoints(unit,mana);
        sleep(1);
    until GetUnitManaPoints(unit) == mana;
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            setATB(cr,1);
        else
            setATB(cr,0);
        end;
    end;
    local ennemies = GetUnits(1-side,CREATURE);
    for i,en in ennemies do
        setATB(en,0);
    end;
    setATB(GetHero(side),0);
    if GetHero(1-side) then setATB(GetHero(1-side),0) end;
end;

function UnitPlayNext_Creature(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            setATB(cr,0.99);
        end;
    end;
end;

function UnitPlayNext_WarMachine(side,type)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == type then
            setATB(wm,0.99);
        end;
    end;
end;

function UnitRandomShoot(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            ShootCombatUnit(cr,RandomCreature(1-side,i));
            setATB(cr,0);
        end;
    end;
end;

function UnitCast_RandomEnnemy(side,id0,id1,id2,spell)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            UnitCastAimedSpell(cr,spell,RandomCreature(1-side,i));
            setATB(cr,0);
        end;
    end;
end;

function UnitSpecialAbility(side,id0,id1,id2,ability)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            UseCombatAbility(cr,ability);
        end;
    end;
end;

function BallistaTargetShoot(side,target)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
            ShootCombatUnit(wm,target);
            setATB(wm,0);
        end;
    end;
end;

function BallistaRandomShoot(side)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
            ShootCombatUnit(wm,RandomCreature(1-side,nil));
        end;
    end;
end;

function SummonStack(side,id,amount,offset)
    local x,y;
    if (side == 0) then x=2+offset else x=13-offset end;
    -- y = 10;
    if amount == 0 then amount = 1 end;
    SummonCreature(side,id,amount,x);
    sleep(1);
end;

function SummonCopy(side,id0,id1,id2)
    local largest = 0;
    local copied_stack = "none";
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        local nb = GetCreatureNumber(cr);
        if id == id0 or id == id1 or id == id2 then
            if nb > largest then
                largest = nb;
                copied_stack = cr;
            end;
        end;
    end;
    if IsCombatUnit(copied_stack) then
        local x,y = GetUnitPosition(copied_stack);
        SummonCreature(side,GetCreatureType(copied_stack),largest,x,y+1);
        sleep(1);
    end;
end;

function DoCastTargetSpell(unit,spell,mana,target)
    repeat sleep(1) until GetUnitManaPoints(unit) >= mana;
	UnitCastAimedSpell(unit,spell,target);
	THREAD_STATE = 1;
end;

function DoCastAreaSpell(unit,spell,mana,x,y)
    repeat sleep(1) until GetUnitManaPoints(unit) >= mana;
	UnitCastAreaSpell(unit,spell,x,y)
	THREAD_STATE = 1;
end;

function DoCastGlobalSpell(unit,spell,mana)
    repeat sleep(1) until GetUnitManaPoints(unit) >= mana;
	UnitCastGlobalSpell(unit,spell);
	THREAD_STATE = 1;
end;

function HeroCast_Target(hero,spell,required,target)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,target);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_AllEnnemies(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    local ennemies = GetUnits(1-side,CREATURE);
    for i,en in ennemies do
        if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
        startThread(DoCastTargetSpell,hero,spell,required,en);
        repeat Wait() until THREAD_STATE == 1;
        THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    end;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomAlly(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomEnnemy(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(1-side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomEnnemyArea(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    local x,y = GetUnitPosition(RandomCreature(1-side,mana+COMBAT_TURN));
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_Area(hero,spell,x,y,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_Global(hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastGlobalSpell,hero,spell,required);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroAttack_RandomEnnemy(side)
    SetControlMode(side,MODE_AUTO);
    sleep(1);
    SetControlMode(side,MODE_MANUAL);
    SetControlMode(side,MODE_NORMAL);
end;

function SiphonEnnemyMana(hero_id,side)
    local ennemies = GetUnits(1-side,CREATURE);
    local amount = 0;
    for i,en in ennemies do
        local mana = GetUnitManaPoints(en);
        SetMana(en,0);
        amount = amount + mana;
    end;
    local hero_mana = GetUnitManaPoints(hero_id);
    local hero_max_mana = GetUnitMaxManaPoints(hero_id);
    hero_mana = hero_mana + amount;
    if (hero_mana > hero_max_mana) then
        SetMana(hero_id,hero_max_mana);
    else
        SetMana(hero_id,hero_mana);
    end;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function TriggerHeroSpe_Start(side,hero_name,hero_id)
    -- Haven
    if hero_name == "Duncan" then
        print("Trigger ballista random shoot !")
        BallistaRandomShoot(side);
    end;
    if hero_name == "Orrin" then
        print("Trigger archers atb boost !")
        UnitPlayFirst(side,3,4,107);
    end;
    if hero_name == "Markal" then
        print("Trigger cast Mass Confusion !")
        HeroCast_Global(hero_id,213,FREE_MANA);
    end;
    if hero_name == "Axel" then
        print("Trigger cast Prayer !")
        HeroCast_Global(hero_id,54,NO_COST);
    end;
    if hero_name == "RedHeavenHero03" then
        print("Trigger cast Blade Barriers !")
        local m = GetUnitManaPoints(hero_id);
        local x = 10 - 5 * side;
        for y=2,9 do
            HeroCast_Area(hero_id,284,x,y,FREE_MANA);
            HeroCast_Area(hero_id,284,x-1+side*2,11-y,FREE_MANA);
        end;
        SetMana(hero_id,m);
    end;
    -- Preserve
	if hero_name == "Ossir" then
        print("Trigger hunters random shoot !")
        UnitRandomShoot(side,47,48,147);
    end;
    if hero_name == "Vaniel" then
        print("Trigger hero cast Mass Haste !")
        HeroCast_Global(hero_id,221,FREE_MANA);
    end;
    if hero_name == "Ildar" then
        print("Trigger elder druids summoning !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.1;
        SummonStack(side,50,trunc(0.5*m*m),0);
    end;
    if hero_name == "Gem" then
        print("Trigger siphon mana !")
        SiphonEnnemyMana(hero_id,side);
    end;
    -- Academy
    if hero_name == "Isher" then
        print("Trigger copy largest golems group !")
        SummonCopy(side,61,62,161);
    end;
    if hero_name == "Davius" then
        print("Trigger rakshasas dash !")
        UnitSpecialAbility(side,67,68,164,176);
    end;
    if hero_name == "Gurvilin" then
        print("Trigger disrupting rays !")
        HeroCast_AllEnnemies(side,hero_id,13,FREE_MANA);
    end;
    if hero_name == "Zehir" then
        print("Trigger summon elementals !")
        HeroCast_Global(hero_id,43,FREE_MANA);
    end;
    if hero_name == "Emilia" then
        print("Trigger summon beehives !")
        local x = 13 - 11 * side;
        HeroCast_Area(hero_id,283,x,1,FREE_MANA);
        HeroCast_Area(hero_id,283,x,10,FREE_MANA);
    end;
    if hero_name == "Cyrus" then
        print("Trigger mages magic fist !")
        UnitCast_RandomEnnemy(side,63,64,162,2);
    end;
    if hero_name == "Astral" then
        print("Trigger random arcane crystals !")
        local m = trunc(GetUnitManaPoints(hero_id) * 0.05);
        local x1 = 13 - 11 * side;
        local x2 = 9 - 3 * side;
        for i = 1,m do
            startThread(UnitCastAreaSpell,hero_id,282,random(x1,x2,m),random(1,10,i));
        end;
    end;
    -- Fortress
    if hero_name == "Skeggy" then
        print("Trigger spearwielders random shoot !")
        UnitRandomShoot(side,94,95,167);
    end;
    -- Necropolis
    if hero_name == "Pelt" then
        print("Trigger summon and kill skeleton !")
        local n = length(GetUnits(1-side,CREATURE));
        SummonStack(1-side,152,1,5);
        repeat sleep(10) until length(GetUnits(1-side,CREATURE)) == n+1;
        HeroCast_Target(hero_id,1,FREE_MANA,GetUnits(1-side,CREATURE)[n]);
    end;
    if hero_name == "Archilus" then
        print("Trigger summon avatar of death !")
        HeroCast_Global(hero_id,200,FREE_MANA);
    end;
    if hero_name == "Aislinn" then
        print("Trigger cast mass weakness !")
        HeroCast_Global(hero_id,210,FREE_MANA);
    end; 
    if hero_name == "Vidomina" then
        print("Trigger random sorrow")
        local e = GetUnits(1-side,CREATURE);
        local m = GetUnitMaxManaPoints(hero_id) * 0.02;
        local n = min(length(e),1+trunc(m));
        for i = 1,n do
            HeroCast_Target(hero_id,277,FREE_MANA,e[i-1]);
        end;
    end;
    if hero_name == "Muscip" then
        print("Trigger duplicate ghosts !")
        for i,cr in GetUnits(side,CREATURE) do
            local id = GetCreatureType(cr);
            if id == 33 or id == 34 or id == 154 then
                local nb = GetCreatureNumber(cr);
                local x,y = GetUnitPosition(cr);
                SummonCreature(side,id,nb,x);
                sleep(1);
            end;
        end;
    end;
    -- Inferno
    if hero_name == "Jazaz" then
        print("Trigger mark of the damned")
        HeroCast_RandomEnnemy(side,hero_id,56,NO_COST);
    end;
    if hero_name == "Efion" then
        print("Trigger random blindness !")
        HeroCast_RandomEnnemy(side,hero_id,19,FREE_MANA);
    end;
    if hero_name == "Biara" then
        print("Trigger succubus random shoot !")
        UnitRandomShoot(side,21,22,134);
    end;
    if hero_name == "Sovereign" then
        print("Trigger pit lords summoning !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.1;
        SummonStack(side,26,trunc(0.1*m*m),0);
        SummonStack(side,26,trunc(0.1*m*m),0);
    end;
    if hero_name == "Deleb" then
        print("Trigger mine fields !")
        local x = 10 - 5 * side;
        HeroCast_Area(hero_id,38,x,3,FREE_MANA);
        HeroCast_Area(hero_id,38,x,8,FREE_MANA);
    end;
end;

function TriggerHeroSpe_Turn(side,hero_name,hero_id,unit)
    if TRIGGER_LIMIT_PER_COMBAT[hero_name] then
        if TRIGGER_LIMIT_PER_COMBAT[hero_name] == 0 then
            return nil;
        end;
    else
        return nil;
    end;
    -- Haven
    if hero_name == "RedHeavenHero01" and hero_id == unit then
        print("Trigger random stoneskin or deflect arrows !")
        local unit = RandomCreature(side,COMBAT_TURN);
        HeroCast_Target(hero_id,25,FREE_MANA,unit);
        HeroCast_Target(hero_id,29,FREE_MANA,unit);
        setATB(hero_id,1);
    end;
    if hero_name == "Maeve" and hero_id == unit then
        print("Trigger random Encourage !")
        HeroCast_RandomAlly(side,hero_id,52,NO_COST);
        setATB(hero_id,1);
    end;
    if hero_name == "Jeddite" and hero_id == unit then
        print("Trigger random Vampirism !")
        local m = GetUnitManaPoints(hero_id);
        if m >= 100 then
            HeroCast_RandomAlly(side,hero_id,278,NO_COST);
            setATB(hero_id,1);
        end;
    end;
    -- Academy
    if hero_name == "Minasli" and hero_id == unit then
        print("Trigger fire ballista ATB boost !")
        UnitPlayNext_WarMachine(side,WAR_MACHINE_BALLISTA);
    end;
    if hero_name == "Rissa" and hero_id == unit then
        print("Trigger random Slow !")
        local m = GetUnitManaPoints(hero_id);
        if m >= 20 then
            HeroCast_RandomEnnemy(side,hero_id,12,NO_COST);
            setATB(hero_id,1);
        end;
    end;
    -- Necropolis
    if hero_name == "Gles" and hero_id == unit then
        print("Trigger random Plague !")
        HeroCast_RandomEnnemy(side,hero_id,14,FREE_MANA);
        setATB(hero_id,1);
    end;
    if hero_name == "Straker" and hero_id == unit then
        print("Trigger summon zombies !")
        local m = GetUnitMaxManaPoints(hero_id);
        SummonCreature(side,32,m);
        setATB(hero_id,1);
    end;
    if hero_name == "Giovanni" and hero_id == unit then
        print("Trigger random Ice Bolt !")
        HeroCast_RandomEnnemy(side,hero_id,4,FREE_MANA);
        setATB(hero_id,1);
    end;
    -- Inferno
    -- if hero_name == "Jazaz" and hero_id == unit then
    --     print("Trigger hero random attack !")
    --     HeroAttack_RandomEnnemy(side);
    --     sleep(10);
    --     setATB(hero_id,1);
    -- end;
    if hero_name == "Agrael" and hero_id ~= unit then
        local id = GetCreatureType(unit);
        if id ~= nil then
            if (id >= 15 and id <= 28) or (id >= 131 and id <= 137) then
                print("Trigger creature explosion !")
                local x,y = GetUnitPosition(unit);
                UnitCastAreaSpell(unit,162,x,y);
                setATB(unit,1);
            end;
        end;
    end;
    if hero_name == "Deleb" and hero_id == unit then
        print("Trigger random Stone spikes !")
        HeroCast_RandomEnnemyArea(side,hero_id,237,FREE_MANA);
        setATB(hero_id,1);
    end;
    if hero_name == "Calid2" and hero_id == unit then
        print("Trigger random Fireball !")
        HeroCast_RandomEnnemyArea(side,hero_id,5,FREE_MANA);
    end;
end;

function TriggerHeroSpe_EnnemyTurn(side,hero_name,hero_id,unit)
    if TRIGGER_LIMIT_PER_COMBAT[hero_name] then
        if TRIGGER_LIMIT_PER_COMBAT[hero_name] == 0 then
            return nil;
        end;
    else
        return nil;
    end;
    -- Inferno
    if hero_name == "Sheltem" then
        print("Trigger fireball ballista shoot !")
        BallistaTargetShoot(1-side,unit);
    end;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function CombatStartSpecials()
	if GetHero(ATTACKER) then
		local attacker_id = GetAttackerHero();
		local attacker = GetHeroName(attacker_id);
		TriggerHeroSpe_Start(ATTACKER,attacker,attacker_id);
	end;
	if GetHero(DEFENDER) then
		local defender_id = GetDefenderHero(); 
		local defender = GetHeroName(defender_id);
		TriggerHeroSpe_Start(DEFENDER,defender,defender_id);
	end;
end;

function UnitMoveSpecials(unit)
    if CURRENT_UNIT ~= unit then
        CURRENT_UNIT = unit;
        COMBAT_TURN = COMBAT_TURN + 1;

        local side = nil;
        if IsAttacker(unit) then side = ATTACKER else side = DEFENDER end;
    
        if GetHero(side) then
            local hero_id = GetHero(side);
            local hero_name = GetHeroName(hero_id);
            TriggerHeroSpe_Turn(side,hero_name,hero_id,unit);
        end;
        if GetHero(1-side) then
            local hero_id = GetHero(1-side);
            local hero_name = GetHeroName(hero_id);
            TriggerHeroSpe_EnnemyTurn(side,hero_name,hero_id,unit);
        end;
    end;
end;

