PLAYER_DAILY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's daily events
PLAYER_WEEKLY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's weekly events
PLAYER_ONETIME_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's onetime events
TURN = 1; -- current turn

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

ATTRIBUTE_NAME = {"None", "Attaque", "Defense", "Puissance Magique", "Esprit", "Moral", "Chance"};
RESOURCE_NAME = {"wood", "ores", "mercury", "cystals", "sulfur", "gems", "golds"};
ONE_TIME_BONUSES = {["Isabell"]=0,["Brem"]=0,["Linaas"]=0,["Metlirn"]=0,["Josephine"]=0};

ARTIFACTS_GAINS = {
	["Brem0"]=26,
	["Brem1"]=88,
	["Brem2"]=21,
	["Brem3"]=25,
	["Brem4"]=11,
	["Brem5"]=77 -- Wayfarer boots / Crown of leadership / Ring of life / Golden horseshoe / Crown of courage / Tome of light magic
	["Josephine0"]=87,
	["Josephine1"]=94,
	["Josephine2"]=35,
	["Josephine3"]=68,
	["Josephine4"]=45,
	["Josephine5"]=79 -- Tarot deck / Book of power / Tunic of enlightment / Sandal of the blessed / Staff of sar-issus / Tome of summoning magic
}

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function Spe_AddCreatures(hero,player,u1,u2,u3,coef)
	print("Add creatures to hero "..hero);
	local level = GetHeroLevel(hero);
	local nb = round(coef*level);
	if nb >= 1 then
		local army = GetHeroArmy(hero);
		local b = false;
		for i = 0,6 do
			if b then
				b = true;
			elseif (army[i] == u1) then
				AddHeroCreatures(hero,u1,nb);
				b = true;
			elseif (army[i] == u2) then	
				AddHeroCreatures(hero,u2,nb);
				b = true;
			elseif (army[i] == u3) then	
				AddHeroCreatures(hero,u3,nb);
				b = true;
			end;
		end;
		if b then ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb},hero,player,5) end;
	end;
end;

function Spe_AddCreatures2(hero,player,id,coef)
	print("Add specific creatures to hero "..hero);
	local level = GetHeroLevel(hero);
	local nb = round(coef*level);
	if nb >= 1 then
		AddHeroCreatures(hero,id,nb);
		ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb},hero,player,5);
	end;
end;

function Spe_AddCreatures3(hero,player,u1,u2,u3,coef)
	print("Add creatures to heroes other than "..hero);
	local level = GetHeroLevel(hero);
	local nb = round(coef*level);
	for i,heroname in GetPlayerHeroes(player) do
		if heroname ~= hero then
			if nb >= 1 then
				local army = GetHeroArmy(heroname);
				local b = false;
				for i = 0,6 do
					if b then
						b = true;
					elseif (army[i] == u1) then
						AddHeroCreatures(heroname,u1,nb);
						b = true;
					elseif (army[i] == u2) then	
						AddHeroCreatures(heroname,u2,nb);
						b = true;
					elseif (army[i] == u3) then	
						AddHeroCreatures(heroname,u3,nb);
						b = true;
					end;
				end;
				if b then ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb},hero,player,5) end;
			end;
		end;
	end;
end;

function Spe_ArmyMultiply(hero,player,ids,coef)
	print("Multiply army size for hero "..hero);
	local level = GetHeroLevel(hero);
	local army = GetHeroArmy(hero);
	local total = 0;
	for i = 0,6 do
		for j = 0,length(ids) do
			local id = ids[j];
			if (army[i] == id) then
				local nb = trunc(GetHeroCreatures(hero,id) * level * coef);
				if nb >= 1 then
					AddHeroCreatures(hero,id,nb);
					total = total + nb;
				end;
			end;
		end;
	end;
	ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=total},hero,player,5);
end;

