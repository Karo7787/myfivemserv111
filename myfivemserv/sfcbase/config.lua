local locales = {}
configs = {}
configs.lang = "pl" -- support 'en', 'pl' or your lang
configs.framework = "esx" -- support 'esx', 'qbcore', 'other' !!important!! esx works only with exports["es_extended"]:getSharedObject()
configs.notify = "esx" -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' 
configs.inventory = "ox_inventory" -- support 'ox_inventory' or 'other' !!important!! other need config
configs.devMode = false -- true or false

configs.blip = true
configs.blipSprite = 590
configs.blipScale = 0.7
configs.blipColour = 33
configs.blipText = "Baza"

-- config for interactions
configs.gradeForStashBoss = 9
configs.gradeForStashAll = 3
configs.gradeForStashPriv = 0
configs.gradeForClothesPriv = 0
configs.gradeForClothesBase = 0
configs.gradeForAddClothesPriv = 30
configs.gradeForAddClothesBase = 3
configs.gradeForRemoveClothesBase = 3
configs.gradeForCrafting = 0
configs.gradeForCameraSettings = 9

-- config for stash
configs.stashAll = {
	slots = 50,
	maxWeight = 75000
}

configs.stashBoss = {
	slots = 30,
	maxWeight = 75000
}

configs.stashPriv = {
	slots = 50,
	maxWeight = 75000
}

-- locales
locales.pl = {
	buyInfo = "Zakup bazy",
	buyInfo2 = "Czy na pewno chcesz zakupić baze w tym miejscu?",
	interaction = "Wejdź",
	interaction2 = "Wyjdź",
	interaction3 = "Otwórz szafkę szefa",
	interaction4 = "Otwórz szafkę ogólną",
	interaction5 = "Otwórz szafkę prywatną",
	interaction6 = "Ubrania prywatne",
	interaction7 = "Ubrania organizacji",
	interaction8 = "Dodaj ubranie prywatne",
	interaction9 = "Dodaj ubranie organizacji",
	interaction10 = "Usuń ubranie organizacji",
	interaction11 = "Wytwarzanie",
	interaction12 = "Ustaw kamery",
	cameraInfo = "Ustawienia kamer",
	cameraInfo2 = "Wklej link do webhooka z Discorda:",
	stashInfo = "Szafka prywatna",
	stashInfo2 = "Szafka",
	stashInfo3 = "Szafka szefa",
	error1 = "Ta baza jest już zajęta.",
	error2 = "Link jest niepoprawny.",
}

locales.en = {
	buyInfo = "Purchase base",
	buyInfo2 = "Are you sure you want to purchase the base at this location?",
	interaction = "Enter",
	interaction2 = "Exit",
	interaction3 = "Open boss's locker",
	interaction4 = "Open general locker",
	interaction5 = "Open private locker",
	interaction6 = "Private clothes",
	interaction7 = "Organization clothes",
	interaction8 = "Add private clothes",
	interaction9 = "Add organization clothes",
	interaction10 = "Remove organization clothes",
	interaction11 = "Crafting",
	interaction12 = "Set cameras",
	cameraInfo = "Camera settings",
	cameraInfo2 = "Paste the Discord webhook link:",
	stashInfo = "Private locker",
	stashInfo2 = "Locker",
	stashInfo3 = "Boss's locker",
	error1 = "This base is already occupied.",
	error2 = "The link is invalid.",
}

function notificationClient(text) -- its client side
	if configs.notify == "sfnotify" then
		TriggerEvent('sfnotify', 'info', text)
	end
	if configs.notify == "esx" then
		TriggerEvent('esx:showNotification', text, 'info')
	end
	if configs.notify == "qbcore" then
		TriggerEvent('QBCore:Notify', text, 'primary')
	end
	if configs.notify == "ox_lib" then
		lib.notify({description = text})
	end
	if configs.notify == "other" then
		--print(text)
	end
end

function notificationServer(srcdata, text) -- its server side
	local src = srcdata
	if configs.notify == "sfnotify" then
		TriggerClientEvent('sfnotify', src, 'info', text)
	end
	if configs.notify == "esx" then
		TriggerClientEvent('esx:showNotification', src, text, 'info')
	end
	if configs.notify == "qbcore" then 
		TriggerClientEvent('QBCore:Notify', src, text, 'primary')
	end
	if configs.notify == "ox_lib" then
		TriggerClientEvent('ox_lib:notify', src, {description = text})
	end
	if configs.notify == "other" then
		--TriggerClientEvent('yournotify', src, text)
	end
