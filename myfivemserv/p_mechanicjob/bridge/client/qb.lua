if Config.Framework ~= 'QB' then
    return
end

local QBCore = exports['qb-core']:GetCoreObject()

PlayerData = {}

Core.CheckDuty = function()
    return exports['piotreq_jobcore']:GetDutyData()
end

Core.GetPlayerJob = function()
    local playerJob = QBCore.PlayerData.job
    return {
        name = playerJob.name,
        grade = tonumber(playerJob.grade.level),
        label = playerJob.label
    }
end

Citizen.CreateThread(function()
    lib.registerRadial({
        id = 'mechanic_options',
        items = {
            {
                label = locale('tablet'),
                icon = 'tablet',
                onSelect = function()
                    exports['piotreq_lst']:OpenLST()
                end
            },
        }
    })
end)

local function loadMechanicRadial()
    local items = {
        {
            label = 'Off',
            icon = 'walkie-talkie',
            onSelect = function()
                exports['pma-voice']:setRadioChannel(0)
            end
        }
    }
    for channel, data in pairs(Config.Radio) do
        if data.jobs[PlayerData.job.name] then
            items[#items + 1] = {
                label = '#'..channel..' - '..data.label,
                icon = 'walkie-talkie',
                onSelect = function()
                    exports['pma-voice']:setRadioChannel(channel)
                end
            }
        end
    end
    lib.registerRadial({
        id = 'mechanic_radio_menu',
        items = items
    })
    lib.addRadialItem({
        id = 'mechanic_radio',
        icon = 'walkie-talkie',
        label = 'Radio',
        menu = 'mechanic_radio_menu'
    })
    lib.registerRadial({
        id = 'mechanic_options',
        items = {
            {
                label = 'Tablet',
                icon = 'tablet',
                onSelect = function()
                    exports['piotreq_lst']:OpenLST()
                end
            },
            {
                label = 'Tuning',
                icon = 'bullhorn',
                onSelect = function()
                    if GetResourceState('p_tuningmenu') ~= 'missing' then
                        exports['p_tuningmenu']:OpenTuningMenu(false)
                    else
                        print('[ERROR] Set your tuning menu export / event in client/editable')
                    end
                end
            },
        }
    })
end

RegisterNetEvent('piotreq_jobcore:UpdateDuty')
AddEventHandler('piotreq_jobcore:UpdateDuty', function(data)
    if not PlayerData.job or not Config.Workshops[PlayerData.job.name] then
        return
    end

    if data.status == 1 then
        loadMechanicRadial()
    else
        lib.removeRadialItem('mechanic_radio')
        lib.registerRadial({
            id = 'mechanic_options',
            items = {
                {
                    label = locale('tablet'),
                    icon = 'tablet',
                    onSelect = function()
                        exports['piotreq_lst']:OpenLST()
                    end
                },
            }
        })
    end
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(xPlayer)
    PlayerData = xPlayer
    Wait(500)
    if PlayerData and PlayerData.job and Config.Workshops[PlayerData.job.name] then
        lib.addRadialItem({
            {
              id = 'mechanic_menu',
              label = locale('job_menu'),
              icon = 'briefcase',
              menu = 'mechanic_options'
            },
        })
        if not Config.MechanicMDT then
            loadMechanicRadial()
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
    Wait(500)
    if PlayerData and PlayerData.job and Config.Workshops[PlayerData.job.name] then
        lib.addRadialItem({
            {
              id = 'mechanic_menu',
              label = locale('job_menu'),
              icon = 'briefcase',
              menu = 'mechanic_options'
            },
        })
        if not Config.MechanicMDT then
            loadMechanicRadial()
        end
    else
        lib.removeRadialItem('mechanic_menu')
    end
end)

AddEventHandler('onClientResourceStart', function(rsName)
    if rsName == GetCurrentResourceName() then
        PlayerData = QBCore.PlayerData
        Wait(100)
        if PlayerData and PlayerData.job and Config.Workshops[PlayerData.job.name] then
            lib.addRadialItem({
                {
                  id = 'mechanic_menu',
                  label = locale('job_menu'),
                  icon = 'briefcase',
                  menu = 'mechanic_options'
                },
            })
            if not Config.MechanicMDT then
                loadMechanicRadial()
            end
        end
    end
end)

Core.ShowNotification = function(text)
    QBCore.Functions.Notify(text)
end

Core.IsSpawnPointClear = function(coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = cache.ped
        coords = GetEntityCoords(playerPed)
    end

    for k, entity in pairs(GetGamePool('CVehicle')) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = entity
        end
    end

    return #nearbyEntities == 0 and true or false
end

Core.Inventory = {
    openInventory = function(invType, data)
        if GetResourceState('ox_inventory') == 'started' then
            exports['ox_inventory']:openInventory(invType, data)
        elseif GetResourceState('qs-inventory') == 'started' then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", data)
            TriggerEvent("inventory:client:SetCurrentStash", data)
        end
    end,
    useItem = function(data, cb)
        if GetResourceState('ox_inventory') == 'started' then
            exports['ox_inventory']:useItem(data, cb)
        elseif GetResourceState('qs-inventory') == 'started' then
            cb(true)
        end
    end,
    getItemCount = function(itemName)
        if GetResourceState('ox_inventory') == 'started' then
            return exports['ox_inventory']:Search('count', itemName)
        elseif GetResourceState('qs-inventory') == 'started' then
            return exports['qs-inventory']:Search(itemName)
        end
    end,
}

Core.playOutfitAnim = function()
    local animDict = lib.requestAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, animDict, 'try_tie_negative_a', 2.0, 2.0, 2000, 49, 0, false, false, false)
    RemoveAnimDict(animDict)
end

Core.setPrivateClothes = function()
    Core.playOutfitAnim()
    Citizen.Wait(1500)
    TriggerServerEvent('qb-clothes:loadPlayerSkin')
end

Core.SetPlayerOutfit = function(skin)
    if not skin then return end
    if type(skin) ~= 'table' then
        skin = json.decode(skin)
    end
    
    if GetResourceState('illenium-appearance') == 'started' then
        Core.playOutfitAnim()
        Citizen.Wait(1500)
        exports['illenium-appearance']:setPedComponents(PlayerPedId(), json.decode(skin).components)
        exports['illenium-appearance']:setPedProps(PlayerPedId(), json.decode(skin).props)
    else
        Core.playOutfitAnim()
        Citizen.Wait(1500)
        TriggerEvent('qb-clothing:client:loadOutfit', skin)
    end
end

Core.GetPlayerSkin = function()
    local skin = lib.callback.await('p_mechanicjob/server/getSkin', false)
    return skin
end