if GetResourceState('qbx_core') ~= 'started' then return end

Core = {
    isPlayerLoaded = false,
    GetPlayerJob = function()
        local playerData = exports['qbx_core']:GetPlayerData()
        if playerData and playerData.job then
            return {
                name = playerData.job.name,
                grade = tonumber(playerData.job.grade.level),
                label = playerData.job.label,
            }
        end

        return {
            name = 'unemployed',
            grade = 0,
            label = 'Unemployed',
        }
    end,
    GetPlayerGroup = function()
        return lib.callback.await('p_policejob/getGroup', false)
    end,
    getPlayerName = function()
        local charinfo = exports['qbx_core']:GetPlayerData().charinfo
        return charinfo.firstname..' '..charinfo.lastname
    end,
    getIdentifier = function()
        return exports['qbx_core']:GetPlayerData().citizenid
    end,
    GetPlayerSex = function()
        return exports['qbx_core']:GetPlayerData().charinfo.gender
    end
}

Citizen.CreateThread(function()
    if not Config.OxRadial then return end
    lib.registerRadial({
        id = 'police_road',
        items = {
            {
                label = locale('resume'),
                icon = 'traffic-light',
                onSelect = function()
                    exports['p_policejob']:ResumeTraffic()
                    Editable.showNotify(locale('you_resumed_traffic'), 'success')
                end
            },
            {
                label = locale('slow'),
                icon = 'traffic-light',
                onSelect = function()
                    exports['p_policejob']:SlowTraffic()
                    Editable.showNotify(locale('you_slowed_traffic'), 'success')
                end
            },
            {
                label = locale('stop'),
                icon = 'traffic-light',
                onSelect = function()
                    exports['p_policejob']:StopTraffic()
                    Editable.showNotify(locale('you_stopped_traffic'), 'success')
                end
            }
        }
    })
end)

