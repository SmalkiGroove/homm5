
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
    [H_INGA] = NoneRoutine,
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
