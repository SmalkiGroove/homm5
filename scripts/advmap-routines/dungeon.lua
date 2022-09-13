
function Routine_AddHeroManticores(player, hero)
    -- Manticore - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
    AddHero_CreatureType(player, hero, CREATURE_MANTICORE, 0.13);
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_DUNGEON_HERO = {
    [H_SORGAL] = "NoneRoutine",
    [H_KYTHRA] = "NoneRoutine",
    [H_AGBETH] = "NoneRoutine",
    [H_RANLETH] = "NoneRoutine",
    [H_DARKSTORM] = "NoneRoutine",
    [H_YRWANNA] = "NoneRoutine",
    [H_VAYSHAN] = "NoneRoutine",
    [H_THRALSAI] = "NoneRoutine",
    [H_LETHOS] = "NoneRoutine",
    [H_ERUINA] = "NoneRoutine",
    [H_YRBETH] = "NoneRoutine",
    [H_SYLSAI] = "NoneRoutine",
    [H_SINITAR] = "NoneRoutine",
    [H_SHADYA] = "NoneRoutine",
    [H_RAELAG] = "NoneRoutine",
    [H_YLAYA] = "NoneRoutine",
    [H_SEPHINROTH] = "NoneRoutine",
    [H_KASTORE] = "NoneRoutine",
};

START_TRIGGER_DUNGEON = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

DAILY_TRIGGER_DUNGEON = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

WEEKLY_TRIGGER_DUNGEON = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};


for i,hero in HEROES_DUNGEON do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_DUNGEON_HERO[hero]);
end;

function DoDungeonRoutine_Start(player, hero)
    startThread(START_TRIGGER_DUNGEON[hero], player);
end;

function DoDungeonRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_DUNGEON[hero], player);
end;

function DoDungeonRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_DUNGEON[hero], player);
end;


print("Loaded Dungeon advmap routines");
ROUTINES_LOADED[DUNGEON] = 1;
