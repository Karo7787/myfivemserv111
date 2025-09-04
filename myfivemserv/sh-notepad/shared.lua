if IsDuplicityVersion() then
    local inventory
    if GetResourceState('ox_inventory') == 'started' then inventory = 'ox_inventory' end
    if GetResourceState('qb-inventory') == 'started' then inventory = 'qb-inventory' end
    if GetResourceState('lj-inventory') == 'started' then inventory = 'lj-inventory' end
    if GetResourceState('mf-inventory') == 'started' then inventory = 'mf-inventory' end
    if GetResourceState('core_inventory') == 'started' then inventory = 'core_inventory' end
    if GetResourceState('qs-inventory') == 'started' then
        local s, e = pcall(function() return type(exports['qs-inventory'].GetInventory) == 'function' end)
        if s then
            inventory = 'qs-inventoryv2'
        elseif GetResourceState('qs-core') == 'started' then
            TriggerEvent('qs-core:getSharedObject', function(library)
                QS = library
                inventory = 'qs-inventory'
            end)
        end
    end

    if inventory == 'ox_inventory' then
        exports('notepadUsed', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                sh.itemFunction(cfg.notepadItem, inventory.id, { slot = slot })
                return false
            end
        end)

        exports('pageUsed', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                sh.itemFunction(cfg.pageItem, inventory.id, { slot = slot })
                return false
            end
        end)
    else
        if framework == 'esx' then
            while not ESX do
                Wait(0)
            end

            ESX.RegisterUsableItem(cfg.notepadItem, function(...) sh.itemFunction(cfg.notepadItem, ...) end)
            ESX.RegisterUsableItem(cfg.pageItem, function(...) sh.itemFunction(cfg.pageItem, ...) end)
        elseif framework == 'qb' then
            while not QBCore do
                Wait(0)
            end

            QBCore.Functions.CreateUseableItem(cfg.notepadItem, function(...) sh.itemFunction(cfg.notepadItem, ...) end)
            QBCore.Functions.CreateUseableItem(cfg.pageItem, function(...) sh.itemFunction(cfg.pageItem, ...) end)
        end
    end

    sh.addItem = function(src, name, count, metadata)
        if QS and inventory == 'qs-inventory' then
            local player = QS.GetPlayerFromId(src)
            if player then
                player.addItem(item, 1, false, metadata)
            end
        elseif inventory == 'qs-inventoryv2' then
            exports['qs-inventory']:AddItem(src, name, count, nil, metadata)
        elseif framework == 'esx' then
            local player = ESX.GetPlayerFromId(src)
            if player then
                player.addInventoryItem(name, count, metadata)
            end
        elseif framework == 'qb' then
            local player = QBCore.Functions.GetPlayer(src)
            if player then
                player.Functions.AddItem(name, count, nil, metadata)
            end
        end
    end

    sh.getItemMetadata = function(src, slotId)
        if QS and inventory == 'qs-inventory' then
            local player = QS.GetPlayerFromId(src)
            if not player then return false end
            return player.PlayerData.items[slotId].info
        elseif inventory == 'qs-inventoryv2' then
            local items = exports['qs-inventory']:GetInventory(src)
            return items[slotId].info
        elseif framework == 'esx' then
            if inventory == 'ox_inventory' then
                local item = exports.ox_inventory:GetSlot(src, slotId)
                return item.metadata
            elseif inventory == 'mf-inventory' then
                local player = ESX.GetPlayerFromId(src)
                if not player then return false end
                local inv = exports['mf-inventory']:getInventory(player.identifier)
                local item = inv:getItemAtSlot(slotId)
                return item.metadata
            elseif inventory == 'core_inventory' then
                local player = ESX.GetPlayerFromId(src)
                if not player then return false end
                local inventoryId = 'content-' .. player.getIdentifier():gsub(':', '')
                local items = exports['core_inventory']:getInventory(inventoryId)
                for i = 1, #items do
                    if items[i].id == slotId then
                        return items[i].metadata or items[i].info
                    end
                end
            end
        elseif framework == 'qb' then
            if inventory == 'ox_inventory' then
                local item = exports.ox_inventory:GetSlot(src, slotId)
                return item.metadata
            elseif inventory == 'qb-inventory' or inventory == 'lj-inventory' then
                local player = QBCore.Functions.GetPlayer(src)
                if not player then return false end
                local item = player.Functions.GetItemBySlot(slotId)
                return item.info
            elseif inventory == 'core_inventory' then
                local player = QBCore.Functions.GetPlayer(src)
                if not player then return false end
                local inventoryId = 'content-' .. player.PlayerData.citizenid
                local items = exports['core_inventory']:getInventory(inventoryId)
                for i = 1, #items do
                    if items[i].id == slotId then
                        return items[i].metadata or items[i].info
                    end
                end
            end
        end
    end

    sh.setItemMetadata = function(src, slotId, metadata)
        if QS and inventory == 'qs-inventory' then
            local player = QS.GetPlayerFromId(src)
            if not player then return false end
            player.PlayerData.items[slotId].info = metadata
            player.SetInventory(player.PlayerData.items, true)
        elseif inventory == 'qs-inventoryv2' then
            exports['qs-inventory']:SetItemMetadata(src, slotId, metadata)
        elseif framework == 'esx' then
            if inventory == 'ox_inventory' then
                exports.ox_inventory:SetMetadata(src, slotId, metadata)
            elseif inventory == 'mf-inventory' then
                local player = ESX.GetPlayerFromId(src)
                if not player then return false end
                local inv = exports['mf-inventory']:getInventory(player.identifier)
                local item = inv:getItemAtSlot(slotId)
                item.metadata = metadata
                player.setInventory(inv)
            elseif inventory == 'core_inventory' then
                local player = ESX.GetPlayerFromId(src)
                if not player then return false end
                local inventoryId = 'content-' .. player.getIdentifier():gsub(':', '')
                exports['core_inventory']:updateMetadata(inventoryId, slotId, metadata)
            end
        elseif framework == 'qb' then
            if inventory == 'ox_inventory' then
                exports.ox_inventory:SetMetadata(src, slotId, metadata)
            elseif inventory == 'qb-inventory' or inventory == 'lj-inventory' then
                local player = QBCore.Functions.GetPlayer(src)
                if not player then return false end
                local inv = player.PlayerData.items
                inv[slotId].info = metadata
                player.Functions.SetInventory(inv)
            elseif inventory == 'core_inventory' then
                local player = ESX.GetPlayerFromId(src)
                if not player then return false end
                local inventoryId = 'content-' .. player.PlayerData.citizenid
                exports['core_inventory']:updateMetadata(inventoryId, slotId, metadata)
            end
        end
    end
end
