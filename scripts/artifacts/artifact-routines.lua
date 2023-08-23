

DAILY_ARTIFACT_ROUTINES = {}
WEEKLY_ARTIFACT_ROUTINES = {}
AFTERCOMBAT_ARTIFACT_ROUTINES = {}
LEVELUP_ARTIFACT_ROUTINES = {}


function UpdateArtifacts()
    for player = 1,8 do
        if (GetPlayerState(player) == 1) then
			for i,hero in GetPlayerHeroes(player) do
                ScanHeroArtifacts(hero)
            end
        end
    end
end

function DoWatchArtifacts()
    while 1 do
        sleep(60)
        startThread(UpdateArtifacts)
    end
end
