
for i,hero in HEROES_ORCS do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_STRONGHOLD_HERO[hero]);
end;




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
