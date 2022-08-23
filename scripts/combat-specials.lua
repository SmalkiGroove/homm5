COMBAT_TURN = 0;
CURRENT_UNIT = "none";

function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id0 then
            setATB(cr,1);
        else if GetCreatureType(cr) == id1 then
            setATB(cr,1);
        else if GetCreatureType(cr) == id2 then
            setATB(cr,1);
        else
            setATB(cr,0);
        end;
    end;
    local ennemies = GetUnits(1-side,CREATURE);
    for i,en in ennemies do
        setATB(en,0);
    end;
end;

function UnitRandomShoot(side,id0,id1,id2)
    local seed = GetUnitManaPoints(GetHero(side))
    local creatures = GetUnits(side,CREATURE);
	local ennemies = GetUnits(1-side,CREATURE);
	local stacks = length(ennemies);
    local target = 0;
    if ennemies ~= nil then
        for i,cr in creatures do
            if stacks >= 2 then target = random(0,stacks-1,i+seed) end;
            if GetCreatureType(cr) == id0 then
                ShootCombatUnit(cr,ennemies[target]);
                setATB(cr,0);
            end;
            if GetCreatureType(cr) == id1 then
                ShootCombatUnit(cr,ennemies[target]);
                setATB(cr,0);
            end;
            if GetCreatureType(cr) == id2 then
                ShootCombatUnit(cr,ennemies[target]);
                setATB(cr,0);
            end;
        end;
	end;
end;

function BallistaRandomShoot(side)
    local seed = GetUnitManaPoints(GetHero(side))
    local war_machines = GetUnits(side,WAR_MACHINE);
	local ennemies = GetUnits(1-side,CREATURE);
	local stacks = length(ennemies);
    local target = 0;
    if ennemies ~= nil then
        for i,wm in war_machines do
            if stacks >= 2 then target = random(0,stacks-1,seed) end;
            if GetWarMachineType(wm) == WAR_MACHINE_BALLISTA then
                ShootCombatUnit(wm,ennemies[target]);
            end;
        end;
	end;
end;

function SummonStack(side,id,amount,offset)
    local x,y;
    if (side == 0) then x=2+offset else x=13-offset end;
    y = 10;
    if amount == 0 then amount = 1 end;
    SummonCreature(side,id,amount,x,y);
    sleep(1);
end;

function HeroAttackEnnemies(side,hero)
	local ennemies = GetUnits(1-side,CREATURE);
    for i,en in ennemies do
        --ShootCombatUnit(hero,en);
    end;
end;

function HeroCast_RandomAlly(side,hero,spell,free,seed)
    local mana = GetUnitManaPoints(hero);
    local creatures = GetUnits(side,CREATURE);
    local stacks = length(creatures);
    local target;
    if stacks >= 2 then target = random(0,stacks-1,mana+seed) else target = 0 end;
    if free == 1 then SetUnitManaPoints(hero,99) end;
    UnitCastAimedSpell(hero,spell,creatures[target]);
    if free == 1 then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_RandomEnnemy(side,hero,spell,free,seed)
    local mana = GetUnitManaPoints(hero);
    local creatures = GetUnits(1-side,CREATURE);
    local stacks = length(creatures);
    local target;
    if stacks >= 2 then target = random(0,stacks-1,mana+seed) else target = 0 end;
    if free == 1 then SetUnitManaPoints(hero,99) end;
    UnitCastAimedSpell(hero,spell,creatures[target]);
    if free == 1 then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_RandomEnnemyArea(side,hero,spell,free,seed)
    local mana = GetUnitManaPoints(hero);
    local creatures = GetUnits(1-side,CREATURE);
    local stacks = length(creatures);
    local target;
    if stacks >= 2 then target = random(0,stacks-1,mana+seed) else target = 0 end;
    local x,y = GetUnitPosition(creatures[target]);
    if free == 1 then SetUnitManaPoints(hero,99) end;
    UnitCastAreaSpell(hero,spell,x,y)
    if free == 1 then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_Area(hero,spell,x,y,free)
    local mana = GetUnitManaPoints(hero);
    if free == 1 then SetUnitManaPoints(hero,99) end;
    UnitCastAreaSpell(hero,spell,x,y)
    if free == 1 then SetUnitManaPoints(hero,mana) end;
end;

function HeroCast_Global(hero,spell,free)
    local mana = GetUnitManaPoints(hero);
    if free == 1 then SetUnitManaPoints(hero,99) end;
    UnitCastGlobalSpell(hero,spell);
    if free == 1 then SetUnitManaPoints(hero,mana) end;
end;

