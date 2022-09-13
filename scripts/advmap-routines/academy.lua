
function Routine_GainAcademyArtifacts()
    -- Book of power / Tunic of enlightment / Sandal of the blessed / Staff of sar-issus / Tome of summoning magic
    local hero = H_JOSEPHINE;
    local level = GetHeroLevel(hero);
    if     level == 10 then GiveArtifact(hero, ARTIFACT_BOOK_OF_POWER)
    elseif level == 20 then GiveArtifact(hero, ARTIFACT_CHAIN_MAIL_OF_ENLIGHTMENT)
    elseif level == 30 then GiveArtifact(hero, ARTIFACT_SANDALS_OF_THE_SAINT)
    elseif level == 40 then GiveArtifact(hero, ARTIFACT_STAFF_OF_MAGI)
    elseif level == 50 then GiveArtifact(hero, ARTIFACT_TOME_OF_SUMMONING_MAGIC)
    end;
end;

function Routine_GainArtifactTarotDeck(player, hero)
    -- Give hero artifact Tarot deck
    GiveArtifact(hero, ARTIFACT_TAROT_DECK);
end;

function Routine_AddOtherHeroesGremlins(player, hero)
    -- Gremlins (other heroes) - 1 * level
    for i,h in GetPlayerHeroes(player) do
        if h ~= hero then
            AddHero_CreatureInTypes(player, h, {CREATURE_GREMLIN,CREATURE_MASTER_GREMLIN,CREATURE_GREMLIN_SABOTEUR}, 1.0);
        end;
    end;
end;

function Routine_GenerateGoldsExponential(player, hero)
    -- Gold - 1:250 - 7:500 - 14:1000 - 21:2000 ... 49:32k
    local amount = 250 * power(2, trunc(0.143 * GetHeroLevel(hero)));
    AddPlayer_Resource(player, hero, GOLD, amount);
end;

function Routine_AddOtherHeroesExperience(player, hero)
    -- Exp (other heroes) - 3% total hero exp
    for i,h in GetPlayerHeroes(player) do
        if h ~= hero then
            AddHero_StatPercent(player, hero, STAT_EXPERIENCE, 0.03);
        end;
    end;
end;

function Routine_AddHeroDjinns(player, hero)
    -- Djinn - 1:4 - 2:10 - 3:17 - 4:24 - 5:30 ... 8:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_GENIE,CREATURE_MASTER_GENIE,CREATURE_DJINN_VIZIER}, 0.15);
end;

function Routine_AddAndEvolveEagles(player, hero)
    -- Eagle - 1:6 - 2:17 - 3:28 - 4:39 - 5:50 / Eagle to Phoenix for 50 Elemental Gargoyles
    AddHero_CreatureType(player, hero, CREATURE_SNOW_APE, 0.09);
    ChangeHero_CreatureFusion(player, hero, CREATURE_SNOW_APE, CREATURE_MARBLE_GARGOYLE, CREATURE_PHOENIX, 50);
end;

function Routine_AddRecruitsRakshasas(player, hero)
    -- Rakshasas - 0.25 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_6, CREATURE_RAKSHASA, 0.25);
end;


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_ACADEMY_HERO = {
    [H_HAVEZ] = "NoneRoutine",
    [H_MINASLI] = "NoneRoutine",
    [H_JOSEPHINE] = "Routine_GainAcademyArtifacts",
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

START_TRIGGER_ACADEMY = {
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

DAILY_TRIGGER_ACADEMY = {
    [H_HAVEZ] = Routine_AddOtherHeroesGremlins,
    [H_MINASLI] = NoneRoutine,
    [H_JOSEPHINE] = NoneRoutine,
    [H_RAZZAK] = NoneRoutine,
    [H_DAVIUS] = NoneRoutine,
    [H_RISSA] = NoneRoutine,
    [H_GURVILIN] = NoneRoutine,
    [H_JHORA] = NoneRoutine,
    [H_CYRUS] = NoneRoutine,
    [H_FAIZ] = Routine_GenerateGoldsExponential,
    [H_MAAHIR] = NoneRoutine,
    [H_NATHIR] = NoneRoutine,
    [H_NUR] = NoneRoutine,
    [H_GALIB] = Routine_AddHeroDjinns,
    [H_ZEHIR] = NoneRoutine,
    [H_THEODORUS] = Routine_AddAndEvolveEagles,
    [H_EMILIA] = NoneRoutine,
};

WEEKLY_TRIGGER_ACADEMY = {
    [H_HAVEZ] = NoneRoutine,
    [H_MINASLI] = NoneRoutine,
    [H_JOSEPHINE] = NoneRoutine,
    [H_RAZZAK] = NoneRoutine,
    [H_DAVIUS] = Routine_AddRecruitsRakshasas,
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


for i,hero in HEROES_ACADEMY do
	Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_ACADEMY_HERO[hero]);
end;

function DoAcademyRoutine_Start(player, hero)
    startThread(START_TRIGGER_ACADEMY[hero], player);
end;

function DoAcademyRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_ACADEMY[hero], player);
end;

function DoAcademyRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_ACADEMY[hero], player);
end;


print("Loaded Academy advmap routines");
ROUTINES_LOADED[ACADEMY] = 1;
