
function Routine_BallistaRandomSalvo(side, hero)
    -- print("Trigger ballista random shoot !")
    local n = trunc(GetUnitMaxManaPoints(hero) * 0.05);
    for i = 1,n do
        RandomShoot_Ballista(side);
        sleep(100);
    end;
end;

function Routine_ArchersMoveFirst(side, hero)
    -- print("Trigger archers atb boost !")
    SetATB_CreatureTypes(side, {CREATURE_ARCHER,CREATURE_MARKSMAN,CREATURE_LONGBOWMAN}, ATB_INSTANT);
end;

function Routine_CastPrayer(side, hero)
    -- print("Trigger cast Prayer !")
    HeroCast_Global(hero, SPELL_PRAYER, NO_COST);
end;

function Routine_CastMassConfusion(side, hero)
    -- print("Trigger cast Mass Confusion !")
    HeroCast_Global(hero, SPELL_MASS_FORGETFULNESS, FREE_MANA);
end;

function Routine_CastRandomStoneskinAndDeflect(side, hero)
    -- print("Trigger random stoneskin and deflect arrows !")
    if CURRENT_UNIT == hero then
        local unit = RandomCreature(side, COMBAT_TURN);
        HeroCast_Target(hero, 25, FREE_MANA, unit);
        HeroCast_Target(hero, 29, FREE_MANA, unit);
        SetATB_ID(hero, ATB_INSTANT);
    end;
end;

function Routine_CastRandomEncourage(side, hero)
    -- print("Trigger random Encourage !")
    if CURRENT_UNIT == hero then
        HeroCast_RandomCreature(hero, SPELL_ENCOURAGE, NO_COST, side);
        SetATB_ID(hero, ATB_INSTANT);
    end;
end;

function Routine_CastRandomVampirism(side, hero)
    -- print("Trigger random Vampirism !")
    if CURRENT_UNIT == hero then
        if GetUnitManaPoints(hero) >= 100 then
            HeroCast_RandomCreature(hero, SPELL_VAMPIRISM, NO_COST, side);
            SetATB_ID(hero, ATB_INSTANT);
        end;
    end;
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
    [H_DUNCAN] = Routine_BallistaRandomSalvo,
    [H_DOUGAL] = Routine_ArchersMoveFirst,
    [H_KLAUS] = NoneRoutine,
    [H_IRINA] = NoneRoutine,
    [H_ISABEL] = NoneRoutine,
    [H_LASZLO] = NoneRoutine,
    [H_NICOLAI] = NoneRoutine,
    [H_GODRIC] = NoneRoutine,
    [H_FREYDA] = Routine_CastPrayer,
    [H_RUTGER] = NoneRoutine,
    [H_MAEVE] = NoneRoutine,
    [H_ELLAINE] = NoneRoutine,
    [H_ALARIC] = NoneRoutine,
    [H_GABRIELLE] = NoneRoutine,
    [H_ORLANDO] = NoneRoutine,
    [H_MARKAL] = Routine_CastMassConfusion,
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
    [H_MAEVE] = Routine_CastRandomEncourage,
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


function DoHavenRoutine_CombatPrepare(side, name, id)
    startThread(HAVEN_COMBAT_PREPARE[name], side, id);
end;

function DoHavenRoutine_CombatStart(side, name, id)
    startThread(HAVEN_COMBAT_START[name], side, id);
end;

function DoHavenRoutine_CombatTurn(side, name, id)
    startThread(HAVEN_COMBAT_TURN[name], side, id);
end;

function DoHavenRoutine_UnitDied(side, name, id, unit)
    startThread(HAVEN_UNIT_DIED[name], side, id, unit);
end;


print("Loaded Haven combat routines");
ROUTINES_LOADED[HAVEN] = 1;