function SiphonEnnemyMana(hero_id,side)
    local ennemies = GetUnits(1-side,CREATURE);
    local amount = 0;
    for i,en in ennemies do
        local mana = GetUnitManaPoints(en);
        SetUnitManaPoints(en,0);
        amount = amount + mana;
    end;
    local hero_mana = GetUnitManaPoints(hero_id);
    local hero_max_mana = GetUnitMaxManaPoints(hero_id);
    hero_mana = hero_mana + amount;
    if (hero_mana > hero_max_mana) then
        SetUnitManaPoints(hero_id,hero_max_mana);
    else
        SetUnitManaPoints(hero_id,hero_mana);
    end;
end;

--------------------------------------------------------------------------

function TriggerHeroSpe_Start(side,hero_name,hero_id)
    -- Haven
    if hero_name == "Duncan" then
        print("Trigger ballista random shoot !")
        BallistaRandomShoot(side);
    end;
    if hero_name == "Orrin" then
        print("Trigger archers atb boost !")
        UnitPlayFirst(side,3,4,107);
    end;
    if hero_name == "Markal" then
        print("Trigger cast Mass Confusion !")
        HeroCast_Global(hero_id,213,1);
    end;
    if hero_name == "Axel" then
        print("Trigger cast Prayer !")
        HeroCast_Global(hero_id,54,0);
    end;
    if hero_name == "RedHeavenHero03" then
        print("Trigger cast Blade Barriers !")
        local x;
        if (side == 0) then x=10 else x=5 end;
        for y=2,9 do
            startThread(HeroCast_Area(hero_id,284,x,y,1));
        end;
    end;
    -- Preserve
	if hero_name == "Ossir" then
        print("Trigger hunters random shoot !")
        UnitRandomShoot(side,47,48,147);
    end;
    if hero_name == "Vaniel" then
        print("Trigger hero cast Mass Haste !")
        HeroCast_Global(hero_id,221,1);
    end;
    if hero_name == "Ildar" then
        print("Trigger elder druids summoning !")
        local m = GetUnitMaxManaPoints(hero_id) * 0.1;
        SummonStack(side,50,trunc(0.5*m*m),0);
    end;
    if hero_name == "Gem" then
        print("Trigger siphon mana !")
        SiphonEnnemyMana(hero_id,side);
    end;
    -- Fortress
    if hero_name == "Skeggy" then
        print("Trigger spearwielders random shoot !")
        UnitRandomShoot(side,94,95,167);
    end;
end;

function TriggerHeroSpe_Turn(side,hero_name,hero_id,unit)
    -- Haven
    if hero_name == "RedHeavenHero01" then
        print("Trigger random stoneskin or deflect arrows !")
        HeroCast_RandomAlly(side,hero_id,25,1,COMBAT_TURN);
        HeroCast_RandomAlly(side,hero_id,29,1,COMBAT_TURN);
        setATB(hero_id,1);
    end;
    if hero_name == "Maeve" and hero_id == unit then
        print("Trigger random Encourage !")
        HeroCast_RandomAlly(side,hero_id,52,0,COMBAT_TURN);
        setATB(hero_id,1);
    end;
    if hero_name == "Jeddite" then
        print("Trigger random Vampirism !")
        local m = GetUnitManaPoints(hero_id);
        if m => 100 then
            HeroCast_RandomAlly(side,hero_id,278,0,COMBAT_TURN);
            setATB(hero_id,1);
        end;
    end;
    -- Inferno
    if hero_name == "toto" and hero_id == unit then
        print("Trigger random Fireball !")
        HeroCast_RandomEnnemyArea(side,hero_id,5,1,COMBAT_TURN);
    end;
end;


function CombatStartSpecials()
	if GetHero(ATTACKER) then
		local attacker_id = GetAttackerHero();
		local attacker = GetHeroName(attacker_id);
		TriggerHeroSpe_Start(ATTACKER,attacker,attacker_id);
	end;
	if GetHero(DEFENDER) then
		local defender_id = GetDefenderHero(); 
		local defender = GetHeroName(defender_id);
		TriggerHeroSpe_Start(DEFENDER,defender,defender_id);
	end;
end;

function UnitMoveSpecials(unit)
    if CURRENT_UNIT ~= unit then
        CURRENT_UNIT = unit;
        COMBAT_TURN = COMBAT_TURN + 1;

        local side = nil;
        if IsAttacker(unit) then side = ATTACKER else side = DEFENDER end;
    
        if GetHero(side) then
            local hero_id = GetHero(side);
            local hero_name = GetHeroName(hero_id);
            TriggerHeroSpe_Turn(side,hero_name,hero_id,unit);
        end;
    end;
end;
