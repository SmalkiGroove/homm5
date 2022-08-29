PLAYER_DAILY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's daily events
PLAYER_WEEKLY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's weekly events
PLAYER_ONETIME_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's onetime events
TURN = 1; -- current turn

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

ATTRIBUTE_NAME = {"Experience", "Offense", "Defense", "Spellpower", "Knowledge", "Luck", "Morale", "Movement", "Mana"};
RESOURCE_NAME = {"wood", "ores", "mercury", "cystals", "sulfur", "gems", "golds"};
ONE_TIME_BONUSES = {["Isabell"]=0,["Brem"]=0,["Linaas"]=0,["Metlirn"]=0,["Josephine"]=0,["Thant"]=0};

ARTIFACTS_GAINS = {
	["Brem0"]=26,
	["Brem1"]=88,
	["Brem2"]=21,
	["Brem3"]=25,
	["Brem4"]=11,
	["Brem5"]=77, -- Wayfarer boots / Crown of leadership / Ring of life / Golden horseshoe / Crown of courage / Tome of light magic
	["Josephine0"]=87,
	["Josephine1"]=94,
	["Josephine2"]=35,
	["Josephine3"]=68,
	["Josephine4"]=45,
	["Josephine5"]=79, -- Tarot deck / Book of power / Tunic of enlightment / Sandal of the blessed / Staff of sar-issus / Tome of summoning magic
	["Thant0"]=55,
	["Thant1"]=64,
	["Thant2"]=71,
	["Thant3"]=63,
	["Thant4"]=83,
	["Thant5"]=78, -- Necromancer's Helm / Tunic of carved flesh / Amulet of Necromancy / Cursed Ring / Skull of Markal / Tome of dark magic
};

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

function Spe_UpgradeCreatures(hero,player,base,upgrade,consume,coef)
	local army = GetHeroArmy(hero);
	local nb_base = GetHeroCreatures(hero,base);
	local nb_consume = GetHeroCreatures(hero,consume);
	if nb_consume >= coef then
		local nb = trunc(nb_consume / coef);
		nb = min(nb, nb_base);
		RemoveHeroCreatures(hero,consume,nb*coef);
		RemoveHeroCreatures(hero,base,nb);
		AddHeroCreatures(hero,upgrade,nb);
		-- ShowFlyingSign({"/Text/Game/Scripts/Evolve.txt"; num=nb},hero,player,5);
	end;
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

function Spe_GiveStats2(hero,player,stat,coef)
	print("Adding statistics to heroes other than "..hero);
	local total = GetHeroStat(hero,stat);
	local value = round(coef*total);
	for i,heroname in GetPlayerHeroes(player) do
		if heroname ~= hero then
			if value >= 1 then
				ChangeHeroStat(heroname,stat,value);
				local attribute = ATTRIBUTE_NAME[stat];
				ShowFlyingSign({"/Text/Game/Scripts/Stats.txt"; stat=attribute},heroname,player,5);
			end;
		end;
	end;
end;

