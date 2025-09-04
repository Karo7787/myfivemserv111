if GetResourceState('ak47_inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        if invType == 'player' then
            exports['ak47_inventory']:OpenInventory(data)
        elseif type(data) == 'table' then
            exports['ak47_inventory']:OpenInventory({
                identifier = ('%s_%s'):format(data.id, data.owner),
                type = 'stash',
                maxWeight = 500000,
                slots = 50,
                label = ('%s_%s'):format(data.id, data.owner)
            })
        else
            exports['ak47_inventory']:OpenInventory(data)
        end
    end,
    getItemCount = function(itemName, metadata)
        return exports['ak47_inventory']:Search('count', itemName, metadata or nil)
    end,
    useItem = function(data, cb)
        cb(true)
    end,
}