
for i,hero in HEROES_ACADEMY do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_ACADEMY_HERO[hero]);
end;

function DoAcademyRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_ACADEMY[hero], player);
end;

function DoAcademyRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_ACADEMY[hero], player);
end;


LEVEL_UP_ACADEMY_HERO = {
    [H_HAVEZ] = "NoneRoutine",
    [H_MINASLI] = "NoneRoutine",
    [H_JOSEPHINE] = "NoneRoutine",
    [H_RAZZAK] = "NoneRoutine",
    [H_DAVIUS] = "NoneRoutine",
    [H_RISSA] = "NoneRoutine",
    [H_GURVILIN] = "NoneRoutine",
    [H_JHORA] = "NoneRoutine",
    [H_CYRUS] = "NoneRoutine",
    [H_FAIZ] = "NoneRoutine",
    [H_MAAHIR] = "NoneRoutine",
    [H_NATHIR] = "NoneRoutine",
    [H_NUR] = "NoneRoutine",
    [H_GALIB] = "NoneRoutine",
    [H_ZEHIR] = "NoneRoutine",
    [H_THEODORUS] = "NoneRoutine",
    [H_EMILIA] = "NoneRoutine",
};

DAILY_TRIGGER_ACADEMY = {
    [H_HAVEZ] = NoneRoutine,
    [H_MINASLI] = NoneRoutine,
    [H_JOSEPHINE] = NoneRoutine,
    [H_RAZZAK] = NoneRoutine,
    [H_DAVIUS] = NoneRoutine,
    [H_RISSA] = NoneRoutine,
    [H_GURVILIN] = NoneRoutine,
    [H_JHORA] = NoneRoutine,
    [H_CYRUS] = NoneRoutine,
    [H_FAIZ] = NoneRoutine,
    [H_MAAHIR] = NoneRoutine,
    [H_NATHIR] = NoneRoutine,
    [H_NUR] = NoneRoutine,
    [H_GALIB] = NoneRoutine,
    [H_ZEHIR] = NoneRoutine,
    [H_THEODORUS] = NoneRoutine,
    [H_EMILIA] = NoneRoutine,
};

WEEKLY_TRIGGER_ACADEMY = {
    [H_HAVEZ] = NoneRoutine,
    [H_MINASLI] = NoneRoutine,
    [H_JOSEPHINE] = NoneRoutine,
    [H_RAZZAK] = NoneRoutine,
    [H_DAVIUS] = NoneRoutine,
    [H_RISSA] = NoneRoutine,
    [H_GURVILIN] = NoneRoutine,
    [H_JHORA] = NoneRoutine,
    [H_CYRUS] = NoneRoutine,
    [H_FAIZ] = NoneRoutine,
    [H_MAAHIR] = NoneRoutine,
    [H_NATHIR] = NoneRoutine,
    [H_NUR] = NoneRoutine,
    [H_GALIB] = NoneRoutine,
    [H_ZEHIR] = NoneRoutine,
    [H_THEODORUS] = NoneRoutine,
    [H_EMILIA] = NoneRoutine,
};
