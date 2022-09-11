
function DoSylvanRoutine_CombatPrepare(side, name, id)
    startThread(SYLVAN_COMBAT_START[name], side, id);
end;

function DoSylvanRoutine_CombatStart(side, name, id)
    startThread(SYLVAN_COMBAT_START[name], side, id);
end;

function DoSylvanRoutine_CombatTurn(side, name, id, unit)
    startThread(SYLVAN_COMBAT_TURN[name], side, id, unit);
end;

function DoSylvanRoutine_UnitDied(side, name, id, unit)
    startThread(SYLVAN_UNIT_DIED[name], side, id, unit);
end;


SYLVAN_COMBAT_PREPARE = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = NoneRoutine,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = NoneRoutine,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = NoneRoutine,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = NoneRoutine,
};

SYLVAN_COMBAT_START = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = Routine_AngerTreantsAbility,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = Routine_HunterRandomShoot,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = NoneRoutine,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = Routine_SummonDruidStack,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = Routine_CastMassHaste,
    [H_GEM] = Routine_SiphonEnnemyMana,
    [H_ELLESHAR] = NoneRoutine,
};

SYLVAN_COMBAT_TURN = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = NoneRoutine,
    [H_TALANAR] = Routine_CastRandomBloodlust,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = Routine_SummonWolfStack,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = Routine_DruidsMoveNext,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = NoneRoutine,
};

SYLVAN_UNIT_DIED = {
    [H_WYNGAAL] = NoneRoutine,
    [H_ANWEN] = NoneRoutine,
    [H_TALANAR] = NoneRoutine,
    [H_OSSIR] = NoneRoutine,
    [H_FINDAN] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_JENOVA] = NoneRoutine,
    [H_KYRRE] = NoneRoutine,
    [H_IVOR] = NoneRoutine,
    [H_MEPHALA] = NoneRoutine,
    [H_ALARON] = NoneRoutine,
    [H_DIRAEL] = NoneRoutine,
    [H_VINRAEL] = NoneRoutine,
    [H_YLTHIN] = NoneRoutine,
    [H_TIERU] = NoneRoutine,
    [H_GEM] = NoneRoutine,
    [H_ELLESHAR] = NoneRoutine,
};


function Routine_AngerTreantsAbility(side, hero)
    -- print("Trigger anger treants rage of forest !")
    UnitSpecialAbility(side,0,0,150,329);
end;

function Routine_HunterRandomShoot(side, hero)
    -- print("Trigger hunters random shoot !")
    UnitRandomShoot(side,47,48,147);
end;

function Routine_SummonDruidStack(side, hero)
    -- print("Trigger elder druids summoning !")
    local m = GetUnitMaxManaPoints(hero_id) * 0.1;
    SummonStack(side,50,trunc(0.5*m*m),0);
end;

function Routine_CastMassHaste(side, hero)
    -- print("Trigger hero cast Mass Haste !")
    HeroCast_Global(hero_id,221,FREE_MANA);
end;

function Routine_SiphonEnnemyMana(side, hero)
    -- print("Trigger siphon mana !")
    SiphonEnnemyMana(hero_id,side);
end;

function Routine_CastRandomBloodlust(side, hero, unit)
    -- print("Trigger random bloodlust !")
    HeroCast_RandomAlly(side,hero_id,28,FREE_MANA);
    setATB(hero_id,1);
end;

function Routine_SummonWolfStack(side, hero, unit)
    -- print("Trigger spawn wolves pack !")
    local m = trunc(GetUnitManaPoints(hero_id) * 0.34);
    if m > 0 then SummonCreature(side,113,m) end;
end;

function Routine_DruidsMoveNext(side, hero, unit)
    -- print("Trigger druids play next !")
    UnitPlayNext_Creature(side,49,50,148);
end;
