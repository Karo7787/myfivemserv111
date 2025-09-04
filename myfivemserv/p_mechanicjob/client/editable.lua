-- lib.onCache('vehicle', function(value)
--     if value then
--         lib.addRadialItem({
--             {
--                 id = 'mileage',
--                 label = locale('check_mileage'),
--                 icon = 'car',
--                 onSelect = function()
--                     local mileage = exports['p_mechanicjob']:getMileage(value)
--                     Core.ShowNotification(locale('vehicle_mileage', exports['p_mechanicjob']:formatMileage(mileage)))
--                 end
--             }
--         })
--     else
--         lib.removeRadialItem('mileage')
--     end
-- end)

Citizen.CreateThread(function()
    for jobName, stashes in pairs(Config.Stashes) do
        for i = 1, #stashes, 1 do
            local stash = stashes[i]
            local options = {
                {
                    name = 'p_mechanicjob:OpenStash_'..jobName..'_'..i,
                    label = locale('open_stash'),
                    icon = 'fa-solid fa-box',
                    distance = 2,
                    groups = jobName,
                    onSelect = function()
                        Core.Inventory.openInventory('stash', stash.name)
                    end
                },
            }
    
            if stash.trash then
                table.insert(options, {
                    name = 'p_mechanicjob:OpenTrash_'..jobName..'_'..i,
                    label = locale('open_trash'),
                    icon = 'fa-solid fa-trash',
                    distance = 2,
                    groups = jobName,
                    onSelect = function()
                        Core.Inventory.openInventory('stash', stash.name..'_trash')
                    end
                })
                table.insert(options, {
                    name = 'p_mechanicjob:ClearTrash_'..jobName..'_'..i,
                    label = locale('clear_trash'),
                    icon = 'fa-solid fa-trash',
                    groups = jobName,
                    distance = 2,
                    onSelect = function()
                        TriggerServerEvent('p_mechanicjob:main:ClearTrash', i)
                    end
                })
            end

            if stash.wardrobe then
                table.insert(options, {
                    name = 'p_mechanicjob:SelectOutfit'..jobName..'_'..i,
                    label = locale('select_outfit'),
                    icon = 'fa-solid fa-tshirt',
                    distance = 2,
                    onSelect = function()
                        exports['p_mechanicjob']:OpenOutfitsMenu()
                    end
                })
            end
            exports['ox_target']:addSphereZone({
                coords = stash.coords,
                radius = 0.5,
                debug = Config.Debug,
                options = options
            })
        end
    end

    -- exports['ox_target']:addGlobalVehicle({
    --     {
    --         name = 'p_mechanic:rotateVehicle',
    --         label = locale('rotate_vehicle'),
    --         icon = 'fa-solid fa-car',
    --         distance = 2,
    --         onSelect = function(data)
    --             if lib.progressBar({
    --                 duration = 8000,
    --                 label = locale('rotating_vehicle'),
    --                 useWhileDead = false,
    --                 canCancel = true,
    --                 disable = {
    --                     car = true,
    --                 },
    --                 anim = {
    --                     dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
    --                     clip = 'machinic_loop_mechandplayer',
    --                     flag = 1
    --                 },
    --             }) then
    --                 NetworkRequestControlOfEntity(data.entity)
    --                 while not NetworkHasControlOfEntity(data.entity) do
    --                     Wait(10)
    --                     NetworkRequestControlOfEntity(data.entity)
    --                 end

    --                 local carCoords = GetEntityRotation(data.entity, 2)
    --                 SetEntityRotation(data.entity, carCoords[1], 0, carCoords[3], 2, true)
    --                 SetVehicleOnGroundProperly(data.entity)
    --             end
    --         end,
    --         canInteract = function(entity)
    --             local roll = GetEntityRoll(entity)
	-- 			local speed = GetEntitySpeed(entity)

	-- 		    if (roll > 75.0 or roll < -75.0) and (speed < 2) then 
	-- 				return true 
	-- 			end

    --             return false
    --         end
    --     }
    -- })
end)