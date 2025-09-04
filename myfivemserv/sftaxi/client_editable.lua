local coords = {}
local size = {}
local rotation = {}
local options = {}

CreateThread(function()   
    coords[1] = vec3(905.84, -154.84, 74.22)
	size[1] = vec3(1.3, 0.8, 2.0)
	rotation[1] = 58.0
	options[1] = {
        {
			name = "sftaxi-rent-car",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" then
					return true
				end
			end,
			onSelect = function ()
				rentCar('taxi')
			end,
			icon = 'fa-solid fa-car',
			label = locale("interaction_rent").." ("..configs.taxiModels['taxi'].costRent.."$)",
            distance = 2.5
		},
		{
			name = "sftaxi-rent-car2",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" then
					return true
				end
			end,
			onSelect = function ()
				rentCar('gbtaxistanierle')
			end,
			icon = 'fa-solid fa-car',
			label = locale("interaction_rent").." ("..configs.taxiModels['gbtaxistanierle'].costRent.."$)",
            distance = 2.5
		},
        {
			name = "sftaxi-back-car",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" and rentedCar then
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
			name = "sftaxi-sluzba-zejdz",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" then
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
			name = "sftaxi-sluzba-wejdz",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "unemployed" and checkPermissions("taxi") then
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
        {
			name = "sftaxi-zlecenie",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" and not jobActive then
					return true
				end
			end,
			onSelect = function ()
				notificationClient(locale('info_about_job'))
			end,
			icon = 'fa-solid fa-circle-info',
			label = locale("interaction_info"),
            distance = 2.5
		},
		{
			name = "sftaxi-przebieralnia",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" then
					return true
				end
			end,
			onSelect = function ()
				changeClothes("private")
			end,
			icon = 'fa-solid fa-shirt',
			label = locale("clothesPriv"),
		},
		{
			name = "sftaxi-przebieralnia-robocze",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == "taxi" then
					return true
				end
			end,
			onSelect = function ()
				changeClothes("job")
			end,
			icon = 'fa-solid fa-shirt',
			label = locale("clothesJob"),
		},
	}
	coords[2] = vec3(896.9961, -175.6220, 74.4995)
	size[2] = vec3(1.0, 0.8, 1.3)
	rotation[2] = 60.0
	options[2] = {
		{
			name = "sftaxi-boss-stash",
			canInteract = function(entity, distance, coords, name)
				if exports["sfjob"]:getActiveJob() == 'taxi' and exports["sfjob"]:getActiveJobGrade() >= 9 and configs.bossStash then
					return true
				end
			end,
			onSelect = function ()
				openBossStash()
			end,
			icon = 'fa-solid fa-box',
			label = locale("stashBoss"),
			distance = 3.0
		},
	}
    exports["sfjob"]:createInteraction(coords[1], size[1], rotation[1], options[1])
	if configs.bossStash then
		exports["sfjob"]:createInteraction(coords[2], size[2], rotation[2], options[2])
	end
end)

function changeClothes(action) -- its client side
	if action == "addClothesForJob" then -- adding clothes in the work cabinet
		-- you need config this
	end
	if action == "deleteClothesForJob" then -- deleting clothes in the work cabinet
		-- you need config this
	end
	if action == "private" then -- private cabinet with clothes
		-- you need config this
	end
	if action == "job" then -- work cabinet with clothes
		-- you need config this
	end
end