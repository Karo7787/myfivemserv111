if Config.Framework ~= 'ESX' then
    return
end

local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    
    Citizen.Wait(1000)
    onPlayerLoaded()
end)

Core.CheckDuty = function()
    return GetResourceState('piotreq_gmt') == 'started' and exports['piotreq_jobcore']:GetDutyData() or {status = 1}
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Core.GetPlayerSkin = function()
    local skin = nil
    TriggerEvent('skinchanger:getSkin', function(skinData)
        skin = skinData
    end)

    while skin == nil do Citizen.Wait(100) end

    return skin
end

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
        if type(skin) ~= 'table' then
            skin = json.decode(skin)
        end
        exports['illenium-appearance']:setPedComponents(PlayerPedId(), skin.components)
        exports['illenium-appearance']:setPedProps(PlayerPedId(), skin.props)
    else
        TriggerEvent('skinchanger:getSkin', function(mySkin)
            Core.playOutfitAnim()
            Citizen.Wait(1500)
            TriggerEvent('skinchanger:loadClothes', mySkin, skin)
        end)
    end
end

Core.GetPlayerJob = function()
    return ESX.PlayerData.job
end

Core.ShowNotification = function(text)
    ESX.ShowNotification(text)
end

Core.ShowTextUI = function(text)
    lib.showTextUI(text)
end

Core.hideTextUI = function()
    lib.hideTextUI()
end

Core.openInventory = function(invType, data, items)
    if GetResourceState('ox_inventory') == 'started' then
        exports['ox_inventory']:openInventory(invType, data)
    elseif GetResourceState('qb-inventory') == 'started' then
        TriggerServerEvent('p_ambulancejob/inventory/openInventory', invType, data)
    elseif GetResourceState('ps-inventory') == 'started' then
        TriggerServerEvent('p_ambulancejob/inventory/openInventory', invType, data)
    elseif GetResourceState('qs-inventory') == 'started' then
        local shopData = {
            label = data.type,
            items = items
        }
        for i = 1, #shopData.items, 1 do
            shopData.items[i].slot = i
            shopData.items[i].amount = 99999
        end
        TriggerServerEvent("inventory:server:OpenInventory", "shop", data.type..'_'..data.id, shopData)
    elseif GetResourceState('tgiann-inventory') == 'started' then
        TriggerServerEvent('p_ambulancejob/inventory/openInventory', invType, data)
    elseif GetResourceState('codem-inventory') == 'started' then
        TriggerServerEvent('p_ambulancejob/inventory/openInventory', invType, data)
    end
end

Core.GetItemInfo = function(itemName)
    if GetResourceState('ox_inventory') == 'started' then
        return exports['ox_inventory']:Items(itemName) -- need to return label and optionally description
    elseif GetResourceState('qb-inventory') == 'started' then
        return QBCore.Shared.Items[itemName]
    elseif GetResourceState('ps-inventory') == 'started' then
        return QBCore.Shared.Items[itemName]
    elseif GetResourceState('qs-inventory') == 'started' then
        local itemList = exports['qs-inventory']:GetItemList()
        return itemList[itemName]
    elseif GetResourceState('tgiann-inventory') == 'started' then
        local itemData = exports["tgiann-inventory"]:Items(itemName)
        return itemData
    elseif GetResourceState('codem-inventory') == 'started' then
        local itemList = exports['codem-inventory']:GetItemList()
        return itemList[itemName]
    end
end

Core.GetItemCount = function(itemName)
    if GetResourceState('ox_inventory') == 'started' then
        return exports['ox_inventory']:Search('count', itemName)
    else
        local itemCount = lib.callback.await('p_ambulancejob:server:getItemCount', false, itemName)
        return itemCount
    end
end

Core.GetItemImage = function(itemName)
    if GetResourceState('ox_inventory') == 'started' then
        return 'https://cfx-nui-ox_inventory/web/images/'..itemName..'.png'
    elseif GetResourceState('qb-inventory') == 'started' then
      return 'https://cfx-nui-qb-inventory/html/images/'..itemName..'.png'
    elseif GetResourceState('ps-inventory') == 'started' then
      return 'https://cfx-nui-ps-inventory/html/images/'..itemName..'.png'
    elseif GetResourceState('qs-inventory') == 'started' then
     return 'https://cfx-nui-qs-inventory/html/images/'..itemName..'.png'
    elseif GetResourceState('tgiann-inventory') == 'started' then
      return 'https://cfx-nui-tgiann-inventory/html/images/'..itemName..'.png'
    elseif GetResourceState('codem-inventory') == 'started' then
  return 'https://cfx-nui-codem-inventory/html/itemimages/'..itemName..'.png'
    end
end

Core.IsSpawnPointClear = function(coords, distance)
    return ESX.Game.IsSpawnPointClear(coords, distance)
end

Core.GetPlayerName = function(playerId)
    return Player(playerId).state.name or 'Unknown'
end

Core.ProgressBar = function(data)
    return lib.progressBar({
        duration = data.duration,
        label = data.label,
        useWhileDead = data.useWhileDead or false,
        canCancel = data.canCancel or true,
        disable = data.disable or {
            car = true,
            move = true,
            combat = true
        },
        anim = data.anim,
        prop = data.prop
    })
