PLAYER_DAILY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's daily events
PLAYER_WEEKLY_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's weekly events
PLAYER_ONETIME_EVENTS_CHECK = {1,1,1,1,1,1,1,1}; -- last turn number applied for each player's onetime events
TURN = 1; -- current turn

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

ATTRIBUTE_NAME = {"Experience", "Offense", "Defense", "Spellpower", "Knowledge", "Luck", "Morale", "Movement", "Mana"};
RESOURCE_NAME = {"wood", "ores", "mercury", "cystals", "sulfur", "gems", "golds"};
ONE_TIME_BONUSES = {[H_ISABEL]=0,[H_RUTGER]=0,[H_WYNGAAL]=0,[H_ANWEN]=0,[H_KYRRE]=0,[H_JOSEPHINE]=0,[H_THANT]=0,[H_TOLGHAR]=0,[H_HEDWIG]=0};

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

TRANSFORM_ARRAY_FORTRESS = { 0,
	92,93,94,95,98,99,96,97,100,101,102,103,104,105,
	92,93,94,95,98,99,96,97,100,101,102,103,104,105,
	92,93,94,95,98,99,96,97,100,101,104,105,102,103,
	94,95,92,93,98,99,96,97,100,101,102,103,104,105,
	92,93,94,95,98,99,96,97,100,101,102,103,104,105,
	92,93,94,95,98,99,96,97,102,103,100,101,104,105,
	0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	166,167,169,168,170,171,172,
	0,0,0,0,
	92,93,96,97,98,99,94,95,100,101,102,103,104,105,
	166,167,169,168,170,171,172,
	166,167,169,168,171,170,172,
	167,166,169,168,170,171,172,
	166,167,169,168,170,172,171,
	166,167,169,168,170,171,172,
	0,0,0,0,0,0,0,
	166,168,169,167,170,171,172,
	0 };

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function Spe_AddCreatures(hero,player,u1,u2,u3,coef)
	print("Add creatures to hero "..hero);
	local level = GetHeroLevel(hero);
	local nb = round(coef*level);
	if nb >= 1 then
		local army = GetHeroArmy(hero);
		local b = 0;
		for i = 1,7 do
			if b ~= 0 then
				b = 1;
			elseif (army[i] == u1) then
				AddHeroCreatures(hero,u1,nb);
				b = 1;
			elseif (army[i] == u2) then	
				AddHeroCreatures(hero,u2,nb);
				b = 1;
			elseif (army[i] == u3) then	
				AddHeroCreatures(hero,u3,nb);
				b = 1;
			end;
		end;
		if b == 1 then ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb},hero,player,5) end;
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
				local b = 0;
				for i = 1,7 do
					if b ~= 0 then
						b = 1;
					elseif (army[i] == u1) then
						AddHeroCreatures(heroname,u1,nb);
						b = 1;
					elseif (army[i] == u2) then	
						AddHeroCreatures(heroname,u2,nb);
						b = 1;
					elseif (army[i] == u3) then	
						AddHeroCreatures(heroname,u3,nb);
						b = 1;
					end;
				end;
				if b == 1 then ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb},hero,player,5) end;
			end;
		end;
	end;
end;

function Spe_ArmyMultiply(hero,player,ids,coef)
	print("Multiply army size for hero "..hero);
	local level = GetHeroLevel(hero);
	local army = GetHeroArmy(hero);
	local total = 0;
	for i = 1,7 do
		for j = 1,length(ids) do
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

function Spe_UpgradeCreatures2(hero,player,base,upgrade)
	local nb = GetHeroCreatures(hero,base);
	RemoveHeroCreatures(hero,base,nb);
	AddHeroCreatures(hero,upgrade,nb);
	-- ShowFlyingSign({"/Text/Game/Scripts/Evolve.txt"; num=nb},hero,player,5);
end;

function Spe_TransformCreatures(hero,player,array)
	local army = GetHeroArmy(hero);
	for i=1,7 do
		if army[i] and army[i] ~= 0 then
			local id = array[army[i]];
			print("transform unit "..army[i].." into unit "..id)
			if id ~= 0 then
				local n = GetHeroCreatures(hero,army[i]);
				RemoveHeroCreatures(hero,army[i],n);
				AddHeroCreatures(hero,id,n);
			end;
		end;
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
		-- ShowFlyingSign({"/Text/Game/Scripts/Stats.txt"; stat=attribute},hero,player,5);
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
				-- ShowFlyingSign({"/Text/Game/Scripts/Stats.txt"; stat=attribute},heroname,player,5);
			end;
		end;
	end;
end;

