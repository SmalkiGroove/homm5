
function DoAcademyRoutine_CombatPrepare(side, name, id)
    startThread(ACADEMY_COMBAT_START[name], side, id);
end;

function DoAcademyRoutine_CombatStart(side, name, id)
    startThread(ACADEMY_COMBAT_START[name], side, id);
end;

function DoAcademyRoutine_CombatTurn(side, name, id, unit)
    startThread(ACADEMY_COMBAT_TURN[name], side, id, unit);
end;

function DoAcademyRoutine_UnitDied(side, name, id, unit)
    startThread(ACADEMY_UNIT_DIED[name], side, id, unit);
end;


ACADEMY_COMBAT_PREPARE = {
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

ACADEMY_COMBAT_START = {
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

ACADEMY_COMBAT_TURN = {
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

ACADEMY_UNIT_DIED = {
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
