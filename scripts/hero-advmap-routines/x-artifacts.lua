

START_TRIGGER_ARTIFACTS_ROUTINES = {
    [ARTIFACT_NONE] = NoneRoutine,
}

DAILY_TRIGGER_ARTIFACTS_ROUTINES = {
    [ARTIFACT_NONE] = NoneRoutine,
}

WEEKLY_TRIGGER_ARTIFACTS_ROUTINES = {
    [ARTIFACT_NONE] = NoneRoutine,
}

AFTER_COMBAT_TRIGGER_ARTIFACTS_ROUTINES = {
    [ARTIFACT_NONE] = NoneRoutine,
}


function DoArtifactsRoutine_Start(player, hero)
    for k,v in START_TRIGGER_ARTIFACTS_ROUTINES do
        -- if HasHeroSkill(hero, k) then
        --     startThread(v, player, hero)
        -- end
    end
end

function DoArtifactsRoutine_Daily(player, hero)
    for k,v in DAILY_TRIGGER_ARTIFACTS_ROUTINES do
        -- if HasHeroSkill(hero, k) then
        --     startThread(v, player, hero)
        -- end
    end
end

function DoArtifactsRoutine_Weekly(player, hero)
    for k,v in WEEKLY_TRIGGER_ARTIFACTS_ROUTINES do
        -- if HasHeroSkill(hero, k) then
        --     startThread(v, player, hero)
        -- end
    end
end

function DoArtifactsRoutine_AfterCombat(player, hero, index)
    for k,v in AFTER_COMBAT_TRIGGER_ARTIFACTS_ROUTINES do
        -- if HasHeroSkill(hero, k) then
        --     startThread(v, player, hero, index)
        -- end
    end
end


-- print("Loaded artifacts advmap routines")
ROUTINES_LOADED[x_artifacts] = 1
