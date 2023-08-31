
function Routine_Offence(player, hero)

end


START_TRIGGER_SKILLS_ROUTINES = {
    [SKILL_NONE] = NoneRoutine,
    [SKILL_OFFENCE] = Routine_Offence,
}

DAILY_TRIGGER_SKILLS_ROUTINES = {
    [SKILL_NONE] = NoneRoutine,
}

WEEKLY_TRIGGER_SKILLS_ROUTINES = {
    [SKILL_NONE] = NoneRoutine,
}

AFTER_COMBAT_TRIGGER_SKILLS_ROUTINES = {
    [SKILL_NONE] = NoneRoutine,
}



function DoSkillsRoutine_Start(player, hero)
    for k,v in START_TRIGGER_SKILLS_ROUTINES do
        if HasHeroSkill(hero, k) then
            startThread(v, player, hero)
        end
    end
end

function DoSkillsRoutine_Daily(player, hero)
    for k,v in DAILY_TRIGGER_SKILLS_ROUTINES do
        if HasHeroSkill(hero, k) then
            startThread(v, player, hero)
        end
    end
end

function DoSkillsRoutine_Weekly(player, hero)
    for k,v in WEEKLY_TRIGGER_SKILLS_ROUTINES do
        if HasHeroSkill(hero, k) then
            startThread(v, player, hero)
        end
    end
end

function DoSkillsRoutine_AfterCombat(player, hero, index)
    for k,v in AFTER_COMBAT_TRIGGER_SKILLS_ROUTINES do
        if HasHeroSkill(hero, k) then
            startThread(v, player, hero, index)
        end
    end
end


-- print("Loaded skills advmap routines")
ROUTINES_LOADED[9] = 1
