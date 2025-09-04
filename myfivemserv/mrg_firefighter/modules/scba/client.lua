SCBA = function()
    local self = {}
    self.moduleName = "scba"
    self.Started = false
    self.PlayerData = nil
    self.jobs = {}
    self.Thread = nil
    self.onDuty = false 
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
        self.RegisterEvents()
    end

    self.CanUseSCBA = function()
        local sex = "male"
        if GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
            sex = "female"
        end
        if GetPedDrawableVariation(PlayerPedId(), 8) == Config.Scba.cloth_numbers[sex].active then
            return "yes"
        elseif GetPedDrawableVariation(PlayerPedId(), 8) == Config.Scba.cloth_numbers[sex].inactive then
            return "no"
        else
            return "not"
        end
    end
    self.setSCBAState = function(state, playerId)
        Wait(10)
        if not playerId then
            local sex = "male"
            if GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
                sex = "female"
            end
            exports["mrg_skin"]:setPlayerComponent(8, "drawable", tonumber(state and Config.Scba.cloth_numbers[sex].active or Config.Scba.cloth_numbers[sex].inactive), true) -- T-shirt
            if state then
                self.Thread = CreateThread(function()
                    while LocalPlayer.state.SCBAActive do
                        local slot = exports.ox_inventory:Search('slots', 'scba')
                        if #slot >= 1 then
                            slot = slot[1]
                        end 
                        local damage = 1
                        damage = damage * (#LocalPlayer.state.SCBAPlayerShared == 0 and 1 or #LocalPlayer.state.SCBAPlayerShared)
                        if slot.metadata.durability-damage <= 10 then
                            PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
                        end
                        SendNUIMessage({
                            PayloadType	= "PlayTone",
                            Payload		= {"scba_breath", 0.1}
                        })
                        if slot.metadata.durability-damage <= 0 then
                            PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
                            Wait(750)
                            PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
                            Wait(750)
                            PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
                            Wait(750)
                            PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
                        end
                        TriggerServerEvent("mrg_firefighter:modules:scba:damage", slot.slot, damage)
                        Wait(5000)
                    end
                end)
            end
        else
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
    end

    self.RegisterEvents = function()
        RegisterNetEvent('esx:setJob', function(job, lastJob)
            self.OnJobUpdate(job)
        end)
        RegisterNetEvent("mrg_firefighter:modules:scba:state", self.setSCBAState)
        RegisterNetEvent("ox_lib:RadialOpened", function()
            if self.PlayerData.job then
                if Config.Stations[self.PlayerData.job.name] then
                    local elements = {
                        {
                            id = "mdt",
                            label = "Tablet",
                            icon = "fa-tablet-screen-button",
                            iconWidth = 25,
                            iconHeight = 25,
                            onSelect = function()
                                exports['piotreq_gmt']:OpenGMT()
                            end
                        },
                        {
                            id = "badge",
                            label = "Odznaka",
                            icon = "fa-solid fa-medal",
                            iconWidth = 25,
                            iconHeight = 25,
                            onSelect = function()
                                TriggerServerEvent('mrg_documents:document:show', "lsfd")
                            end
                        },
                        {
                            id = "objects",
                            label = "Obiekty",
                            icon = "road-barrier",
                            iconWidth = 25,
                            iconHeight = 25,
                            onSelect = function()
                                exports['p_policejob']:ObjectMenu()
                            end
                        },
                        {
                            id = "signs",
                            label = "Ruch Drogowy",
                            icon = "fa-solid fa-traffic-light",
                            iconWidth = 25,
                            iconHeight = 25,
                            menu = "job-lsfd-traffic"
                        },
                        {
                            id = "radio",
                            label = "Radio",
                            icon = 'walkie-talkie',
                            iconWidth = 25,
                            iconHeight = 25,
                            menu = 'job-lsfd-radio'
                        }
                    }
                    
                    if self.CanUseSCBA() == "yes" or self.CanUseSCBA() == "no" then
                        table.insert(elements, {
                            id = "scba",
                            label = LocalPlayer.state.SCBAActive and "Wyłącz SCBA" or "Włącz SCBA",
                            icon = 'fa-solid fa-mask-ventilator',
                            iconWidth = 25,
                            iconHeight = 25,
                            onSelect = function()
                                TriggerServerEvent("mrg_firefighter:modules:scba:toggle")
                            end
                        })
                    end
                    lib.registerRadial({
                        id = 'job-lsfd',
                        items = elements
                    })
                end
            end
        end)
        RegisterNetEvent('esx:playerLoaded', function (xPlayer, skin)
            Wait(100)
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