--------------------------------------------------------------------------

function UnitPlayFirst(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
    for i,cr in creatures do
        if GetCreatureType(cr) == id0 then
            setATB(cr,1);
            print("Boosted ATB of creature "..id0)
        end;
        if GetCreatureType(cr) == id1 then
            setATB(cr,1);
            print("Boosted ATB of creature "..id1)
        end;
        if GetCreatureType(cr) == id2 then
            setATB(cr,1);
            print("Boosted ATB of creature "..id2)
        end;
    end;
end;

function UnitRandomShoot(side,id0,id1,id2)
    local creatures = GetUnits(side,CREATURE);
	local ennemies = GetUnits(1-side,CREATURE);
	local stacks = length(ennemies);
    local target = 0;
    if ennemies ~= nil then
        for i,cr in creatures do
            if stacks >= 2 then target = random(0,stacks-1,i+10) end;
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

function SummonStack(side,id)
    
end;

--------------------------------------------------------------------------

function TriggerHeroSpe(side,heroname)
	if heroname == "Ossir" then
        print("Tigger hunters random shoot !")
        UnitRandomShoot(side,47,48,147);
    end;
    if heroname == "Skeggy" then
        print("Tigger spearwielders random shoot !")
        UnitRandomShoot(side,94,95,167);
    end;
end;


function CombatStartSpecials()
	if GetHero(ATTACKER) then
		local attacker_id = GetAttackerHero();
		local attacker = GetHeroName(attacker_id);
		TriggerHeroSpe(ATTACKER,attacker);
	end;
	if GetHero(DEFENDER) then
		local defender_id = GetDefenderHero(); 
		local defender = GetHeroName(defender_id);
		TriggerHeroSpe(DEFENDER,defender);
	end;
end;

