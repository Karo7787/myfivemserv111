Config.Spawner = {}

Config.Spawner.Spawners = {
    ['mechanic'] = {
        [1] = {
            coords = vector4(-322.65, -118.62, 39.01, 157.98),
            spawnCoords = vector4(-367.72, -123.05, 38.7, 68.16),
            ped = 's_m_y_airworker',
            vehicles = {
                ['flatbed3'] = 'flatbed' -- model name from base game for photo
            }
        }
    }
}

Config.Spawner.AddKeys = function(plate, vehicle, model)
    exports["dbl_carkeys"]:AddKey(plate)
    TriggerServerEvent('giveremote', plate)
end

Config.Spawner.RemoveKeys = function(plate, vehicle, model)
    exports["dbl_carkeys"]:RemoveKey(plate)
    TriggerServerEvent('removeremote', plate)
end