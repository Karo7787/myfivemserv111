ESX = exports.es_extended:getSharedObject()
lib.locale()
local JobPoint = nil
RegisterNetEvent('esx:playerLoaded', function(playerData)
    TriggerServerEvent("tr-bloodtransport:InitPlayer")
end)

Citizen.CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.StartCoord,
        size = vector3(1,1,3),
        rotation = -20,
        debug = false,
        options = {
            {
                label = locale("job.take"),
                distance = 2,
                groups = {"ambulance"},
                icon = "fa-solid fa-truck-medical",
                canInteract = function()
                    return JobPoint == nil
                end,
                onSelect = function(data) 
                    ESX.TriggerServerCallback('tr-bloodtransport:StartJob', function(success, bags)
                        if success then
                            lib.notify({
                                description = locale("job.notifications.success")
                            })
                            JobPoint = math.random(1, #Config.DestitationCoords)
                            SetNewWaypoint(Config.DestitationCoords[JobPoint].x, Config.DestitationCoords[JobPoint].y)
                        else
                            lib.notify({
                                description = locale("job.notifications."..bags)
                            })
                        end
                    end)
                end
            }
        }
    })
    for k, coords in pairs(Config.DestitationCoords) do
        exports.ox_target:addBoxZone({
            coords = coords,
            size = vector3(1,1,3),
            rotation = -20,
            debug = false,
            options = {
                {
                    label = locale("job.deliver"),
                    distance = 2,
                    groups = {"ambulance"},
                    icon = "fa-solid fa-truck-medical",
                    canInteract = function()
                        return JobPoint == k
                    end,
                    onSelect = function(data) 
                        ESX.TriggerServerCallback('tr-bloodtransport:DeliverBlood', function(success, oldcount, newcount, thisend)
                            if success then
                                if thisend then
                                    lib.notify({
                                        description = locale("job.notifications.deliverend")
                                    })
                                    JobPoint = nil
                                    SetNewWaypoint(Config.StartCoord.x, Config.StartCoord.y)
                                else
                                    lib.notify({
                                        description = locale("job.notifications.deliversuccess", oldcount - newcount)
                                    })
                                    JobPoint = math.random(1, #Config.DestitationCoords)
                                    SetNewWaypoint(Config.DestitationCoords[JobPoint].x, Config.DestitationCoords[JobPoint].y)
                                end
                            end
                        end, JobPoint)
                    end
                }
            }
        })
    end
end)