function Spe_CallCreatures(hero,player,creature,dwelling,coef)
	print("Call creatures from towns to hero "..hero);
	local level = GetHeroLevel(hero);
	local towns = GetHeroTowns(player,hero);
	for i,town in towns do
		if GetTownBuildingLevel(town,dwelling) ~= 0 then
			local recruits = GetObjectDwellingCreatures(town,creature);
			local amount = min(level*coef,recruits);
			if amount >= 1 then
				SetObjectDwellingCreatures(town,creature,recruits-amount+1);
				AddHeroCreatures(hero,creature,amount);
				ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=amount},hero,player,5);
				-- ShowFlyingSign({"/Text/Game/Scripts/Called.txt"; num=nb},hero,player,5);
			end;
		end;
	end;
end;

function Spe_AddRecruits(hero,player,creature,dwelling,coef)
	print("Adding recruits from hero "..hero);
	local level = GetHeroLevel(hero);
	local towns = GetHeroTowns(player,hero);
	local nb = round(coef*level);
	if nb >= 1 then
		for i,town in towns do
			if GetTownBuildingLevel(town,dwelling) ~= 0 then
				SetObjectDwellingCreatures(town,creature,GetObjectDwellingCreatures(town,creature) + nb);
				ShowFlyingSign({"/Text/Game/Scripts/Recruits.txt"; num=nb},hero,player,5);
			end;
		end;
	end;
end;

function Spe_GiveStats(hero,player,stat,coef)
	print("Adding statistics to hero "..hero);
	-- 0 exp - 1 offence - 2 defence - 3 spellpower - 4 knowledge - 5 luck - 6 morale - 7 movement - 8 mana
	local level = GetHeroLevel(hero);
	local amount = trunc(coef*level);
	if amount >= 1 then
		ChangeHeroStat(hero,stat,amount);
		local attribute = ATTRIBUTE_NAME[stat];
		ShowFlyingSign({"/Text/Game/Scripts/Stats.txt"; stat=attribute},hero,player,5);
	end;
end;

function Spe_GiveResources(hero,player,resource,chosenamount)
	print("Adding resources from hero "..hero);
	-- resource : 0 wood - 1 ore - 2 mercury - 3 crystal - 4 sulfur - 5 gems - 6 gold
	local currentamount = GetPlayerResource(player,resource);
	local newamount = currentamount + chosenamount;
	if chosenamount > 0 then
		SetPlayerResource(player,resource,newamount);
		ShowFlyingSign({"/Text/Game/Scripts/Resources.txt"; num=chosenamount},hero,player,5);
	end;
end;