local function loadPoliceRadial()
    local playerData = exports['qbx_core']:GetPlayerData()
    local items = {
        {
            label = locale('off'),
            icon = 'walkie-talkie',
            onSelect = function()
                exports['pma-voice']:setRadioChannel(0)
            end
        }
    }
    for channel, data in pairs(Config.Radio) do
        if data.jobs[playerData.job.name] then
            items[#items + 1] = {
                label = '#'..channel..' - '..data.label,
                icon = 'walkie-talkie',
                onSelect = function()
                    if Inventory.getItemCount('radio') > 0 then
                        exports['pma-voice']:setRadioChannel(channel)
                    else
                        Editable.showNotify(locale('you_need_radio'), 'error')
                    end
                end
            }
        end
    end
    lib.registerRadial({
        id = 'police_radio_menu',
        items = items
    })
    lib.addRadialItem({
        id = 'police_radio',
        icon = 'walkie-talkie',
        label = locale('radio'),
        menu = 'police_radio_menu'
    })
    lib.registerRadial({
        id = 'police_options',
        items = {
            {
                label = locale('tablet'),
                icon = 'tablet',
                onSelect = function()
                    if GetResourceState('piotreq_gpt') == 'started' then
                        exports['piotreq_gpt']:OpenGPT()
                    elseif GetResourceState('ps-mdt') == 'started' then
                        ExecuteCommand('mdt')
                    elseif GetResourceState('tk_mdt') == 'started' then
                        exports['tk_mdt']:openUI('police')
                    elseif GetResourceState('lb-tablet') == 'started' then
                        exports["lb-tablet"]:ToggleOpen(true, false)
                    elseif GetResourceState('redutzu-mdt') == 'started' then
                        TriggerEvent('redutzu-mdt:client:openMDT')
                    elseif GetResourceState('qs-mdt') == 'started' then
                        ExecuteCommand('openmdt')
                    elseif GetResourceState('codem-mdt') == 'started' then
                        ExecuteCommand('mdt')
                    elseif GetResourceState('drx_mdt') == 'started' then
                        exports.drx_mdt:OpenMDT()
                    end
                end
            },
            {
                label = locale('dispatch'),
                icon = 'bullhorn',
                onSelect = function()
                    if GetResourceState('piotreq_gpt') == 'started' then
                        exports['piotreq_gpt']:OpenDispatch()
                    elseif GetResourceState('ps-dispatch') == 'started' then
                        local calls = lib.callback.await('ps-dispatch:callback:getCalls', false)
                        TriggerEvent('ps-dispatch:client:openMenu', calls)
                    elseif GetResourceState('cd_dispatch') == 'started' then
                        ExecuteCommand('dispatchlarge')
                    elseif GetResourceState('qs-dispatch') == 'started' then
                        ExecuteCommand('toggleopendispatch')
                    elseif GetResourceState('rcore_dispatch') == 'started' then
                        ExecuteCommand('panel')
                    elseif GetResourceState('codem-dispatch') == 'started' then
                        ExecuteCommand('showDispatchs')
                    end
                end
            },
            {
                label = locale('traffic'),
                icon = 'road',
                menu = 'police_road'
            },
            {
                label = locale('objects'),
                icon = 'road-barrier',
                onSelect = function()
                    ObjectMenu()
                end
            },
            {
                label = locale('analyze_vehicle'),
                icon = 'car',
                onSelect = function()
                    exports['p_policejob']:analyzeVehicle()
                end
            }
        }
    })
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
        return
    end

    Wait(1000)
    local playerData = exports['qbx_core']:GetPlayerData()
    if not playerData or not playerData.job or not playerData.job.name then
        return
    end

    Core.isPlayerLoaded = true
    loadStationsBlips()
    loadGaragesBlips()

    if not Config.OxRadial then return end
    if Config.Jobs[playerData.job.name] then
        lib.addRadialItem({
            {
              id = 'police_menu',
              label = locale('job_menu'),
              icon = 'briefcase',
              menu = 'police_options'
            },
        })
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            loadPoliceRadial()
        end
    else
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            lib.removeRadialItem('police_radio')
        end
    end
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(playerData)
    Wait(1000)
    loadGaragesBlips()
    loadStationsBlips()

    Core.isPlayerLoaded = true
    if not Config.OxRadial then return end
    if Config.Jobs[playerData.job.name] then
        lib.addRadialItem({
            {
              id = 'police_menu',
              label = locale('job_menu'),
              icon = 'briefcase',
              menu = 'police_options'
            },
        })
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            loadPoliceRadial()
        end
    else
        lib.removeRadialItem('police_menu')
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            lib.removeRadialItem('police_radio')
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobData)
    Wait(1000)
    loadStationsBlips()
    loadGaragesBlips()
    Core.isPlayerLoaded = true
    if not Config.OxRadial then return end
    if Config.Jobs[jobData.name] then
        lib.addRadialItem({
            {
              id = 'police_menu',
              label = locale('job_menu'),
              icon = 'briefcase',
              menu = 'police_options'
            },
        })
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            loadPoliceRadial()
        end
    else
        lib.removeRadialItem('police_menu')
        if not GetResourceState('piotreq_gpt') ~= 'missing' then
            lib.removeRadialItem('police_radio')
        end
    end
end)

RegisterNetEvent('piotreq_jobcore:UpdateDuty')
AddEventHandler('piotreq_jobcore:UpdateDuty', function(data)
    if not Config.OxRadial then return end
    local playerData = exports['qbx_core']:GetPlayerData()
    if not playerData or not playerData.job or not playerData.job.name then
        return
    end

    if not Config.Jobs[playerData.job.name] then
        return
    end

    if data.status == 1 then
        loadPoliceRadial()
    else
        lib.removeRadialItem('police_radio')
        lib.registerRadial({
            id = 'police_options',
            items = {
                {
                    label = locale('tablet'),
                    icon = 'tablet',
                    onSelect = function()
                        if GetResourceState('piotreq_gpt') == 'started' then
                            exports['piotreq_gpt']:OpenGPT()
                        elseif GetResourceState('ps-mdt') == 'started' then
                            ExecuteCommand('mdt')
                        elseif GetResourceState('tk_mdt') == 'started' then
                            exports['tk_mdt']:openUI('police')
                        elseif GetResourceState('lb-tablet') == 'started' then
                            exports["lb-tablet"]:ToggleOpen(true, false)
                        elseif GetResourceState('redutzu-mdt') == 'started' then
                            TriggerEvent('redutzu-mdt:client:openMDT')
                        elseif GetResourceState('qs-mdt') == 'started' then
                            ExecuteCommand('openmdt')
                        elseif GetResourceState('codem-mdt') == 'started' then
                            ExecuteCommand('mdt')
                        elseif GetResourceState('drx_mdt') == 'started' then
                            exports.drx_mdt:OpenMDT()
                        end
                    end
                },
            }
        })
    end
end)

