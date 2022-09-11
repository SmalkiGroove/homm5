
function DoInfernoRoutine_CombatPrepare(side, name, id)
    startThread(INFERNO_COMBAT_START[name], side, id);
end;

function DoInfernoRoutine_CombatStart(side, name, id)
    startThread(INFERNO_COMBAT_START[name], side, id);
end;

function DoInfernoRoutine_CombatTurn(side, name, id, unit)
    startThread(INFERNO_COMBAT_TURN[name], side, id, unit);
end;

function DoInfernoRoutine_UnitDied(side, name, id, unit)
    startThread(INFERNO_UNIT_DIED[name], side, id, unit);
end;


INFERNO_COMBAT_PREPARE = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = NoneRoutine,
    [H_CALID] = NoneRoutine,
};

INFERNO_COMBAT_START = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = Routine_CastMarkOfTheDamned,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = Routine_CastRandomBlindness,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = Routine_SuccubusRandomShoot,
    [H_KHABELETH] = Routine_SummonPitlords,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = Routine_CastMineFields,
    [H_CALID] = NoneRoutine,
};

INFERNO_COMBAT_TURN = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = Routine_BallistaShootUnit,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = Routine_DemonicCreatureExplosion,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = Routine_CastRandomStoneSpikes,
    [H_CALID] = Routine_CastRandomFireball,
};

INFERNO_UNIT_DIED = {
    [H_GRAWL] = NoneRoutine,
    [H_NEBIROS] = NoneRoutine,
    [H_MARBAS] = NoneRoutine,
    [H_HARKENRAZ] = NoneRoutine,
    [H_CALH] = NoneRoutine,
    [H_SHELTEM] = NoneRoutine,
    [H_ALASTOR] = NoneRoutine,
    [H_GROK] = NoneRoutine,
    [H_NYMUS] = NoneRoutine,
    [H_JEZEBETH] = NoneRoutine,
    [H_MALUSTAR] = NoneRoutine,
    [H_AGRAEL] = NoneRoutine,
    [H_BIARA] = NoneRoutine,
    [H_KHABELETH] = NoneRoutine,
    [H_ZYDAR] = NoneRoutine,
    [H_DELEB] = NoneRoutine,
    [H_CALID] = NoneRoutine,
};


function Routine_CastMarkOfTheDamned(side, hero)
    -- print("Trigger mark of the damned")
    HeroCast_RandomEnnemy(side,hero_id,56,NO_COST);
end;

function Routine_CastRandomBlindness(side, hero)
    -- print("Trigger random blindness !")
    HeroCast_RandomEnnemy(side,hero_id,19,FREE_MANA);
end;

function Routine_SuccubusRandomShoot(side, hero)
    -- print("Trigger succubus random shoot !")
    UnitRandomShoot(side,21,22,134);
end;

function Routine_SummonPitlords(side, hero)
    -- print("Trigger pit lords summoning !")
    local m = GetUnitMaxManaPoints(hero_id) * 0.1;
    SummonStack(side,26,trunc(0.1*m*m),0);
    SummonStack(side,26,trunc(0.1*m*m),0);
end;

function Routine_CastMineFields(side, hero)
    -- print("Trigger mine fields !")
    local x = 12 - 9 * side;
    HeroCast_Area(hero_id,38,x,4,FREE_MANA);
    HeroCast_Area(hero_id,38,x,9,FREE_MANA);
end;

function Routine_BallistaShootUnit(side, hero, unit)
    -- print("Trigger fireball ballista shoot !")
    BallistaTargetShoot(1-side,unit);
end;

function Routine_DemonicCreatureExplosion(side, hero, unit)
    local id = GetCreatureType(unit);
    if id ~= nil then
        if (id >= 15 and id <= 28) or (id >= 131 and id <= 137) then
            -- print("Trigger creature explosion !")
            local x,y = GetUnitPosition(unit);
            UnitCastAreaSpell(unit,162,x,y);
            setATB(unit,1);
        end;
    end;
end;

function Routine_CastRandomStoneSpikes(side, hero, unit)
    -- print("Trigger random Stone spikes !")
    HeroCast_RandomEnnemyArea(side,hero_id,237,FREE_MANA);
    setATB(hero_id,1);
end;

function Routine_CastRandomFireball(side, hero, unit)
    -- print("Trigger random Fireball !")
    HeroCast_RandomEnnemyArea(side,hero_id,5,FREE_MANA);
end;
