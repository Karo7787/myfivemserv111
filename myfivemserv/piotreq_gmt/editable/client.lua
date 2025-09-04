GMT.Editable = {}

local ESX, QBCore = nil, nil
if Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
end

GMT.Editable.GetPlayerJob = function()
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

GMT.Editable.Notify = function(text)
    lib.notify({
        title = 'Notification',
        description = text,
        type = 'inform'
    })
end

GMT.Editable.GetPlayerIdentifier = function()
    return lib.callback.await('piotreq_gmt/getPlayerIdentifier', false)
end

GMT.Editable.SpawnVehicle = function(model, coords, heading, cb)
    local vehModel = lib.requestModel(model)
    local vehicle = CreateVehicle(model, coords, heading, true)
    while not DoesEntityExist(vehicle) do
        Wait(0)
    end

    cb(vehicle)
end

GMT.Editable.SetVehProperties = function(vehicle, properties)
    lib.setVehicleProperties(vehicle, properties)
end

GMT.Editable.IsPointClear = function(coords, dist)
    local vehicles = lib.getNearbyVehicles(vector3(coords.x, coords.y, coords.z), dist, false)
    return #vehicles == 0
end

GMT.Editable.FormatPlate = function(plateFormat)
    return plateFormat:format(math.random(111111, 999999)) -- example 'PD123456'
end

lib.addKeybind({
    name = 'Medic_Dispatch',
    description = locale('reports'),
    defaultKey = 'DELETE',
    onPressed = function(self)
        OpenDispatch()
    end,
})


RegisterNUICallback("fetchRaports", function(data, cb)
    local raports = lib.callback.await('piotreq_gmt:fetchRaports', false)
    cb(raports)
end)

RegisterNuiCallback("createRaport", function(data, cb)
    local ok = lib.callback.await('piotreq_gmt:createRaport', false, data)
    cb(ok)
end)

RegisterNuiCallback("editRaport", function(data, cb)
    local ok = lib.callback.await('piotreq_gmt:editRaport', false, data)
    cb(ok)
end)
