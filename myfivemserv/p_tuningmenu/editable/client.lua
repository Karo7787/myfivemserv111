editable = {}

editable.getGroup = function()
    return lib.callback.await('p_tuningmenu/getGroup', false)
end

editable.getInventoryItems = function()
    if GetResourceState('ox_inventory') == 'started' then
        return exports['ox_inventory']:GetPlayerItems()
    elseif GetResourceState('qs-inventory') == 'started' then
        local items = {}
        local playerItems = exports['qs-inventory']:getUserInventory()
        for itemName, itemData in pairs(playerItems) do
            items[#items + 1] = {
                name = itemName,
                count = itemData.amount,
                metadata = itemData.info or itemData.metadata
            }
        end
        return items
    end 
end

editable.showNotification = function(text)
    lib.notify({
        title = 'Notification',
        description = text,
        type = 'inform'
    })
end

editable.openPaymentMenu = function(totalPrice, cart)
    local p = promise.new()
    local coords = GetEntityCoords(cache.ped)
    local nearbyPlayers = lib.getNearbyPlayers(coords, 10.0, true)
    local myId = cache.serverId
    local options = {}
    for i = 1, #nearbyPlayers do
        local nearbyPlayer = nearbyPlayers[i]
        local serverId = GetPlayerServerId(nearbyPlayer.id)
        options[i] = {
            label = serverId == myId and serverId..' '..locale('you') or locale('player')..' - '..serverId,
            value = serverId
        }
    end

    local input = lib.inputDialog(locale('who_will_pay'), {
        { label = 'ID Gracza', type = 'select', options = options, required = true},
        { label = 'Sposób Zapłaty', type = 'select', options = {
            {
                label = "Karta",
                value = "bank"
            },
            {
                label = "Gotówka",
                value = "money"
            }
        }, required = true}
    })

    if not input then
        p:resolve(false)
    else
        local result = lib.callback.await('p_tuningmenu:Payment', false, {
            playerId = input[1],
            type = input[2],
            price = totalPrice,
            cart = cart
        })
        p:resolve(result)
    end

    local await = Citizen.Await(p)
    return await
end