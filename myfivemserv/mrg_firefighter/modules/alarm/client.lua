Alarm = function()
    local self = {}
    self.moduleName = "alarm"
    self.Started = false
    self.jobs = {}
    self.EnabledStations = {}

    self.Init = function()
        self.RegisterLoop()
        self.RegisterEvents()
        self.Started = true
    end

    self.RegisterLoop = function()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
        
                local FireSirenCount = 0
                for _, _ in pairs(self.EnabledStations) do FireSirenCount = FireSirenCount + 1 end
        
                if FireSirenCount >= 1 then
                    local PlayerPed = PlayerPedId()
                    local PlayerCoords = GetEntityCoords(PlayerPed, false)
        
                    for _, Station in pairs(self.EnabledStations) do
                        local Distance = Vdist(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Station.Loc.x, Station.Loc.y, Station.Loc.z) + 0.01 -- Stops divide by 0 errors
                        if (Distance <= Station.Radius) then
        
                            local SirenVolume = 1 - (Distance / Station.Radius)
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                local VC = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()), false)
                                -- If vehicle is not a motobike or a bicycle
                                if VC ~= 8 or VC ~= 13 then
                                    -- Lower the alarm volume by 45%
                                    SirenVolume = SirenVolume * 0.45
                                end
                            end
                            SendNUIMessage({
                                PayloadType	= "SetSirenVolume",
                                Payload		= {Station.Name, SirenVolume}
                            })
                        else
                            SendNUIMessage({
                                PayloadType	= "SetSirenVolume",
                                Payload		= {Station.Name, 0}
                            })
                        end
                    end
                end
        
            end
        end)
    end
    self.RegisterEvents = function()
        RegisterNetEvent("mrg_firefighter:modules:alarm:sync", function(Sirens)
            self.EnabledStations = Sirens
        end)

        RegisterNetEvent("mrg_firefighter:modules:alarm:play", function()
            for _, Station in pairs(self.EnabledStations) do
                SendNUIMessage({
                    PayloadType	= "PlaySiren",
                    Payload		= {Station.Name, Station.ID, Station.Siren}
                })
            end
        end)
        RegisterNetEvent("mrg_firefighter:modules:alarm:stop", function(Station)
            SendNUIMessage({
                PayloadType	= "StopSiren",
                Payload		= {Station.Name, Station.ID, Station.Siren}
            })
        end)
        RegisterNUICallback("RemoveSiren", function(Station)
            if GetPlayerServerId(PlayerId()) == Station.ID then
                TriggerServerEvent("mrg_firefighter:modules:alarm:remove", Station.Name)
            end
        
            self.EnabledStations[Station.Name] = nil
        end)
    end

    return self
end