function Spe_GetResourceAmount(hero)
	print("Compute amount of resources for hero "..hero);
	local level = GetHeroLevel(hero);
	if hero == "Orlando" then return (level-1) * 250 end;
	if hero == "Mephala" then return trunc(level * 0.5) end;
	if hero == "Faiz" then return 250 * power(2, trunc(0.143*level)) - 250 end;
	if hero == "Harkenraz" then return trunc(0.34*level) end;
	if hero == "Menel" then return trunc(level * 0.2) end;
	return 1;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function ApplyHeroesSpe_daily(player)
	print("Daily run for player "..player);
	local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,"Orlando") ~= nil then startThread(Spe_GiveResources,"Orlando",player,6,Spe_GetResourceAmount("Orlando")) end; -- Gold - 250*level
		if contains(heroes,"Sarge") ~= nil then startThread(Spe_AddCreatures,"Sarge",player,11,12,111,0.05) end; -- Cavalier - 1:10 - 2:30 - 3:50
		if contains(heroes,"RedHeavenHero06") ~= nil then startThread(Spe_AddCreatures2,"RedHeavenHero06",player,110,0.13) end; -- Zealot - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		-- Preserve
		if contains(heroes,"Diraya") ~= nil then startThread(Spe_AddCreatures2,"Diraya",player,44,0.5) end; -- Sprites - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		if contains(heroes,"Jenova") ~= nil then startThread(Spe_AddCreatures,"Jenova",player,55,56,151,0.03) end; -- Green Dragon - 1:17 - 2:50
		if contains(heroes,"Arniel") ~= nil then startThread(Spe_AddCreatures2,"Arniel",player,113,0.5) end; -- Wolf - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		if contains(heroes,"Elleshar") ~= nil then startThread(Spe_GiveStats,"Elleshar",player,0,500) end; -- Exp - +500*level
		if contains(heroes,"Mephala") ~= nil then startThread(Spe_GiveResources,"Mephala",player,random(1),Spe_GetResourceAmount("Mephala")) end; -- Wood or Ore - +1 / 2 levels
		-- Academy
		if contains(heroes,"Havez") ~= nil then startThread(Spe_AddCreatures3,"Havez",player,57,58,159,1) end; -- Gremlins - 1*level
		if contains(heroes,"Faiz") ~= nil then startThread(Spe_GiveResources,"Faiz",player,6,Spe_GetResourceAmount("Faiz")) end; -- Gold - 1:250 - 7:500 - 14:1000 - 21:2000 ... 49:32k
		if contains(heroes,"Tan") ~= nil then startThread(Spe_AddCreatures,"Tan",player,65,66,163,0.15) end; -- Djinn - 1:4 - 2:10 - 3:17 - 4:24 - 5:30 ... 8:50
		if contains(heroes,"Timerkhan") ~= nil then startThread(Spe_AddCreatures2,"Timerkhan",player,114,0.09) end; -- Eagle - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
		-- Fortress
		if contains(heroes,"Hangvul2") ~= nil then startThread(Spe_AddCreatures,"Hangvul2",player,102,103,171,0.09) end; -- Thane - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
		-- Necropolis
		if contains(heroes,"Effig") ~= nil then startThread(Spe_AddCreatures,"Effig",player,37,38,156,0.12) end; -- Lich - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		if contains(heroes,"Thant") ~= nil then startThread(Spe_AddCreatures2,"Thant",player,116,0.25) end; -- Mummy - 1:2 - 2:6 - 3:10 - 4:14 - 5:18 ... 13:50
		if contains(heroes,"Xerxon") ~= nil then startThread(Spe_AddCreatures2,"Xerxon",player,89,0.1) end; -- Black Knight - 1:5 - 2:15 - 3:25 - 4:35 - 5:45
		-- Inferno
		if contains(heroes,"Harkenraz") ~= nil then startThread(Spe_GiveResources,"Harkenraz",player,4,Spe_GetResourceAmount("Harkenraz")) end; -- Gold 250 - Sulfur +1 / 3 levels
		if contains(heroes,"Ash") ~= nil then startThread(Spe_AddCreatures,"Ash",player,23,24,135,0.13) end; -- Hellmare - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		if contains(heroes,"Sovereign") ~= nil then startThread(Spe_AddCreatures,"Sovereign",player,25,26,136,0.09) end; -- Pitlord - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
		-- Dungeon
		if contains(heroes,"Menel") ~= nil then startThread(Spe_GiveResources,"Menel",player,6,Spe_GetResourceAmount("Menel")) end; -- Gold - 5:100 - 10:200 - 20:400 ... 50:1000
		if contains(heroes,"Ferigl") ~= nil then startThread(Spe_AddCreatures,"Ferigl",player,77,78,141,0.12) end; -- Raptor - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		if contains(heroes,"Eruina") ~= nil then startThread(Spe_AddCreatures,"Eruina",player,81,82,143,0.08) end; -- Matron - 1:7 - 2:19 - 3:32 - 4:44
		if contains(heroes,"Almegir") ~= nil then startThread(Spe_AddCreatures2,"Almegir",player,115,0.13) end; -- Manticore - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		-- Stronghold
		if contains(heroes,"Hero6") ~= nil then startThread(Spe_AddCreatures,"Hero6",player,127,128,178,0.05) end; -- Wyvern - 1:10 - 2:30 - 3:50
	end;
	print("Daily run done.");
	PLAYER_DAILY_EVENTS_CHECK[player] = TURN;
end;

