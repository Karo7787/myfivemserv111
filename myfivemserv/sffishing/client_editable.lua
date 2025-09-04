------------ ox_inventory ----------- If you are not using ox_inventory comment this out

exports('tablet_fish', function(data, slot)
	exports.ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent("sffishing:tabletopen")
		end
	end)
end)
exports('fish_rod_1', function(data, slot)
	exports.ox_inventory:useItem(data, function(data)
		if data then
			startFishing(1)
		end
	end)
end)
exports('fish_rod_2', function(data, slot)
	exports.ox_inventory:useItem(data, function(data)
		if data then
			startFishing(2)
		end
	end)
end)
exports('fish_packredworm', function(data, slot)
	exports.ox_inventory:useItem(data, function(data)
		if data then
			TriggerServerEvent("sffishing:giveWorms")
		end
	end)
end)

------------ end ox_inventory -----------

------------ qs-inventory ----------- 
-- RegisterNetEvent("sffishing:qs_tabletOpen", function()
-- 	if searchItemClient('tablet_fish') > 0 then
--     	TriggerEvent("sffishing:tabletopen")
-- 	end
-- end)
-- RegisterNetEvent("sffishing:qs_fish_rod_1", function()
-- 	if searchItemClient('fish_rod_1') > 0 then
--     	startFishing(1)
-- 	end
-- end)
-- RegisterNetEvent("sffishing:qs_fish_rod_2", function()
-- 	if searchItemClient('fish_rod_2') > 0 then
-- 		startFishing(2)
-- 	end
-- end)
-- RegisterNetEvent("sffishing:qs_fish_packredworm", function()
-- 	if searchItemClient('fish_packredworm') > 0 then
--     	TriggerServerEvent("sffishing:giveWorms")
-- 	end
-- end)
------------ end qs-inventory ----------- 

local boatRented = false

SFX = nil
if configs.framework == "esx" then
	SFX = exports["es_extended"]:getSharedObject()
end

if configs.framework == "qbcore" then
	SFX = exports['qb-core']:GetCoreObject()
end

function checkIsDead()
	return false
end

function sfCreatePed(typ, name, vec, anim)
    local hashKey = name
    local pedType = typ
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

	local created_ped = CreatePed(pedType, hashKey, vec.x, vec.y, vec.z-1, vec.w, false, true)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	if anim then
		TaskStartScenarioInPlace(created_ped, anim, 0, true)
	end
end

Citizen.CreateThread(function()
	exports.ox_target:addBoxZone({
		coords = vec3(configs.coordsFishingSell.x, configs.coordsFishingSell.y, configs.coordsFishingSell.z),
		size = vec3(1.0, 1.0, 2.0),
		rotation =  configs.coordsFishingSell.w,
		debug = configs.devMode,
		options = {
			{
				name = "sffishing-sellFish",
				onSelect = function ()
					TriggerServerEvent("sffishing:sellAllFish")
				end,
				icon = 'fa-solid fa-basket-shopping',
				label = locale("interactionSellFish"),
				distance = 2.0
			},
		}
	})
	if configs.rentBoatForFishing then
		sfCreatePed(0, "ig_floyd", configs.coordsInteractionRentBoat, "WORLD_HUMAN_CLIPBOARD")
		exports.ox_target:addBoxZone({
			coords = vec3(configs.coordsInteractionRentBoat.x, configs.coordsInteractionRentBoat.y, configs.coordsInteractionRentBoat.z),
			size = vec3(1.0, 1.0, 2.0),
			rotation =  configs.coordsInteractionRentBoat.w,
			debug = configs.devMode,
			options = {
				{
					name = "sffishing-rentBoat",
					onSelect = function ()
						if configs.framework == "esx" then
							if SFX.Game.IsSpawnPointClear(vec3(configs.spawnRentBoat.x, configs.spawnRentBoat.y, configs.spawnRentBoat.z), 2.5) then
								TriggerServerEvent("sffishing:rentBoat")
							else
								notificationClient(locale("infoBackBoat3"))
							end	
						else
							print("You need to configure it")
						end			
					end,
					icon = 'fa-solid fa-ship',
					label = locale("interactionRentBoat").." ("..configs.priceForRentBoat.."$)",
					distance = 2.0
				},
				{
					name = "sffishing-rentBoatBack",
					canInteract = function(entity, distance, coords, name)
						return boatRented
					end,
					onSelect = function ()
						TriggerServerEvent("sffishing:rentBoatBack")
					end,
					icon = 'fa-solid fa-ship',
					label = locale("interactionRentBoat2"),
					distance = 2.0
				},
			}
		})
	end
end)

RegisterNetEvent("sffishing:rentBoat", function(bool)
    boatRented = bool
end)

----------------------------------------------------------

lib.callback.register('sffishing:minigame', function()
	return lib.skillCheck({'medium', 'medium', 'medium'}, {'W', 'S', 'A', 'D'})
end)

RegisterCommand('stopfishing', function()
    stopFishing()
end, false)
RegisterKeyMapping('stopfishing', locale("infoKeymap"), 'keyboard', 'X')