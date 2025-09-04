local bridge = {}

--- @param source integer
function bridge.getPlayer(source)
    return exports.ND_Core:getPlayer(source)
end

function bridge.getPlayerIdentifier(player)
    return player.identifier
end

function bridge.checkCopCount()
    local amount = 0
    local players = exports.NDCore:getPlayers()
    local policeDepartments = {'sahp', 'lspd', 'bcso'}

    for _, player in pairs(players) do
        for i=1, #policeDepartments do
            if player.groups[policeDepartments[i]] then
                amount += 1
            end
        end
    end
    
    return amount
end

function bridge.hasPoliceJob(source)
    local player = exports.ND_Core:getPlayer(source)
    local playerJob = player.getData('job')
    
    if playerJob == 'police' then
        return true
    end

    return nil
end

AddEventHandler('ND:characterLoaded', function()
    local source = source
    OnPlayerLoaded(source)
end)

return bridge