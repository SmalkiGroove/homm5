
function DoCommonRoutine_Start(player, hero) end
function DoCommonRoutine_Daily(player, hero) end
function DoCommonRoutine_Weekly(player, hero) end
function DoCommonRoutine_LevelUp(hero) end

function NoneRoutine()
    -- print("Nothing happens !")
end


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


function AddPlayer_Resource(player, hero, resource, amount)
	-- print("Adding resources from hero "..hero)
	if amount >= 1 then
		local curamount = GetPlayerResource(player, resource)
		local newamount = curamount + amount
		SetPlayerResource(player, resource, newamount)
		ShowFlyingSign({"/Text/Game/Scripts/Resources/"..RESOURCE_TEXT[resource]..".txt"; num=amount}, hero, player, FLYING_SIGN_TIME)
	end
end

function AddHero_StatAmount(player, hero, stat, amount)
    if amount >= 1 then
		ChangeHeroStat(hero, stat, amount)
		ShowFlyingSign({"/Text/Game/Scripts/Stats/"..ATTRIBUTE_TEXT[stat]..".txt"; num=amount}, hero, player, FLYING_SIGN_TIME)
	end
end

function AddHero_StatPerLevel(player, hero, stat, coef)
	-- print("Adding statistics to hero "..hero)
	local level = GetHeroLevel(hero)
	local amount = trunc(coef * level)
	if amount >= 1 then
		ChangeHeroStat(hero, stat, amount)
		ShowFlyingSign({"/Text/Game/Scripts/Stats/"..ATTRIBUTE_TEXT[stat]..".txt"; num=amount}, hero, player, FLYING_SIGN_TIME)
	end
end

function AddHero_StatPercent(player, hero, stat, coef)
	-- print("Adding statistics to hero "..hero)
	local current = GetHeroStat(hero, stat)
	local amount = round(coef * current)
	if amount >= 1 then
		ChangeHeroStat(hero, stat, amount)
		local attribute = ATTRIBUTE_NAME[stat]
		ShowFlyingSign({"/Text/Game/Scripts/Stats/"..ATTRIBUTE_TEXT[stat]..".txt"; num=amount}, hero, player, FLYING_SIGN_TIME)
	end
end

function AddHero_CreatureType(player, hero, type, coef)
	-- print("Add specific creature to hero "..hero)
	local level = GetHeroLevel(hero)
	local nb = round(coef * level)
	if nb >= 1 then
		AddHeroCreatures(hero, type, nb)
		ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
	end
end

function AddHero_CreatureInTypes(player, hero, types, coef)
	-- print("Add creatures to hero "..hero)
	local level = GetHeroLevel(hero)
	local nb = round(coef * level)
	if nb >= 1 then
		local army = GetHeroArmy(hero)
		local b = 0
		for i = 1,7 do
            if contains(types, army[i]) then
                AddHeroCreatures(hero, army[i], nb)
                ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
                return
            end
        end
	end
end

function AddHero_CreatureTypesPercent(player, hero, types, coef)
	-- print("Multiply army size for hero "..hero)
	local level = GetHeroLevel(hero)
	local army = GetHeroArmy(hero)
	local total = 0
	for i = 1,7 do
        local cr = army[i]
        if contains(types, cr) then
            local nb = trunc(GetHeroCreatures(hero, cr) * level * coef)
            if nb >= 1 then
                AddHeroCreatures(hero, cr, nb)
                total = total + nb
            end
        end
	end
	ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=total}, hero, player, FLYING_SIGN_TIME)
end

function AddHero_TownRecruits(player, hero, dwelling, creature, coef)
	-- print("Adding recruits from hero "..hero)
	local level = GetHeroLevel(hero)
	local towns = GetHeroTowns(player, hero)
	local nb = round(coef * level)
	if nb >= 1 then
		for i,town in towns do
			if GetTownBuildingLevel(town, dwelling) ~= 0 then
                local current = GetObjectDwellingCreatures(town, creature)
				SetObjectDwellingCreatures(town, creature, current + nb)
				ShowFlyingSign({"/Text/Game/Scripts/Recruits.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
			end
		end
	end
end

function AddHero_CreatureFromDwelling(player, hero, dwelling, creature, coef)
	-- print("Call creatures from towns to hero "..hero)
	local level = GetHeroLevel(hero)
	local towns = GetHeroTowns(player, hero)
	for i,town in towns do
		if GetTownBuildingLevel(town,dwelling) ~= 0 then
			local recruits = GetObjectDwellingCreatures(town, creature)
			local nb = min(coef * level, recruits)
			if nb >= 1 then
				SetObjectDwellingCreatures(town, creature, recruits-nb+1)
				AddHeroCreatures(hero, creature, nb)
				ShowFlyingSign({"/Text/Game/Scripts/Reinforcements.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
			end
		end
	end
end

function ChangeHero_CreatureUpgrade(player, hero, base, upgrade)
	local nb = GetHeroCreatures(hero, base)
	RemoveHeroCreatures(hero, base, nb)
	AddHeroCreatures(hero, upgrade, nb)
	ShowFlyingSign({"/Text/Game/Scripts/Evolve.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
end

function ChangeHero_CreatureFusion(player, hero, base, consume, upgrade, coef)
	local nb_base = GetHeroCreatures(hero,base)
	local nb_consume = GetHeroCreatures(hero,consume)
	if nb_consume >= coef then
		local nb = trunc(nb_consume / coef)
		nb = min(nb, nb_base)
		RemoveHeroCreatures(hero, consume, coef * nb)
		RemoveHeroCreatures(hero, base, nb)
		AddHeroCreatures(hero, upgrade, nb)
		ShowFlyingSign({"/Text/Game/Scripts/Evolve.txt"; num=nb}, hero, player, FLYING_SIGN_TIME)
	end
end

function ChangeHero_CreatureTransform(player, hero, array)
	local army = GetHeroArmy(hero)
	for i = 1,7 do
        local cr = army[i]
		if cr and cr ~= 0 then
			local type = array[cr]
			print("transform unit "..cr.." into unit "..type)
			if type ~= 0 then
				local nb = GetHeroCreatures(hero, cr)
				RemoveHeroCreatures(hero, cr, nb)
				AddHeroCreatures(hero, type, nb)
			end
		end
	end
end

print("Loaded common advmap routines")
ROUTINES_LOADED[0] = 1
