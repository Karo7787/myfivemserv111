local Zones = {}
Citizen.CreateThread(function()
    for id, zone in pairs(Config.Zones) do
        Zones[id] = {
            conf = zone,
            poly = PolyZone:Create(zone.points, {
                name="zone_"..id,
                minZ=0.0,
                maxZ=62.0,
                debugGrid=Config.Debug,
                gridDivisions=25
            })
        }
    end
end)

Citizen.CreateThread(function() 
    Citizen.CreateThread(function()
        while true do
            local plyPed = PlayerPedId()
            local coord = GetEntityCoords(plyPed)
            for id, zone in pairs(Zones) do
                if zone.poly:isPointInside(coord) then
                    Citizen.Wait(zone.conf.wait)
                    if zone.conf.action == "client" then
                        zone.conf.func(GetPlayerServerId(PlayerId()), id)
                    else
                        TriggerServerEvent("tr-zones:excecutezone", id)
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)    
end)