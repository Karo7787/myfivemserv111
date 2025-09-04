if GetResourceState('qb-inventory') ~= 'started' then return end

Inventory = {
    openInventory = function(invType, data)
        if invType == 'stash' then
            if data.owner then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", data.id..'_'..data.owner, {
                    maxweight = 250000,
                    slots = 100,
                })
                TriggerEvent("inventory:client:SetCurrentStash", data.id..'_'..data.owner)
            else
                TriggerServerEvent('p_policejob/inventory/openInventory', invType, data)
            end
        else
            TriggerServerEvent('p_policejob/inventory/openInventory', invType, data)
        end
    end,
    getItemCount = function(itemName)
        local items = QBCore.Functions.GetPlayerData().items
        for _, item in pairs(items) do
            if item.name == itemName then
                return item.amount
            end
        end
        
        return 0
    end,
    useItem = function(data, cb)
        cb(true)
    end,
}