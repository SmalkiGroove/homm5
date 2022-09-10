
function GetTownFactionID(town)
	local towntype = 0;
	if     contains(GetObjectNamesByType("TOWN_HEAVEN"),town) ~= nil then towntype = 1 
	elseif contains(GetObjectNamesByType("TOWN_PRESERVE"),town) ~= nil then towntype = 2 
	elseif contains(GetObjectNamesByType("TOWN_INFERNO"),town) ~= nil then towntype = 3 
	elseif contains(GetObjectNamesByType("TOWN_NECROMANCY"),town) ~= nil then towntype = 4 
	elseif contains(GetObjectNamesByType("TOWN_ACADEMY"),town) ~= nil then towntype = 5 
	elseif contains(GetObjectNamesByType("TOWN_DUNGEON"),town) ~= nil then towntype = 6 
	elseif contains(GetObjectNamesByType("TOWN_FORTRESS"),town) ~= nil then towntype = 7 
	elseif contains(GetObjectNamesByType("TOWN_STRONGHOLD"),town) ~= nil then towntype = 8 end;
	return towntype
end;

function GetFactionTowns(num)
	local towntype = "TOWN";
	if 	   num == 1 then towntype = "TOWN_HEAVEN"
	elseif num == 2 then towntype = "TOWN_PRESERVE"
	elseif num == 3 then towntype = "TOWN_INFERNO" 
	elseif num == 4 then towntype = "TOWN_NECROMANCY" 
	elseif num == 5 then towntype = "TOWN_ACADEMY" 
	elseif num == 6 then towntype = "TOWN_DUNGEON" 
	elseif num == 7 then towntype = "TOWN_FORTRESS" 
	elseif num == 8 then towntype = "TOWN_STRONGHOLD" end;
    
    local towns = GetObjectNamesByType(towntype);
    return towns;
end;

function GetHeroFactionID(hero)
	local race = 0;
	if 	   contains(HEROES_HAVEN,hero) ~= nil then race = 1 
	elseif contains(HEROES_SYLVAN,hero) ~= nil then race = 2 
	elseif contains(HEROES_INFERNO,hero) ~= nil then race = 3 
	elseif contains(HEROES_NECRO,hero) ~= nil then race = 4 
	elseif contains(HEROES_ACADEMY,hero) ~= nil then race = 5 
	elseif contains(HEROES_DUNGEON,hero) ~= nil then race = 6 
	elseif contains(HEROES_FORTRESS,hero) ~= nil then race = 7 	
	elseif contains(HEROES_ORCS,hero) ~= nil then race = 8 end;
	return race
end;

function GetPlayerTowns(player)
	local cities = {};
	local towns = GetObjectNamesByType("TOWN");
	for i,town in towns do
		if GetObjectOwner(town) == player then
			insert(cities,town);
		end;
	end;
	return cities;
end;

function GetHeroTowns(player,hero)
    local cities = {};
    local factionID = GetHeroFactionID(hero);
    local towns = GetFactionTowns(factionID);
    for i,town in towns do
		if GetObjectOwner(town) == player then
			insert(cities,town);
		end;
	end;
	return cities;
end;

function GetHeroArmy(hero)
	local type = {};
	type[1], type[2], type[3], type[4], type[5], type[6], type[7] = GetHeroCreaturesTypes(hero);
	return type
end;