Citizen.CreateThread(function()
    if not Config.OxRadial then return end
    lib.registerRadial({
        id = 'police_options',
        items = {
            {
                label = locale('tablet'),
                icon = 'tablet',
                onSelect = function()
                    if GetResourceState('piotreq_gpt') == 'started' then
                        exports['piotreq_gpt']:OpenGPT()
                    elseif GetResourceState('ps-mdt') == 'started' then
                        ExecuteCommand('mdt')
                    elseif GetResourceState('tk_mdt') == 'started' then
                        exports['tk_mdt']:openUI('police')
                    elseif GetResourceState('lb-tablet') == 'started' then
                        exports["lb-tablet"]:ToggleOpen(true, false)
                    elseif GetResourceState('redutzu-mdt') == 'started' then
                        TriggerEvent('redutzu-mdt:client:openMDT')
                    elseif GetResourceState('qs-mdt') == 'started' then
                        ExecuteCommand('openmdt')
                    elseif GetResourceState('codem-mdt') == 'started' then
                        ExecuteCommand('mdt')
                    elseif GetResourceState('drx_mdt') == 'started' then
                        exports.drx_mdt:OpenMDT()
                    end
                end
            },
        }
    })
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    if GetResourceState('qs-dispatch') ~= 'missing' then
        RegisterNetEvent('p_policejob/qs-dispatch/alert', function(alertName)
            exports['qs-dispatch'][alertName]()
        end)
    elseif GetResourceState('codem-dispatch') ~= 'missing' then
        RegisterNetEvent('p_policejob/codem-dispatch/alert', function(data)
            exports['codem-dispatch']:CustomDispatch(data)
        end)
    end
end)

Core.AddNewEvidence = function(data)
    if GetResourceState('piotreq_gpt') == 'started' then
        TriggerServerEvent('piotreq_gpt:AddNewEvidence', data)
    elseif GetResourceState('redutzu-mdt') == 'started' then
        exports['redutzu-mdt']:CreateEvidence({
            name = data.item.metadata.displayBlood and locale('blood') or locale('bullet'),
            description = data.data
        })
    end
end

Core.sortGarageVehicles = function(garageName, result)
    local options = {}
    for i = 1, #result, 1 do
        local vehicleData = result[i].mods and json.decode(result[i].mods) or {}
        vehicleData.plate = result[i].plate
        vehicleData.model = result[i].vehicle
        local vehicleName = nil
        local display, make = GetDisplayNameFromVehicleModel(vehicleData.model), GetMakeNameFromVehicleModel(vehicleData.model)
        if Config.Garage.CustomLabels[display:lower()] then
            vehicleName = Config.Garage.CustomLabels[display:lower()]
        else
            local displayLabel, makeLabel = GetLabelText(display), GetLabelText(make)
            vehicleName = (makeLabel ~= 'NULL' and makeLabel or make)..' '..(displayLabel ~= 'NULL' and displayLabel or display)
        end
        options[i] = {
            title = vehicleName,
            description = locale('take_out_vehicle', vehicleName),
            arrow = true,
            image = 'https://docs.fivem.net/vehicles/'..display:lower()..'.webp',
            metadata = {
                {label = locale('vehicle_plate'), value = result[i].plate},
                {label = locale('vehicle_vin'), value = result[i].vin or 'Unknown'},
                {label = locale('vehicle_engine'), value = math.floor(result[i].engine and (result[i].engine / 10) or 100)..'%'},
                {label = locale('vehicle_body'), value = math.floor(result[i].body and (result[i].body / 10) or 100)..'%'},
                {label = locale('vehicle_fuel'), value = math.floor(result[i].fuel or 100)..'%'},
            },
            onSelect = function()
                clientGarages[garageName].takeOutVehicle(vehicleData)
            end
        }
    end

    return options
end