
function DoFortressRoutine_CombatPrepare(side, name, id)
    startThread(FORTRESS_COMBAT_START[name], side, id);
end;

function DoFortressRoutine_CombatStart(side, name, id)
    startThread(FORTRESS_COMBAT_START[name], side, id);
end;

function DoFortressRoutine_CombatTurn(side, name, id, unit)
    startThread(FORTRESS_COMBAT_TURN[name], side, id, unit);
end;

function DoFortressRoutine_UnitDied(side, name, id, unit)
    startThread(FORTRESS_UNIT_DIED[name], side, id, unit);
end;


FORTRESS_COMBAT_PREPARE = {
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

FORTRESS_COMBAT_START = {
    [H_INGVAR] = NoneRoutine,
    [H_ROLF] = NoneRoutine,
    [H_WULFSTAN] = Routine_BallistaMoveFirst,
    [H_TAZAR] = NoneRoutine,
    [H_MAXIMUS] = NoneRoutine,
    [H_KARLI] = Routine_SkirmishersRandomShoot,
    [H_HEDWIG] = NoneRoutine,
    [H_TOLGHAR] = NoneRoutine,
    [H_EBBA] = NoneRoutine,
    [H_ULAND] = Routine_ThanesAbility,
    [H_HAEGEIR] = NoneRoutine,
    [H_HELMAR] = NoneRoutine,
    [H_BRAND] = Routine_CastFireWalls,
    [H_ERLING] = Routine_RunePriestsMoveFirst,
    [H_HANGVUL] = NoneRoutine,
    [H_BART] = Routine_SummonEarthElementals,
    [H_INGA] = Routine_CastMeteorShowers,
};

FORTRESS_COMBAT_TURN = {
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
    [H_INGA] = Routine_CastRandomImplosion,
};

FORTRESS_UNIT_DIED = {
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


function Routine_BallistaMoveFirst(side, hero)
    -- print("Trigger ballista play first !")
    WarMachinePlayFirst(side,WAR_MACHINE_BALLISTA);
end;

function Routine_SkirmishersRandomShoot(side, hero)
    -- print("Trigger spearwielders random shoot !")
    UnitRandomShoot(side,94,95,167);
end;

function Routine_ThanesAbility(side, hero)
    -- print("Trigger Thanes ability !")
    UnitSpecialAbility2(side,103,345);
    UnitSpecialAbility2(side,171,247);
end;

function Routine_CastFireWalls(side, hero)
    -- print("Trigger cast Fire walls !")
    local m = GetUnitManaPoints(hero_id);
    local x = 11 - 7 * side;
    for y=2,11 do
        HeroCast_Area(hero_id,236,x,y,FREE_MANA);
    end;
    SetMana(hero_id,m);
end;

function Routine_RunePriestsMoveFirst(side, hero)
    -- print("Trigger rune priests play first !")
    UnitPlayFirst(side,100,101,170);
end;

function Routine_SummonEarthElementals(side, hero)
    -- print("Trigger summon earth elems !")
    local m = GetUnitMaxManaPoints(hero_id) * 0.5;
    SummonStack(side,87,m,4);
    SummonStack(side,87,m,4);
end;

function Routine_CastMeteorShowers(side, hero)
    -- print("Trigger uber meteor shower !")
    local x = 15 - 13 * side;
    HeroCast_Area(hero_id,285,x,9,FREE_MANA);
    sleep(1500);
    HeroCast_Area(hero_id,285,x,4,FREE_MANA);
end;

function Routine_CastRandomImplosion(side, hero, unit)
    if GetUnitManaPoints(hero_id) >= 250 then
        -- print("Trigger random implosion !")
        HeroCast_RandomEnnemy(side,hero_id,9,NO_COST);
        setATB(hero_id,1);
    end;
end;
