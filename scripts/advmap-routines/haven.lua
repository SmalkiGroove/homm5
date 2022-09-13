
for i,hero in HEROES_HAVEN do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_HAVEN_HERO[hero]);
end;

function DoHavenRoutine_Start(player, hero)
    startThread(START_TRIGGER_HAVEN[hero], player);
end;

function DoHavenRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_HAVEN[hero], player);
end;

function DoHavenRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_HAVEN[hero], player);
end;


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
    [H_RUTGER] = "NoneRoutine",
    [H_MAEVE] = "NoneRoutine",
    [H_ELLAINE] = "NoneRoutine",
    [H_ALARIC] = "NoneRoutine",
    [H_GABRIELLE] = "NoneRoutine",
    [H_ORLANDO] = "NoneRoutine",
    [H_MARKAL] = "NoneRoutine",
};

START_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = NoneRoutine,
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
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = NoneRoutine,
};

DAILY_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = NoneRoutine,
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
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = NoneRoutine,
};

WEEKLY_TRIGGER_HAVEN = {
    [H_DUNCAN] = NoneRoutine,
    [H_DOUGAL] = NoneRoutine,
    [H_KLAUS] = NoneRoutine,
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
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = NoneRoutine,
};

