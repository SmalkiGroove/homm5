

function Routine_GainHavenArtifacts()
    -- Crown of leadership / Ring of life / Golden horseshoe / Crown of courage / Tome of light magic
    local hero = H_RUTGER
    local level = GetHeroLevel(hero)
    if     level == 10 then GiveArtifact(hero, ARTIFACT_CROWN_OF_LEADER)
    elseif level == 20 then GiveArtifact(hero, ARTIFACT_RING_OF_LIFE)
    elseif level == 30 then GiveArtifact(hero, ARTIFACT_GOLDEN_HORSESHOE)
    elseif level == 40 then GiveArtifact(hero, ARTIFACT_CROWN_OF_COURAGE)
    elseif level == 50 then GiveArtifact(hero, ARTIFACT_TOME_OF_LIGHT_MAGIC)
    end
end

function Routine_AddTwoLuckPoints(player, hero)
    --Luck +2
    AddHero_StatAmount(player, hero, STAT_LUCK, 2)
end

function Routine_GainArtifactBoots(player, hero)
    -- Give hero artifact Wayfarer boots
    GiveArtifact(hero, ARTIFACT_WAYFARER_BOOTS)
end

function Routine_AddHeroCavaliers(player, hero)
    -- Cavalier - 1:10 - 2:30 - 3:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_CAVALIER,CREATURE_PALADIN,CREATURE_CHAMPION}, 0.05)
end

function Routine_AddHeroZealots(player, hero)
    -- Zealot - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
    AddHero_CreatureType(player, hero, CREATURE_ZEALOT, 0.13)
end

function Routine_GenerateGoldsLinear(player, hero)
    -- Gold - 250 * level
    local amount = (GetHeroLevel(hero) - 1) * 250
    AddPlayer_Resource(player, hero, GOLD, amount)
end

function Routine_HeroCallGriffins(player, hero)
    -- Griffins - 1.5 * level transfered
    AddHero_CreatureFromDwelling(player, hero, TOWN_BUILDING_DWELLING_4, CREATURE_ROYAL_GRIFFIN, 1.5)
end

function Routine_IncreaseHeroArmy(player, hero)
    -- T2 T3 T5 : 1% * level
    local types = {CREATURE_ARCHER,CREATURE_MARKSMAN,CREATURE_LONGBOWMAN,CREATURE_FOOTMAN,CREATURE_SWORDSMAN,CREATURE_VINDICATOR,CREATURE_PRIEST,CREATURE_CLERIC,CREATURE_ZEALOT}
    AddHero_CreatureTypesPercent(player, hero, types, 0.01)
end

function Routine_AddRecruitsPeasants(player, hero)
    -- Peasants - 7 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_1, CREATURE_PEASANT, 7.0)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_HAVEN_HERO = {
    [H_DUNCAN] = "NoneRoutine",
    [H_DOUGAL] = "NoneRoutine",
    [H_KLAUS] = "NoneRoutine",
    [H_IRINA] = "NoneRoutine",
    [H_ISABEL] = "NoneRoutine",
    [H_LASZLO] = "NoneRoutine",
    [H_NICOLAI] = "NoneRoutine",
    [H_GODRIC] = "NoneRoutine",
    [H_FREYDA] = "NoneRoutine",
    [H_RUTGER] = "Routine_GainHavenArtifacts",
    [H_MAEVE] = "NoneRoutine",
    [H_ELLAINE] = "NoneRoutine",
    [H_ALARIC] = "NoneRoutine",
    [H_GABRIELLE] = "NoneRoutine",
    [H_ORLANDO] = "NoneRoutine",
    [H_MARKAL] = "NoneRoutine",
}

START_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = NoneRoutine,
    [H_IRINA] = NoneRoutine,
    [H_ISABEL] = Routine_AddTwoLuckPoints,
    [H_LASZLO] = NoneRoutine,
    [H_NICOLAI] = NoneRoutine,
    [H_GODRIC] = NoneRoutine,
    [H_FREYDA] = NoneRoutine,
    [H_RUTGER] = Routine_GainArtifactBoots,
    [H_MAEVE] = NoneRoutine,
    [H_ELLAINE] = NoneRoutine,
    [H_ALARIC] = NoneRoutine,
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = NoneRoutine,
}

DAILY_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = Routine_AddHeroCavaliers,
    [H_IRINA] = NoneRoutine,
    [H_ISABEL] = NoneRoutine,
    [H_LASZLO] = NoneRoutine,
    [H_NICOLAI] = NoneRoutine,
    [H_GODRIC] = NoneRoutine,
    [H_FREYDA] = NoneRoutine,
    [H_RUTGER] = NoneRoutine,
    [H_MAEVE] = NoneRoutine,
    [H_ELLAINE] = NoneRoutine,
    [H_ALARIC] = NoneRoutine,
    [H_GABRIELLE] = Routine_AddHeroZealots,
    [H_ORLANDO] = Routine_GenerateGoldsLinear,
    [H_MARKAL] = NoneRoutine,
}

WEEKLY_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = NoneRoutine,
    [H_IRINA] = Routine_HeroCallGriffins,
    [H_ISABEL] = NoneRoutine,
    [H_LASZLO] = NoneRoutine,
    [H_NICOLAI] = Routine_IncreaseHeroArmy,
    [H_GODRIC] = NoneRoutine,
    [H_FREYDA] = NoneRoutine,
    [H_RUTGER] = NoneRoutine,
    [H_MAEVE] = NoneRoutine,
    [H_ELLAINE] = Routine_AddRecruitsPeasants,
    [H_ALARIC] = NoneRoutine,
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = NoneRoutine,
}


function DoHavenRoutine_Start(player, hero)
    startThread(START_TRIGGER_HAVEN[hero], player, hero)
end

function DoHavenRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_HAVEN[hero], player, hero)
end

function DoHavenRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_HAVEN[hero], player, hero)
end

function DoHavenRoutine_LevelUp(hero)
    Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_HAVEN_HERO[hero])
end


print("Loaded Haven advmap routines")
ROUTINES_LOADED[HAVEN] = 1
