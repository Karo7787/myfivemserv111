local ox_inventory = exports.ox_inventory

exports('coke', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_coke", 50000)
		end
	end)
end)

Citizen.CreateThread(function()
	exports.ox_target:addModel(configs.obejectsModel, {
		{
            icon = "fa-solid fa-cannabis",
            label = locale('interaction'),
            onSelect = function(entity)    
				local isObject = objectForInteraction[entity.entity]
				if isObject then
					TriggerServerEvent("sfcoke:takePlant", isObject)
				end
            end,
            canInteract = function(entity)
                return objectForInteraction[entity]
            end,
            distance = 2.0
        },
	})

	exports.ox_target:addModel(configs.obejectsModelBarrel, {
		{
            icon = "fa-solid fa-gem",
            label = locale('interaction2'),
            onSelect = function(entity)    
				local isObject = objectForInteraction[entity.entity]
				if isObject then
					TriggerServerEvent("sfcoke:takePlantBarrel", isObject)
				end
            end,
            canInteract = function(entity)
                return objectForInteraction[entity]
            end,
            distance = 2.0
        },
	})


end)

lib.callback.register('sfcoke:animTake', function()
    if lib.progressBar({
		duration = 5000,
		label = locale('progress'),
		useWhileDead = false,
		canCancel = false,
		disable = {
			car = true,
			move = true,
			combat = true,
		},
		anim = {
			dict = 'anim@amb@business@cfm@cfm_cut_sheets@',
			clip = 'fine_tune_loading_guilotine_billcutter'
		},
	}) then
		return true
	else
		return false
	end
end)

lib.callback.register('sfcoke:animTakeBarrel', function()
    if lib.progressBar({
		duration = 5000,
		label = locale('progress2'),
		useWhileDead = false,
		canCancel = false,
		disable = {
			car = true,
			move = true,
			combat = true,
		},
		anim = {
			dict = 'weapons@first_person@aim_idle@p_m_zero@melee@small_wpn@hammer@fidgets@c',
			clip = 'fidget_low_loop'
		},
	}) then
		return true
	else
		return false
	end
end)

local configServer = {}
local selectedPlace = ""
Citizen.CreateThread(function()
	configServer = lib.callback.await('sfcoke:getConfig', false)
	for i,v in pairs(configServer.placeForCooking) do
		if v.coordsDoorsOutside then
			print(v.coordsDoorsOutside.x)
			exports.ox_target:addSphereZone({
				coords = vec(v.coordsDoorsOutside.x, v.coordsDoorsOutside.y, v.coordsDoorsOutside.z),
				radius = 1.0,
				debug = configs.devMode,
				drawSprite = true,
				options = {
					{
						icon = "fa-solid fa-door-open",
						label = locale('interaction3'),
						onSelect = function()
							DoScreenFadeOut(100)
							selectedPlace = i
							TriggerServerEvent("sfcoke:teleportIn", i)
							Wait(300)
							DoScreenFadeIn(200)
						end,
						distance = 2.5
					}
				}
			})

			exports.ox_target:addSphereZone({
				coords = vec(v.coordsDoorsInside.x, v.coordsDoorsInside.y, v.coordsDoorsInside.z),
				radius = 1.0,
				debug = configs.devMode,
				drawSprite = true,
				options = {
					{
						icon = "fa-solid fa-door-open",
						label = locale('interaction4'),
						onSelect = function()
							DoScreenFadeOut(100)
							TriggerServerEvent("sfcoke:teleportOut", i)
							Wait(300)
							DoScreenFadeIn(200)
						end,
						distance = 2.5
					}
				}
			})
		end
		for index, value in pairs(v.createCoke) do
			exports.ox_target:addSphereZone({
				coords = vec(value.x, value.y, value.z),
				radius = 0.5,
				debug = configs.devMode,
				drawSprite = true,
				options = {
					{
						icon = "fa-solid fa-flask-vial",
						label = locale('interaction5'),
						onSelect = function()
							TriggerServerEvent("sfcoke:createCoke", i)
						end,
						distance = 2.5
					}
				}
			})
		end
		for index, value in pairs(v.packingPlace) do
			exports.ox_target:addSphereZone({
				coords = vec(value.x, value.y, value.z),
				radius = 0.5,
				debug = configs.devMode,
				drawSprite = true,
				options = {
					{
						icon = "fa-solid fa-tape",
						label = locale('interaction6'),
						onSelect = function()
							TriggerServerEvent("sfcoke:packCoke", i, "small")
						end,
						distance = 2.5
					},
					{
						icon = "fa-solid fa-robot",
						label = locale('interaction7'),
						onSelect = function()
							TriggerServerEvent("sfcoke:packCoke", i, "toy")
						end,
						distance = 2.5
					}
				}
			})
		end
	end
end)

lib.callback.register('sfcoke:animCreate', function()
    if lib.progressBar({
		duration = 5000,
		label = locale('progress3'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			move = true,
			combat = true,
		},
		anim = {
			dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
			clip = 'coke_cut_coccutter'
		},
	}) then
		return true
	else
		return false
	end
end)

lib.callback.register('sfcoke:animPackingSmall', function()
    if lib.progressBar({
		duration = 5000,
		label = locale('progress4'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			move = true,
			combat = true,
		},
		anim = {
			scenario = 'PROP_HUMAN_PARKING_METER',
		},
	}) then
		return true
	else
		return false
	end
end)


lib.callback.register('sfcoke:animPackingToy', function()
    if lib.progressBar({
		duration = 10000,
		label = locale('progress5'),
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			move = true,
			combat = true,
		},
		anim = {
			dict = 'anim@gangops@facility@servers@bodysearch@',
			clip = 'player_search'
		},
	}) then
		return true
	else
		return false
	end
end)
