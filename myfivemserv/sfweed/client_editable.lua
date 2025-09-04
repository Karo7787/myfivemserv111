local ox_inventory = exports.ox_inventory

exports('joint_blue_dream', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_blue_dream")
			end
		end
	end)
end)

exports('joint_lemon_haze', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_lemon_haze")
			end
		end
	end)
end)

exports('joint_og_kush', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_og_kush")
			end
		end
	end)
end)

exports('joint_purple_haze', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_purple_haze")
			end
		end
	end)
end)

exports('joint_skunk', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_skunk")
			end
		end
	end)
end)

exports('joint_white_widow', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			-- TriggerEvent("effect_weed", 50000)
			if GetResourceState("mrg_drunkness") then
				exports["mrg_drunkness"]:PlayEffect(PlayerPedId(), "joint_white_widow")
			end
		end
	end)
end)

exports('weed_water_can', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then           
            if IsEntityInWater(PlayerPedId())  then 
				if data.metadata.durability == nil or data.metadata.durability<100.0 then
					if lib.progressBar({
						duration = 5000,
						label = locale('progress_label_1'),
						useWhileDead = false,
						canCancel = true,
						disable = {
							car = true,
							move = true,
							combat = true,
						},
						anim = {
							scenario = 'PROP_HUMAN_BUM_BIN'
						},
						prop = {
							model = `prop_wateringcan`,
							bone = 57005,
							pos = vec3(0.32, -0.15, 0.0),
							rot = vec3(260.0, 0.0, 0.0)
						}						
					}) then
						TriggerServerEvent("sfweed:setDurablilityWC", data.slot, 100.0)
					end
				else
					notificationClient(locale('error_4'))
				end
            else
                notificationClient(locale('error_5'))
            end
		end
	end)
end)

exports('seedWeed', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			if isInZone then
				local count = searchItemClient('weed_bag_ground')
				local count2 = searchItemClient('weed_pot')
				if count >= 1 and count2 >= 1 then
					CreateThread(function()
						createPlant(data.name)
					end)
				else
					notificationClient(locale('error_6'))
				end
			else
				notificationClient(locale('error_7'))
			end
		end
	end)
end)

Citizen.CreateThread(function()
	exports.ox_target:addModel(configs.weedProps, {
		{
            icon = "fa-solid fa-cannabis",
            label = locale('interact_label'),
            onSelect = function(entity)    
				local isObject = objectForInteraction[entity.entity]
				if isObject and weedObjects[isObject] then
					local check = weedObjects[isObject]
					local netId = isObject
					local optionsAll = {}
					local descWater = locale('menu_text_1')
					local descFert = locale('menu_text_1')
					if check.water > 0 then descWater = locale('menu_text_2') end
					if check.fertilizer > 0 then descFert = locale('menu_text_2') end
					
					local stageInfo = check.percent..'% '..locale('menu_text_3')
					if check.percent>100 then
						stageInfo = '100% '..locale('menu_text_3')
					end
					if check.stage == 0 then stageInfo = locale('menu_text_4') end
					if check.stage == 5 and check.percent>= 100 then stageInfo = locale('menu_text_5') end
					table.insert(optionsAll, {
						title = locale('menu_text_6'),
						description = stageInfo,
						icon = 'fa-solid fa-info',
						readOnly = true
					})

					if check.stage ~= 0 and check.percent < 100 then  
						table.insert(optionsAll, {
							title = locale('menu_text_7'),
							description = descWater,
							icon = 'fa-solid fa-droplet',
							readOnly = true
						})
						table.insert(optionsAll, {
							title = locale('menu_text_8'),
							description = descFert,
							icon = 'fa-solid fa-plus',
							readOnly = true
						})
					end

					if check.water == 0 and check.stage ~= 0 and check.percent<100 then
						table.insert(optionsAll, {
							title = locale('menu_text_9'),
							icon = 'fa-solid fa-droplet',
							onSelect = function()
								watteringPlant(netId)
							end,
						})
					end

					if check.fertilizer == 0 and check.stage ~= 0 and check.percent<100 then 
						table.insert(optionsAll, {
							title = locale('menu_text_10'),
							icon = 'fa-solid fa-plus',
							onSelect = function()
								fertilizingPlant(netId)
							end,
						})
					end

					table.insert(optionsAll, {
						title = locale('menu_text_11'),
						icon = 'fa-solid fa-fire',
						onSelect = function()
							destroyPlant(netId)
						end,
					})

					if check.stage == 5 and check.percent>= 100 then
						table.insert(optionsAll, {
							title = locale('menu_text_12'),
							icon = 'fa-solid fa-scissors',
							onSelect = function()
								takePlant(netId)
							end,
						})
					end
					lib.registerContext({
						id = 'sfweed_menu_plant',
						title = locale('menu_text_13'),
						options = optionsAll
					})
					lib.showContext('sfweed_menu_plant')
				end
            end,
            canInteract = function(entity)
                return isInZone and objectForInteraction[entity]
            end,
            distance = 2.0
        },
	})
end)

