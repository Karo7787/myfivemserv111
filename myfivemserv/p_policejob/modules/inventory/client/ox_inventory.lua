if GetResourceState('ox_inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        exports['ox_inventory']:openInventory(invType, data)
    end,
    getItemCount = function(itemName, metadata)
        return exports['ox_inventory']:Search('count', itemName, metadata or nil)
    end,
    useItem = function(data, cb)
        exports['ox_inventory']:useItem(data, cb)
    end,
}