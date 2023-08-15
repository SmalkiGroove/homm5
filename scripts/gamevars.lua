
GAME_ID = "test"

ComputeGameId = function()
	GAME_ID = "titotu"
	SetGameVar("game_id", GAME_ID)
end


RegisterHero = function(name)
    local key = GAME_ID..'_'..name
    SetGameVar(key.."_level", GetHeroLevel(name))
    SetGameVar(key.."_stat_att", GetHeroStat(name, STAT_ATTACK))
    SetGameVar(key.."_stat_def", GetHeroStat(name, STAT_DEFENCE))
    SetGameVar(key.."_stat_pwr", GetHeroStat(name, STAT_SPELL_POWER))
    SetGameVar(key.."_stat_klg", GetHeroStat(name, STAT_KNOWLEDGE))
    SetGameVar(key.."_stat_lck", GetHeroStat(name, STAT_LUCK))
    SetGameVar(key.."_stat_mrl", GetHeroStat(name, STAT_MORALE))
end

DataUpdate = function()
    local Check = function()
        for player = 1,8 do
            if (GetPlayerState(player) == 1) then
                for i,hero in GetPlayerHeroes(player) do
                    RegisterHero(hero)
                end
            end
        end
    end

    while 1 do
        sleep(50)
        print("update data...")
        startThread(Check)
    end
end

startThread(DataUpdate)

SOURCE_LOADED["gamevars"] = 1