
function ConvertDwellingT1(hero,dwelling)
    local race = GetHeroFactionID(hero) - 1
    ReplaceDwelling(dwelling, race)
end




-- print("Loaded conversion advmap routines")
ROUTINES_LOADED[9] = 1
