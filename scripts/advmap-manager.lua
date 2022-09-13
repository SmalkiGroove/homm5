
ROUTINES_LOADED = {
	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0,
};

function LoadScript(path, key)
	dofile(path);
	repeat sleep(1) until ROUTINES_LOADED[key] == 1;
end;

LoadScript("/scripts/advmap-routines/_common.lua", 0)
LoadScript("/scripts/advmap-routines/academy.lua", ACADEMY)
LoadScript("/scripts/advmap-routines/dungeon.lua", DUNGEON)
LoadScript("/scripts/advmap-routines/fortress.lua", FORTRESS)
LoadScript("/scripts/advmap-routines/haven.lua", HAVEN)
LoadScript("/scripts/advmap-routines/inferno.lua", INFERNO)
LoadScript("/scripts/advmap-routines/necropolis.lua", NECROPOLIS)
LoadScript("/scripts/advmap-routines/preserve.lua", PRESERVE)
LoadScript("/scripts/advmap-routines/stronghold.lua", STRONGHOLD)


TURN = 1;

PLAYER_HEROES = { [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {} };

ADD_PLAYER_HERO = {
	[1] = "AddPlayer1Hero",
	[2] = "AddPlayer2Hero",
	[3] = "AddPlayer3Hero",
	[4] = "AddPlayer4Hero",
	[5] = "AddPlayer5Hero",
	[6] = "AddPlayer6Hero",
	[7] = "AddPlayer7Hero",
	[8] = "AddPlayer8Hero",
};
REMOVE_PLAYER_HERO = {
	[1] = "RemovePlayer1Hero",
	[2] = "RemovePlayer2Hero",
	[3] = "RemovePlayer3Hero",
	[4] = "RemovePlayer4Hero",
	[5] = "RemovePlayer5Hero",
	[6] = "RemovePlayer6Hero",
	[7] = "RemovePlayer7Hero",
	[8] = "RemovePlayer8Hero",
};

START_ROUTINES = {
	[0] = DoCommonRoutine_Start,
	[1] = DoHavenRoutine_Start,
	-- [2] = DoPreserveRoutine_Start,
	-- [3] = DoInfernoRoutine_Start,
	-- [4] = DoNecropolisRoutine_Start,
	-- [5] = DoAcademyRoutine_Start,
	-- [6] = DoDungeonRoutine_Start,
	-- [7] = DoFortressRoutine_Start,
	-- [8] = DoStrongholdRoutine_Start,
};

DAILY_ROUTINES = {
	[0] = DoCommonRoutine_Daily,
	[1] = DoHavenRoutine_Daily,
	-- [2] = DoPreserveRoutine_Daily,
	-- [3] = DoInfernoRoutine_Daily,
	-- [4] = DoNecropolisRoutine_Daily,
	-- [5] = DoAcademyRoutine_Daily,
	-- [6] = DoDungeonRoutine_Daily,
	-- [7] = DoFortressRoutine_Daily,
	-- [8] = DoStrongholdRoutine_Daily,
};

WEEKLY_ROUTINES = {
	[0] = DoCommonRoutine_Weekly,
	[1] = DoHavenRoutine_Weekly,
	-- [2] = DoPreserveRoutine_Weekly,
	-- [3] = DoInfernoRoutine_Weekly,
	-- [4] = DoNecropolisRoutine_Weekly,
	-- [5] = DoAcademyRoutine_Weekly,
	-- [6] = DoDungeonRoutine_Weekly,
	-- [7] = DoFortressRoutine_Weekly,
	-- [8] = DoStrongholdRoutine_Weekly,
};



function DoPlayerHeroesSpe(player, newweek)
	while (not IsPlayerCurrent(player)) do sleep(10) end;
	print("Player "..player.." turn started");
	for i,hero in PLAYER_HEROES[player] do
		local faction = GetHeroFactionID(hero);
		startThread(DAILY_ROUTINES[faction], player, hero);
		if newweek then startThread(WEEKLY_ROUTINES[faction], player, hero) end;
	end;
end;

function NewDayTrigger()
	TURN = TURN + 1;
	print("New day ! Turn "..TURN);
	local newweek = GetDate(DAY_OF_WEEK) == 1;
	for player = 1,8 do
		if (GetPlayerState(player) == 1) then
			startThread(DoPlayerHeroesSpe, player, newweek);
		end;
	end;
end;

Trigger(NEW_DAY_TRIGGER, "NewDayTrigger");


function AddPlayer1Hero(hero) insert(PLAYER_HEROES[1], hero) end;
function AddPlayer2Hero(hero) insert(PLAYER_HEROES[2], hero) end;
function AddPlayer3Hero(hero) insert(PLAYER_HEROES[3], hero) end;
function AddPlayer4Hero(hero) insert(PLAYER_HEROES[4], hero) end;
function AddPlayer5Hero(hero) insert(PLAYER_HEROES[5], hero) end;
function AddPlayer6Hero(hero) insert(PLAYER_HEROES[6], hero) end;
function AddPlayer7Hero(hero) insert(PLAYER_HEROES[7], hero) end;
function AddPlayer8Hero(hero) insert(PLAYER_HEROES[8], hero) end;

function RemovePlayer1Hero(hero) remove(PLAYER_HEROES[1], hero) end;
function RemovePlayer2Hero(hero) remove(PLAYER_HEROES[2], hero) end;
function RemovePlayer3Hero(hero) remove(PLAYER_HEROES[3], hero) end;
function RemovePlayer4Hero(hero) remove(PLAYER_HEROES[4], hero) end;
function RemovePlayer5Hero(hero) remove(PLAYER_HEROES[5], hero) end;
function RemovePlayer6Hero(hero) remove(PLAYER_HEROES[6], hero) end;
function RemovePlayer7Hero(hero) remove(PLAYER_HEROES[7], hero) end;
function RemovePlayer8Hero(hero) remove(PLAYER_HEROES[8], hero) end;

for i = 1,8 do
	Trigger(PLAYER_ADD_HERO_TRIGGER, i, ADD_PLAYER_HERO[i]);
	Trigger(PLAYER_REMOVE_HERO_TRIGGER, i, REMOVE_PLAYER_HERO[i]);
end;


function InitializeHeroes()
	for player = 1,8 do
		if (GetPlayerState(player) == 1) then
			PLAYER_HEROES[player] = GetPlayerHeroes(player);
			for i,hero in PLAYER_HEROES[player] do
				local faction = GetHeroFactionID(hero);
				startThread(START_ROUTINES[faction], player, hero);
			end;
		end;
	end;
end;

InitializeHeroes()
