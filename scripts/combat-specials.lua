COMBAT_READY = nil
COMBAT_TURN = 0;
CURRENT_UNIT = "none";

THREAD_LIMIT = 50;
THREAD_STATE = 0;
THREAD_FINISHER = THREAD_LIMIT;

GRID_X_MIN = 2;
GRID_X_MAX = 15;
GRID_Y_MIN = 1;
GRID_Y_MAX = 12;

NO_COST = 0;
FREE_MANA = 99;

NO_ATB_RESET_HEROES = {
    [HERO] = { H_BERTRAND,H_FINDAN,H_NEBIROS,H_KRAGH },
    [CREATURE] = { H_WYNGAAL,H_CRAGHACK },
    [WAR_MACHINE] = { },
};

TRIGGER_LIMIT_PER_COMBAT = {
    [H_ANDREAS]=-1,
    [H_MAEVE]=-1,
    ["Jeddite"]=-1,
    [H_TALANAR]=-1,
    [H_FINDAN]=-1,
    [H_ALARON]=-1,
    [H_IVOR]=-1,
    [H_MINASLI]=-1,
    [H_RISSA]=-1,
    [H_KASPAR]=-1,
    [H_ORSON]=-1,
    [H_GIOVANNI]=-1,
    [H_SHELTEM]=-1,
    [H_CALID]=-1,
    [H_AGRAEL]=-1,
    [H_DELEB]=-1,
    [H_INGA]=-1,
    [H_MATEWA]=-1,
    [H_KILGHAN]=-1,
    [H_KRAAL]=-1,
    [H_SHIVA]=-1,
    [H_GARUNA]=-1,
    [H_ZOULEIKA]=-1,
}; -- -1 means no limit

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

function ResetATB()
    for side = 0,1 do
        local heroname = "none";
        if GetHero(side) then heroname = GetHeroName(GetHero(side)) end;
        if contains(NO_ATB_RESET_HEROES[CREATURE],heroname) == nil then
            for i,cr in GetUnits(side,CREATURE) do setATB(cr,0) end;
        end;
        if contains(NO_ATB_RESET_HEROES[WAR_MACHINE],heroname) == nil then
            for i,wm in GetUnits(side,WAR_MACHINE) do setATB(wm,0) end;
        end;
        if GetHero(side) then
            if contains(NO_ATB_RESET_HEROES[HERO],heroname) == nil then setATB(GetHero(side),0) end;
        end;
    end;
    COMBAT_READY = not nil;
end;

function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            setATB(cr,1);
        end;
    end;
end;

function WarMachinePlayFirst(side,type)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == type then
            setATB(wm,1);
        end;
    end;
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
            sleep(100);
        end;
    end;
end;

function UnitCast_RandomEnnemy(side,id0,id1,id2,spell)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            UnitCastAimedSpell(cr,spell,RandomCreature(1-side,i));
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

function UnitSpecialAbility2(side,id,ability)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id then
            local x,y = GetUnitPosition(RandomCreature(1-side,i));
            UseCombatAbility(cr,ability,x,y);
        end;
    end;
end;

function BallistaTargetShoot(side,target)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
            ShootCombatUnit(wm,target);
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

