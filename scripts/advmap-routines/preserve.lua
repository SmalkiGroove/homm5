
for i,hero in HEROES_SYLVAN do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_SYLVAN_HERO[hero]);
end;

function DoPreserveRoutine_Start(player, hero)
    startThread(START_TRIGGER_PRESERVE[hero], player);
end;

function DoPreserveRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_PRESERVE[hero], player);
end;

function DoPreserveRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_PRESERVE[hero], player);
end;


LEVEL_UP_SYLVAN_HERO = {
    [H_WYNGAAL] = "NoneRoutine",
    [H_ANWEN] = "NoneRoutine",
    [H_TALANAR] = "NoneRoutine",
    [H_OSSIR] = "NoneRoutine",
    [H_FINDAN] = "NoneRoutine",
    [H_JENOVA] = "NoneRoutine",
    [H_GILRAEN] = "NoneRoutine",
    [H_KYRRE] = "NoneRoutine",
    [H_IVOR] = "NoneRoutine",
    [H_MEPHALA] = "NoneRoutine",
    [H_ALARON] = "NoneRoutine",
    [H_DIRAEL] = "NoneRoutine",
    [H_VINRAEL] = "NoneRoutine",
    [H_YLTHIN] = "NoneRoutine",
    [H_TIERU] = "NoneRoutine",
    [H_GEM] = "NoneRoutine",
    [H_ELLESHAR] = "NoneRoutine",
};

START_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = NoneRoutine,
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
};

DAILY_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = NoneRoutine,
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
};

WEEKLY_TRIGGER_PRESERVE = {
    [H_WYNGAAL] = NoneRoutine,
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
};
