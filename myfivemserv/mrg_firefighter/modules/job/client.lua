Job = function()
    local self = {}
    self.moduleName = "job"
    self.Started = false
    self.PlayerData = nil
    self.jobs = {}
    self.onDuty = false

    self.IsAllowed = function(grade)
        if not grade then grade = 0 end
        if not self.PlayerData then return false end
        if not Config.Stations[self.PlayerData.job.name] then return false end

        return Config.Stations[self.PlayerData.job.name] >= grade
    end

    self.Translate = function(key)
        return locale('client.modules.'..self.moduleName.."."..key)
    end

    self.Init = function()
        for k, v in pairs(Config.Stations) do
            table.insert(self.jobs, k)
        end
        if ESX.IsPlayerLoaded() then
            self.OnPlayerLoaded()
        end
        self.Stash()
        self.Shop()
        self.PrivateStash()
        self.RegisterEvents()
        exports.ox_target:addSphereZone({
            coords = vec3(-1029.6, -1390.25, 11.3),
            radius = 0.4,
            options = {
                {
                    label = self.Translate("slide"),
                    icon = "fa-solid fa-fire",
                    onSelect = function()
                        local ply = PlayerPedId()
                        local coord = vec3(-1029.624, -1390.209, 10.0240)
                        lib.requestAnimDict('missrappel', 5000)
                        SetEntityCoords(ply, coord.x, coord.y, coord.z, true, true, true, false)
                        SetEntityHeading(ply, 90.0)
                        FreezeEntityPosition(ply, true)
                        TaskPlayAnim(ply, "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
                        Citizen.CreateThread(function()
                            usingPole = true
                            while usingPole do
                                if not IsEntityPlayingAnim(ply, "missrappel", "rope_idle", 3) then
                                    TaskPlayAnim(ply, "missrappel", "rope_idle", 8.0, 8.0, -1, 2, 1.0, false, false, false)
                                end
                                local pCoords = GetEntityCoords(ply)
                                if math.abs(pCoords.z - 4.9731) < 0.3 then
                                    ClearPedTasksImmediately(ply)
                                    usingPole = false
                                    FreezeEntityPosition(ply, false)
                                    SetEntityCollision(ply, true, true)
                                else
                                    local currPos = GetEntityCoords(ply)
                                    FreezeEntityPosition(ply, false)
                                    SetEntityCollision(ply, false, true)
                                    SetEntityHeading(ply, GetEntityHeading(ply) + 2.0)
                                    SetEntityCoordsNoOffset(ply, currPos.x, currPos.y, currPos.z - 0.045, true, true, true)
                                end
                                Citizen.Wait(1)
                            end
                        end)
                    end
                },
            }
        })
    end

    self.PrivateStash = function()
        for job, station in pairs(Config.Stations) do
            for stashId, coords in pairs(station.Locations["private_stash"]) do
                local targetjobs = {}
                for k, v in pairs(self.jobs) do
                    targetjobs[v] = 0
                end
                exports.ox_target:addSphereZone({
                    coords = coords,
                    radius = 0.5,
                    options = {
                        {
                            label = self.Translate("open.private_stash"),
                            icon = "fa-solid fa-box",
                            groups = targetjobs,
                            onSelect = function()
                                exports.ox_inventory:openInventory('stash', { id = "firefighter-"..job.."-private-"..stashId })
                            end
                        },
                    }
                })
            end
        end
    end
    
    self.Shop = function()
        for job, station in pairs(Config.Stations) do
            for shopID, shop in pairs(station.Locations["shop"]) do
                local targetjobs = {}
                for k, v in pairs(self.jobs) do
                    targetjobs[v] = 0
                end
                exports.ox_target:addSphereZone({
                    coords = shop.coords,
                    radius = 0.5,
                    options = {
                        {
                            label = shop.label,
                            icon = "fa-solid fa-box",
                            groups = targetjobs,
                            onSelect = function()
                                print("firefighter-"..job.."-shop-"..shopID)
                                exports.ox_inventory:openInventory('shop', { type = "firefighter-"..job.."-shop-"..shopID })
                            end
                        },
                    }
                })
            end
        end
    end
    self.Stash = function()
        for job, station in pairs(Config.Stations) do
            for stashId, coords in pairs(station.Locations["stash"]) do
                local targetjobs = {}
                for k, v in pairs(self.jobs) do
                    targetjobs[v] = 0
                end
                exports.ox_target:addSphereZone({
                    coords = coords,
                    radius = 0.5,
                    options = {
                        {
                            label = self.Translate("open.stash"),
                            icon = "fa-solid fa-box",
                            groups = targetjobs,
                            canInteract = function()
                                return self.onDuty
                            end,
                            onSelect = function()
                                exports.ox_inventory:openInventory('stash', "firefighter-"..job.."-"..stashId)
                            end
                        },
                    }
                })
            end
        end
    end

    self.OnJobUpdate = function(job)
        self.PlayerData = ESX.GetPlayerData()
        self.PlayerData.job = job
    end
    
    self.OnPlayerLoaded = function()
        self.Started = true
        self.PlayerData = ESX.GetPlayerData()
        local data = exports['piotreq_jobcore']:GetDutyData()
        if data.status == 1 and Config.Stations[self.PlayerData.job.name] then
            self.onDuty = true
        end
        self.CreateBlips()
    end

    self.CreateBlips = function()
        for k, v in pairs(Config.Stations) do
            local settings = v.blip
            local blip = AddBlipForCoord(settings.coords.x, settings.coords.y, settings.coords.z)
            SetBlipSprite (blip, settings.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, settings.scale)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, settings.color)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(settings.text)
            EndTextCommandSetBlipName(blip)
        end
    end

    self.RegisterEvents = function()
        RegisterNetEvent('esx:setJob', function(job, lastJob)
            self.OnJobUpdate(job)
        end)
        RegisterNetEvent('esx:playerLoaded', function (xPlayer, skin)
            self.OnPlayerLoaded()
        end)
        RegisterNetEvent('piotreq_jobcore:UpdateDuty', function(data)
            if data.status == 1 and Config.Stations[data.job] then
                self.onDuty = true
            else
                self.onDuty = false
            end
        end)
    end

    return self
end