
function Routine_InvokeBladeBarriers(side, hero)
    -- print("Trigger cast Blade Barriers !")
    local m = GetUnitManaPoints(hero)
    local x1 = 12 - 9 * side
    local x2 = 11 - 7 * side
    for y= GRID_Y_MIN+1,GRID_Y_MAX-1 do
        HeroCast_Area(hero, SPELL_BLADE_BARRIER, FREE_MANA, x1, y)
        HeroCast_Area(hero, SPELL_BLADE_BARRIER, FREE_MANA, x2, GRID_Y_MAX-y+1)
    end
    SetMana(hero, m)
end

function Routine_CastVampirismOnWitches(side, hero)
    -- print("Trigger cast Vampirism !")
    local w = {}
    for i,cr in GetUnits(side, CREATURE) do
        local type = GetCreatureType(CURRENT_UNIT)
        if type == CREATURE_WITCH or type == CREATURE_BLOOD_WITCH or type == CREATURE_BLOOD_WITCH_2 then
            insert(w, cr)
        end
    end
    local m = GetUnitMaxManaPoints(hero) * 0.01
    local n = min(length(w), 1+trunc(m))
    for i = 1,n do
        HeroCast_Target(hero, SPELL_VAMPIRISM, FREE_MANA, w[i])
    end
end

function Routine_ScoutsMoveFirst(side, hero)
    -- print("Trigger scouts play first !")
    SetATB_CreatureTypes(side, {CREATURE_SCOUT,CREATURE_ASSASSIN,CREATURE_STALKER}, ATB_INSTANT)
end

function Routine_HeroMoveFirst(side, hero)
    -- print("Trigger hero play first !")
    SetATB_ID(hero, ATB_INSTANT)
end

function Routine_CastRandomDeepFrost(side, hero)
    -- print("Trigger cast deep frost !")
    HeroCast_RandomCreature(hero, SPELL_DEEP_FREEZE, FREE_MANA, 1-side)
end

function Routine_CastRandomLightningBolt(side, hero)
    -- print("Trigger cast lightning bolt !")
    HeroCast_RandomCreature(hero, SPELL_LIGHTNING_BOLT, FREE_MANA, 1-side)
end

function Routine_CastConjurePhoenix(side, hero)
    -- print("Trigger cast conjure phoenix !")
    HeroCast_Global(hero, SPELL_CONJURE_PHOENIX, FREE_MANA)
end

function Routine_RidersHydraSynergy(side, hero)
    -- print("Trigger riders boost hydras atb !")
    if CURRENT_UNIT_SIDE == side then
        local type = GetCreatureType(CURRENT_UNIT)
        if type == CREATURE_RIDER or type == CREATURE_RAVAGER or type == CREATURE_BLACK_RIDER then
            local r = 20 + trunc(GetUnitMaxManaPoints(hero) * 0.2)
            if random(0, 100, COMBAT_TURN) <= r then
                SetATB_CreatureTypes(side, {CREATURE_HYDRA,CREATURE_CHAOS_HYDRA,CREATURE_ACIDIC_HYDRA}, ATB_NEXT)
            end
        end
    end
end

function Routine_MinotaursMoveNext(side, hero)
    -- print("Trigger minotaurs play next !")
    if CURRENT_UNIT == hero then
        SetATB_CreatureTypes(side, {CREATURE_MINOTAUR,CREATURE_MINOTAUR_KING,CREATURE_MINOTAUR_CAPTAIN}, ATB_NEXT)
    end
end

function Routine_RefreshMatronMana(side, hero)
    -- print("Trigger refresh shadow witches mana !")
    if CURRENT_UNIT == hero then
        for i,cr in GetUnits(side, CREATURE) do
            local type = GetCreatureType(cr)
            if type == CREATURE_MATRON or type == CREATURE_MATRIARCH or type == CREATURE_SHADOW_MISTRESS then
                local m = GetUnitMaxManaPoints(cr)
                SetMana(cr, m)
            end
        end
    end
end

function Routine_CastRandomLightningBolt2(side, hero)
    -- print("Trigger cast lightning bolt !")
    if CURRENT_UNIT == hero then
        HeroCast_RandomCreature(hero, SPELL_LIGHTNING_BOLT, FREE_MANA, 1-side)
    end
end


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
}

DUNGEON_COMBAT_START = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = Routine_InvokeBladeBarriers,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = Routine_CastVampirismOnWitches,
    [H_VAYSHAN] = Routine_ScoutsMoveFirst,
    [H_THRALSAI] = Routine_HeroMoveFirst,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = Routine_CastRandomDeepFrost,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = Routine_CastRandomLightningBolt,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = Routine_CastConjurePhoenix,
}

DUNGEON_COMBAT_TURN = {
    [H_SORGAL] = Routine_RidersHydraSynergy,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = Routine_MinotaursMoveNext,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = Routine_RefreshMatronMana,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = Routine_CastRandomLightningBolt2,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
}

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
}

function DoDungeonRoutine_CombatPrepare(side, name, id)
    startThread(DUNGEON_COMBAT_PREPARE[name], side, id)
end

function DoDungeonRoutine_CombatStart(side, name, id)
    startThread(DUNGEON_COMBAT_START[name], side, id)
end

function DoDungeonRoutine_CombatTurn(side, name, id, unit)
    startThread(DUNGEON_COMBAT_TURN[name], side, id, unit)
end

function DoDungeonRoutine_UnitDied(side, name, id, unit)
    startThread(DUNGEON_UNIT_DIED[name], side, id, unit)
end


-- print("Loaded Dungeon combat routines")
ROUTINES_LOADED[DUNGEON] = 1
