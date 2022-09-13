
function Routine_AddHeroHellHounds(player, hero)
    -- Hell hounds - 1:2 - 2:5 - 3:8 - 4:11 - ... - 17:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_HELL_HOUND,CREATURE_CERBERI,CREATURE_FIREBREATHER_HOUND}, 0.33);
end;

function Routine_GenerateSulfur(player, hero)
    -- Sulfur - +1 / 3 levels
    local amount = trunc(0.34 * GetHeroLevel(hero));
    AddPlayer_Resource(player, hero, SULFUR, amount);
end;

function Routine_AddHeroNightmares(player, hero)
    -- Nightmare - 1:5 - 2:13 - 3:21 - 4:30 - 5:38 - 6:46
    AddHero_CreatureInTypes(player, hero, {CREATURE_NIGHTMARE,CREATURE_FRIGHTFUL_NIGHTMARE,CREATURE_HELLMARE}, 0.12);
end;

function Routine_AddHeroFireDragons(player, hero)
    -- Fire Dragon - 1:2 - 2:5 - 3:9 - 4:12 - 5:15 ... 15:49
    AddHero_CreatureType(player, hero, CREATURE_FIRE_DRAGON, 0.3);
end;

function Routine_AddRandomStat(player, hero)
    -- Random attribute - +1 / 5*lvl / week
    local stat = 1 + random(3);
    AddHero_StatPerLevel(player, hero, stat, 0.2);
end;

function Routine_AddRecruitsInferno(player, hero)
    -- Imps - 2.5 * level recruits per week / Horned demons - 1.5 * level recruits per week / Devils - 0.1 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_1, CREATURE_FAMILIAR, 2.5);
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_2, CREATURE_DEMON, 1.5);
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_7, CREATURE_DEVIL, 0.1);
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_INFERNO_HERO = {
    [H_GRAWL] = "NoneRoutine",
    [H_NEBIROS] = "NoneRoutine",
    [H_MARBAS] = "NoneRoutine",
    [H_HARKENRAZ] = "NoneRoutine",
    [H_CALH] = "NoneRoutine",
    [H_SHELTEM] = "NoneRoutine",
    [H_ALASTOR] = "NoneRoutine",
    [H_GROK] = "NoneRoutine",
    [H_NYMUS] = "NoneRoutine",
    [H_JEZEBETH] = "NoneRoutine",
    [H_MALUSTAR] = "NoneRoutine",
    [H_AGRAEL] = "NoneRoutine",
    [H_BIARA] = "NoneRoutine",
    [H_KHABELETH] = "NoneRoutine",
    [H_ZYDAR] = "NoneRoutine",
    [H_DELEB] = "NoneRoutine",
    [H_CALID] = "NoneRoutine",
};

START_TRIGGER_INFERNO = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = NoneRoutine,
    [H_CALID] = NoneRoutine,
};

DAILY_TRIGGER_INFERNO = {
    [H_GRAWL] = Routine_AddHeroHellHounds,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = Routine_GenerateSulfur,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = Routine_AddHeroNightmares,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = NoneRoutine,
    [H_CALID] = NoneRoutine,
};

WEEKLY_TRIGGER_INFERNO = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = Routine_AddHeroFireDragons,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = Routine_AddRandomStat,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = Routine_AddRecruitsInferno,
    [H_DELEB] = NoneRoutine,
    [H_CALID] = NoneRoutine,
};


function DoInfernoRoutine_Start(player, hero)
    startThread(START_TRIGGER_INFERNO[hero], player, hero);
end;

function DoInfernoRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_INFERNO[hero], player, hero);
end;

function DoInfernoRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_INFERNO[hero], player, hero);
end;

function DoInfernoRoutine_LevelUp(hero)
    Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_INFERNO_HERO[hero]);
end;


print("Loaded Inferno advmap routines");
ROUTINES_LOADED[INFERNO] = 1;
