
function HackHeroMana(hero)
    local temp = 1000000000 + GetHeroLevel(hero) * 10000000
    ChangeHeroStat(hero, STAT_KNOWLEDGE, 200000000)
    repeat sleep(1) until GetHeroStat(hero, STAT_KNOWLEDGE) > 200000000
    ChangeHeroStat(hero, STAT_MANA_POINTS, temp)
    repeat sleep(1) until GetHeroStat(hero, STAT_MANA_POINTS) > 1000
    ChangeHeroStat(hero, STAT_KNOWLEDGE, -200000000)
    repeat sleep(1) until GetHeroStat(hero, STAT_KNOWLEDGE) < 200000000
end

function EnableCombatHook(object)
    Trigger(OBJECT_TOUCH_TRIGGER, object, "HeroAttackMonsters")
    SetObjectEnabled(object, nil)
end

function DisableCombatHook(object)
    Trigger(OBJECT_TOUCH_TRIGGER, object, nil)
    SetObjectEnabled(object, not nil)
end

function HeroAttackMonsters(hero, monsters)
    HackHeroMana(hero)
    DisableCombatHook(monsters)
    MakeHeroInteractWithObject(hero, monsters)
    EnableCombatHook(monsters)
end

function DoTriggerCombatStart()
    local monsters = GetObjectNamesByType("CREATURE")
    for i,monster in monsters do
        EnableCombatHook(monster)
    end
end


-- print("Loaded monster advmap routines")
ROUTINES_LOADED[x_combat_trigger] = 1
