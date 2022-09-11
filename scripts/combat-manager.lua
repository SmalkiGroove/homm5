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
    [HERO] = { H_BERTRAND, H_FINDAN, H_NEBIROS, H_KRAGH },
    [CREATURE] = { H_WYNGAAL, H_CRAGHACK },
    [WAR_MACHINE] = { },
};

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

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

doFile("/scripts/combat-routines/_common.lua")
doFile("/scripts/combat-routines/academy.lua")
doFile("/scripts/combat-routines/dungeon.lua")
doFile("/scripts/combat-routines/fortress.lua")
doFile("/scripts/combat-routines/haven.lua")
doFile("/scripts/combat-routines/inferno.lua")
doFile("/scripts/combat-routines/necropolis.lua")
doFile("/scripts/combat-routines/preserve.lua")
doFile("/scripts/combat-routines/stronghold.lua")

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

TURN_ROUTINES = {
    [0] = DoCommonRoutine_CombatTurn,
    [1] = DoHavenRoutine_CombatTurn,
    [2] = DoPreserveRoutine_CombatTurn,
    [3] = DoInfernoRoutine_CombatTurn,
    [4] = DoNecropolisRoutine_CombatTurn,
    [5] = DoAcademyRoutine_CombatTurn,
    [6] = DoDungeonRoutine_CombatTurn,
    [7] = DoFortressRoutine_CombatTurn,
    [8] = DoStrongholdRoutine_CombatTurn,
};

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

        if ATTACKER_HERO ~= nil then
            local turnroutine = TURN_ROUTINES[ATTACKER_RACE];
            startThread(turnroutine, ATTACKER, ATTACKER_HERO, ATTACKER_HERO_ID);
        end;
        if DEFENDER_HERO ~= nil then
            local turnroutine = TURN_ROUTINES[DEFENDER_RACE];
            startThread(turnroutine, DEFENDER, DEFENDER_HERO, DEFENDER_HERO_ID);
        end;
    end;
end;

function ManageUnitDeath(unit)
    if ATTACKER_HERO ~= nil then
        local deathroutine = DEATH_ROUTINES[ATTACKER_RACE];
		startThread(deathroutine, ATTACKER, ATTACKER_HERO, ATTACKER_HERO_ID, unit);
	end;
	if DEFENDER_HERO ~= nil then
		local deathroutine = DEATH_ROUTINES[DEFENDER_RACE];
		startThread(deathroutine, DEFENDER, DEFENDER_HERO, DEFENDER_HERO_ID, unit);
	end;
end;
