
TURN = 1; -- current turn

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
	[2] = DoPreserveRoutine_Start,
	[3] = DoInfernoRoutine_Start,
	[4] = DoNecropolisRoutine_Start,
	[5] = DoAcademyRoutine_Start,
	[6] = DoDungeonRoutine_Start,
	[7] = DoFortressRoutine_Start,
	[8] = DoStrongholdRoutine_Start,
};

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
};

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
};

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

ONE_TIME_BONUSES = {[H_ISABEL]=0,[H_RUTGER]=0,[H_WYNGAAL]=0,[H_ANWEN]=0,[H_KYRRE]=0,[H_JOSEPHINE]=0,[H_THANT]=0,[H_TOLGHAR]=0,[H_HEDWIG]=0};

ARTIFACTS_GAINS = {
	["Brem0"]=26,
	["Brem1"]=88,
	["Brem2"]=21,
	["Brem3"]=25,
	["Brem4"]=11,
	["Brem5"]=77, -- Wayfarer boots / Crown of leadership / Ring of life / Golden horseshoe / Crown of courage / Tome of light magic
	["Thant0"]=55,
	["Thant1"]=64,
	["Thant2"]=71,
	["Thant3"]=63,
	["Thant4"]=83,
	["Thant5"]=78, -- Necromancer's Helm / Tunic of carved flesh / Amulet of Necromancy / Cursed Ring / Skull of Markal / Tome of dark magic
};

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------



function ApplyHeroesSpe_daily(player)
	print("Daily run for player "..player);
	local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,H_ORLANDO) ~= nil then
			local amount = (GetHeroLevel(H_ORLANDO) - 1) * 250;
			startThread(Spe_GiveResources,H_ORLANDO,player,6,amount); -- Gold - 250*level
		end;
		if contains(heroes,H_KLAUS) ~= nil then
			startThread(Spe_AddCreatures,H_KLAUS,player,11,12,111,0.05) -- Cavalier - 1:10 - 2:30 - 3:50
		end;
		if contains(heroes,H_GABRIELLE) ~= nil then
			startThread(Spe_AddCreatures2,H_GABRIELLE,player,110,0.13); -- Zealot - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		end;
		-- Preserve
		if contains(heroes,H_DIRAEL) ~= nil then
			startThread(Spe_AddCreatures2,H_DIRAEL,player,44,0.5); -- Sprites - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		end;
		if contains(heroes,H_JENOVA) ~= nil then
			startThread(Spe_AddCreatures,H_JENOVA,player,55,56,151,0.03); -- Green Dragon - 1:17 - 2:50
		end;
		if contains(heroes,H_IVOR) ~= nil then
			startThread(Spe_AddCreatures2,H_IVOR,player,113,0.5); -- Wolf - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		end;
		if contains(heroes,H_VINRAEL) ~= nil then
			startThread(Spe_GiveStats,H_VINRAEL,player,0,300); -- Exp - +300 * level
		end;
		if contains(heroes,H_MEPHALA) ~= nil then
			local amount = trunc(GetHeroLevel(H_MEPHALA) * 0.5);
			local res = random(1);
			startThread(Spe_GiveResources,H_MEPHALA,player,res,amount); -- Wood or Ore - +1 / 2 levels
		end;
		-- Fortress
		if contains(heroes,H_HAEGEIR) ~= nil then
			startThread(Spe_TransformCreatures,H_HAEGEIR,player,TRANSFORM_ARRAY_FORTRESS); -- Transform creatures to Fortress units
		end;
		-- Necropolis
		if contains(heroes,H_ZOLTAN) ~= nil then
			startThread(Spe_AddCreatures,H_ZOLTAN,player,37,38,156,0.12); -- Lich - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		end;
		if contains(heroes,H_THANT) ~= nil then
			startThread(Spe_AddCreatures2,H_THANT,player,116,0.25); -- Mummy - 1:2 - 2:6 - 3:10 - 4:14 - 5:18 ... 13:50
		end;
		if contains(heroes,H_XERXON) ~= nil then
			startThread(Spe_AddCreatures2,H_XERXON,player,89,0.1); -- Black Knight - 1:5 - 2:15 - 3:25 - 4:35 - 5:45
			startThread(Spe_UpgradeCreatures,H_XERXON,player,89,90,37,1); -- B.Knights to D.Knights for 1 Lich
		end;
		if contains(heroes,H_RAVEN) ~= nil then
			local mult = ceil(GetHeroLevel(H_RAVEN) * 0.1);
			local army = GetHeroArmy(H_RAVEN);
			local amount = 0;
			for i=1,7 do
				if army[i] and army[i] ~= 0 then amount = amount + GetHeroCreatures(H_RAVEN,army[i]) end;
			end;
			startThread(Spe_GiveResources,H_RAVEN,player,6,amount*mult); -- Gold - 1 per creature in army per 10 levels
		end;
		-- Inferno
		if contains(heroes,H_GRAWL) ~= nil then
			startThread(Spe_AddCreatures,H_GRAWL,player,19,20,133,0.33); -- Hell hounds - 1:2 - 2:5 - 3:8 - 4:11 - ... - 17:50
		end;
		if contains(heroes,H_HARKENRAZ) ~= nil then
			local amount = trunc(0.34 * GetHeroLevel(H_HARKENRAZ));
			startThread(Spe_GiveResources,H_HARKENRAZ,player,4,amount); -- Sulfur - +1 / 3 levels
		end;
		if contains(heroes,H_GROK) ~= nil then
			startThread(Spe_AddCreatures,H_GROK,player,23,24,135,0.12); -- Hellmare - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		end;
		-- Dungeon
		if contains(heroes,"Menel") ~= nil then
			local amount = trunc(GetHeroLevel("Menel") * 0.2);
			startThread(Spe_GiveResources,"Menel",player,6,amount); -- Gold - 5:100 - 10:200 - 20:400 ... 50:1000
		end;
		if contains(heroes,"Ferigl") ~= nil then
			startThread(Spe_AddCreatures,"Ferigl",player,77,78,141,0.12); -- Raptor - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		end;
		if contains(heroes,"Eruina") ~= nil then
			startThread(Spe_AddCreatures,"Eruina",player,81,82,143,0.08); -- Matron - 1:7 - 2:19 - 3:32 - 4:44
		end;
		if contains(heroes,"Almegir") ~= nil then
			startThread(Spe_AddCreatures2,"Almegir",player,115,0.13); -- Manticore - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		end;
		-- Stronghold
		if contains(heroes,H_SHAKKARUKAT) ~= nil then
			startThread(Spe_AddCreatures,H_SHAKKARUKAT,player,127,128,178,0.05); -- Wyvern - 1:10 - 2:30 - 3:50
		end;
	end;
	print("Daily run done.");
	PLAYER_DAILY_EVENTS_CHECK[player] = TURN;
