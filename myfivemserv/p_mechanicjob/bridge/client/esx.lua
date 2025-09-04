if Config.Framework ~= 'ESX' then
    return
end

ESX = exports['es_extended']:getSharedObject()

PlayerData = {}

Core.CheckDuty = function()
    return Config.MechanicMDT and exports['piotreq_jobcore']:GetDutyData() or {status = 1}
end

Core.GetPlayerJob = function()
    return ESX.PlayerData.job
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    ESX.PlayerData.job = job
end)

AddEventHandler('onClientResourceStart', function(rsName)
    if rsName == GetCurrentResourceName() then
        ESX.PlayerData = ESX.GetPlayerData()
        PlayerData = ESX.PlayerData
    end
end)

Core.ShowNotification = function(text)
    ESX.ShowNotification(text)
end

Core.IsSpawnPointClear = function(coords, distance)
    return ESX.Game.IsSpawnPointClear(coords, distance)
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
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        Core.playOutfitAnim()
        Citizen.Wait(1500)
        TriggerEvent('skinchanger:loadClothes', skin, skin)
    end)
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
        TriggerEvent('skinchanger:getSkin', function(mySkin)
            Core.playOutfitAnim()
            Citizen.Wait(1500)
            TriggerEvent('skinchanger:loadClothes', mySkin, skin)
        end)
    end
end

Core.GetPlayerSkin = function()
    local skin = nil
    TriggerEvent('skinchanger:getSkin', function(skinData)
        skin = skinData
    end)

    while skin == nil do Citizen.Wait(100) end

    return skin
end

function UserInCoords(points)
    usercoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(points) do
        if #(usercoords - v) < 5 then
            return true
        end
    end
    return false
end

InAnyPoint = false
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            if UserInCoords(Config.TuningPoints) then
                if not InAnyPoint then
                    InAnyPoint = true
                    lib.addRadialItem({
                        {
                            id = 'tune',
                            label = 'Przeglądaj Katalog',
                            icon = 'fa-solid fa-wrench',
                            onSelect = function()
                                OpenTuning()
                            end
                        },
                    })
                end
            else
                if InAnyPoint then
                    InAnyPoint = false
                    lib.removeRadialItem('tune')
                end
            end
        else
            if InAnyPoint then
                InAnyPoint = false
                lib.removeRadialItem('tune')
            end
        end
        Wait(100)
    end
end)
exports("IsInAnyPoint", function()
    return InAnyPoint
end)

OpenTuning = function()
    local PD = ESX.GetPlayerData()
    local isStation = true
    if Config.Workshops[PD.job.name] ~= nil then
        isStation = false
    end
    exports['p_tuningmenu']:OpenTuningMenu(isStation)
end