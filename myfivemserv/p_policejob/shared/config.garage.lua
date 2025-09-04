Config.Garage = {}

Config.Garage.CreateVehicleKeys = function(plate, model, netId)
    if GetResourceState('p_carkeys') == 'started' then
        TriggerServerEvent('p_carkeys:CreateKeys', plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports['wasabi_carlock']:GiveKey(plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    elseif GetResourceState('tgiann-hotwire') == 'started' then
        exports["tgiann-hotwire"]:GiveKeyPlate(plate, true)
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
    elseif GetResourceState('mrg_carkeys') == 'started' then
        exports["mrg_carkeys"]:AddKey(plate)
    end
end

Config.Garage.RemoveVehicleKeys = function(plate, model, netId)
    if GetResourceState('p_carkeys') == 'started' then
        TriggerServerEvent('p_carkeys:RemoveKeys', plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports['wasabi_carlock']:RemoveKey(plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:RemoveKeys(plate, model)
    elseif GetResourceState('tgiann-hotwire') == 'started' then
        exports["tgiann-hotwire"]:GiveKeyPlate(plate, true)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        TriggerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
    elseif GetResourceState('qbx_vehiclekeys') == 'started' then
        TriggerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
    elseif GetResourceState('mrg_carkeys') == 'started' then
        exports["mrg_carkeys"]:RemoveKey(plate)
    end
end

Config.Garage.CustomLabels = { -- FOR OWNED VEHICLES ONLY
    ['nkshinobi'] = 'Scigasz LSPD/Sheriff',
    ['nkmanchez3'] = 'Cross LSPD/Sheriff',
    ['pbike'] = 'Rower',
    ['prisonbusrb'] = 'Wiezniarka'
}

Config.Garage.CustomImages = {
    -- ['police'] = 'LINK TO IMAGE', -- set here link to image, it can be fivemanage :)
    -- ['police2'] = 'LINK TO IMAGE',
    -- ['police3'] = 'LINK TO IMAGE',
}

Config.Garage.Garages = {
    ['Mission_Row'] = {
        vehicles = { -- UNCOMMENT THIS IF YOU WANT VEHICLE SPAWNER
            ['police'] = {
                [0] = { -- FROM GRADE 0 CAN TAKE THIS VEHICLES
                    ['nkshinobi'] = 'Scigasz LSPD/Sheriff', -- spawn name and display name
                    ['nkmanchez3'] = 'Cross LSPD/Sheriff', -- spawn name and display name
                    ['pbike'] = 'Rower', -- spawn name and display name
                    ['prisonbusrb'] = 'Wiezniarka' -- spawn name and display name
                },
            }
        },
        ped = {
            model = 's_m_y_cop_01',
            anim = {dict = 'amb@world_human_cop_idles@male@idle_b', clip = 'idle_e'}
        },
        coords = vector4(-1082.09, -827.34, 4.87, 121.38),
        allowedJobs = {
            ['police'] = 0,
            ['sheriff'] = 0
        },
        blip = { -- only visible for allowed jobs
            sprite = 357,
            scale = 0.75,
            color = 3,
            label = 'Garaz Vespucci'
        },
        spawnPoints = {
            vector4(-1094.57, -828.15, 4.87, 222.31),
            vector4(-1097.29, -830.37, 4.87, 217.57),
            vector4(-1100.33, -832.47, 4.87, 218.39)
        }
    }
}