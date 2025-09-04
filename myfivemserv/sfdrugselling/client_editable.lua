waitForResponse = false
lastPed = nil
Citizen.CreateThread(function()
	exports.ox_target:addGlobalPed({
		{
            icon = "fa-solid fa-cannabis",
            label = locale('interaction_ped'),
            onSelect = function(entity)    
				waitForResponse = true
				local time = 3000
			    TaskLookAtEntity(entity.entity, PlayerPedId(), time, 2048, 3)
    			TaskTurnPedToFaceEntity(entity.entity, PlayerPedId(), time)
				PlayPedAmbientSpeechNative(entity.entity, "GENERIC_BUY", "SPEECH_PARAMS_FORCE")
				lastPed = entity.entity
                TriggerServerEvent("sfdrugselling:sell", NetworkGetNetworkIdFromEntity(entity.entity), getItemForSell())
            end,
            canInteract = function(entity)
				if IsPedSittingInAnyVehicle(PlayerPedId()) then return false end
				if not isInZone and not configs.sellingEverywhere then return false end
				if IsPedAPlayer(entity) or waitForResponse or Entity(entity).state.drugSell or IsEntityPositionFrozen(entity) or IsPedInAnyVehicle(entity) or IsPedDeadOrDying(entity) or not getItemForSell() then return false end
				local time = 1000
			    TaskLookAtEntity(entity, PlayerPedId(), time, 2048, 3)
    			TaskTurnPedToFaceEntity(entity, PlayerPedId(), time)
				return true
            end,
            distance = 2.0
        },
	})
end)

lib.callback.register('sfdrugselling:sell', function(money)
	local type2 = type(money)
	local amount = 0
	if type2 == "number" then
		amount = money
	elseif type2 == "table" then
		local input = lib.inputDialog(locale('amount_input'), {
			{type = 'slider', required = true, min = money[1], max = money[2], step = 1},
		})
		if input ~= nil then
			amount = tonumber(input[1])
		else
			amount = false
		end
	end
    return amount
end)

-- RegisterNetEvent("sfdrugselling:callcops", function()
--     exports["ps-dispatch"]:CustomAlert({
--         coords = GetEntityCoords(PlayerPedId()),
--         message = "Sprzedaż Narkotyków",
--         dispatchCode = "10-30",
--         description = "Sprzedaż Narkotyków",
--         sprite = 51,
--         color = 2,
--         scale = 0.9,
--         length = 3,
--     })
-- end)