
function DoStrongholdRoutine_CombatPrepare(side, name, id)
    startThread(STRONGHOLD_COMBAT_START[name], side, id);
end;

function DoStrongholdRoutine_CombatStart(side, name, id)
    startThread(STRONGHOLD_COMBAT_START[name], side, id);
end;

function DoStrongholdRoutine_CombatTurn(side, name, id, unit)
    startThread(STRONGHOLD_COMBAT_TURN[name], side, id, unit);
end;

function DoStrongholdRoutine_UnitDied(side, name, id, unit)
    startThread(STRONGHOLD_UNIT_DIED[name], side, id, unit);
end;


STRONGHOLD_COMBAT_PREPARE = {
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

STRONGHOLD_COMBAT_START = {
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

STRONGHOLD_COMBAT_TURN = {
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

STRONGHOLD_UNIT_DIED = {
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


function Routine_CastCallOfBlood(side, hero)
    -- print("Trigger call of blood !")
    HeroCast_TargetCreature(side,hero_id,291,FREE_MANA,121,122,175);
end;

function Routine_CastBattlecry(side, hero)
    -- print("Trigger battlecry !")
    HeroCast_Global(hero_id,294,FREE_MANA);
end;

function Routine_CastHordeAnger(side, hero)
    if GetUnitManaPoints(hero_id) >= 10 then
        -- print("Trigger horde's anger !")
        HeroCast_RandomEnnemy(side,hero_id,295,10);
    end;
end;

function Routine_CastPowerfulBlowCentaur(side, hero)
    -- print("Trigger powerful blow on centaur !")
    HeroCast_TargetCreature(side,hero_id,305,FREE_MANA,119,120,174);
end;

function Routine_CastRallingCry(side, hero)
    -- print("Trigger ralling cry !")
    HeroCast_Global(hero_id,290,FREE_MANA);
end;

function Routine_BallistaRandomShoot(side, hero)
    -- print("Trigger ballista random shoot !")
    BallistaRandomShoot(side);
end;

function Routine_CastLightningSpell(side, hero)
    -- print("Trigger lightning spell !")
    local ennemies = GetUnits(1-side,CREATURE);
    local spell = 3;
    if length(ennemies) >= 4 then spell = 7 end;
    HeroCast_Target(hero_id,spell,FREE_MANA,ennemies[0]);
end;

function Routine_CyclopsMoveNext(side, hero, unit)
    -- print("Trigger cyclops play next !")
    UnitPlayNext_Creature(side,129,130,179);
end;

function Routine_SummonGoblinStack(side, hero, unit)
    -- print("Trigger summon goblins !")
    local m = trunc(GetUnitMaxManaPoints(hero_id) * 1.5);
    SummonCreature(side,117,m);
end;

function Routine_ShamansManaRegen(side, hero, unit)
    -- print("Trigger shamans mana !")
    local id = GetCreatureType(unit);
    if id == 123 or id == 124 or id == 176 then
        local a = trunc(GetUnitMaxManaPoints(hero_id) * 0.1);
        local m = GetUnitManaPoints(unit);
        SetMana(unit,m+a);
    end;
end;

function Routine_CastRandomRegenOrPlague(side, hero, unit)
    -- print("Trigger regen or plague !")
    if GetUnitType(unit) == WAR_MACHINE and GetWarMachineType(unit) == WAR_MACHINE_BALLISTA then
        if mod(TURN,2) == 0 then
            HeroCast_RandomAlly(side,hero_id,280,FREE_MANA);
        else
            HeroCast_RandomEnnemy(side,hero_id,14,FREE_MANA);
        end;
    end;
end;

function Routine_CastRandomVulnerability(side, hero, unit)
    -- print("Trigger random vulnerability !")
    HeroCast_RandomEnnemy(side,hero_id,13,FREE_MANA);
    setATB(hero_id,1);
end;
