
GAME_ID = "test"

ComputeGameId = function()
	GAME_ID = "titotu"
	SetGameVar("game_id", GAME_ID)
end


RegisterHero = function(name)
    local key = GAME_ID..'_'..name
    SetGameVar(key.."_level", GetHeroLevel(name))
end

DataUpdate = function()
    SetGameVar("update_request", "none")
    while true do
        local value = GetGameVar("update_request")
        if value ~= "none" then
            RegisterHero(value)
            SetGameVar("update_request", "none")
        else
            sleep(10)
        end
    end
end

startThread(DataUpdate)

SOURCE_LOADED["gamevars"] = 1