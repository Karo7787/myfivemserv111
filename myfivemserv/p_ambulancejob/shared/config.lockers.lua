Config.Lockers = {}

Config.Lockers.Targets = {
    ['Pillbox'] = {
        coords = vector3(57.15, -385.8, 39.38),
        radius = 0.65,
        drawSprite = true,
        options = {
            {
                name = 'Pillbox_Stash',
                label = locale('private_locker'),
                icon = 'fa-solid fa-box',
                distance = 2,
                groups = {['ambulance'] = 0},
                isLocker = true,
                slots = 50,
                weight = 500000,
                isShared = false, -- true = same for everyone
                onSelect = function()
                    if GetResourceState('ox_inventory') == 'started' then
                        exports['ox_inventory']:openInventory('stash', 'Pillbox_Stash') -- stash id = option name
                    else
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'Pillbox_Stash', {
                            maxweight = 500000,
                            slots = 50,
                        })
                        TriggerEvent("inventory:client:SetCurrentStash", 'Pillbox_Stash')
                    end
                end
            },
        }
    }
}

Config.OutfitsAccess = { -- permissions for /medic_outfit
    ['ambulance'] = 0,
}

Config.Wardrobes = {
    ['Pillbox'] = {
        coords = vector3(58.59, -390.35, 39.38),
        radius = 0.75,
        drawSprite = false,
    }
}