end;

function ApplyHeroesSpe_weekly(player)
	print("Weekly run for player "..player);
    local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,H_ELLAINE) ~= nil then
			startThread(Spe_AddRecruits,H_ELLAINE,player,CREATURE_PEASANT,TOWN_BUILDING_DWELLING_1,7); -- Peasants - 7 * level recruits per week
		end;
		if contains(heroes,H_IRINA) ~= nil then
			startThread(Spe_CallCreatures,H_IRINA,player,CREATURE_GRIFFIN,TOWN_BUILDING_DWELLING_4,1.5); -- Griffins - 1.5 * level transfered
		end;
		if contains(heroes,H_BERTRAND) ~= nil then
			startThread(Spe_GiveStats,H_BERTRAND,player,1,0.1); -- Attack - +1 / 10*lvl / week
		end;
		if contains(heroes,H_NICOLAI) ~= nil then
			startThread(Spe_ArmyMultiply,H_NICOLAI,player,{3,4,107,5,6,108,9,10,110},0.01); -- T2 T3 T5 : 1% * level
		end;
		-- Preserve
		if contains(heroes,H_ANWEN) ~= nil then
			startThread(Spe_AddCreatures2,H_ANWEN,player,150,0.25); -- Anger Treant - 1:2 - 2:6 - 3:10 - 4:14 ... 13:50
		end;
		if contains(heroes,H_GILRAEN) ~= nil then
			startThread(Spe_AddRecruits,H_GILRAEN,player,CREATURE_BLADE_JUGGLER,TOWN_BUILDING_DWELLING_1,6); -- Blade Jugglers - 6 * level recruits per week
		end;
		if contains(heroes,H_YLTHIN) ~= nil then
			startThread(Spe_CallCreatures,H_YLTHIN,player,CREATURE_UNICORN,TOWN_BUILDING_DWELLING_5,0.75); -- Unicorns - 0.75 * level transfered
		end;
		if contains(heroes,H_ELLESHAR) ~= nil then
			startThread(Spe_GiveStats,H_ELLESHAR,player,3,0.2); -- Spellpower - +1 / 5*lvl / week
		end;
		if contains(heroes,H_TALANAR) ~= nil then
			startThread(Spe_GiveStats,H_TALANAR,player,1,0.1); -- Attack - +1 / 10*lvl / week
		end;
		-- Necropolis
		if contains(heroes,H_DEIRDRE) ~= nil then
			startThread(Spe_AddCreatures2,H_DEIRDRE,player,157,0.13); -- Banshee - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		end;
		if contains(heroes,H_ARANTIR) ~= nil then
			startThread(Spe_AddRecruits,H_ARANTIR,player,CREATURE_SKELETON,TOWN_BUILDING_DWELLING_1,3.5); -- Skeletons - 3.5 * level recruits per week
			startThread(Spe_AddRecruits,H_ARANTIR,player,CREATURE_WALKING_DEAD,TOWN_BUILDING_DWELLING_2,2); -- Walking deads - 2 * level recruits per week
			startThread(Spe_AddRecruits,H_ARANTIR,player,CREATURE_MANES,TOWN_BUILDING_DWELLING_3,0.75); -- Manes - 0.75 * level recruits per week
		end;
		if contains(heroes,H_LUCRETIA) ~= nil then
			startThread(Spe_CallCreatures,H_LUCRETIA,player,CREATURE_VAMPIRE,TOWN_BUILDING_DWELLING_4,1.5); -- Vampires - 1.5 * level transfered
		end;
		-- Inferno
		if contains(heroes,H_ZYDAR) ~= nil then
			startThread(Spe_AddRecruits,H_ZYDAR,player,CREATURE_FAMILIAR,TOWN_BUILDING_DWELLING_1,2.5); -- Imps - 2.5 * level recruits per week
			startThread(Spe_AddRecruits,H_ZYDAR,player,CREATURE_DEMON,TOWN_BUILDING_DWELLING_2,1.5); -- Horned demons - 1.5 * level recruits per week
			startThread(Spe_AddRecruits,H_ZYDAR,player,CREATURE_DEVIL,TOWN_BUILDING_DWELLING_7,0.1); -- Devils - 0.1 * level recruits per week
		end;
		if contains(heroes,H_MALUSTAR) ~= nil then
			local stat = 1+random(3);
			startThread(Spe_GiveStats,H_MALUSTAR,player,stat,0.2); -- Random attribute - +1 / 5*lvl / week
		end;
		if contains(heroes,H_MARBAS) ~= nil then
			startThread(Spe_AddCreatures2,H_MARBAS,player,104,0.3); -- Fire Dragon - 1:2 - 2:5 - 3:9 - 4:12 - 5:15 ... 15:49
		end;
		-- Dungeon
		if contains(heroes,"Ohtarig") ~= nil then
			startThread(Spe_AddRecruits,"Ohtarig",player,CREATURE_SCOUT,TOWN_BUILDING_DWELLING_1,3);
		end;
		if contains(heroes,"Urunir") ~= nil then
			startThread(Spe_AddRecruits,"Urunir",player,CREATURE_WITCH,TOWN_BUILDING_DWELLING_2,2.4);
		end;
		if contains(heroes,"Darkstorm") ~= nil then
			startThread(Spe_AddRecruits,"Darkstorm",player,CREATURE_MINOTAUR,TOWN_BUILDING_DWELLING_3,1.4);
		end;
		-- Stronghold
		if contains(heroes,H_GORSHAK) ~= nil then
			startThread(Spe_CallCreatures,H_GORSHAK,player,CREATURE_CENTAUR,TOWN_BUILDING_DWELLING_4,1); -- Centaurs - 1 * level transfered
		end;
		if contains(heroes,H_ZOULEIKA) ~= nil then
			local stat = 3+random(1);
			startThread(Spe_GiveStats,H_ZOULEIKA,player,stat,0.1); --Spellpower or Knowledge - +1 / 10*lvl / week
		end;
		if contains(heroes,H_SHIVA) ~= nil then
			startThread(Spe_AddRecruits,H_SHIVA,player,CREATURE_SHAMAN,TOWN_BUILDING_DWELLING_2,3); -- Shamans - 3 * level recruits per week
		end;
		if contains(heroes,H_MUKHA) ~= nil then
			startThread(Spe_AddCreatures2,H_MUKHA,player,70,0.2); -- Titans - 1:3 - 2:8 - 3:13 - 4:18 - 5:23 ... 10:48
		end;
	end;
	print("Weekly run done.");
	PLAYER_WEEKLY_EVENTS_CHECK[player] = TURN;
