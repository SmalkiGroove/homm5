
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


function Routine_BallistaRandomSalvo(side, hero)
    -- print("Trigger ballista random shoot !")
    BallistaRandomShoot(side);
end;

function Routine_ArchersMoveFirst(side, hero)
    -- print("Trigger archers atb boost !")
    UnitPlayFirst(side,3,4,107);
end;

function Routine_CastPrayer(side, hero)
    -- print("Trigger cast Prayer !")
    HeroCast_Global(hero_id,54,NO_COST);
end;

function Routine_InvokeBladeBarriers(side, hero)
    -- print("Trigger cast Blade Barriers !")
    local m = GetUnitManaPoints(hero_id);
    local x = 12 - 9 * side;
    for y=2,11 do
        HeroCast_Area(hero_id,284,x,y,FREE_MANA);
        HeroCast_Area(hero_id,284,x-1+side*2,11-y,FREE_MANA);
    end;
    SetMana(hero_id,m);
end;

function Routine_CastMassConfusion(side, hero)
    -- print("Trigger cast Mass Confusion !")
    HeroCast_Global(hero_id,213,FREE_MANA);
end;

function Routine_CastRandomStoneskinAndDeflect(side, hero, unit)
    -- print("Trigger random stoneskin and deflect arrows !")
    local unit = RandomCreature(side,COMBAT_TURN);
    HeroCast_Target(hero_id,25,FREE_MANA,unit);
    HeroCast_Target(hero_id,29,FREE_MANA,unit);
    setATB(hero_id,1);
end;

function Routine_CastRandomEncourage(side, hero, unit)
    -- print("Trigger random Encourage !")
    HeroCast_RandomAlly(side,hero_id,52,NO_COST);
    setATB(hero_id,1);
end;

function Routine_CastRandomVampirism(side, hero, unit)
    -- print("Trigger random Vampirism !")
    local m = GetUnitManaPoints(hero_id);
    if m >= 100 then
        HeroCast_RandomAlly(side,hero_id,278,NO_COST);
        setATB(hero_id,1);
    end;
end;
