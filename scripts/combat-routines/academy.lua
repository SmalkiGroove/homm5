
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
    [H_RAZZAK] = Routine_DuplicateGolemStack,
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
    [H_DAVIUS] = Routine_RakshasasAbility,
    [H_RISSA] = NoneRoutine,
    [H_GURVILIN] = Routine_CastMultipleVulnerability,
    [H_JHORA] = NoneRoutine,
    [H_CYRUS] = Routine_MagesCastMagicFist,
    [H_FAIZ] = NoneRoutine,
    [H_MAAHIR] = NoneRoutine,
    [H_NATHIR] = NoneRoutine,
    [H_NUR] = Routine_CastMultipleArcaneCrystals,
    [H_GALIB] = NoneRoutine,
    [H_ZEHIR] = Routine_CastSummonElementals,
    [H_THEODORUS] = NoneRoutine,
    [H_EMILIA] = Routine_CastSummonHive,
};

ACADEMY_COMBAT_TURN = {
    [H_HAVEZ] = NoneRoutine,
    [H_MINASLI] = Routine_BallistaMoveNext,
    [H_JOSEPHINE] = NoneRoutine,
    [H_RAZZAK] = NoneRoutine,
    [H_DAVIUS] = NoneRoutine,
    [H_RISSA] = Routine_CastRandomSlow,
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


function Routine_DuplicateGolemStack(side, hero)
    -- print("Trigger copy largest golems group !")
    local largest = 0;
    local copied_stack = "none";
    local creatures = GetUnits(side, CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            local nb = GetCreatureNumber(cr);
            if nb > largest then
                largest = nb;
                copied_stack = cr;
            end;
        end;
    end;
    if IsCombatUnit(copied_stack) then
        local x,y = GetUnitPosition(copied_stack);
        SummonCreatureStack_XY(side, GetCreatureType(copied_stack), largest, x, y+1);
    end;
end;

function Routine_RakshasasAbility(side, hero)
    -- print("Trigger rakshasas dash !")
    UnitSpecialAbility(side,67,68,164,176);
end;

function Routine_CastMultipleVulnerability(side, hero)
    -- print("Trigger disrupting rays !")
    HeroCast_AllEnnemies(side,hero_id,13,FREE_MANA);
end;

function Routine_MagesCastMagicFist(side, hero)
    -- print("Trigger mages magic fist !")
    UnitCast_RandomEnnemy(side,63,64,162,2);
end;

function Routine_CastMultipleArcaneCrystals(side, hero)
    -- print("Trigger random arcane crystals !")
    local m = trunc(GetUnitManaPoints(hero_id) * 0.05);
    local x1 = 13 - 11 * side;
    local x2 = 9 - 3 * side;
    for i = 1,m do
        startThread(UnitCastAreaSpell,hero_id,282,random(x1,x2,m),random(1,10,i));
    end;
end;

function Routine_CastSummonElementals(side, hero)
    -- print("Trigger summon elementals !")
    HeroCast_Global(hero_id,43,FREE_MANA);
end;

function Routine_CastSummonHive(side, hero)
    -- print("Trigger summon beehives !")
    local x = 15 - 13 * side;
    HeroCast_Area(hero_id,283,x,1,FREE_MANA);
    HeroCast_Area(hero_id,283,x,12,FREE_MANA);
end;

function Routine_BallistaMoveNext(side, hero, unit)
    -- print("Trigger fire ballista ATB boost !")
    UnitPlayNext_WarMachine(side,WAR_MACHINE_BALLISTA);
end;

function Routine_CastRandomSlow(side, hero, unit)
    -- print("Trigger random Slow !")
    local m = GetUnitManaPoints(hero_id);
    if m >= 20 then
        HeroCast_RandomEnnemy(side,hero_id,12,NO_COST);
        setATB(hero_id,1);
    end;
end;
