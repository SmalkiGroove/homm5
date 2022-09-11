COMBAT_READY = nil;
ATTACKER_RACE = nil;
DEFENDER_RACE = nil;
ATTACKER_HERO = nil;
DEFENDER_HERO = nil;

COMBAT_TURN = 0;
CURRENT_UNIT = "none";
CURRENT_UNIT_SIDE = nil;
ALLIED_CREATURES = {};
ENNEMY_CREATURES = {};

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

START_ROUTINES = {
    [0] = DoCommonRoutine_CombatStart,
    [1] = DoHavenRoutine_CombatStart,
    [2] = DoPreserveRoutine_CombatStart,
    [3] = DoInfernoRoutine_CombatStart,
    [4] = DoNecropolisRoutine_CombatStart,
    [5] = DoAcademyRoutine_CombatStart,
    [6] = DoDungeonRoutine_CombatStart,
    [7] = DoFortressRoutine_CombatStart,
    [8] = DoStrongholdRoutine_CombatStart,
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

function ManageCombatPrepare()
    ATTACKER_HERO = GetHero(ATTACKER) and GetHeroName(ATTACKER_HERO_ID);
    DEFENDER_HERO = GetHero(DEFENDER) and GetHeroName(DEFENDER_HERO_ID);
    if ATTACKER_HERO ~= nil then
        ATTACKER_RACE = GetHeroFactionID(ATTACKER_HERO);
    end;
    if DEFENDER_HERO ~= nil then
        DEFENDER_RACE = GetHeroFactionID(DEFENDER_HERO);
    end;
end;

function ManageCombatStart()
    ResetATB()
    repeat sleep(1) until COMBAT_READY;

	if ATTACKER_HERO ~= nil then
        local startroutine = START_ROUTINES[ATTACKER_RACE];
		startThread(startroutine, ATTACKER, ATTACKER_HERO, ATTACKER_HERO_ID);
	end;
	if DEFENDER_HERO ~= nil then
		local startroutine = START_ROUTINES[DEFENDER_RACE];
		startThread(startroutine, DEFENDER, DEFENDER_HERO, DEFENDER_HERO_ID);
	end;
end;

function ManageCombatTurn(unit)
    if CURRENT_UNIT ~= unit then
        COMBAT_TURN = COMBAT_TURN + 1;
        CURRENT_UNIT = unit;
        CURRENT_UNIT_SIDE = IsAttacker(unit) and ATTACKER or DEFENDER;
        ALLIED_CREATURES = GetUnits(CURRENT_UNIT_SIDE, CREATURE);
        ENNEMY_CREATURES = GetUnits(1-CURRENT_UNIT_SIDE, CREATURE);

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

