COMBAT_TURN = 0;
CURRENT_UNIT = "none";

THREAD_LIMIT = 50;
THREAD_STATE = 0;
THREAD_FINISHER = THREAD_LIMIT;

NO_COST = 0;
FREE_MANA = 99;

TRIGGER_LIMIT_PER_COMBAT = {
    ["Duncan"]=0,
    ["Orrin"]=0,
    ["Markal"]=0,
    ["Axel"]=0,
    ["RedHeavenHero03"]=0,
    ["Ossir"]=0,
}

function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id0 then
            setATB(cr,1);
        elseif GetCreatureType(cr) == id1 then
            setATB(cr,1);
        elseif GetCreatureType(cr) == id2 then
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

function UnitRandomShoot(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id0 then
            ShootCombatUnit(cr,RandomCreature(1-side,i));
            setATB(cr,0);
        elseif GetCreatureType(cr) == id1 then
            ShootCombatUnit(cr,RandomCreature(1-side,i));
            setATB(cr,0);
        elseif GetCreatureType(cr) == id2 then
            ShootCombatUnit(cr,RandomCreature(1-side,i));
            setATB(cr,0);
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
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,target);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_RandomAlly(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_RandomEnnemy(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(1-side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_RandomEnnemyArea(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    local x,y = GetUnitPosition(RandomCreature(1-side,mana+COMBAT_TURN));
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_Area(hero,spell,x,y,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_Global(hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetUnitManaPoints(hero,FREE_MANA) end;
    startThread(DoCastGlobalSpell,hero,spell,required);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetUnitManaPoints(hero,mana) end;
end;

function SiphonEnnemyMana(hero_id,side)
    local ennemies = GetUnits(1-side,CREATURE);
    local amount = 0;
    for i,en in ennemies do
        local mana = GetUnitManaPoints(en);
        SetUnitManaPoints(en,0);
        amount = amount + mana;
    end;
    local hero_mana = GetUnitManaPoints(hero_id);
    local hero_max_mana = GetUnitMaxManaPoints(hero_id);
    hero_mana = hero_mana + amount;
    if (hero_mana > hero_max_mana) then
        SetUnitManaPoints(hero_id,hero_max_mana);
    else
        SetUnitManaPoints(hero_id,hero_mana);
    end;
end;

--------------------------------------------------------------------------

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
        SetUnitManaPoints(hero_id,m);
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
    -- Fortress
    if hero_name == "Skeggy" then
        print("Trigger spearwielders random shoot !")
        UnitRandomShoot(side,94,95,167);
    end;
end;

function TriggerHeroSpe_Turn(side,hero_name,hero_id,unit)
    if TRIGGER_LIMIT_PER_COMBAT[hero_name] then
        if TRIGGER_LIMIT_PER_COMBAT[hero_name] == 0 then
            return nil;
        end;
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
    -- Inferno
    if hero_name == "toto" and hero_id == unit then
        print("Trigger random Fireball !")
        HeroCast_RandomEnnemyArea(side,hero_id,5,FREE_MANA);
    end;
end;


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
    end;
end;
















function RandomCreature(side, seed)
    local creatures = GetUnits(side,CREATURE);
    local stacks = length(ennemies);
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
