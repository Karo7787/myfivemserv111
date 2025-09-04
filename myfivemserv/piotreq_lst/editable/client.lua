LST.Editable = {}

local ESX, QBCore = nil, nil
if Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)
elseif Config.Framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
end

LST.Editable.Notify = function(text)
    lib.notify({
        title = 'Notification',
        description = text,
        type = 'inform'
    })
end

LST.Editable.GetJob = function()
    if Config.Framework == 'ESX' then
        return ESX.GetPlayerData().job
    elseif Config.Framework == 'QB' then
        local playerJob = QBCore.Functions.GetPlayerData().job
        if playerJob then
            return {
                name = playerJob.name,
                grade = tonumber(playerJob.grade.level),
                label = playerJob.label,
            }
        end
    elseif Config.Framework == 'QBOX' then
        local playerJob = exports['qbx_core']:GetPlayerData().job
        if playerJob then
            return {
                name = playerJob.name,
                grade = tonumber(playerJob.grade.level),
                label = playerJob.label,
            }
        end
    end
end

LST.Editable.GetPlayerIdentifier = function()
    local identifier = lib.callback.await('p_mechanicjob/getIdentifier', false)
end

LST.Editable.SpawnVehicle = function(model, coords, heading, cb)
    local vehicleModel = type(model) == 'number' and model or joaat(model)
    lib.requestModel(vehicleModel)
    local vehicle = CreateVehicle(vehicleModel, coords, heading, true, true)
    local id = NetworkGetNetworkIdFromEntity(vehicle)
    SetNetworkIdCanMigrate(id, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(vehicleModel)
    SetVehRadioStation(vehicle, 'OFF')

    RequestCollisionAtCoord(coords)
    while not HasCollisionLoadedAroundEntity(vehicle) do
        Wait(0)
    end

    if cb then
        cb(vehicle)
    end
end

LST.Editable.SetVehProperties = function(vehicle, properties)
    lib.setVehicleProperties(vehicle, properties)
end

LST.Editable.IsPointClear = function(coords, dist)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = cache.ped
        coords = GetEntityCoords(playerPed)
    end

    for k, entity in pairs(GetGamePool('CVehicle')) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = entity
        end
    end

    return #nearbyEntities == 0
end

LST.Editable.FormatPlate = function(plateFormat)
    return plateFormat:format(math.random(1111, 9999)) -- example 'MECH1234'
end

lib.addKeybind({
    name = 'Mechanic_Dispatch',
    description = locale('reports'),
    defaultKey = 'DELETE',
    onPressed = function(self)
        OpenDispatch()
    end,
})