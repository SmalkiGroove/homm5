
for i,hero in HEROES_FORTRESS do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_FORTRESS_HERO[hero]);
end;

function DoFortressRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_FORTRESS[hero], player);
end;

function DoFortressRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_FORTRESS[hero], player);
end;


LEVEL_UP_FORTRESS_HERO = {
    [H_INGVAR] = "NoneRoutine",
    [H_ROLF] = "NoneRoutine",
    [H_WULFSTAN] = "NoneRoutine",
    [H_TAZAR] = "NoneRoutine",
    [H_MAXIMUS] = "NoneRoutine",
    [H_KARLI] = "NoneRoutine",
    [H_HEDWIG] = "NoneRoutine",
    [H_TOLGHAR] = "NoneRoutine",
    [H_EBBA] = "NoneRoutine",
    [H_ULAND] = "NoneRoutine",
    [H_HAEGEIR] = "NoneRoutine",
    [H_HELMAR] = "NoneRoutine",
    [H_BRAND] = "NoneRoutine",
    [H_ERLING] = "NoneRoutine",
    [H_HANGVUL] = "NoneRoutine",
    [H_BART] = "NoneRoutine",
    [H_INGA] = "NoneRoutine",
};

DAILY_TRIGGER_FORTRESS = {
    [H_INGVAR] = NoneRoutine,
    [H_ROLF] = NoneRoutine,
    [H_WULFSTAN] = NoneRoutine,
    [H_TAZAR] = NoneRoutine,
    [H_MAXIMUS] = NoneRoutine,
    [H_KARLI] = NoneRoutine,
    [H_HEDWIG] = NoneRoutine,
    [H_TOLGHAR] = NoneRoutine,
    [H_EBBA] = NoneRoutine,
    [H_ULAND] = NoneRoutine,
    [H_HAEGEIR] = NoneRoutine,
    [H_HELMAR] = NoneRoutine,
    [H_BRAND] = NoneRoutine,
    [H_ERLING] = NoneRoutine,
    [H_HANGVUL] = NoneRoutine,
    [H_BART] = NoneRoutine,
    [H_INGA] = NoneRoutine,
};

WEEKLY_TRIGGER_FORTRESS = {
    [H_INGVAR] = NoneRoutine,
    [H_ROLF] = NoneRoutine,
    [H_WULFSTAN] = NoneRoutine,
    [H_TAZAR] = NoneRoutine,
    [H_MAXIMUS] = NoneRoutine,
    [H_KARLI] = NoneRoutine,
    [H_HEDWIG] = NoneRoutine,
    [H_TOLGHAR] = NoneRoutine,
    [H_EBBA] = NoneRoutine,
    [H_ULAND] = NoneRoutine,
    [H_HAEGEIR] = NoneRoutine,
    [H_HELMAR] = NoneRoutine,
    [H_BRAND] = NoneRoutine,
    [H_ERLING] = NoneRoutine,
    [H_HANGVUL] = NoneRoutine,
    [H_BART] = NoneRoutine,
    [H_INGA] = NoneRoutine,
};
