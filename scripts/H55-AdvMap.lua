------------------------------------------------------------------------------------------------------------------------------------------------
--MIGHT & MAGIC: HEROES 5.5 - ADVENTURE MAP
------------------------------------------------------------------------------------------------------------------------------------------------

--Author: Magnomagus
--Website: http://heroescommunity.com/viewthread.php3?TID=41303

------------------------------------------------------------------------------------------------------------------------------------------------------
--TRIGGERS
------------------------------------------------------------------------------------------------------------------------------------------------------

function H55_PrepareAdvMap()
	print("H55 Preparing Advmap..");
	
	local alltowns = GetObjectNamesByType("TOWN"); 
	
	------------------------------------------------------------------------------------------------------------------------------------------------
	--H55_DEBUG = {101,"TownLevels",1,"NoHero"};------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {102,"ShamanPatterns",1,"NoHero"};--------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	for i,shaman in H55_Shamans do
		H55_ShamanPattern[shaman] = random(6)+1;	
	end;
	for i,witch in H55_Witches do
		H55_ShamanPattern[witch] = random(6)+1;	
	end;	
	
	------------------------------------------------------------------------------------------------------------------------------------------------
	--H55_DEBUG = {103,"AIHandicap",1,"NoHero"};------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {104,"StartingBonus",1,"NoHero"};---------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	for i=1,8 do
		if (GetPlayerState(i) == 1) and (H55_IsThisAIPlayer(i) ~= 1) then
			local heroes = GetPlayerHeroes(i);
			local goldtoken = GetPlayerResource(i,6);
			local woodtoken = GetPlayerResource(i,0);
			local oretoken = GetPlayerResource(i,1);
			local mercurytoken = GetPlayerResource(i,2);
			local crystaltoken = GetPlayerResource(i,3);
			local sulphurtoken = GetPlayerResource(i,4);
			local gemtoken = GetPlayerResource(i,5);			
			if contains(H55_StartBonusGold,goldtoken) ~= nil then
				H55_GiveResourcesSilent(i,6,2500);
			end;
			if heroes ~= nil then
				if H55_Difficulty == 0 then 
					if contains(H55_StartBonusNormalWO,woodtoken) ~= nil then
						SetPlayerResource(i,0,30);
						H55_StartCreatureBonus(i,heroes[0],1,4);
					end;
					if contains(H55_StartBonusNormalWO,oretoken) ~= nil then
						SetPlayerResource(i,1,30);			
					end;
					if contains(H55_StartBonusNormal,mercurytoken) ~= nil then
						SetPlayerResource(i,2,15);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusNormal,crystaltoken) ~= nil then
						SetPlayerResource(i,3,15);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusNormal,sulphurtoken) ~= nil then
						SetPlayerResource(i,4,15);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusNormal,gemtoken) ~= nil then
						SetPlayerResource(i,5,15);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
				elseif H55_Difficulty == 3 then
					if contains(H55_StartBonusImpossibleWO,woodtoken) ~= nil then
						SetPlayerResource(i,0,10);
						H55_StartCreatureBonus(i,heroes[0],1,4);				
					end;
					if contains(H55_StartBonusImpossibleWO,oretoken) ~= nil then
						SetPlayerResource(i,1,10);		
					end;
					if contains(H55_StartBonusImpossible,mercurytoken) ~= nil then
						SetPlayerResource(i,2,5);
						H55_StartCreatureBonus(i,heroes[0],1,4);						
					end;
					if contains(H55_StartBonusImpossible,crystaltoken) ~= nil then
						SetPlayerResource(i,3,5);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusImpossible,sulphurtoken) ~= nil then
						SetPlayerResource(i,4,5);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusImpossible,gemtoken) ~= nil then
						SetPlayerResource(i,5,5);
						H55_StartCreatureBonus(i,heroes[0],1,4);				
					end;
				else
					if contains(H55_StartBonusHardWO,woodtoken) ~= nil then
						SetPlayerResource(i,0,20);
						H55_StartCreatureBonus(i,heroes[0],1,4);						
					end;
					if contains(H55_StartBonusHardWO,oretoken) ~= nil then
						SetPlayerResource(i,1,20);				
					end;
					if contains(H55_StartBonusHard,mercurytoken) ~= nil then
						SetPlayerResource(i,2,10);
						H55_StartCreatureBonus(i,heroes[0],1,4);					
					end;
					if contains(H55_StartBonusHard,crystaltoken) ~= nil then
						SetPlayerResource(i,3,10);
						H55_StartCreatureBonus(i,heroes[0],1,4);
					end;
					if contains(H55_StartBonusHard,sulphurtoken) ~= nil then
						SetPlayerResource(i,4,10);
						H55_StartCreatureBonus(i,heroes[0],1,4);						
					end;
					if contains(H55_StartBonusHard,gemtoken) ~= nil then
						SetPlayerResource(i,5,10);
						H55_StartCreatureBonus(i,heroes[0],1,4);
					end;
				end;
			end;
		end;
	end;

	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {106,"AICompensation",1,"NoHero"};--------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	for i=1,8 do
		if (GetPlayerState(i) == 1) and (H55_IsThisAIPlayer(i) == 1) then
			local heroes = GetPlayerHeroes(i);
			if heroes ~= nil then			
				for i,hero in heroes do
					if H55_GetHeroClassType(hero) == "Might" or H55_GetHeroClassType(hero) == "Barbarian" or H55_GetHeroClass(hero) == "Assassin" then
						GiveHeroSkill(hero,6);
						GiveHeroSkill(hero,6);	
						GiveHeroSkill(hero,6);	
					elseif H55_GetHeroClassType(hero) == "Magic" then
						GiveHeroSkill(hero,8);
						GiveHeroSkill(hero,8);	
						GiveHeroSkill(hero,8);	
					else
						GiveHeroSkill(hero,7);
						GiveHeroSkill(hero,7);	
						GiveHeroSkill(hero,7);
					end;
					if H55_GetHeroClass(hero) == "Demonlord" then
						GiveHeroSkill(hero,4);
						GiveHeroSkill(hero,4);
					end;
					if H55_GetHeroClass(hero) == "Warden" then
						GiveHeroSkill(hero,11);
						GiveHeroSkill(hero,11);
					end;
					if H55_GetHeroClass(hero) == "Sorcerer" then
						GiveHeroSkill(hero,9);
						GiveHeroSkill(hero,9);
					end;			
				end;
			end;
		end;
	end;

	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {107,"StartingArmies",1,"NoHero"};--------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	for i=1,8 do
		if (GetPlayerState(i) == 1) then
			local heroes = GetPlayerHeroes(i);
			
			--DK Guilds
			
			if contains(heroes,"Xerxon") ~= nil then
				H55_DKSpecial[i] = 1;
			end;
			
			--Inferno Heroes
			
			if contains(heroes,"Calid") ~= nil then
				AddHeroCreatures("Calid",21,3);
			end;
			if contains(heroes,"Oddrema") ~= nil then
				AddHeroCreatures("Oddrema",21,2);
			end;	
			if contains(heroes,"Marder") ~= nil then
				local hounds = GetHeroCreatures("Marder",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Marder",19,hounds)
				end;
				AddHeroCreatures("Marder",21,3);
			end;
			if contains(heroes,"Sheltem") ~= nil then
				local hounds = GetHeroCreatures("Sheltem",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Sheltem",19,hounds)	
				end;
				AddHeroCreatures("Sheltem",21,3);
			end;
			if contains(heroes,"Harkenraz") ~= nil then
				local hounds = GetHeroCreatures("Harkenraz",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Harkenraz",19,hounds)
				end;	
				AddHeroCreatures("Harkenraz",21,3);		
			end;
			if contains(heroes,"Calh") ~= nil then
				local hounds = GetHeroCreatures("Calh",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Calh",19,hounds)
				end;	
				AddHeroCreatures("Calh",21,3);		
			end;
			if contains(heroes,"Jazaz") ~= nil then
				local hounds = GetHeroCreatures("Jazaz",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Jazaz",19,hounds)
				end;
				AddHeroCreatures("Jazaz",21,3);		
			end;
			if contains(heroes,"Efion") ~= nil then
				local hounds = GetHeroCreatures("Efion",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Efion",19,hounds)
				end;
				AddHeroCreatures("Efion",21,3);		
			end;
			if contains(heroes,"Ash") ~= nil then
				local hounds = GetHeroCreatures("Ash",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Ash",19,hounds)
				end;
				AddHeroCreatures("Ash",21,3);		
			end;
			if contains(heroes,"Malustar") ~= nil then
				local hounds = GetHeroCreatures("Malustar",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Malustar",19,hounds)
				end;
				AddHeroCreatures("Malustar",21,3);		
			end;
			if contains(heroes,"Grok") ~= nil then
				local hounds = GetHeroCreatures("Grok",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Grok",19,hounds)
				end;	
				AddHeroCreatures("Grok",21,3);		
			end;
			if contains(heroes,"Nymus") ~= nil then
				local hounds = GetHeroCreatures("Nymus",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Nymus",19,hounds)
				end;
				AddHeroCreatures("Nymus",21,3);		
			end;
			if contains(heroes,"Biara") ~= nil then
				local hounds = GetHeroCreatures("Biara",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Biara",19,hounds)
				end;	
				AddHeroCreatures("Biara",21,3);		
			end;
			if contains(heroes,"Sovereign") ~= nil then
				local hounds = GetHeroCreatures("Sovereign",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Sovereign",19,hounds)
				end;
				AddHeroCreatures("Sovereign",21,3);		
			end;
			if contains(heroes,"Agrael") ~= nil then
				local hounds = GetHeroCreatures("Agrael",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Agrael",19,hounds)
				end;
				AddHeroCreatures("Agrael",21,3);		
			end;	
			if contains(heroes,"Deleb") ~= nil then
				local hounds = GetHeroCreatures("Deleb",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Deleb",19,hounds)
				end;	
				AddHeroCreatures("Deleb",21,3);		
			end;	
			if contains(heroes,"Calid2") ~= nil then
				local hounds = GetHeroCreatures("Calid2",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Calid2",19,hounds)
				end;	
				AddHeroCreatures("Calid2",21,3);		
			end;	
			if contains(heroes,"Zydar") ~= nil then
				local hounds = GetHeroCreatures("Zydar",19)
				if hounds >= 1 and hounds <= 3 then
					RemoveHeroCreatures("Zydar",19,hounds)
				end;
				AddHeroCreatures("Zydar",21,3);		
			end;			
			if contains(heroes,"Straker") ~= nil then
				AddHeroCreatures("Straker",29,21);
			end;
			if contains(heroes,"Nathaniel") ~= nil then
				AddHeroCreatures("Nathaniel",3,8);
			end;
			if contains(heroes,"Mardigo") ~= nil then
				AddHeroCreatures("Mardigo",3,5);
			end;
			if contains(heroes,"Orrin") ~= nil then
				AddHeroCreatures("Orrin",1,16);
			end;
			if contains(heroes,"Ossir") ~= nil then
				AddHeroCreatures("Ossir",43,2);
			end;
			if contains(heroes,"Gillion") ~= nil then
				AddHeroCreatures("Gillion",47,2);
			end;
			if contains(heroes,"Havez") ~= nil then
				AddHeroCreatures("Havez",59,7);
			end;
			if contains(heroes,"Isher") ~= nil then
				AddHeroCreatures("Isher",57,19);
			end;
			if contains(heroes,"Rolf") ~= nil then
				AddHeroCreatures("Rolf",94,5);
			end;
			if contains(heroes,"Ingvar") ~= nil then
				AddHeroCreatures("Ingvar",94,5);
			end;
			if contains(heroes,"Skeggy") ~= nil then
				AddHeroCreatures("Skeggy",92,15);
			end;
			if contains(heroes,"Darkstorm") ~= nil then
				AddHeroCreatures("Darkstorm",71,7);
			end;
			if contains(heroes,"Urunir") ~= nil then
				AddHeroCreatures("Urunir",71,7);
			end;
			if contains(heroes,"Ohtarig") ~= nil then
				AddHeroCreatures("Ohtarig",75,3);
			end;
			if contains(heroes,"Hero4") ~= nil then
				AddHeroCreatures("Hero4",117,18);
			end;
			if contains(heroes,"Hero8") ~= nil then
				AddHeroCreatures("Hero8",119,7);
			end;	
		end;
	end;	
	
	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {108,"ArtifactMerchants",1,"NoHero"};-----------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------

	if H55_NoArtifactMerchantsInTowns == 1 then
		for i, academy in (GetObjectNamesByType("TOWN_ACADEMY")) do
			DestroyTownBuildingToLevel(academy,TOWN_BUILDING_SPECIAL_3,0,0);
		end;
		for i, dungeon in (GetObjectNamesByType("TOWN_DUNGEON")) do
			DestroyTownBuildingToLevel(dungeon,TOWN_BUILDING_SPECIAL_4,0,0);
		end;
	else				
		for i, academy in (GetObjectNamesByType("TOWN_ACADEMY")) do
			local owner = GetObjectOwner(academy);
			if owner == 0 then
				DestroyTownBuildingToLevel(academy,TOWN_BUILDING_SPECIAL_3,0,0);
			elseif owner >= 1 then
				if H55_IsThisAIPlayer(owner) == 1 then
					DestroyTownBuildingToLevel(academy,TOWN_BUILDING_SPECIAL_3,0,0);
				end;
			end;
		end;
		for i, dungeon in (GetObjectNamesByType("TOWN_DUNGEON")) do
			local owner = GetObjectOwner(dungeon);
			if owner == 0 then
				DestroyTownBuildingToLevel(dungeon,TOWN_BUILDING_SPECIAL_4,0,0);
			elseif owner >= 1 then
				if H55_IsThisAIPlayer(owner) == 1 then
					DestroyTownBuildingToLevel(dungeon,TOWN_BUILDING_SPECIAL_4,0,0);
				end;
			end;
		end;
	end;

	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {109,"RunicShrines",1,"NoHero"};----------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	if H55_CompetitiveRunelore == 1 then
		for i, fortress in (GetObjectNamesByType("TOWN_FORTRESS")) do
			local owner = GetObjectOwner(fortress);
			if owner == 0 then
				DestroyTownBuildingToLevel(fortress,TOWN_BUILDING_SPECIAL_1,2,0);
			end;
		end;
	end;
						
	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {110,"SpecialObjects",1,"NoHero"};--------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	if H55_SphinxsQty ~= 0 then
		for i, sphinx in H55_Sphinxs do
			SetObjectEnabled(sphinx,nil);
			H55_SphinxVisited[sphinx] = {};
			Trigger(OBJECT_TOUCH_TRIGGER,sphinx,"H55_SphinxVisit");
		end;
	end;
	
	if H55_WitchHutsQty ~= 0 then
		if H55_ARMG_Duel == 1 then
			for i, hut in H55_WitchHuts do	
				SetObjectEnabled(hut,nil);
				Trigger(OBJECT_TOUCH_TRIGGER,hut,"H55_WitchVisitDuel");
			end;
		else
			for i, hut in H55_WitchHuts do
				local choice1 = random(12)+1
				local choice2 = random(12)+1
				if choice1 == choice2 and choice2 <= 11 then
					choice2 = choice2+1;
				end;
				if choice1 == choice2 and choice2 == 12 then
					choice2 = 1;
				end;
				H55_WHChoice1[hut] = choice1;
				H55_WHChoice2[hut] = choice2;
				H55_WHVisited[hut] = {};
				SetObjectEnabled(hut,nil);
				Trigger(OBJECT_TOUCH_TRIGGER,hut,"H55_WitchVisit");
			end;
		end;
	end;

	------------------------------------------------------------------------------------------------------------------------------------------------
	H55_DEBUG = {115,"DwellingConversion",1,"NoHero"};----------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------
	
	for i=1,8 do
		H55_TriggerToObjectType(H55_T1DwellingTypes[i],OBJECT_TOUCH_TRIGGER,"H55_T1DwellingVisit",nil);
	end;
	for i=1,8 do
		H55_TriggerToObjectType(H55_T2DwellingTypes[i],OBJECT_TOUCH_TRIGGER,"H55_T2DwellingVisit",nil);
	end;	
	for i=1,8 do
		H55_TriggerToObjectType(H55_T3DwellingTypes[i],OBJECT_TOUCH_TRIGGER,"H55_T3DwellingVisit",nil);
	end;
	for i=1,8 do
		H55_TriggerToObjectType(H55_T4DwellingTypes[i],OBJECT_TOUCH_TRIGGER,"H55_T4DwellingVisit",nil);
	end;	
	
	print("H55 Adventure Objects ready");
end;

------------------------------------------------------------------------------------------------------------------------------------------------------
--DWELLING CONVERSION
------------------------------------------------------------------------------------------------------------------------------------------------------

function H55_GetT1DwellingRace(dwelling)
	local dwellingrace = 0;
	for i=1,8 do
		if contains(GetObjectNamesByType(H55_T1DwellingTypes[i]),dwelling) then 
			dwellingrace = i;
		end;
	end;
	return dwellingrace;
end;

function H55_GetT2DwellingRace(dwelling)
	local dwellingrace = 0;
	for i=1,8 do
		if contains(GetObjectNamesByType(H55_T2DwellingTypes[i]),dwelling) then 
			dwellingrace = i;
		end;
	end;
	return dwellingrace;
end;

function H55_GetT3DwellingRace(dwelling)
	local dwellingrace = 0;
	for i=1,8 do
		if contains(GetObjectNamesByType(H55_T3DwellingTypes[i]),dwelling) then 
			dwellingrace = i;
		end;
	end;
	return dwellingrace;
end;

function H55_GetT4DwellingRace(dwelling)
	local dwellingrace = 0;
	for i=1,8 do
		if contains(GetObjectNamesByType(H55_T4DwellingTypes[i]),dwelling) then 
			dwellingrace = i;
		end;
	end;
	return dwellingrace;
end;
	
function H55_T1DwellingVisit(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetT1DwellingRace(dwelling);
	if H55_TownManageOwners[hero] == 1 and H55_TownConvEnabled == 1 and playerrace ~= dwellingrace ~= nil and GetObjectOwner(dwelling) == player and H55_IsThisAIPlayer(player) ~= 1 then
			QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/DwellingConversion.txt";gold=H55_DwellingT1ConvCosts[1],wood=H55_DwellingT1ConvCosts[2],ore=H55_DwellingT1ConvCosts[2]},
			"H55_T1DwellingVisitConvert('"..hero.."','"..dwelling.."')","H55_T1DwellingVisitNoAction('"..hero.."','"..dwelling.."')");
	else
		H55_T1DwellingVisitNoAction(hero,dwelling);
	end;
end;

function H55_T2DwellingVisit(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetT2DwellingRace(dwelling);
	if H55_TownManageOwners[hero] == 1 and H55_TownConvEnabled == 1 and playerrace ~= dwellingrace ~= nil and GetObjectOwner(dwelling) == player and H55_IsThisAIPlayer(player) ~= 1 then
			QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/DwellingConversion.txt";gold=H55_DwellingT2ConvCosts[1],wood=H55_DwellingT2ConvCosts[2],ore=H55_DwellingT2ConvCosts[2]},
			"H55_T2DwellingVisitConvert('"..hero.."','"..dwelling.."')","H55_T2DwellingVisitNoAction('"..hero.."','"..dwelling.."')");
	else
		H55_T2DwellingVisitNoAction(hero,dwelling);
	end;
end;

function H55_T3DwellingVisit(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetT3DwellingRace(dwelling);
	if H55_TownManageOwners[hero] == 1 and H55_TownConvEnabled == 1 and playerrace ~= dwellingrace ~= nil and GetObjectOwner(dwelling) == player and H55_IsThisAIPlayer(player) ~= 1 then
			QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/DwellingConversion.txt";gold=H55_DwellingT3ConvCosts[1],wood=H55_DwellingT3ConvCosts[2],ore=H55_DwellingT3ConvCosts[2]},
			"H55_T3DwellingVisitConvert('"..hero.."','"..dwelling.."')","H55_T3DwellingVisitNoAction('"..hero.."','"..dwelling.."')");
	else
		H55_T3DwellingVisitNoAction(hero,dwelling);
	end;
end;

function H55_T4DwellingVisit(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetT4DwellingRace(dwelling);
	if H55_TownManageOwners[hero] == 1 and H55_TownConvEnabled == 1 and playerrace ~= dwellingrace ~= nil and GetObjectOwner(dwelling) == player and H55_IsThisAIPlayer(player) ~= 1 then
			QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/DwellingConversion.txt";gold=H55_DwellingT4ConvCosts[1],wood=H55_DwellingT4ConvCosts[2],ore=H55_DwellingT4ConvCosts[2]},
			"H55_T4DwellingVisitConvert('"..hero.."','"..dwelling.."')","H55_T4DwellingVisitNoAction('"..hero.."','"..dwelling.."')");
	else
		H55_T4DwellingVisitNoAction(hero,dwelling);
	end;
end;

function H55_T1DwellingVisitConvert(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetTownRaceID(playerrace);	
	local amountT1dwellings = length(GetObjectNamesByType(H55_T1DwellingTypes[playerrace]));	
	if amountT1dwellings < H55_MaxDwellingsT1 then
		if GetPlayerResource(player,0) < H55_DwellingT1ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,1) < H55_DwellingT1ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,6) < H55_DwellingT1ConvCosts[1] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		else	
			local x,y,z = GetObjectPosition(dwelling);
			H55_TakeResourcesSilent(player,0,H55_DwellingT1ConvCosts[2]);
			H55_TakeResourcesSilent(player,1,H55_DwellingT1ConvCosts[2]);
			H55_TakeResourcesSilent(player,6,H55_DwellingT1ConvCosts[1]);		
			Play3DSoundForPlayers(GetPlayerFilter(player),H55_SndCrash,x,y,z);
			ReplaceDwelling(dwelling,dwellingrace);
		end;
	else
		ShowFlyingSign("/Text/Game/Scripts/TownPortal/TC_Limit.txt", hero, player, 5);	
	end;
end;

function H55_T2DwellingVisitConvert(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetTownRaceID(playerrace);	
	local amountT2dwellings = length(GetObjectNamesByType(H55_T2DwellingTypes[playerrace]));	
	if amountT2dwellings < H55_MaxDwellingsT2 then
		if GetPlayerResource(player,0) < H55_DwellingT2ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,1) < H55_DwellingT2ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,6) < H55_DwellingT2ConvCosts[1] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		else	
			local x,y,z = GetObjectPosition(dwelling);
			H55_TakeResourcesSilent(player,0,H55_DwellingT2ConvCosts[2]);
			H55_TakeResourcesSilent(player,1,H55_DwellingT2ConvCosts[2]);
			H55_TakeResourcesSilent(player,6,H55_DwellingT2ConvCosts[1]);		
			Play3DSoundForPlayers(GetPlayerFilter(player),H55_SndCrash,x,y,z);
			ReplaceDwelling(dwelling,dwellingrace);
		end;
	else
		ShowFlyingSign("/Text/Game/Scripts/TownPortal/TC_Limit.txt", hero, player, 5);	
	end;
end;

function H55_T3DwellingVisitConvert(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetTownRaceID(playerrace);	
	local amountT3dwellings = length(GetObjectNamesByType(H55_T3DwellingTypes[playerrace]));	
	if amountT3dwellings < H55_MaxDwellingsT3 then
		if GetPlayerResource(player,0) < H55_DwellingT3ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,1) < H55_DwellingT3ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,6) < H55_DwellingT3ConvCosts[1] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		else	
			local x,y,z = GetObjectPosition(dwelling);
			H55_TakeResourcesSilent(player,0,H55_DwellingT3ConvCosts[2]);
			H55_TakeResourcesSilent(player,1,H55_DwellingT3ConvCosts[2]);
			H55_TakeResourcesSilent(player,6,H55_DwellingT3ConvCosts[1]);		
			Play3DSoundForPlayers(GetPlayerFilter(player),H55_SndCrash,x,y,z);
			ReplaceDwelling(dwelling,dwellingrace);
		end;
	else
		ShowFlyingSign("/Text/Game/Scripts/TownPortal/TC_Limit.txt", hero, player, 5);	
	end;
end;

function H55_T4DwellingVisitConvert(hero,dwelling)
	local player = GetObjectOwner(hero);
	local playerrace = H55_GetPlayerRace(player);
	local dwellingrace = H55_GetTownRaceID(playerrace);	
	local amountT4dwellings = length(GetObjectNamesByType(H55_T4DwellingTypes[playerrace]));	
	if amountT4dwellings < H55_MaxDwellingsT4 then
		if GetPlayerResource(player,0) < H55_DwellingT4ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,1) < H55_DwellingT4ConvCosts[2] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		elseif GetPlayerResource(player,6) < H55_DwellingT4ConvCosts[1] then 
			ShowFlyingSign("/Text/Game/Scripts/TownPortal/TCNoRes.txt", hero, player, 5);
		else	
			local x,y,z = GetObjectPosition(dwelling);
			H55_TakeResourcesSilent(player,0,H55_DwellingT4ConvCosts[2]);
			H55_TakeResourcesSilent(player,1,H55_DwellingT4ConvCosts[2]);
			H55_TakeResourcesSilent(player,6,H55_DwellingT4ConvCosts[1]);		
			Play3DSoundForPlayers(GetPlayerFilter(player),H55_SndCrash,x,y,z);
			ReplaceDwelling(dwelling,dwellingrace);
		end;
	else
		ShowFlyingSign("/Text/Game/Scripts/TownPortal/TC_Limit.txt", hero, player, 5);	
	end;
end;

function H55_T1DwellingVisitNoAction(hero,dwelling)
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,nil);
	SetObjectEnabled(dwelling,not nil);
	MakeHeroInteractWithObject(hero,dwelling);
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,"H55_T1DwellingVisit");
	SetObjectEnabled(dwelling,nil);
end;

function H55_T2DwellingVisitNoAction(hero,dwelling)
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,nil);
	SetObjectEnabled(dwelling,not nil);
	MakeHeroInteractWithObject(hero,dwelling);
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,"H55_T2DwellingVisit");
	SetObjectEnabled(dwelling,nil);
end;

function H55_T3DwellingVisitNoAction(hero,dwelling)
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,nil);
	SetObjectEnabled(dwelling,not nil);
	MakeHeroInteractWithObject(hero,dwelling);
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,"H55_T3DwellingVisit");
	SetObjectEnabled(dwelling,nil);
end;

function H55_T4DwellingVisitNoAction(hero,dwelling)
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,nil);
	SetObjectEnabled(dwelling,not nil);
	MakeHeroInteractWithObject(hero,dwelling);
	Trigger(OBJECT_TOUCH_TRIGGER,dwelling,"H55_T4DwellingVisit");
	SetObjectEnabled(dwelling,nil);
end;

------------------------------------------------------------------------------------------------------------------------------------------
--SPHINX
------------------------------------------------------------------------------------------------------------------------------------------

function H55_SphinxVisit(hero,sphinx)
	local player = GetObjectOwner(hero);
	if H55_SphinxVisited[sphinx][hero] ~= 1 then
		if H55_SphinxExp[hero] == nil then
			GiveExp(hero,5000);
			H55_SphinxExp[hero] = 5000;
			H55_SphinxVisited[sphinx][hero] = 1;
			MarkObjectAsVisited(sphinx,hero);
		else 
			GiveExp(hero,(H55_SphinxExp[hero]+5000));
			H55_SphinxExp[hero] = (H55_SphinxExp[hero]+5000);
			H55_SphinxVisited[sphinx][hero] = 1;
			MarkObjectAsVisited(sphinx,hero);
		end;
	else
		if H55_IsThisAIPlayer(player) ~= 1 then ShowFlyingSign("/Text/Game/Scripts/Sphinxdead.txt",hero,player,5) end;
	end;
end;

function H55_WitchVisitDuel(hero,witch)
	local player = GetObjectOwner(hero);
	if H55_DuelExperienceReceived[player] ~= 1 then
		GiveExp(hero,H55_ExpTable[H55_Duel_HeroLevel]);
		H55_DuelExperienceReceived[player] = 1;
		MarkObjectAsVisited(witch,hero);
	else
		if H55_IsThisAIPlayer(player) ~= 1 then ShowFlyingSign("/Text/Game/Scripts/Witch/Already.txt",hero,player,5) end;
	end;
end;

function H55_IllegalVisit(hero,object)	
	local player = GetObjectOwner(hero);
	if H55_IsThisAIPlayer(player) ~= 1 then 
		ShowFlyingSign("/Text/Game/Scripts/Duel/Booster.txt",hero,player,5);
		sleep(8);
	end;
	MarkObjectAsVisited(object,hero);
end;

----------------------------------------------------------------------------------------------------------------------------------------------
--WITCH HUT 
----------------------------------------------------------------------------------------------------------------------------------------------

function H55_WitchVisit(hero,hut)
	local player = GetObjectOwner(hero);
	if H55_IsThisAIPlayer(player) == 1 then
		print("AI Visits Witch Hut!");
	elseif contains(H55_WHVisited[hut],hero) then
			ShowFlyingSign("/Text/Game/Scripts/Witch/Already.txt",hero,player,5);
	else
		local choice1 = H55_WHChoice1[hut];
		local classtype = H55_GetHeroClass(hero);
		for i=1,H55_ClassesCount do
			if classtype == H55_ClassesNames[i] then
				local mastery1 = GetHeroSkillMastery(hero,H55_WitchSkills[H55_WitchSelect[i][choice1]]);				
				if mastery1 <= 2 then
					QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/Witch/Questionone.txt";
					mastery=H55_WitchMasteryText[mastery1],skill=H55_WitchSkillText[H55_WitchSelect[i][choice1]]},
					"H55_WitchAccept01('"..hero.."','"..hut.."')","H55_WitchRefuse01('"..hero.."','"..hut.."')");
				elseif mastery1 == 3 then
					H55_WitchVisit2nd(hero,hut);
				end;
				break;
			end;
			
		end;
	end;
end;

function H55_WitchAccept01(hero,hut)
	local player = GetObjectOwner(hero);
	local classtype = H55_GetHeroClass(hero);
	local choice1 = H55_WHChoice1[hut];
	local visits = length(H55_WHVisited[hut])
	local currentvisitor = length(H55_WHVisited[hut])+1
	local x,y,z = GetObjectPosition(hut);
	for i=1,H55_ClassesCount do
		if classtype == H55_ClassesNames[i] then
			GiveHeroSkill(hero,H55_WitchSkills[H55_WitchSelect[i][choice1]]);
			H55_WHVisited[hut][currentvisitor] = hero;
			Play3DSoundForPlayers(GetPlayerFilter(player), H55_SndWitch,x,y,z);
			MarkObjectAsVisited(hut,hero);
			break;
		end;
	end;
end;

function H55_WitchVisit2nd(hero,hut)
	local player = GetObjectOwner(hero);
	local choice2 = H55_WHChoice2[hut];
	local classtype = H55_GetHeroClass(hero);
	local price = 2000;
	for i=1,H55_ClassesCount do
		if classtype == H55_ClassesNames[i] then
			local mastery2 = GetHeroSkillMastery(hero,H55_WitchSkills[H55_WitchSelect[i][choice2]]);
			if mastery2 <= 2 then
				QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/Witch/Questiononealt.txt";
				gold=price,mastery=H55_WitchMasteryText[mastery2],skill=H55_WitchSkillText[H55_WitchSelect[i][choice2]]},
				"H55_WitchAccept02('"..hero.."','"..hut.."')","H55_WitchRefuse02('"..hero.."')");
			elseif mastery2 == 3 then
				ShowFlyingSign("/Text/Game/Scripts/Witch/Already.txt",hero,player,5);				
			end;
			break;
		end;
	end;
