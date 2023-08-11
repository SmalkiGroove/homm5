
function Routine_AddHeroLuck()
    --Luck +1 per 10 levels
    local hero = H_ANWEN
    local player = GetObjectOwner(hero)
    if mod(GetHeroLevel(hero), 10) == 0 then
        AddHero_StatAmount(player, hero, STAT_LUCK, 1)
    end
end

function Routine_GainSylvanArtifacts()
    -- Ring of haste and Moonblade
    local hero = H_HEDWIG
    if GetHeroLevel(hero) == 30 then
        GiveArtifact(hero, ARTIFACT_RING_OF_HASTE)
        GiveArtifact(hero, ARTIFACT_MOONBLADE)
    end
end

function Routine_AddThreeMoralePoints(player, hero)
    -- Morale +3
    AddHero_StatAmount(player, hero, STAT_MORALE, 3)
end

function Routine_AddHeroGreenDragons(player, hero)
    -- Green Dragon - 1:17 - 2:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_GREEN_DRAGON,CREATURE_GOLD_DRAGON,CREATURE_RAINBOW_DRAGON}, 0.03)
end

function Routine_AddHeroWolves(player, hero)
    -- Wolf - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
    AddHero_CreatureType(player, hero, CREATURE_WOLF, 0.5)
end

function Routine_GenerateWoodOrOre(player, hero)
    -- Wood or Ore - +1 / 2 levels
    local level = GetHeroLevel(hero)
    local resource = random(0, 1, level)
    local amount = trunc(level * 0.5)
    AddPlayer_Resource(player, hero, resource, amount)
end

function Routine_AddHeroSprites(player, hero)
    -- Sprites - 1:1 - 2:3 - 3:5 - 4:7 - 5:9 ... 25:49
    AddHero_CreatureType(player, hero, CREATURE_SPRITE, 0.5)
end

function Routine_AddHeroExperience(player, hero)
    -- Exp - +300 * level
    AddHero_StatPerLevel(player, hero, STAT_EXPERIENCE, 300)
end

function Routine_AddHeroAngerTreants(player, hero)
    -- Anger Treant - 1:2 - 2:6 - 3:10 - 4:14 ... 13:50
    AddHero_CreatureType(player, hero, CREATURE_ANGER_TREANT, 0.25)
end

function Routine_AddRecruitsBladeJugglers(player, hero)
    -- Blade Jugglers - 6 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_1, CREATURE_BLADE_JUGGLER, 6.0)
end

function Routine_HeroCallUnicorns(player, hero)
    -- Unicorns - 0.75 * level transfered
    AddHero_CreatureFromDwelling(player, hero, TOWN_BUILDING_DWELLING_5, CREATURE_WHITE_UNICORN, 1.5)
end

function Routine_AddHeroSpellPower(player, hero)
    -- Spellpower - +1 / 5*lvl / week
    AddHero_StatPerLevel(player, hero, STAT_SPELL_POWER, 0.2)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_SYLVAN_HERO = {
    [H_WYNGAAL] = "NoneRoutine",
    [H_ANWEN] = "Routine_AddHeroLuck",
    [H_TALANAR] = "NoneRoutine",
    [H_OSSIR] = "NoneRoutine",
    [H_FINDAN] = "NoneRoutine",
    [H_JENOVA] = "NoneRoutine",
    [H_GILRAEN] = "NoneRoutine",
    [H_KYRRE] = "Routine_GainSylvanArtifacts",
    [H_IVOR] = "NoneRoutine",
    [H_MEPHALA] = "NoneRoutine",
    [H_ALARON] = "NoneRoutine",
    [H_DIRAEL] = "NoneRoutine",
    [H_VINRAEL] = "NoneRoutine",
    [H_YLTHIN] = "NoneRoutine",
    [H_TIERU] = "NoneRoutine",
    [H_GEM] = "NoneRoutine",
    [H_ELLESHAR] = "NoneRoutine",
}

START_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = Routine_AddThreeMoralePoints,
    [H_ANWEN] = NoneRoutine,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_GILRAEN] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = NoneRoutine,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = NoneRoutine,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = NoneRoutine,
}

DAILY_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = NoneRoutine,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = Routine_AddHeroGreenDragons,
    [H_GILRAEN] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = Routine_AddHeroWolves,
    [H_MEPHALA] = Routine_GenerateWoodOrOre,
    [H_ALARON] = NoneRoutine,
    [H_DIRAEL] = Routine_AddHeroSprites,
    [H_VINRAEL] = Routine_AddHeroExperience,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = NoneRoutine,
}

WEEKLY_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = Routine_AddHeroAngerTreants,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_GILRAEN] = Routine_AddRecruitsBladeJugglers,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = NoneRoutine,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = NoneRoutine,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = Routine_HeroCallUnicorns,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = Routine_AddHeroSpellPower,
}


function DoPreserveRoutine_Start(player, hero)
    startThread(START_TRIGGER_PRESERVE[hero], player, hero)
end

function DoPreserveRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_PRESERVE[hero], player, hero)
end

function DoPreserveRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_PRESERVE[hero], player, hero)
end

function DoPreserveRoutine_LevelUp(hero)
    Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_SYLVAN_HERO[hero])
end


-- print("Loaded Preserve advmap routines")
ROUTINES_LOADED[PRESERVE] = 1
