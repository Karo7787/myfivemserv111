local bridge = {}

local ESX = exports.es_extended:getSharedObject()

--- @param source integer
function bridge.getPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function bridge.getPlayerIdentifier(player)
    return player.identifier
end

function bridge.checkCopCount()
    return GlobalState['scoreboard_counter']["police"]
end

--- @param source integer
function bridge.hasPoliceJob(source)
    local player = ESX.GetPlayerFromId(source)
    local playerJob = player.getJob().name

    if playerJob == 'police' then
        return true
    end

    return nil
end

AddEventHandler('esx:playerLoaded', function(player)
    OnPlayerLoaded(player)
end)

RegisterNetEvent("mrg_houserobbery:piotreq:alert", function(coords)
    exports['piotreq_gpt']:SendAlert(nil, {
        title = "Napad na mieszkanie",
        code = '10-90',
        coords = coords,
        canAnswer = false,
        maxOfficers = 4,
        time = 5,
        blip = {
            sprite = 40,
            color = 1,
            scale = 0.75,
            alpha = 200,
            name = "Napad na mieszkanie"
        },
        type = 'risk',
        info = {
            {icon = 'fa-solid fa-road', isStreet = true},
        },
        notifyTime = 10000,
    })
end)

return bridge