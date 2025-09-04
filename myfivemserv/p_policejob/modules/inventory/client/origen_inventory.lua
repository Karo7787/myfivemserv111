if GetResourceState('origen_inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        exports['origen_inventory']:openInventory(invType, data)
    end,
    getItemCount = function(itemName, metadata)
        return exports['origen_inventory']:Search('count', itemName, metadata or nil)
    end,
    useItem = function(data, cb)
        local result = exports['origen_inventory']:useSlot(data.slot)
        cb(result)
    end,
}