local bridge = {}

local ESX = exports['es_extended']:getSharedObject()

--- @param source integer
function bridge.getPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function bridge.checkCopCount()
    return GlobalState['scoreboard_counter']["police"]
end

--- @param source integer
function bridge.hasPoliceJob(source)
    local playerData = ESX.GetPlayerData(source)
    local playerJob = playerData.job.name

    if playerJob == 'police' then
        return true
    end

    return nil
end

RegisterNetEvent('esx:playerLoaded', function()
    OnPlayerLoaded()
end)

return bridge