end;

function H55_WitchRefuse01(hero,hut)
	local player = GetObjectOwner(hero);
	local choice2 = H55_WHChoice2[hut];
	local classtype = H55_GetHeroClass(hero);
	local price = 2000;
	for i=1,H55_ClassesCount do
		if classtype == H55_ClassesNames[i] then
			local mastery2 = GetHeroSkillMastery(hero,H55_WitchSkills[H55_WitchSelect[i][choice2]]);
			if mastery2 <= 2 then
				QuestionBoxForPlayers(GetPlayerFilter(player),{"/Text/Game/Scripts/Witch/Questiontwo.txt";
				gold=price,mastery=H55_WitchMasteryText[mastery2], skill=H55_WitchSkillText[H55_WitchSelect[i][choice2]]},
				"H55_WitchAccept02('"..hero.."','"..hut.."')","H55_WitchRefuse02('"..hero.."')");
			elseif mastery2 == 3 then
				ShowFlyingSign("/Text/Game/Scripts/Witch/Nooffer.txt",hero,player,5);				
			end;
			break;
		end;
	end;
end;
	
function H55_WitchAccept02(hero,hut)
	local player = GetObjectOwner(hero);
	local classtype = H55_GetHeroClass(hero);
	local choice2 = H55_WHChoice2[hut];
	local visits = length(H55_WHVisited[hut])
	local currentvisitor = length(H55_WHVisited[hut])+1
	local x,y,z = GetObjectPosition(hut);
	local money = GetPlayerResource(player,6);
	if money >= 2000 then
		for i=1,H55_ClassesCount do
			if classtype == H55_ClassesNames[i] then
				GiveHeroSkill(hero,H55_WitchSkills[H55_WitchSelect[i][choice2]]);
				H55_WHVisited[hut][currentvisitor] = hero;
				Play3DSoundForPlayers(GetPlayerFilter(player), H55_SndWitch,x,y,z);
				MarkObjectAsVisited(hut,hero);
				H55_TakeResources(player,6,2000,hero);
				break;
			end;
		end;	
	else
		ShowFlyingSign("/Text/Game/Scripts/Witch/Nogold.txt",hero,player,5);
	end;
end;

function H55_WitchRefuse02(hero)
	local player = GetObjectOwner(hero);
	ShowFlyingSign("/Text/Game/Scripts/Witch/Nooffer.txt",hero,player,5);
end;

---------------------------------------------------------------------------------------------------------------------------------------------
--ACTIVATOR
---------------------------------------------------------------------------------------------------------------------------------------------

H55_PrepareAdvMap();