function ApplyHeroesSpe_weekly(player)
	print("Weekly run for player "..player);
    local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,"Nathaniel") ~= nil then startThread(Spe_AddRecruits,"Nathaniel",player,CREATURE_PEASANT,TOWN_BUILDING_DWELLING_1,7) end;
		if contains(heroes,"Ving") ~= nil then startThread(Spe_CallCreatures,"Ving",player,CREATURE_GRIFFIN,TOWN_BUILDING_DWELLING_4,1.5) end;
		if contains(heroes,"RedHeavenHero05") ~= nil then startThread(Spe_GiveStats,"RedHeavenHero05",player,1,0.1) end; -- Attack - +1 / 10*lvl / week
		if contains(heroes,"Nicolai") ~= nil then startThread(Spe_ArmyMultiply,"Nicolai",player,{1,2,106,3,4,107,5,6,108,9,10,110},0.01) end; -- T1 T2 T3 T5 : 1% * level
		-- Preserve
		if contains(heroes,"Gillion") ~= nil then startThread(Spe_AddRecruits,"Gillion",player,CREATURE_BLADE_JUGGLER,TOWN_BUILDING_DWELLING_1,6) end;
		if contains(heroes,"Itil") ~= nil then startThread(Spe_CallCreatures,"Itil",player,CREATURE_UNICORN,TOWN_BUILDING_DWELLING_5,0.75) end;
		if contains(heroes,"Vinrael") ~= nil then startThread(Spe_GiveStats,"Vinrael",player,3,0.2) end; -- Spellpower - +1 / 5*lvl / week
		if contains(heroes,"Nadaur") ~= nil then startThread(Spe_GiveStats,"Nadaur",player,1,0.1) end; -- Attack - +1 / 10*lvl / week
		-- Academy
		if contains(heroes,"Davius") ~= nil then startThread(Spe_AddRecruits,"Davius",player,CREATURE_RAKSHASA,TOWN_BUILDING_DWELLING_6,0.25) end;
		-- Fortress
		if contains(heroes,"Ingvar") ~= nil then startThread(Spe_AddRecruits,"Ingvar",player,CREATURE_DEFENDER,TOWN_BUILDING_DWELLING_1,3) end;
		if contains(heroes,"Rolf") ~= nil then startThread(Spe_AddRecruits,"Rolf",player,CREATURE_BEAR_RIDER,TOWN_BUILDING_DWELLING_4,0.9) end;
		if contains(heroes,"Egil") ~= nil then startThread(Spe_AddRecruits,"Egil",player,CREATURE_RUNE_MAGE,TOWN_BUILDING_DWELLING_5,0.3) end;
		-- Necropolis
		if contains(heroes,"Straker") ~= nil then startThread(Spe_AddRecruits,"Straker",player,CREATURE_WALKING_DEAD,TOWN_BUILDING_DWELLING_2,2.5) end;
		if contains(heroes,"Tamika") ~= nil then startThread(Spe_AddRecruits,"Tamika",player,CREATURE_VAMPIRE,TOWN_BUILDING_DWELLING_4,0.9) end;
		-- Inferno
		if contains(heroes,"Calid") ~= nil then startThread(Spe_AddRecruits,"Calid",player,CREATURE_HELL_HOUND,TOWN_BUILDING_DWELLING_3,1.5) end;
		if contains(heroes,"Oddrema") ~= nil then startThread(Spe_AddRecruits,"Oddrema",player,CREATURE_SUCCUBUS,TOWN_BUILDING_DWELLING_4,0.9) end;
		if contains(heroes,"Malustar") ~= nil then startThread(Spe_GiveStats,"Malustar",player,1+random(3),0.1) end; -- Random attribute - +1 / 10*lvl / week
		-- Dungeon
		if contains(heroes,"Ohtarig") ~= nil then startThread(Spe_AddRecruits,"Ohtarig",player,CREATURE_SCOUT,TOWN_BUILDING_DWELLING_1,3) end;
		if contains(heroes,"Urunir") ~= nil then startThread(Spe_AddRecruits,"Urunir",player,CREATURE_WITCH,TOWN_BUILDING_DWELLING_2,2.4) end;
		if contains(heroes,"Darkstorm") ~= nil then startThread(Spe_AddRecruits,"Darkstorm",player,CREATURE_MINOTAUR,TOWN_BUILDING_DWELLING_3,1.4) end;
		-- Stronghold
		if contains(heroes,"Hero8") ~= nil then startThread(Spe_AddRecruits,"Hero8",player,CREATURE_ORC_WARRIOR,TOWN_BUILDING_DWELLING_3,1.4) end;
		if contains(heroes,"Hero4") ~= nil then startThread(Spe_AddRecruits,"Hero4",player,CREATURE_CENTAUR,TOWN_BUILDING_DWELLING_4,0.8) end;
		if contains(heroes,"Kunyak") ~= nil then startThread(Spe_AddRecruits,"Kunyak",player,CREATURE_ORCCHIEF_BUTCHER,TOWN_BUILDING_DWELLING_5,0.3) end;
		if contains(heroes,"Zouleika") ~= nil then startThread(Spe_GiveStats,"Zouleika",player,3+random(1),0.1) end; --Spellpower or Knowledge - +1 / 10*lvl / week
	end;
	print("Weekly run done.");
	PLAYER_WEEKLY_EVENTS_CHECK[player] = TURN;
