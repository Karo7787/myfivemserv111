Config.Spawner = {}

Config.Spawner.Spawners = {
    ['ambulance'] = {
        {
            coords = vector4(69.04, -440.46, 39.28, 65.25),
            spawnCoords = vector4(59.25, -431.2, 39.28, 344.15),
            ped = 's_m_m_security_01',
            vehicles = {
                ['ambulance'] = 'ambulance', -- model name from base game for photo
            }
        },

    }
}

Config.Spawner.VehicleData = {
    ["ambulance"] = {
        extras = {
            [1] = true
        },
        livery = 0
    },
    ["nkstxems"] = {
        extras = {
            [1] = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true
        },
        livery = 0
    },
    ["nkballer7ems"] = {
        extras = {
            [1] = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true
        },
        livery = 0
    },
    ["nkcaracara2ems"] = {
        extras = {
            [1] = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true
        },
        livery = 0
    }

}

Config.Spawner.AddKeys = function(plate, vehicle, model)
    if Config.Spawner.VehicleData[GetEntityArchetypeName(vehicle)] then
        local vehdata = Config.Spawner.VehicleData[GetEntityArchetypeName(vehicle)]
        if vehdata.extras then
            for k, v in pairs(vehdata.extras) do
                print(k, not v)
                SetVehicleExtra(vehicle, k, not v)
            end
        end
        if vehdata.livery then
            SetVehicleLivery(vehicle, vehdata.livery)
        end
    end
    exports["dbl_carkeys"]:AddKey(plate)
end

Config.Spawner.RemoveKeys = function(plate, vehicle, model)
    exports["dbl_carkeys"]:RemoveKey(plate)
end