end

function openStash(id, owner) -- client side
	if configs.inventory == "ox_inventory" then
		exports.ox_inventory:openInventory('stash', {id = id, owner = owner})
	end
	if configs.inventory == "other" then
		-- need config
	end
end

function registerStash(id, label, slots, maxWeight, owner) -- server side
	if owner ~= nil then
		local base_upgrades = MySQL.query.await('SELECT * FROM `crimetab` WHERE `id` = ?', {owner})[1]?.updates
		if base_upgrades then
			for k, v in pairs(json.decode(base_upgrades)) do
				if k == "update-12" and v == "ok" then
					maxWeight = maxWeight + 25000
					slots = slots + 25
				end
				if k == "update-13" and v == "ok" then
					maxWeight = maxWeight + 25000
					slots = slots + 25
				end
			end
		end
	end
	if configs.inventory == "ox_inventory" then
		exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, owner)
	end
	if configs.inventory == "other" then
		-- need config
	end
end

function forceOpenInventory(source, typeInv, id) -- server side
	if configs.inventory == "ox_inventory" then
		exports.ox_inventory:forceOpenInventory(source, typeInv, id)
	end
	if configs.inventory == "other" then
		-- need config
	end
end

-- framework settings --
SFX = nil
if configs.framework == "esx" then
	SFX = exports["es_extended"]:getSharedObject()
end

if configs.framework == "qbcore" then
	SFX = exports['qb-core']:GetCoreObject()
end

if configs.framework == "other" then
	-- need config
end

function getPlayerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local src = idserverplayer
	local data = {}
	if configs.framework == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		if xPlayer then
			data.id = xPlayer.identifier
			data.name = xPlayer.getName()
			return data
		else
			print("error?")
		end
	end
	if configs.framework == "qbcore" then
		local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
		if PlayerData then
			data.id = PlayerData.citizenid
			data.name = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname
			return data
		else
			print("error")
		end
	end
	if configs.framework == "other" then
		-- need config
		data.id = "identifier:character"
		data.name = "Name Surname"
		return data
	end
end

-- dont touch
function locale(name) return locales[configs.lang][name] end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- BASES LIST -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

configs.zones = { -- base zones, if the player leaves the zone, e.g. goes through the wall with an animation, he will find himself in world 0 // strefy baz, jesli gracz opusci strefe np. animacją przejdzie przez sciane to znajdzie sie w świecie 0
    {
        vec(1087.1769, -3095.0437, -39.0),
        vec(1105.6636, -3094.6819, -39.0),
        vec(1106.0476, -3104.0925, -39.0),
        vec(1086.9642, -3103.8188, -39.0)
    },
}

