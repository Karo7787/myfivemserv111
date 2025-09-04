if GetResourceState('core_inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        print('[ERROR] Inventory is missing an openInventory function.')
    end,
    getItemCount = function(itemName)
        return exports.core_inventory:getItemCount(itemName)
    end,
    useItem = function(data, cb)
        cb(true)
    end,
}