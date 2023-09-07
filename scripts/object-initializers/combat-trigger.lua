
COMBAT_TRIGGERING_OBJECTS = {
    "CREATURE",
    "BUILDING_CRYPT",
    "BUILDING_GARGOYLE_STONEVAULT",
    "BUILDING_DWARVEN_TREASURE",
    "BUILDING_BLOOD_TEMPLE",
    "BUILDING_NAGA_BANK",
    "BUILDING_NAGA_TEMPLE",
    "BUILDING_TREANT_THICKET",
    "BUILDING_UNKEMPT",
    "BUILDING_LEAN_TO",
    "BUILDING_SUNKEN_TEMPLE",
    "BUILDING_PYRAMID",
    "BUILDING_DEMOLISH",
    "BUILDING_BUOY",
    "BUILDING_CYCLOPS_STOCKPILE",
    "BUILDING_ABANDONED_MINE",
    "BUILDING_DRAGON_UTOPIA",
}

function HackHeroMana(hero)
    local temp = 1000000000 + GetHeroLevel(hero) * 10000000 + HERO_ACTIVE_ARTIFACT_SETS[hero][1] * 100000 + HERO_ACTIVE_ARTIFACT_SETS[hero][2] * 1000
    ChangeHeroStat(hero, STAT_KNOWLEDGE, 200000000)
    repeat sleep(1) until GetHeroStat(hero, STAT_KNOWLEDGE) > 200000000
    ChangeHeroStat(hero, STAT_MANA_POINTS, temp)
    repeat sleep(1) until GetHeroStat(hero, STAT_MANA_POINTS) > 1000
    ChangeHeroStat(hero, STAT_KNOWLEDGE, -200000000)
    repeat sleep(1) until GetHeroStat(hero, STAT_KNOWLEDGE) < 200000000
end

function RestoreHeroMana(hero)
    sleep(20)
    if GetHeroStat(hero, STAT_MANA_POINTS) > 1000 then
        local temp = 1000000000 + GetHeroLevel(hero) * 10000000 + HERO_ACTIVE_ARTIFACT_SETS[hero][1] * 100000 + HERO_ACTIVE_ARTIFACT_SETS[hero][2] * 1000
        ChangeHeroStat(hero, STAT_MANA_POINTS, -temp)
    end
end

function EnableCombatHook(object)
    if GetObjectPosition(object) then
        Trigger(OBJECT_TOUCH_TRIGGER, object, "HeroAttackMonsters")
        SetObjectEnabled(object, nil)
    end
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
    RestoreHeroMana(hero)
end

function InitializeCombatHook()
    for _,obj in COMBAT_TRIGGERING_OBJECTS do
        local objects = GetObjectNamesByType(obj)
        for _,o in objects do
            EnableCombatHook(o)
        end
    end
end


-- print("Loaded monster advmap routines")
ROUTINES_LOADED[x_combat_trigger] = 1
