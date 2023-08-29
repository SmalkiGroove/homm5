
ROUTINES_LOADED = {
	[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0,
	[9] = 0, [10]= 0, [11]= 0, [12]= 0, [13]= 0, [14]= 0, [15]= 0, [16]= 0, [17]= 0,
}

function LoadScript(path, key)
	-- print("Loading script "..path)
	dofile(path)
	repeat sleep(1) until ROUTINES_LOADED[key] == 1
end

LoadScript("/scripts/hero-advmap-routines/_common.lua", 0)
LoadScript("/scripts/hero-advmap-routines/academy.lua", ACADEMY)
LoadScript("/scripts/hero-advmap-routines/dungeon.lua", DUNGEON)
LoadScript("/scripts/hero-advmap-routines/fortress.lua", FORTRESS)
LoadScript("/scripts/hero-advmap-routines/haven.lua", HAVEN)
LoadScript("/scripts/hero-advmap-routines/inferno.lua", INFERNO)
LoadScript("/scripts/hero-advmap-routines/necropolis.lua", NECROPOLIS)
LoadScript("/scripts/hero-advmap-routines/preserve.lua", PRESERVE)
LoadScript("/scripts/hero-advmap-routines/stronghold.lua", STRONGHOLD)

LoadScript("/scripts/artifacts/artifacts-data.lua", 14)
LoadScript("/scripts/artifacts/artifact-sets.lua", 15)
LoadScript("/scripts/artifacts/artifact-routines.lua", 16)
LoadScript("/scripts/artifacts/artifacts-manager.lua", 17)

LoadScript("/scripts/building-conversion/conversion.lua", 9)

LoadScript("/scripts/object-initializers/combat-trigger.lua", 10)
LoadScript("/scripts/object-initializers/starting-armies.lua", 11)

LoadScript("/scripts/skills/skills-data.lua", 12)


TURN = 1

PLAYER_BRAIN = {
	[1] = OBSERVER,
	[2] = OBSERVER,
	[3] = OBSERVER,
	[4] = OBSERVER,
	[5] = OBSERVER,
	[6] = OBSERVER,
	[7] = OBSERVER,
	[8] = OBSERVER,
}

for i = 1,8 do
	PLAYER_BRAIN[i] = GetPlayerBrain(i)
end

ADD_PLAYER_HERO = {
	[1] = "AddPlayer1Hero",
	[2] = "AddPlayer2Hero",
	[3] = "AddPlayer3Hero",
	[4] = "AddPlayer4Hero",
	[5] = "AddPlayer5Hero",
	[6] = "AddPlayer6Hero",
	[7] = "AddPlayer7Hero",
	[8] = "AddPlayer8Hero",
}
REMOVE_PLAYER_HERO = {
	[1] = "RemovePlayer1Hero",
	[2] = "RemovePlayer2Hero",
	[3] = "RemovePlayer3Hero",
	[4] = "RemovePlayer4Hero",
	[5] = "RemovePlayer5Hero",
	[6] = "RemovePlayer6Hero",
	[7] = "RemovePlayer7Hero",
	[8] = "RemovePlayer8Hero",
}

START_ROUTINES = {
	[0] = DoCommonRoutine_Start,
	[1] = DoHavenRoutine_Start,
	[2] = DoPreserveRoutine_Start,
	[3] = DoInfernoRoutine_Start,
	[4] = DoNecropolisRoutine_Start,
	[5] = DoAcademyRoutine_Start,
	[6] = DoDungeonRoutine_Start,
	[7] = DoFortressRoutine_Start,
	[8] = DoStrongholdRoutine_Start,
}

DAILY_ROUTINES = {
	[0] = DoCommonRoutine_Daily,
	[1] = DoHavenRoutine_Daily,
	[2] = DoPreserveRoutine_Daily,
	[3] = DoInfernoRoutine_Daily,
	[4] = DoNecropolisRoutine_Daily,
	[5] = DoAcademyRoutine_Daily,
	[6] = DoDungeonRoutine_Daily,
	[7] = DoFortressRoutine_Daily,
	[8] = DoStrongholdRoutine_Daily,
}

WEEKLY_ROUTINES = {
	[0] = DoCommonRoutine_Weekly,
	[1] = DoHavenRoutine_Weekly,
	[2] = DoPreserveRoutine_Weekly,
	[3] = DoInfernoRoutine_Weekly,
	[4] = DoNecropolisRoutine_Weekly,
	[5] = DoAcademyRoutine_Weekly,
	[6] = DoDungeonRoutine_Weekly,
	[7] = DoFortressRoutine_Weekly,
	[8] = DoStrongholdRoutine_Weekly,
}

LEVELUP_ROUTINES = {
	[0] = DoCommonRoutine_LevelUp,
	[1] = DoHavenRoutine_LevelUp,
	[2] = DoPreserveRoutine_LevelUp,
	[3] = DoInfernoRoutine_LevelUp,
	[4] = DoNecropolisRoutine_LevelUp,
	[5] = DoAcademyRoutine_LevelUp,
	[6] = DoDungeonRoutine_LevelUp,
	[7] = DoFortressRoutine_LevelUp,
	[8] = DoStrongholdRoutine_LevelUp,
}

AFTER_COMBAT_ROUTINES = {
	[0] = DoCommonRoutine_AfterCombat,
	[1] = DoHavenRoutine_AfterCombat,
	[2] = DoPreserveRoutine_AfterCombat,
	[3] = DoInfernoRoutine_AfterCombat,
	[4] = DoNecropolisRoutine_AfterCombat,
	[5] = DoAcademyRoutine_AfterCombat,
	[6] = DoDungeonRoutine_AfterCombat,
	[7] = DoFortressRoutine_AfterCombat,
	[8] = DoStrongholdRoutine_AfterCombat,
}


function DoPlayerHeroesSpe(player, newweek)
	while (not IsPlayerCurrent(player)) do sleep(10) end
	print("Player "..player.." turn started")
	for i,hero in GetPlayerHeroes(player) do
		local faction = GetHeroFactionID(hero)
		startThread(DAILY_ROUTINES[faction], player, hero)
		if newweek then startThread(WEEKLY_ROUTINES[faction], player, hero) end
	end
end

function NewDayTrigger()
	TURN = TURN + 1
	print("New day ! Turn "..TURN)
	local newweek = GetDate(DAY_OF_WEEK) == 1
	for player = 1,8 do
		if (GetPlayerState(player) == 1) then
			startThread(DoPlayerHeroesSpe, player, newweek)
		end
	end
	if newweek then	
		startThread(DoTriggerBuildingConversion)
	end
end

function CombatResultsHandler(combatIndex)
	local hero = GetSavedCombatArmyHero(combatIndex, 1)
	if hero ~= nil then
		local player = GetSavedCombatArmyPlayer(combatIndex, 1)
		local faction = GetHeroFactionID(hero)
		startThread(AFTER_COMBAT_ROUTINES[faction], player, hero, combatIndex)
	end
end


Trigger(NEW_DAY_TRIGGER, "NewDayTrigger")
Trigger(COMBAT_RESULTS_TRIGGER, "CombatResultsHandler")


function AddPlayer1Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_1, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer2Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_2, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer3Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_3, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer4Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_4, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer5Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_5, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer6Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_6, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer7Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_7, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end
function AddPlayer8Hero(hero)
	local faction = GetHeroFactionID(hero)
	startThread(ReplaceStartingArmy, hero)
	startThread(START_ROUTINES[faction], PLAYER_8, hero)
	startThread(LEVELUP_ROUTINES[faction], hero)
end

function RemovePlayer1Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer2Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer3Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer4Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer5Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer6Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer7Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end
function RemovePlayer8Hero(hero)
	Trigger(HERO_LEVELUP_TRIGGER, hero, nil)
end

for i = 1,8 do
	Trigger(PLAYER_ADD_HERO_TRIGGER, i, ADD_PLAYER_HERO[i])
	Trigger(PLAYER_REMOVE_HERO_TRIGGER, i, REMOVE_PLAYER_HERO[i])
end

function InitializeHeroes()
	for player = 1,8 do
		if (GetPlayerState(player) == 1) then
			for i,hero in GetPlayerHeroes(player) do
				-- print("Initialize hero "..hero)
				local faction = GetHeroFactionID(hero)
				startThread(ReplaceStartingArmy, hero)
				startThread(START_ROUTINES[faction], player, hero)
				startThread(LEVELUP_ROUTINES[faction], hero)
			end
		end
	end
end

-- Initializers
InitializeHeroes()
DoTriggerBuildingConversion()
DoTriggerCombatStart()

-- Game Loops
-- startThread(DoWatchArtifacts)
