
function DoHavenRoutine_CombatPrepare(side, name, id)
    startThread(HAVEN_COMBAT_START[name], side, id);
end;

function DoHavenRoutine_CombatStart(side, name, id)
    startThread(HAVEN_COMBAT_START[name], side, id);
end;

function DoHavenRoutine_CombatTurn(side, name, id, unit)
    startThread(HAVEN_COMBAT_TURN[name], side, id, unit);
end;

function DoHavenRoutine_UnitDied(side, name, id, unit)
    startThread(HAVEN_UNIT_DIED[name], side, id, unit);
end;


HAVEN_COMBAT_PREPARE = {
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

HAVEN_COMBAT_START = {
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

HAVEN_COMBAT_TURN = {
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

HAVEN_UNIT_DIED = {
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