function Spe_GiveResources(hero,player,resource,chosenamount)
	print("Adding resources from hero "..hero);
	-- resource : 0 wood - 1 ore - 2 mercury - 3 crystal - 4 sulfur - 5 gems - 6 gold
	if chosenamount ~= nil and chosenamount > 0 then
		local currentamount = GetPlayerResource(player,resource);
		local newamount = currentamount + chosenamount;
		SetPlayerResource(player,resource,newamount);
		ShowFlyingSign({"/Text/Game/Scripts/Resources.txt"; num=chosenamount},hero,player,5);
	end;
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function ApplyHeroesSpe_daily(player)
	print("Daily run for player "..player);
	local heroes = GetPlayerHeroes(player);
	if heroes~=nil then
		-- Haven
		if contains(heroes,"Orlando") ~= nil then
			local amount = (GetHeroLevel("Orlando") - 1) * 250;
			startThread(Spe_GiveResources,"Orlando",player,6,amount); -- Gold - 250*level
		end;
		if contains(heroes,"Sarge") ~= nil then
			startThread(Spe_AddCreatures,"Sarge",player,11,12,111,0.05) -- Cavalier - 1:10 - 2:30 - 3:50
		end;
		if contains(heroes,"RedHeavenHero06") ~= nil then
			startThread(Spe_AddCreatures2,"RedHeavenHero06",player,110,0.13); -- Zealot - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		end;
		-- Preserve
		if contains(heroes,"Diraya") ~= nil then
			startThread(Spe_AddCreatures2,"Diraya",player,44,0.5); -- Sprites - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		end;
		if contains(heroes,"Jenova") ~= nil then
			startThread(Spe_AddCreatures,"Jenova",player,55,56,151,0.03); -- Green Dragon - 1:17 - 2:50
		end;
		if contains(heroes,"Arniel") ~= nil then
			startThread(Spe_AddCreatures2,"Arniel",player,113,0.5); -- Wolf - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		end;
		if contains(heroes,"Elleshar") ~= nil then
			startThread(Spe_GiveStats,"Elleshar",player,0,300); -- Exp - +300 * level
		end;
		if contains(heroes,"Mephala") ~= nil then
			local amount = trunc(GetHeroLevel("Mephala") * 0.5);
			local res = random(1);
			startThread(Spe_GiveResources,"Mephala",player,res,amount); -- Wood or Ore - +1 / 2 levels
		end;
		-- Academy
		if contains(heroes,"Havez") ~= nil then
			startThread(Spe_AddCreatures3,"Havez",player,57,58,159,1); -- Gremlins (other heroes) - 1*level
		end;
		if contains(heroes,"Faiz") ~= nil then
			local amount = 250 * power(2, trunc(0.143 * GetHeroLevel("Faiz")));
			startThread(Spe_GiveResources,"Faiz",player,6,amount); -- Gold - 1:250 - 7:500 - 14:1000 - 21:2000 ... 49:32k
		end;
		if contains(heroes,"Tan") ~= nil then
			startThread(Spe_AddCreatures,"Tan",player,65,66,163,0.15); -- Djinn - 1:4 - 2:10 - 3:17 - 4:24 - 5:30 ... 8:50
		end;
		if contains(heroes,"Maahir") ~= nil then
			startThread(Spe_GiveStats2,"Maahir",player,0,0.02); -- Exp (other heroes) - 2% total hero exp
		end;
		if contains(heroes,"Timerkhan") ~= nil then
			startThread(Spe_AddCreatures2,"Timerkhan",player,114,0.09); -- Eagle - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
			startThread(Spe_UpgradeCreatures,"Timerkhan",player,114,91,160,50); -- Eagle to Phoenix for 50 Elemental Gargoyles
		end;
		-- Fortress
		if contains(heroes,"Hangvul2") ~= nil then
			startThread(Spe_AddCreatures,"Hangvul2",player,102,103,171,0.09); -- Thane - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
		end;
		-- Necropolis
		if contains(heroes,"Aberrar") ~= nil then
			startThread(Spe_AddCreatures,"Aberrar",player,37,38,156,0.12); -- Lich - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		end;
		if contains(heroes,"Thant") ~= nil then
			startThread(Spe_AddCreatures2,"Thant",player,116,0.25); -- Mummy - 1:2 - 2:6 - 3:10 - 4:14 - 5:18 ... 13:50
		end;
		if contains(heroes,"Xerxon") ~= nil then
			startThread(Spe_AddCreatures2,"Xerxon",player,89,0.1); -- Black Knight - 1:5 - 2:15 - 3:25 - 4:35 - 5:45
			startThread(Spe_UpgradeCreatures,"Xerxon",player,89,90,37,1); -- B.Knights to D.Knights for 1 Lich
		end;
		-- Inferno
		if contains(heroes,"Calid") ~= nil then
			startThread(Spe_AddCreatures,"Calid",player,19,20,133,0.33); -- Hell hounds - 1:2 - 2:5 - 3:8 - 4:11 - ... - 17:50
		end;
		if contains(heroes,"Harkenraz") ~= nil then
			local amount = trunc(0.34 * GetHeroLevel("Harkenraz"));
			startThread(Spe_GiveResources,"Harkenraz",player,4,amount); -- Sulfur - +1 / 3 levels
		end;
		if contains(heroes,"Grok") ~= nil then
			startThread(Spe_AddCreatures,"Ash",player,23,24,135,0.12); -- Hellmare - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
		end;
		if contains(heroes,"Sovereign") ~= nil then
			startThread(Spe_AddCreatures,"Sovereign",player,25,26,136,0.09); -- Pitlord - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
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
		if contains(heroes,"Hero6") ~= nil then
			startThread(Spe_AddCreatures,"Hero6",player,127,128,178,0.05); -- Wyvern - 1:10 - 2:30 - 3:50
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
		if contains(heroes,"Nathaniel") ~= nil then
			startThread(Spe_AddRecruits,"Nathaniel",player,CREATURE_PEASANT,TOWN_BUILDING_DWELLING_1,7); -- Peasants - 7 * level recruits per week
		end;
		if contains(heroes,"Ving") ~= nil then
			startThread(Spe_CallCreatures,"Ving",player,CREATURE_GRIFFIN,TOWN_BUILDING_DWELLING_4,1.5); -- Griffins - 1.5 * level transfered
		end;
		if contains(heroes,"RedHeavenHero05") ~= nil then
			startThread(Spe_GiveStats,"RedHeavenHero05",player,1,0.1); -- Attack - +1 / 10*lvl / week
		end;
		if contains(heroes,"Nicolai") ~= nil then
			startThread(Spe_ArmyMultiply,"Nicolai",player,{3,4,107,5,6,108,9,10,110},0.01); -- T2 T3 T5 : 1% * level
		end;
		-- Preserve
		if contains(heroes,"Gillion") ~= nil then
			startThread(Spe_AddRecruits,"Gillion",player,CREATURE_BLADE_JUGGLER,TOWN_BUILDING_DWELLING_1,6); -- Blade Jugglers - 6 * level recruits per week
		end;
		if contains(heroes,"Itil") ~= nil then
			startThread(Spe_CallCreatures,"Itil",player,CREATURE_UNICORN,TOWN_BUILDING_DWELLING_5,0.75); -- Unicorns - 0.75 * level transfered
		end;
		if contains(heroes,"Vinrael") ~= nil then
			startThread(Spe_GiveStats,"Vinrael",player,3,0.2); -- Spellpower - +1 / 5*lvl / week
		end;
		if contains(heroes,"Nadaur") ~= nil then
			startThread(Spe_GiveStats,"Nadaur",player,1,0.1); -- Attack - +1 / 10*lvl / week
		end;
		-- Academy
		if contains(heroes,"Davius") ~= nil then
			startThread(Spe_AddRecruits,"Davius",player,CREATURE_RAKSHASA,TOWN_BUILDING_DWELLING_6,0.25); -- Rakshasas - 0.25 * level recruits per week
		end;
		-- Fortress
		if contains(heroes,"Ingvar") ~= nil then
			startThread(Spe_AddRecruits,"Ingvar",player,CREATURE_DEFENDER,TOWN_BUILDING_DWELLING_1,3);
		end;
		if contains(heroes,"Rolf") ~= nil then
			startThread(Spe_AddRecruits,"Rolf",player,CREATURE_BEAR_RIDER,TOWN_BUILDING_DWELLING_4,0.9);
		end;
		if contains(heroes,"Egil") ~= nil then
			startThread(Spe_AddRecruits,"Egil",player,CREATURE_RUNE_MAGE,TOWN_BUILDING_DWELLING_5,0.3);
		end;
		-- Necropolis
		if contains(heroes,"Nemor") ~= nil then
			startThread(Spe_AddCreatures2,"Nemor",player,157,0.13); -- Banshee - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
		end;
		if contains(heroes,"Arantir") ~= nil then
			startThread(Spe_AddRecruits,"Arantir",player,CREATURE_SKELETON,TOWN_BUILDING_DWELLING_1,3.5); -- Skeletons - 3.5 * level recruits per week
			startThread(Spe_AddRecruits,"Arantir",player,CREATURE_WALKING_DEAD,TOWN_BUILDING_DWELLING_2,2); -- Walking deads - 2 * level recruits per week
			startThread(Spe_AddRecruits,"Arantir",player,CREATURE_GHOST,TOWN_BUILDING_DWELLING_3,0.75); -- Ghosts - 0.75 * level recruits per week
		end;
		if contains(heroes,"Tamika") ~= nil then
			startThread(Spe_CallCreatures,"Tamika",player,CREATURE_VAMPIRE,TOWN_BUILDING_DWELLING_4,1.5); -- Vampires - 1.5 * level transfered
		end;
		-- Inferno
		if contains(heroes,"Zydar") ~= nil then
			startThread(Spe_AddRecruits,"Zydar",player,CREATURE_FAMILIAR,TOWN_BUILDING_DWELLING_1,2.5); -- Imps - 2.5 * level recruits per week
			startThread(Spe_AddRecruits,"Zydar",player,CREATURE_DEMON,TOWN_BUILDING_DWELLING_2,1.5); -- Horned demons - 1.5 * level recruits per week
			startThread(Spe_AddRecruits,"Zydar",player,CREATURE_DEVIL,TOWN_BUILDING_DWELLING_7,0.1); -- Devils - 0.1 * level recruits per week
		end;
		if contains(heroes,"Malustar") ~= nil then
			local stat = 1+random(3);
			startThread(Spe_GiveStats,"Malustar",player,stat,0.2); -- Random attribute - +1 / 5*lvl / week
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
		if contains(heroes,"Hero8") ~= nil then
			startThread(Spe_AddRecruits,"Hero8",player,CREATURE_ORC_WARRIOR,TOWN_BUILDING_DWELLING_3,1.4);
		end;
		if contains(heroes,"Hero4") ~= nil then
			startThread(Spe_AddRecruits,"Hero4",player,CREATURE_CENTAUR,TOWN_BUILDING_DWELLING_4,0.8);
		end;
		if contains(heroes,"Kunyak") ~= nil then
			startThread(Spe_AddRecruits,"Kunyak",player,CREATURE_ORCCHIEF_BUTCHER,TOWN_BUILDING_DWELLING_5,0.3);
		end;
		if contains(heroes,"Zouleika") ~= nil then
			local stat = 3+random(1);
			startThread(Spe_GiveStats,"Zouleika",player,stat,0.1); --Spellpower or Knowledge - +1 / 10*lvl / week
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
		-- Necropolis
		if contains(heroes,"Thant") ~= nil then
			local level = trunc(0.1*GetHeroLevel("Thant"));
			if (ONE_TIME_BONUSES["Thant"] <= level) then
				for i = ONE_TIME_BONUSES["Thant"],level do
					GiveArtifact("Thant",ARTIFACTS_GAINS["Thant"..i]);
				end;
				ONE_TIME_BONUSES["Thant"] = 1+level;
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
