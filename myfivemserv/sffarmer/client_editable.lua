local coords = {}
local size = {}
local rotation = {}
local options = {}
readyForSell = false

CreateThread(function()   
    exports.ox_target:addModel({`luno_cabbage`}, {
        {
            icon = "fa-solid fa-hand",
            label = locale("interaction_collect"),
            onSelect = function(entity)     
                takePlant(entity.entity, "cabbage")
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and collected['cabbage'] < maxCollected['cabbage'] and collected['eggplant'] == 0 and collected['apple'] == 0 and collectedToFinish['cabbage'] < configs.maxAmountHarvested['cabbage'] then
                    return true
                end
            end,
            distance = 2.0
        },
    })
    exports.ox_target:addModel({`luno_eggplant`}, {
        {
            icon = "fa-solid fa-hand",
            label = locale("interaction_collect"),
            onSelect = function(entity)     
                takePlant(entity.entity, "eggplant")
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and collected['eggplant'] < maxCollected['eggplant'] and collected['cabbage'] == 0 and collected['apple'] == 0  and collectedToFinish['eggplant'] < configs.maxAmountHarvested['eggplant'] then
                    return true
                end
            end,
            distance = 2.0
        },
    })
    exports.ox_target:addModel({`sf_prop_sf_apple_01a`}, {
        {
            icon = "fa-solid fa-hand",
            label = locale("interaction_collect"),
            onSelect = function(entity)     
                takePlant(entity.entity, "apple")
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and collected['apple'] < maxCollected['apple'] and collected['eggplant'] == 0 and collected['cabbage'] == 0 and collectedToFinish['apple'] < configs.maxAmountHarvested['apple'] then
                    return true
                end
            end,
            distance = 2.5
        },
    })
    exports.ox_target:addModel({`bodhi2`}, {
        {
            icon = "fas fa-truck-loading",
            label = locale("interaction_car"),
            onSelect = function(entity)           
                if lib.progressBar({
                    duration = configs.durationProgress['puttingoff'],
                    label = locale('progress_deposit'),
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        move = true,
                    },
                    anim = {
                        dict = 'anim@narcotics@trash',
                        clip = 'drop_front'
                    },
                }) then
                    for i, v in pairs(objects) do
                        if DoesEntityExist(v) then
                            DeleteEntity(v)
                        end
                    end
                    objects = {}
                    local type_farm = ""
                    if collected['cabbage']>0 then
                        type_farm = "cabbage"
                    end
                    if collected['eggplant']>0 then
                        type_farm = "eggplant"
                    end
                    if collected['apple']>0 then
                        type_farm = "apple"
                    end
                    collectedToFinish[type_farm] = collectedToFinish[type_farm] + collected[type_farm]
                    
                    if collectedToFinish['cabbage'] >= configs.maxAmountHarvested['cabbage'] and collectedToFinish['eggplant'] >= configs.maxAmountHarvested['eggplant'] and collectedToFinish['apple'] >= configs.maxAmountHarvested['apple'] then
                        notificationClient(locale("collecting_info"))
                        readyForSell = true
                    elseif collectedToFinish[type_farm] >= configs.maxAmountHarvested[type_farm] then
                        notificationClient(locale("collecting_info2"))
                    end

                    TriggerServerEvent("sffarmer:finishCollect", type_farm, collected[type_farm])
                    collected[type_farm] = 0
                end
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and (collected['cabbage']>0 or collected['eggplant']>0 or collected['apple']>0) then
                    return true
                end
            end,
            distance = 2.0
        },
        {
            icon = "fa-solid fa-bag-shopping",
            label = locale("interaction_car2"),
            onSelect = function(entity)           
                DeleteEntity(mainObject)
                mainObject = false
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and collected['cabbage']== 0 and collected['eggplant']== 0 and collected['apple'] == 0 and mainObject then
                    return true
                end
            end,
            distance = 2.0
        },
        {
            icon = "fa-solid fa-bag-shopping",
            label = locale("interaction_car3"),
            onSelect = function(entity)           
                mainObject = CreateObject(GetHashKey("prop_fruit_basket"), 0, 0, 0, true, true, true)
                AttachEntityToEntity(mainObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.39, -0.04, -0.05, 160.0, 90.0, 225.0, true, true, false, true, 1, true)
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "farmer" and collected['cabbage']== 0 and collected['eggplant']== 0 and collected['apple'] == 0 and not mainObject then
                    return true
                end
            end,
            distance = 2.0
        },
    })

    if configs.blip then
        blip = AddBlipForCoord(2016.9418, 4987.8174, 42.0982)
        SetBlipSprite(blip, configs.blipSprite)
        SetBlipScale(blip, configs.blipScale)
        SetBlipColour(blip, configs.blipColour)
        SetBlipAsShortRange(blip, true)
        AddTextEntry("BlipsSfFarmerMain", configs.blipText)
        BeginTextCommandSetBlipName("BlipsSfFarmerMain")
        EndTextCommandSetBlipName(blip)
    end
    
    coords[1] = vector3(2016.98, 4987.85, 42.1)
	size[1] = vec3(1.3, 0.8, 2.0)
	rotation[1] = 313.0
	options[1] = {
        {
			name = "sffarmer-rent-car",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				rentCar()
			end,
			icon = 'fa-solid fa-car',
			label = locale("interaction_rent")..' ('..configs.costForRentCar..'$)',
            distance = 2.5
		},
        {
			name = "sffarmer-back-car",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" and rentedCar then
					return true
				end
			end,
			onSelect = function ()
				backCar()
			end,
			icon = 'fa-solid fa-car',
			label = locale("interaction_rent2"),
            distance = 2.5
		},
		{
			name = "sffarmer-sluzba-zejdz",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				stopActiveJob()
			end,
			icon = 'fa-solid fa-clipboard-list',
			label = locale("interaction_stopjob"),
            distance = 2.5
		},
		{
			name = "sffarmer-sluzba-wejdz",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "unemployed" and checkPermissions("farmer") then
					return true
				end
			end,
			onSelect = function ()
				startActiveJob()
			end,
			icon = 'fa-solid fa-clipboard-list',
			label = locale("interaction_startjob"),
            distance = 2.5
		},
	}
    coords[2] = vec3(configs.sellItemsCoords.x, configs.sellItemsCoords.y, configs.sellItemsCoords.z)
	size[2] = vec3(1.5, 1.5, 2.0)
	rotation[2] = configs.sellItemsCoords.w
	options[2] = {
        {
			name = "sffarmer-sprzedaz",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				sellProducts()
			end,
			icon = 'fa-solid fa-hand-holding-dollar',
			label = locale("interaction_sellitems"),
            distance = 2.5
		},
	}
    coords[3] = vec3(2304.8666992188, 4996.9262695312, 42.859439849854)
	size[3] = vec3(0.7, 0.7, 1.0)
	rotation[3] = 180.06648254395
	options[3] = {
        {
			name = "sffarmer-a-1",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				shakeTree(1)
			end,
			icon = 'fa-solid fa-hands-holding',
            label = locale("interaction_shaketree"),
            distance = 2.5
		},
	}
    coords[4] = vec3(2317.08203125, 4994.1176757812, 42.408882141113)
	size[4] = vec3(0.7, 0.7, 1.0)
	rotation[4] = 162.70980834961
	options[4] = {
        {
			name = "sffarmer-a-2",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				shakeTree(2)
			end,
			icon = 'fa-solid fa-hands-holding',
            label = locale("interaction_shaketree"),
            distance = 2.5
		},
	}
    coords[5] = vec3(2316.3923339844, 5023.5122070312, 43.623603820801)
	size[5] = vec3(0.7, 0.7, 1.0)
	rotation[5] = 257.49438476562
	options[5] = {
        {
			name = "sffarmer-a-4",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				shakeTree(4)
			end,
			icon = 'fa-solid fa-hands-holding',
            label = locale("interaction_shaketree"),
            distance = 2.5
		},
	}
    coords[6] = vec3(2316.8823242188, 5008.7749023438, 42.870666503906)
	size[6] = vec3(0.7, 0.7, 1.0)
	rotation[6] = 147.92961120605
	options[6] = {
        {
			name = "sffarmer-a-3",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "farmer" then
					return true
				end
			end,
			onSelect = function ()
				shakeTree(3)
			end,
			icon = 'fa-solid fa-hands-holding',
            label = locale("interaction_shaketree"),
            distance = 2.5
		},
	}

    exports["sfjob"]:createInteraction(coords[1], size[1], rotation[1], options[1])
    exports["sfjob"]:createInteraction(coords[2], size[2], rotation[2], options[2])
    exports["sfjob"]:createInteraction(coords[3], size[3], rotation[3], options[3])
    exports["sfjob"]:createInteraction(coords[4], size[4], rotation[4], options[4])
    exports["sfjob"]:createInteraction(coords[5], size[5], rotation[5], options[5])
    exports["sfjob"]:createInteraction(coords[6], size[6], rotation[6], options[6])
end)

function shakeTree(id)
    TriggerServerEvent("sffarmer:shakeTree", id)
    lib.progressBar({
        duration = 5000,
        label = locale('progress_shake'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
        },
        anim = {
            dict = 'random@paparazzi@peek',
            clip = 'left_peek_a'
        },
    })
end

function takePlant(entity, type_farm)
    if not mainObject then notificationClient(locale('bag_info')) return end
    if lib.progressBar({
        duration = configs.durationProgress[type_farm],
        label = locale('progress_collect'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
        },
        anim = configs.animProgress[type_farm],
    }) then
        if DoesEntityExist(entity) then
            local plantId = getCorrectId(entity)
            local res = lib.callback.await('sffarmer:takePlant', false, plantId, type_farm)
            if res then
                collected[type_farm] = collected[type_farm] + 1
                objectHand(type_farm)
                if collected[type_farm] == maxCollected[type_farm] then
                    notificationClient(locale('bag_info2'))
                end
            else
                notificationClient(locale('error_collecting'))
            end
        end     
    end
end   

function changeClothes(status)
	if status == "start" then
		-- your function to change your characters into work clothes
	elseif status == "stop" then
		-- your function to dress up your characters in private clothes
	end
end