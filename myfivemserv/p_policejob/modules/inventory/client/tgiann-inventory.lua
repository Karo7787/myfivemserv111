if GetResourceState('tgiann-inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        TriggerServerEvent('p_policejob/inventory/openInventory', invType, data)
    end,
    getItemCount = function(itemName)
        return exports["tgiann-inventory"]:Search('count', itemName)
    end,
    useItem = function(data, cb)
        cb(true)
    end,
}