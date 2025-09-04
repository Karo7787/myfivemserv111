DisableFire = false
local utils = lib.require('client.utils')
local Config = lib.require('config')
GarageInit = false
function OpenGarages()
    local vehicles 
    if utils.inImpound then
        vehicles = lib.callback.await('mrg_garages:fetchAllVehicles', false)
    else
        vehicles = lib.callback.await('mrg_garages:fetchVehicles', false, Config.Garages[utils.garageId].type or "car")
    end
    if not vehicles then
        ESX.ShowNotification("Nie posiadasz pojazdów w garażu", 'info')
        return
    end

    local sortedVehicles = {}
    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        local vehData = json.decode(vehicle.vehicle)
        local vehModel = GetDisplayNameFromVehicleModel(vehData.model)
        local vehLabel = GetLabelText(vehModel)
        sortedVehicles[i] = {
            name = vehLabel ~= 'NULL' and vehLabel or vehModel,
            plate = vehicle.plate,
            vin = vehicle.vin or 'BRAK',
            vehicle = vehicle.vehicle,
            vehicleid = vehicle.vehicleid,
            engine = vehData.engineHealth and math.floor(vehData.engineHealth / 10) or 100,
            body = vehData.bodyHealth and math.floor(vehData.bodyHealth / 10) or 100,
            fuel = vehData.fuelLevel and math.floor(vehData.fuelLevel) or 100,
            model = string.lower(vehModel),
            status = vehicle.state
        }
    end
    utils.SendReactMessage('loadVehicles', {vehicles = sortedVehicles, inImpound = utils.inImpound, inGarage = utils.garageId ~= nil})
    utils.toggleNuiFrame(true)
end


exports('OpenGarages', OpenGarages)
RegisterNetEvent('mrg_garages:openGarage', OpenGarages)

RegisterNUICallback('locateGarage', function(_, cb)
    local coords, dist = utils.findGarage()
    if not coords then
        return
    end
    
    SetNewWaypoint(coords.x, coords.y)
    ESX.ShowNotification(('Oznaczono najbliższy parking który znajduje się od ciebie %s metrów'):format(math.floor(dist)))
    cb({})
end)

RegisterNUICallback('takeVehicle', function(data, cb)
    if not utils.garageId then
        ESX.ShowNotification('Nie jesteś w pobliżu garażu')
        cb(false)
        return
    end

    local spawnId = utils.getFreeSpawnPoint(utils.garageId)
    if not spawnId then
        ESX.ShowNotification('Brak wolnego miejsca parkingowego')
        cb(false)
        return
    end

    local spawn = Config.Garages[utils.garageId].points[spawnId]
    local result = lib.callback.await('mrg_garages:takeVehicle', false, {plate = data.plate, spawn = spawn})
    utils.SendReactMessage('Hide', {})
    cb(result)
end)

RegisterNetEvent("mrg_garages:SetVehicleProperties", function(result)
    local entity = NetworkGetEntityFromNetworkId(result.netId)
    ESX.Game.SetVehicleProperties(entity, result.vehData)
    Wait(100)
    exports["mrg_fuel"]:SetFuel(entity, result.vehData.fuelLevel)
end)

RegisterNUICallback('parkVehicle', function(data, cb)
    local vehicle = cache.vehicle
    if not vehicle or vehicle == 0 then
        local coords = GetEntityCoords(cache.ped)
        vehicle = ESX.Game.GetClosestVehicle(coords)
    end

    if not vehicle or vehicle == 0 then
        return ESX.ShowNotification('Nie ma żadnego pojazdu w pobliżu')
    end
    
    local result = lib.callback.await('mrg_garages:parkVehicle', false, {
        vehicle = data,
        netId = NetworkGetNetworkIdFromEntity(vehicle),
        properties = ESX.Game.GetVehicleProperties(vehicle)
    })
    utils.SendReactMessage('Hide', {})
    cb(result)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if DisableFire then
            DisablePlayerFiring(PlayerId(), true)
            SetPauseMenuActive(false)
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
        end
    end
end)

RegisterNUICallback('impoundVehicle', function(data, cb)
    ESX.ShowNotification("Trwa poszukiwanie pojazdu....", 'info')
    Citizen.Wait(5 * 1000)
    local result = lib.callback.await('mrg_garages:impoundVehicle', false, data.plate)
    if result then
        ESX.ShowNotification("Auto zostało odholowane z parkingu miejskiego: " .. data.plate, 'info')
    end
    cb(result)
end)

RegisterNUICallback('hideFrame', function(_, cb)
    utils.toggleNuiFrame(false)
    cb({})
end)
inOrg = false
BasesLoaded = false
local bases = {}
Citizen.CreateThread(function()
    while true do
        if ESX.IsPlayerLoaded() then
            local IdGroup = exports["sfctab"]:getMyGroup()
            if IdGroup ~= 0 and not inOrg then
                inOrg = true
                TriggerServerEvent("sfcbase:updateBaseFromTablet", IdGroup, "garage")
            end
            if IdGroup == 0 and inOrg then
                inOrg = false
                RemoveGarage("crime_garage")
            end
        end
        if not BasesLoaded and GetResourceState("sfcbase") == "started" then
            bases = exports["sfcbase"]:GetBases()
            BasesLoaded = true
        end
        Wait(250)
    end
end)

local bases = exports["sfcbase"]:GetBases()
RegisterNetEvent("mrg_garages:crime:UpdateGarage", function(group_id, base_id)
    local IdGroup = exports["sfctab"]:getMyGroup()
    RemoveGarage("crime_garage_"..IdGroup)
    if group_id == IdGroup then
        garagecoords = bases[base_id].garage
        garage = {}
        garage.hideblip = false
        garage.coords = garagecoords
        garage.rotation = garagecoords.w or 0
        garage.size = vector3(10, 10, 10)
        garage.points = {
            vector4(garagecoords.x, garagecoords.y,garagecoords.z, garagecoords.w)
        }
        AddGarage("crime_garage_"..IdGroup, garage)
    end
end)

RegisterNetEvent('EasyAdmin:GetCurrentCar')
AddEventHandler('EasyAdmin:GetCurrentCar', function(a)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	TriggerServerEvent('EasyAdmin:SaveCar', vehProperties, a)
end)