end

Core.CancelProgress = function()
    if lib.progressActive() then
        lib.cancelProgress()
    end
end

local GMT = GetResourceState('piotreq_gmt') ~= 'missing' and true or false

Core.SendAlert = function()
    if GMT then
        TriggerServerEvent('p_ambulancejob:sendDistressAlert')
    else
        print('SET DISPATCH EXPORT IN BRIDGE FILE!!!!!')
        print('SET DISPATCH EXPORT IN BRIDGE FILE!!!!!')
        print('SET DISPATCH EXPORT IN BRIDGE FILE!!!!!')
        print('SET DISPATCH EXPORT IN BRIDGE FILE!!!!!')
        print('SET DISPATCH EXPORT IN BRIDGE FILE!!!!!')
    end
end

-- if GMT then
--     Citizen.CreateThread(function()
--         lib.registerRadial({
--             id = 'ambulance_options',
--             items = {
--                 {
--                     label = 'Tablet',
--                     icon = 'tablet',
--                     onSelect = function()
--                         exports['piotreq_gmt']:OpenGMT()
--                     end
--                 },
--             }
--         })
--     end)

--     AddEventHandler('onClientResourceStart', function(resourceName)
--         if(GetCurrentResourceName() ~= resourceName) then
--             return
--         end
    
--         Wait(1000)
--         if not ESX.PlayerData or not ESX.PlayerData.job or not ESX.PlayerData.job.name then
--             return
--         end
    
--         if Config.Jobs[ESX.PlayerData.job.name] then
--             lib.addRadialItem({
--                 {
--                   id = 'ambulance_menu',
--                   label = locale('job_menu'),
--                   icon = 'briefcase',
--                   menu = 'ambulance_options'
--                 },
--             })
--         end
--     end)
    
--     RegisterNetEvent('esx:playerLoaded')
--     AddEventHandler('esx:playerLoaded', function(xPlayer)
--         Wait(1000)
--         ESX.PlayerData = xPlayer
--         if Config.Jobs[ESX.PlayerData.job.name] then
--             lib.addRadialItem({
--                 {
--                   id = 'ambulance_menu',
--                   label = locale('job_menu'),
--                   icon = 'briefcase',
--                   menu = 'ambulance_options'
--                 },
--             })
--         end
--     end)
    
--     RegisterNetEvent('esx:setJob')
--     AddEventHandler('esx:setJob', function(job)
--         Wait(1000)
--         ESX.PlayerData.job = job
--         if Config.Jobs[ESX.PlayerData.job.name] then
--             lib.addRadialItem({
--                 {
--                   id = 'ambulance_menu',
--                   label = locale('job_menu'),
--                   icon = 'briefcase',
--                   menu = 'ambulance_options'
--                 },
--             })
--         else
--             lib.removeRadialItem('ambulance_menu')
--         end
--     end)
-- end

-- RegisterNetEvent('piotreq_jobcore:UpdateDuty')
-- AddEventHandler('piotreq_jobcore:UpdateDuty', function(data)
--     if not Config.Jobs[ESX.PlayerData.job.name] then
--         return
--     end

--     if data.status == 1 then
--         local items = {
--             {
--                 label = locale('turn_off_radio'),
--                 icon = 'walkie-talkie',
--                 onSelect = function()
--                     exports['pma-voice']:setRadioChannel(0)
--                 end
--             }
--         }
--         for channel, data in pairs(Config.Radio) do
--             if data.jobs[ESX.PlayerData.job.name] then
--                 items[#items + 1] = {
--                     label = '#'..channel..' - '..data.label,
--                     icon = 'walkie-talkie',
--                     onSelect = function()
--                         exports['pma-voice']:setRadioChannel(channel)
--                     end
--                 }
--             end
--         end
--         lib.registerRadial({
--             id = 'ambulance_radio_menu',
--             items = items
--         })
--         lib.addRadialItem({
--             id = 'ambulance_radio',
--             icon = 'walkie-talkie',
--             label = 'Radio',
--             menu = 'ambulance_radio_menu'
--         })
--         if GMT then
--             lib.registerRadial({
--                 id = 'ambulance_options',
--                 items = {
--                     {
--                         label = 'Tablet',
--                         icon = 'tablet',
--                         onSelect = function()
--                             exports['piotreq_gmt']:OpenGMT()
--                         end
--                     },
--                     {
--                         label = 'Dispatch',
--                         icon = 'bullhorn',
--                         onSelect = function()
--                             exports['piotreq_gmt']:OpenDispatch()
--                         end
--                     },
--                 }
--             })
--         end
--     else
--         lib.removeRadialItem('ambulance_radio')
--         if GMT then
--             lib.registerRadial({
--                 id = 'ambulance_options',
--                 items = {
--                     {
--                         label = 'Tablet',
--                         icon = 'tablet',
--                         onSelect = function()
--                             exports['piotreq_gmt']:OpenGMT()
--                         end
--                     },
--                 }
--             })
--         end
--     end
-- end)

AddEventHandler('esx:onPlayerDeath', function()
    if LocalPlayer.state.radioChannel ~= 0 then
        exports['pma-voice']:setRadioChannel(0)
    end
end)
