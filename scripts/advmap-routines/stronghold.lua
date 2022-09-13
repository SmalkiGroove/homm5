
function Routine_AddHeroWyverns(player, hero)
    -- Wyvern - 1:10 - 2:30 - 3:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_WYVERN,CREATURE_WYVERN_POISONOUS,CREATURE_WYVERN_PAOKAI}, 0.05);
end;

function Routine_HeroCallCentaurs(player, hero)
    -- Centaurs - 1 * level transfered
    AddHero_CreatureFromDwelling(player, hero, TOWN_BUILDING_DWELLING_4, CREATURE_CENTAUR_MARADEUR, 1.0);
end;

function Routine_AddRecruitsShamans(player, hero)
    -- Shamans - 3 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_2, CREATURE_SHAMAN, 3.0);
end;

function Routine_AddHeroTitans(player, hero)
    -- Titans - 1:3 - 2:8 - 3:13 - 4:18 - 5:23 ... 10:48
    AddHero_CreatureType(player, hero, CREATURE_TITAN, 0.2);
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_STRONGHOLD_HERO = {
    [H_TELSEK] = "NoneRoutine",
    [H_GORSHAK] = "NoneRoutine",
    [H_GOTAI] = "NoneRoutine",
    [H_AZAR] = "NoneRoutine",
    [H_MATEWA] = "NoneRoutine",
    [H_KUNYAK] = "NoneRoutine",
    [H_KRAGH] = "NoneRoutine",
    [H_KILGHAN] = "NoneRoutine",
    [H_CRAGHACK] = "NoneRoutine",
    [H_KRAAL] = "NoneRoutine",
    [H_SHAKKARUKAT] = "NoneRoutine",
    [H_KUJIN] = "NoneRoutine",
    [H_SHIVA] = "NoneRoutine",
    [H_MUKHA] = "NoneRoutine",
    [H_HAGGASH] = "NoneRoutine",
    [H_URGHAT] = "NoneRoutine",
    [H_GARUNA] = "NoneRoutine",
    [H_ZOULEIKA] = "NoneRoutine",
    [H_ERIKA] = "NoneRoutine",
};

START_TRIGGER_STRONGHOLD = {
    [H_TELSEK] = NoneRoutine,
    [H_GORSHAK] = NoneRoutine,
    [H_GOTAI] = NoneRoutine,
    [H_AZAR] = NoneRoutine,
    [H_MATEWA] = NoneRoutine,
    [H_KUNYAK] = NoneRoutine,
    [H_KRAGH] = NoneRoutine,
    [H_KILGHAN] = NoneRoutine,
    [H_CRAGHACK] = NoneRoutine,
    [H_KRAAL] = NoneRoutine,
    [H_SHAKKARUKAT] = NoneRoutine,
    [H_KUJIN] = NoneRoutine,
    [H_SHIVA] = NoneRoutine,
    [H_MUKHA] = NoneRoutine,
    [H_HAGGASH] = NoneRoutine,
    [H_URGHAT] = NoneRoutine,
    [H_GARUNA] = NoneRoutine,
    [H_ZOULEIKA] = NoneRoutine,
    [H_ERIKA] = NoneRoutine,
};

DAILY_TRIGGER_STRONGHOLD = {
    [H_TELSEK] = NoneRoutine,
    [H_GORSHAK] = NoneRoutine,
    [H_GOTAI] = NoneRoutine,
    [H_AZAR] = NoneRoutine,
    [H_MATEWA] = NoneRoutine,
    [H_KUNYAK] = NoneRoutine,
    [H_KRAGH] = NoneRoutine,
    [H_KILGHAN] = NoneRoutine,
    [H_CRAGHACK] = NoneRoutine,
    [H_KRAAL] = NoneRoutine,
    [H_SHAKKARUKAT] = Routine_AddHeroWyverns,
    [H_KUJIN] = NoneRoutine,
    [H_SHIVA] = NoneRoutine,
    [H_MUKHA] = NoneRoutine,
    [H_HAGGASH] = NoneRoutine,
    [H_URGHAT] = NoneRoutine,
    [H_GARUNA] = NoneRoutine,
    [H_ZOULEIKA] = NoneRoutine,
    [H_ERIKA] = NoneRoutine,
};

WEEKLY_TRIGGER_TRONGHOLD = {
    [H_TELSEK] = NoneRoutine,
    [H_GORSHAK] = Routine_HeroCallCentaurs,
    [H_GOTAI] = NoneRoutine,
    [H_AZAR] = NoneRoutine,
    [H_MATEWA] = NoneRoutine,
    [H_KUNYAK] = NoneRoutine,
    [H_KRAGH] = NoneRoutine,
    [H_KILGHAN] = NoneRoutine,
    [H_CRAGHACK] = NoneRoutine,
    [H_KRAAL] = NoneRoutine,
    [H_SHAKKARUKAT] = NoneRoutine,
    [H_KUJIN] = NoneRoutine,
    [H_SHIVA] = Routine_AddRecruitsShamans,
    [H_MUKHA] = Routine_AddHeroTitans,
    [H_HAGGASH] = NoneRoutine,
    [H_URGHAT] = NoneRoutine,
    [H_GARUNA] = NoneRoutine,
    [H_ZOULEIKA] = NoneRoutine,
    [H_ERIKA] = NoneRoutine,
};


for i,hero in HEROES_ORCS do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_STRONGHOLD_HERO[hero]);
end;

function DoStrongholdRoutine_Start(player, hero)
    startThread(START_TRIGGER_STRONGHOLD[hero], player);
end;

function DoStrongholdRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_STRONGHOLD[hero], player);
end;

function DoStrongholdRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_TRONGHOLD[hero], player);
end;


print("Loaded Stronghold advmap routines");
ROUTINES_LOADED[STRONGHOLD] = 1;