end;

function ApplyHeroesSpe_onetime(player)
	print("Daily one time bonuses check for player "..player);
	local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,"Isabell") ~= nil then
			if (ONE_TIME_BONUSES["Isabell"] == 0) then
				ChangeHeroStat("Isabell",5,2);
				ONE_TIME_BONUSES["Isabell"] = 1;
			end; --Luck +2
		end;
		if contains(heroes,"Brem") ~= nil then
			local level = trunc(0.1*GetHeroLevel("Brem"));
			if (ONE_TIME_BONUSES["Brem"] <= level) then
				for i = ONE_TIME_BONUSES["Brem"],level do
					GiveArtifact("Brem",ARTIFACTS_GAINS["Brem"..i]);
				end;
				ONE_TIME_BONUSES["Brem"] = 1+level;
			end; --Artifacts
		end;
		-- Preserve
		if contains(heroes,"Linaas") ~= nil then
			if (ONE_TIME_BONUSES["Linaas"] == 0) then
				ChangeHeroStat("Linaas",6,2);
				ONE_TIME_BONUSES["Linaas"] = 1;
			end; --Morale +2
		end;
		if contains(heroes,"Metlirn") ~= nil then
			if (ONE_TIME_BONUSES["Metlirn"] == 0) then
				ChangeHeroStat("Metlirn",5,2);
				ONE_TIME_BONUSES["Metlirn"] = 1;
			end; --Luck +2
		end;
		-- Academy
		if contains(heroes,"Josephine") ~= nil then
			local level = trunc(0.1*GetHeroLevel("Josephine"));
			if (ONE_TIME_BONUSES["Josephine"] <= level) then
				for i = ONE_TIME_BONUSES["Josephine"],level do
					GiveArtifact("Josephine",ARTIFACTS_GAINS["Josephine"..i]);
				end;
				ONE_TIME_BONUSES["Josephine"] = 1+level;
			end; --Artifacts
		end;
	end;
	print("Daily one time bonuses check done.");
	PLAYER_ONETIME_EVENTS_CHECK[player] = TURN;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function HeroesSpe_NewDay()
	local day = GetDate(DAY_OF_WEEK);
	for i = 1,8 do
		if (GetPlayerState(i) == 1) then
			if (IsPlayerCurrent(i)) then
				if ((day == 1) and (PLAYER_WEEKLY_EVENTS_CHECK[i] < TURN)) then ApplyHeroesSpe_weekly(i) end;
				if (PLAYER_DAILY_EVENTS_CHECK[i] < TURN) then ApplyHeroesSpe_daily(i) end;
				if (PLAYER_ONETIME_EVENTS_CHECK[i] < TURN) then ApplyHeroesSpe_onetime(i) end;
			end;
		end;
	end;
end;

function HeroesSpe_LevelUp()

end;

function HeroesSpe_Recruit(hero)

end;

function NewDayTrigger()
	TURN = TURN + 1;
	print("New day ! Turn "..TURN);
	startThread(HeroesSpe_NewDay);
end;


Trigger(NEW_DAY_TRIGGER,"NewDayTrigger");
-- Trigger(PLAYER_ADD_HERO_TRIGGER,"player","HeroesSpe_Recruit");
-- Trigger(HERO_LEVELUP_TRIGGER,"hero","HeroesSpe_LevelUp");