function rollWeed(slot)
	local data = getPlayerItems()
    for _, v in pairs(data) do
        if v.slot == slot then
			local count = searchItemClient(v.name)
			local count2 = searchItemClient('joint_paper')
			if count>=configs.needAmountForRollJoint and count2>=1 then
				if lib.progressBar({
					duration = 5000,
					label = locale('progress_label_2'),
					useWhileDead = false,
					canCancel = true,
					disable = {
						move = true,
						combat = true,
					},
					anim = {
						dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus',
						clip = 'loop'
					},
				}) then
					TriggerServerEvent("sfweed:createJoint", v.name)
				end
			else
				notificationClient(locale('error_8'))
			end
        end
    end
end

function watteringPlant(netId)
    local data = getPlayerItems()
    local foundItem = false
    for _, v in pairs(data) do
        if v.name == "weed_water_can" then
			if v.metadata.durability and v.metadata.durability>=25.0 then
				foundItem = v.slot
			elseif not v.metadata.durability then
				foundItem = v.slot
			end
        end
    end
    if foundItem then
        if lib.progressBar({
            duration = 5000,
            label = locale('progress_label_3'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
				move = true,
				combat = true,
            },
			anim = {
				dict = 'weapon@w_sp_jerrycan',
				clip = 'fire'
            },
			prop = {
				model = `prop_wateringcan`,
				bone = 28422,
				pos = vec3(0.4, 0.125, -0.05),
				rot = vec3(90.0, 180.0, 0.0)
			}
        }) then
            TriggerServerEvent("sfweed:watteringPlant", netId, configs.waterTime)
            TriggerServerEvent("sfweed:setDurablilityWC", foundItem, -24.9)
        end
    else
        notificationClient(locale('error_9'))
    end
end

function fertilizingPlant(netId)
    local count = searchItemClient('weed_fertilizer')
    if count > 0 then
        if lib.progressBar({
            duration = 5000,
            label = locale('progress_label_4'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
				move = true,
				combat = true,
            },
            anim = {
                scenario = 'PROP_HUMAN_BUM_BIN'
            },
        }) then
            TriggerServerEvent("sfweed:fertilizingPlant", netId, configs.fertilizerBoostTime)
        end
    else
        notificationClient(locale('error_10'))
    end
end

function destroyPlant(netId)
    if lib.progressBar({
        duration = 10000,
        label = locale('progress_label_5'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
			move = true,
			combat = true,
        },
        anim = {
            scenario = 'PROP_HUMAN_BUM_BIN'
        },
    }) then
        TriggerServerEvent("sfweed:destroyPlant", netId)
    end
end

function takePlant(netId)
    local count = searchItemClient('weed_scissors')
    if count > 0 then
        if lib.progressBar({
            duration = 5000,
            label = locale('progress_label_6'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
				move = true,
				combat = true,
            },
			anim = {
				dict = 'bzzz_cutting_sickle',
				clip = 'bzzz_cutting_sickle'
            },
			prop = {
				bone = 57005,
				model = `bzzz_prop_sickle_a`,
				pos = vec3(0.1, 0.03, -0.01),
				rot = vec3(-123.0, -52.0, -36.0)
			},
        }) then
            TriggerServerEvent("sfweed:takePlant", netId)
        end
    else
        notificationClient(locale('error_11'))
    end
end

function showTextUI()
	lib.showTextUI(locale('press_info'), {
        position = "top-center",
    })
end

function hideTextUI()
	lib.hideTextUI()
end

function progressBar(options)
	return lib.progressBar(options)
end