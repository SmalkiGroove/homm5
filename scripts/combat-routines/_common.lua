

function NoneRoutine(side, hero)
    -- print("Trigger nothing !")
end;



function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            setATB(cr,1);
        end;
    end;
end;

function WarMachinePlayFirst(side,type)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == type then
            setATB(wm,1);
        end;
    end;
end;

function UnitPlayNext_Creature(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            setATB(cr,0.99);
        end;
    end;
end;

function UnitPlayNext_WarMachine(side,type)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == type then
            setATB(wm,0.99);
        end;
    end;
end;

function UnitRandomShoot(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            ShootCombatUnit(cr,RandomCreature(1-side,i));
            sleep(100);
        end;
    end;
end;

function UnitCast_RandomEnnemy(side,id0,id1,id2,spell)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            UnitCastAimedSpell(cr,spell,RandomCreature(1-side,i));
        end;
    end;
end;

function UnitSpecialAbility(side,id0,id1,id2,ability)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            UseCombatAbility(cr,ability);
        end;
    end;
end;

function UnitSpecialAbility2(side,id,ability)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id then
            local x,y = GetUnitPosition(RandomCreature(1-side,i));
            UseCombatAbility(cr,ability,x,y);
        end;
    end;
end;

function BallistaTargetShoot(side,target)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
            ShootCombatUnit(wm,target);
        end;
    end;
end;

function BallistaRandomShoot(side)
    local war_machines = GetUnits(side,WAR_MACHINE);
    for i,wm in war_machines do
        if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
            ShootCombatUnit(wm,RandomCreature(1-side,nil));
        end;
    end;
end;

function SummonStack(side,id,amount,offset)
    local x,y;
    if (side == 0) then x=2+offset else x=13-offset end;
    -- y = 10;
    if amount == 0 then amount = 1 end;
    SummonCreature(side,id,amount,x);
    sleep(1);
end;

function SummonCopy(side,id0,id1,id2)
    local largest = 0;
    local copied_stack = "none";
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        local nb = GetCreatureNumber(cr);
        if id == id0 or id == id1 or id == id2 then
            if nb > largest then
                largest = nb;
                copied_stack = cr;
            end;
        end;
    end;
    if IsCombatUnit(copied_stack) then
        local x,y = GetUnitPosition(copied_stack);
        SummonCreature(side,GetCreatureType(copied_stack),largest,x,y+1);
        sleep(1);
    end;
end;

function HeroCast_Target(hero,spell,required,target)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,target);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_TargetCreature(side,hero,spell,required,id0,id1,id2)
    local mana = GetUnitManaPoints(hero);
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        local id = GetCreatureType(cr);
        if id == id0 or id == id1 or id == id2 then
            if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
            startThread(DoCastTargetSpell,hero,spell,required,cr);
            repeat Wait() until THREAD_STATE == 1;
            THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
        end;
    end;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_AllEnnemies(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    local ennemies = GetUnits(1-side,CREATURE);
    for i,en in ennemies do
        if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
        startThread(DoCastTargetSpell,hero,spell,required,en);
        repeat Wait() until THREAD_STATE == 1;
        THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    end;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomAlly(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomEnnemy(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastTargetSpell,hero,spell,required,RandomCreature(1-side,mana+COMBAT_TURN));
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_RandomEnnemyArea(side,hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    local x,y = GetUnitPosition(RandomCreature(1-side,mana+COMBAT_TURN));
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_Area(hero,spell,x,y,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastAreaSpell,hero,spell,required,x,y);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroCast_Global(hero,spell,required)
    local mana = GetUnitManaPoints(hero);
    if required == FREE_MANA then SetMana(hero,FREE_MANA) end;
    startThread(DoCastGlobalSpell,hero,spell,required);
    repeat Wait() until THREAD_STATE == 1;
    THREAD_STATE = 0; THREAD_FINISHER = THREAD_LIMIT;
    if required == FREE_MANA then SetMana(hero,mana) end;
end;

function HeroAttack_RandomEnnemy(side)
    SetControlMode(side,MODE_AUTO);
    sleep(1);
    SetControlMode(side,MODE_MANUAL);
    SetControlMode(side,MODE_NORMAL);
end;

function SiphonEnnemyMana(hero_id,side)
    local ennemies = GetUnits(1-side,CREATURE);
    local amount = 0;
    for i,en in ennemies do
        local mana = GetUnitManaPoints(en);
        SetMana(en,0);
        amount = amount + mana;
    end;
    local hero_mana = GetUnitManaPoints(hero_id);
    local hero_max_mana = GetUnitMaxManaPoints(hero_id);
    hero_mana = hero_mana + amount;
    if (hero_mana > hero_max_mana) then
        SetMana(hero_id,hero_max_mana);
    else
        SetMana(hero_id,hero_mana);
    end;
end;

