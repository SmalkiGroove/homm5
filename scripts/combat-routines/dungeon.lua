

DUNGEON_COMBAT_PREPARE = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

DUNGEON_COMBAT_START = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

DUNGEON_COMBAT_TURN = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

DUNGEON_UNIT_DIED = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
};

function DoDungeonRoutine_CombatPrepare(side, name, id)
    startThread(DUNGEON_COMBAT_START[name], side, id);
end;

function DoDungeonRoutine_CombatStart(side, name, id)
    startThread(DUNGEON_COMBAT_START[name], side, id);
end;

function DoDungeonRoutine_CombatTurn(side, name, id, unit)
    startThread(DUNGEON_COMBAT_TURN[name], side, id, unit);
end;

function DoDungeonRoutine_UnitDied(side, name, id, unit)
    startThread(DUNGEON_UNIT_DIED[name], side, id, unit);
end;


print("Loaded Dungeon combat routines");
ROUTINES_LOADED[DUNGEON] = 1;