configs.baseList = {
	{ 
		id = 1, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vec4(-193.7025, -1284.6185, 31.3070, 270.9641), -- front door // drzwi wejsciowe
		teleportOut = vec4(-193.2315, -1284.6385, 31.2808, 268.7869), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(1087.3761, -3099.3770, -39.0000, 89.0660), -- exit door // drzwi wyjściowe
		teleportIn = vec4(1088.1659, -3099.3589, -39.0000, 271.9899), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vec4(-189.9637, -1290.7627, 30.8857, 266.5267), -- parking space // miejsce parkingowe
		stashes = vec4(1103.8033, -3103.1650, -39.0000, 180.7935), -- lockers // szafki
		clothes = vec4(1100.9167, -3103.0986, -39.0000, 180.7935), -- changing room // przebieralnia
		crafting = vec4(1105.2385, -3101.9583, -39.0000, 255.3987), -- crafting
     	camera = vec4(1087.9562, -3101.1760, -39.0000, 90.0000), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = false, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--Micheal
	{ 
		id = 2, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vec4(-820.8259, 176.5100, 71.6015, 294.8045), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vec4(-820.4586, 184.3060, 72.1077, 134.4701), -- parking space // miejsce parkingowe
		stashes = vec4(-811.0718, 174.8125, 76.7453, 259.9954), -- lockers // szafki
		clothes = vec4(-811.6029, 176.4877, 76.7453, 347.4383), -- changing room // przebieralnia
		crafting = vec4(-808.7133, 190.4940, 72.4635, 300.3015), -- crafting
     	camera = vec4(-806.7001, 166.9640, 76.5739, 212.4706), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--Vinewood1
	{ 
		id = 3, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-722.96, 489.96, 109.62, 22.77), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-715.65, 496.32, 109.28, 203.64),-- parking space // miejsce parkingowe
		stashes = vector4(-725.81, 497.32, 109.57, 339.24), -- lockers // szafki
		clothes = vector4(-742.7, 504.7, 109.57, 48.35), -- changing room // przebieralnia
		crafting = vector4(-724.86, 507.69, 109.32, 107.46), -- crafting
     	camera = vector4(-734.28, 506.93, 109.57, 71.21), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--GOH Stara Cammora
	{ 
		id = 4, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-2666.67, 1326.07, 147.38, 80.97), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-2662.93, 1307.5, 147.12, 265.44),-- parking space // miejsce parkingowe
		stashes = vector4(-2673.6, 1336.71, 152.02, 316.62), -- lockers // szafki
		clothes = vector4(-2674.05, 1319.09, 152.01, 175.98), -- changing room // przebieralnia
		crafting = vector4(-2679.52, 1327.23, 144.26, 97.68), -- crafting
     	camera = vector4(-2674.0, 1336.19, 144.26, 335.15), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--lafuenta
	{ 
		id = 5, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(1395.26, 1141.94, 114.64, 260.9), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(1396.55, 1117.26, 114.84, 95.79),-- parking space // miejsce parkingowe
		stashes = vector4(1391.56, 1158.79, 114.34, 95.63), -- lockers // szafki
		clothes = vector4(1399.98, 1139.64, 114.34, 270.11), -- changing room // przebieralnia
		crafting = vector4(1403.74, 1150.1, 114.34, 358.33), -- crafting
     	camera = vector4(1394.98, 1160.11, 114.34, 48.47), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--vinewoodnew
	{ 
		id = 6, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-822.75, 802.27, 202.79, 26.72), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-812.73, 808.52, 202.1, 28.93),-- parking space // miejsce parkingowe
		stashes = vector4(-817.95, 802.31, 205.79, 295.58), -- lockers // szafki
		clothes = vector4(-823.19, 802.96, 202.79, 107.56), -- changing room // przebieralnia
		crafting = vector4(-824.7, 805.01, 205.79, 23.41), -- crafting
     	camera = vector4(-826.87, 804.24, 202.79, 206.57), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},

	--GOHv2
	{ 
		id = 7, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-2555.21, 3754.69, 13.42, 266.38), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-2530.4, 3750.77, 13.1, 201.09),-- parking space // miejsce parkingowe
		stashes = vector4(-2566.25, 3754.66, 13.42, 78.83), -- lockers // szafki
		clothes = vector4(-2561.73, 3763.05, 17.03, 79.74), -- changing room // przebieralnia
		crafting = vector4(-2564.97, 3731.86, 13.42, 167.13), -- crafting
     	camera = vector4(-2574.75, 3745.55, 19.29, 265.2), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},

	--winiarnia
	{ 
		id = 8, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-1883.27, 2062.71, 140.98, 169.13), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-1909.05, 2047.37, 140.74, 206.37),-- parking space // miejsce parkingowe
		stashes = vector4(-1870.35, 2059.01, 135.44, 95.12), -- lockers // szafki
		clothes = vector4(-1886.4, 2062.36, 140.98, 157.94), -- changing room // przebieralnia
		crafting = vector4(-1866.59, 2061.19, 135.43, 179.67), -- crafting
     	camera = vector4(-1874.36, 2067.05, 140.98, 250.05), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--mafiapixel
	{ 
		id = 9, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-1805.63, 432.82, 128.66, 87.85), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-1804.7, 455.23, 128.29, 87.72),-- parking space // miejsce parkingowe
		stashes = vector4(-1810.39, 430.15, 127.85, 183.52), -- lockers // szafki
		clothes = vector4(-1809.6, 435.16, 127.85, 2.82), -- changing room // przebieralnia
		crafting = vector4(-1796.69, 439.86, 128.25, 184.1), -- crafting
     	camera = vector4(-1817.09, 447.35, 128.41, 184.23), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--przyplayboyu
	{ 
		id = 10, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(-1571.1, 19.75, 59.58, 78.84), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(-1553.89, 22.84, 58.58, 349.24),-- parking space // miejsce parkingowe
		stashes = vector4(-1583.65, 20.91, 59.58, 80.03), -- lockers // szafki
		clothes = vector4(-1568.54, 19.2, 64.44, 258.13), -- changing room // przebieralnia
		crafting = vector4(-1571.18, 19.08, 59.58, 166.64), -- crafting
     	camera = vector4(-1576.58, 23.07, 59.58, 289.35), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--doki
	{ 
		id = 11, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		doorsIn = vector4(346.68, -2725.21, 1.71, 118.84), -- front door // drzwi wejsciowe
		teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		garage = vector4(321.72, -2728.08, 5.99, 112.11),-- parking space // miejsce parkingowe
		stashes = vector4(344.36, -2708.31, 1.71, 155.35), -- lockers // szafki
		clothes = vector4(336.67, -2710.84, 5.99, 51.96), -- changing room // przebieralnia
		crafting = vector4(357.7, -2721.51, 1.71, 291.91), -- crafting
     	camera = vector4(337.69, -2713.26, 5.99, 280.46), -- place to set the webhook // miejsce ustawiania webhooka
		openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	},
	--{ 
		--id = 6, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		--doorsIn = vector4(-3216.43, 816.33, 8.93, 300.84), -- front door // drzwi wejsciowe
		--teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		--doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		--teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		--garage = vector4(-3213.66, 832.31, 8.93, 211.22),-- parking space // miejsce parkingowe
		--stashes = vector4(-3225.99, 811.41, 8.93, 28.94), -- lockers // szafki
		--clothes = vector4(-3218.97, 810.7, 8.96, 255.26), -- changing room // przebieralnia
		--crafting = vector4(-3224.86, 801.89, 8.93, 219.45), -- crafting
     	--camera = vector4(-3233.51, 813.11, 14.08, 105.98), -- place to set the webhook // miejsce ustawiania webhooka
		--openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	--},
	--{ 
		--id = 7, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		--doorsIn = vector4(-1135.61, 376.55, 71.3, 148.89), -- front door // drzwi wejsciowe
		--teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		--doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		--teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		--garage = vector4(-1128.83, 380.43, 70.72, 246.68),-- parking space // miejsce parkingowe
		--stashes = vector4(-1144.81, 375.32, 74.93, 306.57), -- lockers // szafki
		--clothes = vector4(-1142.08, 375.13, 74.93, 216.16), -- changing room // przebieralnia
		--crafting = vector4(-1138.75, 375.75, 71.31, 328.7), -- crafting
     	--camera = vector4(-1123.38, 361.45, 71.31, 157.26), -- place to set the webhook // miejsce ustawiania webhooka
		--openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	--},
	--{ 
		--id = 8, -- id must be unique and must be a number // id musi byc unikalne i musi być liczbą
		--doorsIn = vector4(-663.0, 944.08, 244.09, 268.4), -- front door // drzwi wejsciowe
		--teleportOut = vec4(0, 0, 0, 0), -- teleport coordinates outside the base // coordy teleportu poza baza
		--doorsOut = vec4(0, 0, 0, 0), -- exit door // drzwi wyjściowe
		--teleportIn = vec4(0, 0, 0, 0), -- teleport coordinates to the base // coordy teleportu do bazy
		--garage = vector4(-686.46, 963.08, 238.74, 30.83),-- parking space // miejsce parkingowe
		--stashes = vector4(-627.88, 948.42, 243.95, 355.57), -- lockers // szafki
		--clothes = vector4(-636.87, 944.26, 243.97, 272.58), -- changing room // przebieralnia
		--crafting = vector4(-658.3, 949.01, 243.95, 86.3), -- crafting
     	--camera = vector4(-640.86, 949.19, 243.95, 2.85), -- place to set the webhook // miejsce ustawiania webhooka
		--openInterior = true, -- if the interior is open, doors In, teleport, doorsOut, teleport Out are not needed // jesli interior jest otwarty to doorsIn, teleportIn, doorsOut, teleportOut nie są potrzebne
	--},


}

exports("GetBases", function()
	local bases = {}
	for k, v in pairs(configs.baseList) do
        bases[k] = v
    end
    return bases
end)