end;

function ApplyHeroesSpe_onetime(player)
	print("Daily one time bonuses check for player "..player);
	local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,H_ISABEL) ~= nil then
			if (ONE_TIME_BONUSES[H_ISABEL] == 0) then
				ChangeHeroStat(H_ISABEL,5,2);
				ONE_TIME_BONUSES[H_ISABEL] = 1;
			end; --Luck +2
		end;
		if contains(heroes,H_RUTGER) ~= nil then
			local level = trunc(0.1*GetHeroLevel(H_RUTGER));
			if (ONE_TIME_BONUSES[H_RUTGER] <= level) then
				for i = ONE_TIME_BONUSES[H_RUTGER],level do
					GiveArtifact(H_RUTGER,ARTIFACTS_GAINS[H_RUTGER..i]);
				end;
				ONE_TIME_BONUSES[H_RUTGER] = 1+level;
			end; --Artifacts
		end;
		-- Preserve
		if contains(heroes,H_WYNGAAL) ~= nil then
			if (ONE_TIME_BONUSES[H_WYNGAAL] == 0) then
				ChangeHeroStat(H_WYNGAAL,6,3);
				ONE_TIME_BONUSES[H_WYNGAAL] = 1;
			end; --Morale +3
		end;
		if contains(heroes,H_ANWEN) ~= nil then
			local level = trunc(0.1*GetHeroLevel(H_ANWEN));
			if (ONE_TIME_BONUSES[H_ANWEN] <= level) then
				ChangeHeroStat(H_ANWEN,5,level-ONE_TIME_BONUSES[H_ANWEN]+1);
				ONE_TIME_BONUSES[H_ANWEN] = 1+level;
			end; --Luck +1 per 10 levels
		end;
		if contains(heroes,H_KYRRE) ~= nil then
			if (ONE_TIME_BONUSES[H_KYRRE] == 0) then
				if (GetHeroLevel(H_KYRRE) >= 30) then
					GiveArtifact(H_KYRRE,22);
					GiveArtifact(H_KYRRE,58);
					ONE_TIME_BONUSES[H_KYRRE] = 1;
				end;
			end; -- Ring of haste and Moonblade
		end;
		-- Necropolis
		if contains(heroes,H_THANT) ~= nil then
			local level = trunc(0.1*GetHeroLevel(H_THANT));
			if (ONE_TIME_BONUSES[H_THANT] <= level) then
				for i = ONE_TIME_BONUSES[H_THANT],level do
					GiveArtifact(H_THANT,ARTIFACTS_GAINS[H_THANT..i]);
				end;
				ONE_TIME_BONUSES[H_THANT] = 1+level;
			end; --Artifacts
		end;
	end;
	print("Daily one time bonuses check done.");
	PLAYER_ONETIME_EVENTS_CHECK[player] = TURN;
end;

function Initialize_PlayerHeroes(player)
	PLAYER_HEROES[player] = GetPlayerHeroes(player);
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function InitializeHeroes()
	for player = 1,8 do
		if (GetPlayerState(player) == 1) then
			PLAYER_HEROES[player] = GetPlayerHeroes(player);
			for hero in PLAYER_HEROES[player] do
				local faction = GetHeroFactionID(hero);
				startThread(START_ROUTINES[faction], player, hero);
			end;
		end;
	end;
end;

function DoPlayerHeroesSpe(player, newweek)
	while (not IsPlayerCurrent(player)) do sleep(10) end;
	print("Player "..player.." turn started");
	for hero in PLAYER_HEROES[player] do
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