function HeroCast_TargetCreature(side,hero,spell,required,id0,id1,id2)
    local mana = GetUnitManaPoints(hero);
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
            startThread(DoCastTargetSpell,hero,spell,required,cr);
            repeat Wait() until THREAD_STATE == 1;
            THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
        end;
    end;
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
    if hero_name == "none" then
        return nil;
    -- Haven
    elseif hero_name == H_DUNCAN then
        -- print("Trigger ballista random shoot !")
        BallistaRandomShoot(side);
    elseif hero_name == H_DOUGAL then
        -- print("Trigger archers atb boost !")
        UnitPlayFirst(side,3,4,107);
    elseif hero_name == H_MARKAL then
        -- print("Trigger cast Mass Confusion !")
        HeroCast_Global(hero_id,213,FREE_MANA);
    elseif hero_name == H_FREYDA then
        -- print("Trigger cast Prayer !")
        HeroCast_Global(hero_id,54,NO_COST);
    elseif hero_name == H_VALERIA then
        -- print("Trigger cast Blade Barriers !")
        local m = GetUnitManaPoints(hero_id);
        local x = 12 - 9 * side;
        for y=2,11 do
            HeroCast_Area(hero_id,284,x,y,FREE_MANA);
            HeroCast_Area(hero_id,284,x-1+side*2,11-y,FREE_MANA);
        end;
        SetMana(hero_id,m);
    -- Preserve
    elseif hero_name == H_ANWEN then
        -- print("Trigger anger treants rage of forest !")
        UnitSpecialAbility(side,0,0,150,329);
    elseif hero_name == H_OSSIR then
        -- print("Trigger hunters random shoot !")
        UnitRandomShoot(side,47,48,147);
    elseif hero_name == H_TIERU then
        -- print("Trigger hero cast Mass Haste !")
        HeroCast_Global(hero_id,221,FREE_MANA);
    elseif hero_name == H_ALARON then
        -- print("Trigger elder druids summoning !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.1;
        SummonStack(side,50,trunc(0.5*m*m),0);
    elseif hero_name == H_GEM then
        -- print("Trigger siphon mana !")
        SiphonEnnemyMana(hero_id,side);
    -- Academy
    elseif hero_name == H_RAZZAK then
        -- print("Trigger copy largest golems group !")
        SummonCopy(side,61,62,161);
    elseif hero_name == H_DAVIUS then
        -- print("Trigger rakshasas dash !")
        UnitSpecialAbility(side,67,68,164,176);
    elseif hero_name == H_GURVILIN then
        -- print("Trigger disrupting rays !")
        HeroCast_AllEnnemies(side,hero_id,13,FREE_MANA);
    elseif hero_name == H_ZEHIR then
        -- print("Trigger summon elementals !")
        HeroCast_Global(hero_id,43,FREE_MANA);
    elseif hero_name == H_EMILIA then
        -- print("Trigger summon beehives !")
        local x = 15 - 13 * side;
        HeroCast_Area(hero_id,283,x,1,FREE_MANA);
        HeroCast_Area(hero_id,283,x,12,FREE_MANA);
    elseif hero_name == H_CYRUS then
        -- print("Trigger mages magic fist !")
        UnitCast_RandomEnnemy(side,63,64,162,2);
    elseif hero_name == H_NUR then
        -- print("Trigger random arcane crystals !")
        local m = trunc(GetUnitManaPoints(hero_id) * 0.05);
        local x1 = 13 - 11 * side;
        local x2 = 9 - 3 * side;
        for i = 1,m do
            startThread(UnitCastAreaSpell,hero_id,282,random(x1,x2,m),random(1,10,i));
        end;
    -- Fortress
    elseif hero_name == H_WULFSTAN then
        -- print("Trigger ballista play first !")
        WarMachinePlayFirst(side,WAR_MACHINE_BALLISTA);
    elseif hero_name == H_KARLI then
        -- print("Trigger spearwielders random shoot !")
        UnitRandomShoot(side,94,95,167);
    elseif hero_name == H_ULAND then
        -- print("Trigger Thanes ability !")
        UnitSpecialAbility2(side,103,345);
        UnitSpecialAbility2(side,171,247);
    elseif hero_name == H_ERLING then
        -- print("Trigger rune priests play first !")
        UnitPlayFirst(side,100,101,170);
    elseif hero_name == H_BRAND then
        -- print("Trigger cast Fire walls !")
        local m = GetUnitManaPoints(hero_id);
        local x = 11 - 7 * side;
        for y=2,11 do
            HeroCast_Area(hero_id,236,x,y,FREE_MANA);
        end;
        SetMana(hero_id,m);
    elseif hero_name == H_BART then
        -- print("Trigger summon earth elems !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.5;
        SummonStack(side,87,m,4);
        SummonStack(side,87,m,4);
    elseif hero_name == H_INGA then
        -- print("Trigger uber meteor shower !")
        local x = 15 - 13 * side;
        HeroCast_Area(hero_id,285,x,9,FREE_MANA);
        sleep(1500);
        HeroCast_Area(hero_id,285,x,4,FREE_MANA);
    -- Necropolis
    elseif hero_name == H_VLADIMIR then
        -- print("Trigger summon and kill skeleton !")
        local n = length(GetUnits(1-side,CREATURE));
        SummonStack(1-side,152,1,5);
        repeat sleep(10) until length(GetUnits(1-side,CREATURE)) == n+1;
        HeroCast_Target(hero_id,1,FREE_MANA,GetUnits(1-side,CREATURE)[n]);
    elseif hero_name == H_ARCHILUS then
        -- print("Trigger summon avatar of death !")
        HeroCast_Global(hero_id,200,FREE_MANA);
    elseif hero_name == H_AISLINN then
        -- print("Trigger cast mass weakness !")
        HeroCast_Global(hero_id,210,FREE_MANA);
    elseif hero_name == H_VIDOMINA then
        -- print("Trigger random sorrow")
        local e = GetUnits(1-side,CREATURE);
        local m = GetUnitMaxManaPoints(hero_id) * 0.02;
        local n = min(length(e),1+trunc(m));
        for i = 1,n do
            HeroCast_Target(hero_id,277,FREE_MANA,e[i-1]);
        end;
    elseif hero_name == H_NAADIR then
        -- print("Trigger duplicate ghosts !")
        for i,cr in GetUnits(side,CREATURE) do
            local id = GetCreatureType(cr);
            if id == 33 or id == 34 or id == 154 then
                local nb = GetCreatureNumber(cr);
                local x,y = GetUnitPosition(cr);
                SummonCreature(side,id,nb,x);
                sleep(1);
            end;
        end;
    -- Inferno
    elseif hero_name == H_NEBIROS then
        -- print("Trigger mark of the damned")
        HeroCast_RandomEnnemy(side,hero_id,56,NO_COST);
    elseif hero_name == H_ALASTOR then
        -- print("Trigger random blindness !")
        HeroCast_RandomEnnemy(side,hero_id,19,FREE_MANA);
    elseif hero_name == H_BIARA then
        -- print("Trigger succubus random shoot !")
        UnitRandomShoot(side,21,22,134);
    elseif hero_name == H_KHABELETH then
        -- print("Trigger pit lords summoning !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.1;
        SummonStack(side,26,trunc(0.1*m*m),0);
        SummonStack(side,26,trunc(0.1*m*m),0);
    elseif hero_name == H_DELEB then
        -- print("Trigger mine fields !")
        local x = 12 - 9 * side;
        HeroCast_Area(hero_id,38,x,4,FREE_MANA);
        HeroCast_Area(hero_id,38,x,9,FREE_MANA);
    -- Stronghold
    elseif hero_name == H_TELSEK then
        -- print("Trigger call of blood !")
        HeroCast_TargetCreature(side,hero_id,291,FREE_MANA,121,122,175);
    elseif hero_name == H_GOTAI then
        -- print("Trigger battlecry !")
        HeroCast_Global(hero_id,294,FREE_MANA);
    elseif hero_name == H_AZAR then
        if GetUnitManaPoints(hero_id) >= 10 then
            -- print("Trigger horde's anger !")
            HeroCast_RandomEnnemy(side,hero_id,295,10);
        end;
    elseif hero_name == H_KRAGH then
        -- print("Trigger powerful blow on centaur !")
        HeroCast_TargetCreature(side,hero_id,305,FREE_MANA,119,120,174);
    elseif hero_name == H_CRAGHACK then
        -- print("Trigger ralling cry !")
        HeroCast_Global(hero_id,290,FREE_MANA);
    elseif hero_name == H_KRAAL then
        -- print("Trigger ballista random shoot !")
        BallistaRandomShoot(side);
    elseif hero_name == H_MUKHA then
        -- print("Trigger lightning spell !")
        local ennemies = GetUnits(1-side,CREATURE);
        local spell = 3;
        if length(ennemies) >= 4 then spell = 7 end;
        HeroCast_Target(hero_id,spell,FREE_MANA,ennemies[0]);
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

    if hero_name == "none" then
        return nil;
    -- Haven
    elseif hero_name == H_ANDREAS and hero_id == unit then
        -- print("Trigger random stoneskin or deflect arrows !")
        local unit = RandomCreature(side,COMBAT_TURN);
        HeroCast_Target(hero_id,25,FREE_MANA,unit);
        HeroCast_Target(hero_id,29,FREE_MANA,unit);
        setATB(hero_id,1);
    elseif hero_name == H_MAEVE and hero_id == unit then
        -- print("Trigger random Encourage !")
        HeroCast_RandomAlly(side,hero_id,52,NO_COST);
        setATB(hero_id,1);
    elseif hero_name == "Jeddite" and hero_id == unit then
        -- print("Trigger random Vampirism !")
        local m = GetUnitManaPoints(hero_id);
        if m >= 100 then
            HeroCast_RandomAlly(side,hero_id,278,NO_COST);
            setATB(hero_id,1);
        end;
    -- Preserve
    elseif hero_name == H_ALARON and hero_id == unit then
        -- print("Trigger druids play next !")
        UnitPlayNext_Creature(side,49,50,148);
    elseif hero_name == H_TALANAR and hero_id == unit then
        -- print("Trigger random bloodlust !")
        HeroCast_RandomAlly(side,hero_id,28,FREE_MANA);
        setATB(hero_id,1);
    elseif hero_name == H_IVOR and hero_id == unit then
        -- print("Trigger spawn wolves pack !")
        local m = trunc(GetUnitManaPoints(hero_id) * 0.34);
        if m > 0 then SummonCreature(side,113,m) end;
    -- Academy
    elseif hero_name == H_MINASLI and hero_id == unit then
        -- print("Trigger fire ballista ATB boost !")
        UnitPlayNext_WarMachine(side,WAR_MACHINE_BALLISTA);
    elseif hero_name == H_RISSA and hero_id == unit then
        -- print("Trigger random Slow !")
        local m = GetUnitManaPoints(hero_id);
        if m >= 20 then
            HeroCast_RandomEnnemy(side,hero_id,12,NO_COST);
            setATB(hero_id,1);
        end;
    -- Fortress
    elseif hero_name == H_INGA and hero_id == unit then
        if GetUnitManaPoints(hero_id) >= 250 then
            -- print("Trigger random implosion !")
            HeroCast_RandomEnnemy(side,hero_id,9,NO_COST);
            setATB(hero_id,1);
        end;
    -- Necropolis
    elseif hero_name == H_KASPAR and hero_id == unit then
        -- print("Trigger random Plague !")
        HeroCast_RandomEnnemy(side,hero_id,14,FREE_MANA);
        setATB(hero_id,1);
    elseif hero_name == H_ORSON and hero_id == unit then
        -- print("Trigger summon zombies !")
        local m = GetUnitManaPoints(hero_id);
        if m > 0 then SummonCreature(side,32,m) end;
    elseif hero_name == H_GIOVANNI and hero_id == unit then
        -- print("Trigger random Ice Bolt !")
        HeroCast_RandomEnnemy(side,hero_id,4,FREE_MANA);
        setATB(hero_id,1);
    -- Inferno
    elseif hero_name == H_AGRAEL and hero_id ~= unit then
        local id = GetCreatureType(unit);
        if id ~= nil then
            if (id >= 15 and id <= 28) or (id >= 131 and id <= 137) then
                -- print("Trigger creature explosion !")
                local x,y = GetUnitPosition(unit);
                UnitCastAreaSpell(unit,162,x,y);
                setATB(unit,1);
            end;
        end;
    elseif hero_name == H_DELEB and hero_id == unit then
        -- print("Trigger random Stone spikes !")
        HeroCast_RandomEnnemyArea(side,hero_id,237,FREE_MANA);
        setATB(hero_id,1);
    elseif hero_name == H_CALID and hero_id == unit then
        -- print("Trigger random Fireball !")
        HeroCast_RandomEnnemyArea(side,hero_id,5,FREE_MANA);
    -- Stronghold
    elseif hero_name == H_MATEWA and hero_id == unit then
        -- print("Trigger cyclops play next !")
        UnitPlayNext_Creature(side,129,130,179);
    elseif hero_name == H_KILGHAN and hero_id == unit then
        -- print("Trigger summon goblins !")
        local m = trunc(GetUnitMaxManaPoints(hero_id) * 1.5);
        SummonCreature(side,117,m);
    elseif hero_name == H_KRAAL and hero_id == unit then
        -- print("Trigger ballista random shoot !")
        BallistaRandomShoot(side);
    elseif hero_name == H_SHIVA then
        -- print("Trigger shamans mana !")
        local id = GetCreatureType(unit);
        if id == 123 or id == 124 or id == 176 then
            local a = trunc(GetUnitMaxManaPoints(hero_id) * 0.1);
            local m = GetUnitManaPoints(unit);
            SetMana(unit,m+a);
        end;
    elseif hero_name == H_GARUNA then
        -- print("Trigger regen or plague !")
        if GetUnitType(unit) == WAR_MACHINE and GetWarMachineType(unit) == WAR_MACHINE_BALLISTA then
            if mod(TURN,2) == 0 then
                HeroCast_RandomAlly(side,hero_id,280,FREE_MANA);
            else
                HeroCast_RandomEnnemy(side,hero_id,14,FREE_MANA);
            end;
        end;
    elseif hero_name == H_ZOULEIKA and hero_id == unit then
        -- print("Trigger random vulnerability !")
        HeroCast_RandomEnnemy(side,hero_id,13,FREE_MANA);
        setATB(hero_id,1);
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
    -- Preserve
    if hero_name == H_FINDAN then
        -- print("Trigger hero play next !")
        setATB(hero_id,1);
    end;
    -- Inferno
    if hero_name == H_SHELTEM then
        -- print("Trigger fireball ballista shoot !")
        BallistaTargetShoot(1-side,unit);
    end;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function CombatStartSpecials()
    repeat sleep(1) until COMBAT_READY;
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