function Spe_GiveStats3(hero,player,stat,coef)
	print("Adding statistics to hero "..hero);
	local total = GetHeroStat(hero,stat);
	local value = round(coef*total);
	if value >= 1 then
		ChangeHeroStat(hero,stat,value);
		local attribute = ATTRIBUTE_NAME[stat];
		-- ShowFlyingSign({"/Text/Game/Scripts/Stats.txt"; stat=attribute},hero,player,5);
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
		-- Academy
		if contains(heroes,H_HAVEZ) ~= nil then
			startThread(Spe_AddCreatures3,H_HAVEZ,player,57,58,159,1); -- Gremlins (other heroes) - 1*level
		end;
		if contains(heroes,H_FAIZ) ~= nil then
			local amount = 250 * power(2, trunc(0.143 * GetHeroLevel(H_FAIZ)));
			startThread(Spe_GiveResources,H_FAIZ,player,6,amount); -- Gold - 1:250 - 7:500 - 14:1000 - 21:2000 ... 49:32k
		end;
		if contains(heroes,H_GALIB) ~= nil then
			startThread(Spe_AddCreatures,H_GALIB,player,65,66,163,0.15); -- Djinn - 1:4 - 2:10 - 3:17 - 4:24 - 5:30 ... 8:50
		end;
		if contains(heroes,H_MAAHIR) ~= nil then
			startThread(Spe_GiveStats2,H_MAAHIR,player,0,0.03); -- Exp (other heroes) - 3% total hero exp
		end;
		if contains(heroes,H_THEODORUS) ~= nil then
			startThread(Spe_AddCreatures2,H_THEODORUS,player,114,0.09); -- Eagle - 1:6 - 2:17 - 3:28 - 4:39 - 5:50
			startThread(Spe_UpgradeCreatures,H_THEODORUS,player,114,91,160,50); -- Eagle to Phoenix for 50 Elemental Gargoyles
		end;
		-- Fortress
		if contains(heroes,H_HANGVUL) ~= nil then
			startThread(Spe_GiveStats3,H_HANGVUL,player,0,0.05); -- Exp - 5% total hero exp
		end;
		if contains(heroes,H_INGVAR) ~= nil then
			startThread(Spe_AddCreatures,H_INGVAR,player,92,93,166,0.5); -- Defenders - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
		end;
		if contains(heroes,H_ULAND) ~= nil then
			local n = 30 - trunc(GetHeroLevel(H_ULAND) * 0.5);
			startThread(Spe_UpgradeCreatures,H_ULAND,player,100,102,92,n); -- Rune Priest to Thane for n Defenders
			startThread(Spe_UpgradeCreatures,H_ULAND,player,100,103,93,n); -- Rune Priest to Flame lord for n Shieldguards
			startThread(Spe_UpgradeCreatures,H_ULAND,player,100,171,166,n); -- Rune Priest to Thunder Thane for n Mountain Guards
		end;
		if contains(heroes,H_EBBA) ~= nil then
			local amount = trunc(GetHeroLevel(H_EBBA) * 0.2);
			startThread(Spe_GiveResources,H_EBBA,player,3,amount); -- Crystal - +1 / 5 levels
			startThread(Spe_GiveResources,H_EBBA,player,5,amount); -- Gem - +1 / 5 levels
		end;
		if contains(heroes,H_ERLING) ~= nil then
			startThread(Spe_UpgradeCreatures2,H_ERLING,player,100,101); -- Rune Priest to Rune Patriarch
		end;
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
		-- Academy
		if contains(heroes,H_DAVIUS) ~= nil then
			startThread(Spe_AddRecruits,H_DAVIUS,player,CREATURE_RAKSHASA,TOWN_BUILDING_DWELLING_6,0.25); -- Rakshasas - 0.25 * level recruits per week
		end;
		-- Fortress
		if contains(heroes,H_ROLF) ~= nil then
			startThread(Spe_AddRecruits,H_ROLF,player,CREATURE_BEAR_RIDER,TOWN_BUILDING_DWELLING_4,1.75); -- Bears - 1.75 * level recruits per week
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
		-- Academy
		if contains(heroes,H_JOSEPHINE) ~= nil then
			local level = trunc(0.1*GetHeroLevel(H_JOSEPHINE));
			if (ONE_TIME_BONUSES[H_JOSEPHINE] <= level) then
				for i = ONE_TIME_BONUSES[H_JOSEPHINE],level do
					GiveArtifact(H_JOSEPHINE,ARTIFACTS_GAINS[H_JOSEPHINE..i]);
				end;
				ONE_TIME_BONUSES[H_JOSEPHINE] = 1+level;
			end; --Artifacts
		end;
		-- Fortress
		if contains(heroes,H_TOLGHAR) ~= nil then
			if (ONE_TIME_BONUSES[H_TOLGHAR] == 0) then
				ChangeHeroStat(H_TOLGHAR,5,2);
				ChangeHeroStat(H_TOLGHAR,6,2);
				ONE_TIME_BONUSES[H_TOLGHAR] = 1;
			end; --Luck and Morale +2
		end;
		if contains(heroes,H_HEDWIG) ~= nil then
			if (ONE_TIME_BONUSES[H_HEDWIG] == 0) then
				if (GetHeroLevel(H_HEDWIG) >= 40) then
					GiveArtifact(H_HEDWIG,48);
					GiveArtifact(H_HEDWIG,49);
					GiveArtifact(H_HEDWIG,50);
					GiveArtifact(H_HEDWIG,51);
					ONE_TIME_BONUSES[H_HEDWIG] = 1;
				end;
			end; -- Dwarven artfacts set
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


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function DoPlayerHeroesSpe(player,day)
	while (not IsPlayerCurrent(player)) do sleep(10) end;
	print("Player "..player.." turn");
	if ((day == 1) and (PLAYER_WEEKLY_EVENTS_CHECK[player] < TURN)) then ApplyHeroesSpe_weekly(player) end;
	if (PLAYER_DAILY_EVENTS_CHECK[player] < TURN) then ApplyHeroesSpe_daily(player) end;
	if (PLAYER_ONETIME_EVENTS_CHECK[player] < TURN) then ApplyHeroesSpe_onetime(player) end;
end;

function HeroesSpe_NewDay()
	local day = GetDate(DAY_OF_WEEK);
	for i = 1,8 do
		if (GetPlayerState(i) == 1) then
			startThread(DoPlayerHeroesSpe,i,day);
		end;
	end;
end;

function NewDayTrigger()
	TURN = TURN + 1;
	print("New day ! Turn "..TURN);
	startThread(HeroesSpe_NewDay);
end;


Trigger(NEW_DAY_TRIGGER,"NewDayTrigger");
