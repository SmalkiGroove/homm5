
function DoNecropolisRoutine_CombatPrepare(side, name, id)
    startThread(NECROPOLIS_COMBAT_START[name], side, id);
end;

function DoNecropolisRoutine_CombatStart(side, name, id)
    startThread(NECROPOLIS_COMBAT_START[name], side, id);
end;

function DoNecropolisRoutine_CombatTurn(side, name, id, unit)
    startThread(NECROPOLIS_COMBAT_TURN[name], side, id, unit);
end;

function DoNecropolisRoutine_UnitDied(side, name, id, unit)
    startThread(NECROPOLIS_UNIT_DIED[name], side, id, unit);
end;


NECROPOLIS_COMBAT_PREPARE = {
    [H_KASPAR] = NoneRoutine,
    [H_VLADIMIR] = NoneRoutine,
    [H_ORSON] = NoneRoutine,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = NoneRoutine,
    [H_AISLINN] = NoneRoutine,
    [H_GIOVANNI] = NoneRoutine,
    [H_ARCHILUS] = NoneRoutine,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = NoneRoutine,
};

NECROPOLIS_COMBAT_START = {
    [H_KASPAR] = NoneRoutine,
    [H_VLADIMIR] = Routine_SummonAndKillEnnemySkeleton,
    [H_ORSON] = NoneRoutine,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = Routine_DuplicateArmyGhosts,
    [H_AISLINN] = Routine_CastMassWeakness,
    [H_GIOVANNI] = NoneRoutine,
    [H_ARCHILUS] = Routine_SummonAvatarOfDeath,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = Routine_CastMultipleSorrow,
};

NECROPOLIS_COMBAT_TURN = {
    [H_KASPAR] = Routine_CastRandomPlague,
    [H_VLADIMIR] = NoneRoutine,
    [H_ORSON] = Routine_SummonZombieStack,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = NoneRoutine,
    [H_AISLINN] = NoneRoutine,
    [H_GIOVANNI] = Routine_CastRandomIceBolt,
    [H_ARCHILUS] = NoneRoutine,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = NoneRoutine,
};

NECROPOLIS_UNIT_DIED = {
    [H_KASPAR] = NoneRoutine,
    [H_VLADIMIR] = NoneRoutine,
    [H_ORSON] = NoneRoutine,
    [H_ORNELLA2] = NoneRoutine,
    [H_LUCRETIA] = NoneRoutine,
    [H_XERXON] = NoneRoutine,
    [H_DEIRDRE] = NoneRoutine,
    [H_NAADIR] = NoneRoutine,
    [H_AISLINN] = NoneRoutine,
    [H_GIOVANNI] = NoneRoutine,
    [H_ARCHILUS] = NoneRoutine,
    [H_ZOLTAN] = NoneRoutine,
    [H_RAVEN] = NoneRoutine,
    [H_ARANTIR] = NoneRoutine,
    [H_THANT] = NoneRoutine,
    [H_SANDRO] = NoneRoutine,
    [H_VIDOMINA] = NoneRoutine,
};


function Routine_SummonAndKillEnnemySkeleton(side, hero)
    -- print("Trigger summon and kill skeleton !")
    local n = length(GetUnits(1-side,CREATURE));
    SummonStack(1-side,152,1,5);
    repeat sleep(10) until length(GetUnits(1-side,CREATURE)) == n+1;
    HeroCast_Target(hero_id,1,FREE_MANA,GetUnits(1-side,CREATURE)[n]);
end;

function Routine_SummonAvatarOfDeath(side, hero)
    -- print("Trigger summon avatar of death !")
    HeroCast_Global(hero_id,200,FREE_MANA);
end;

function Routine_CastMassWeakness(side, hero)
    -- print("Trigger cast mass weakness !")
    HeroCast_Global(hero_id,210,FREE_MANA);
end;

function Routine_CastMultipleSorrow(side, hero)
    -- print("Trigger random sorrow")
    local e = GetUnits(1-side,CREATURE);
    local m = GetUnitMaxManaPoints(hero_id) * 0.02;
    local n = min(length(e),1+trunc(m));
    for i = 1,n do
        HeroCast_Target(hero_id,277,FREE_MANA,e[i-1]);
    end;
end;

function Routine_DuplicateArmyGhosts(side, hero)
    -- print("Trigger duplicate ghosts !")
    for i,cr in GetUnits(side,CREATURE) do
        local id = GetCreatureType(cr);
        if id == 33 or id == 34 or id == 154 then
            local nb = GetCreatureNumber(cr);
            local x,y = GetUnitPosition(cr);
            SummonCreature(side,id,nb,x);
            sleep(1);
        end;
    end;
end;

function Routine_CastRandomPlague(side, hero, unit)
    -- print("Trigger random Plague !")
    HeroCast_RandomEnnemy(side,hero_id,14,FREE_MANA);
    setATB(hero_id,1);
end;

function Routine_SummonZombieStack(side, hero, unit)
    -- print("Trigger summon zombies !")
    local m = GetUnitManaPoints(hero_id);
    if m > 0 then SummonCreature(side,32,m) end;
end;

function Routine_CastRandomIceBolt(side, hero, unit)
    -- print("Trigger random Ice Bolt !")
    HeroCast_RandomEnnemy(side,hero_id,4,FREE_MANA);
    setATB(hero_id,1);
end;
