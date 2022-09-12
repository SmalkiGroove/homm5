
for i,hero in HEROES_NECRO do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_NECRO_HERO[hero]);
end;

function DoNecropolisRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_NECROPOLIS[hero], player);
end;

function DoNecropolisRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_NECROPOLIS[hero], player);
end;


LEVEL_UP_NECRO_HERO = {
    [H_KASPAR] = "NoneRoutine",
    [H_VLADIMIR] = "NoneRoutine",
    [H_ORSON] = "NoneRoutine",
    [H_ORNELLA2] = "NoneRoutine",
    [H_LUCRETIA] = "NoneRoutine",
    [H_XERXON] = "NoneRoutine",
    [H_DEIRDRE] = "NoneRoutine",
    [H_NAADIR] = "NoneRoutine",
    [H_AISLINN] = "NoneRoutine",
    [H_GIOVANNI] = "NoneRoutine",
    [H_ARCHILUS] = "NoneRoutine",
    [H_ZOLTAN] = "NoneRoutine",
    [H_RAVEN] = "NoneRoutine",
    [H_ARANTIR] = "NoneRoutine",
    [H_THANT] = "NoneRoutine",
    [H_SANDRO] = "NoneRoutine",
    [H_VIDOMINA] = "NoneRoutine",
};

DAILY_TRIGGER_NECROPOLIS = {
    [H_KASPAR] = NoneRoutine,
    [H_VLADIMIR] = NoneRoutine,
    [H_ORSON] = NoneRoutine,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = NoneRoutine,
    [H_AISLINN] = NoneRoutine,
    [H_GIOVANNI] = NoneRoutine,
    [H_ARCHILUS] = NoneRoutine,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = NoneRoutine,
};

WEEKLY_TRIGGER_NECROPOLIS = {
    [H_KASPAR] = NoneRoutine,
    [H_VLADIMIR] = NoneRoutine,
    [H_ORSON] = NoneRoutine,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = NoneRoutine,
    [H_AISLINN] = NoneRoutine,
    [H_GIOVANNI] = NoneRoutine,
    [H_ARCHILUS] = NoneRoutine,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = NoneRoutine,
};
