local bridge = {}

--- @param source integer
function bridge.getPlayer(source)
    return exports.qbx_core:GetPlayer(source)
end

function bridge.getPlayerIdentifier(player)
    return tostring(player.PlayerData.citizenid) or nil
end

function bridge.checkCopCount()
    local amount = exports.qbx_core:GetDutyCountType('leo')
    return amount
end

--- @param source integer
function bridge.hasPoliceJob(source)
    local hasJob = exports.qbx_core:HasPrimaryGroup(source, 'police')
    if not hasJob then return false end

    return true
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local source = source 
    
    OnPlayerLoaded(source)
end)

return bridge