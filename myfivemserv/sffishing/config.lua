local locales = {}
configs = {}
configs.lang = 'pl' -- support 'en', 'pl' or your lang
configs.framework = 'esx' -- support 'esx', 'qbcore', 'other' -- other need config 
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua), 
configs.inventory = 'ox_inventory' -- support 'ox_inventory', 'qs-inventory', or 'other' !!important!! other need config. 'qs-inventory' untested

configs.blipsFishingPlace = true
configs.blipSpriteFishingPlace = 68
configs.blipScaleFishingPlace = 0.7
configs.blipColourFishingPlace = 0

configs.blipsFishingSell = true
configs.blipSpriteFishingSell = 52
configs.blipScaleFishingSell = 0.7
configs.blipColourFishingSell = 29
configs.coordsFishingSell = vec4(-1499.69, -933.03, 10.18, 140.86)

configs.needLicense = true -- true or false
configs.licenseId = "fishing_card" -- fishing card license id

configs.wormInPack = 25 -- how many worms the player should receive after using the worm box

configs.radomTimeFishingMin = 5 -- min waiting time for catching a fish in seconds // radomTimeFishingMin > 0
configs.radomTimeFishingMax = 10 -- max waiting time for catching a fish in seconds // radomTimeFishingMax > radomTimeFishingMin

configs.rentBoatForFishing = true
configs.coordsInteractionRentBoat = vec4(-1605.2463, 5256.6299, 2.0756, 302.6073)
configs.priceForRentBoat = 200
configs.modelRentBoat = "dinghy"
configs.spawnRentBoat = vec4(-1602.3873, 5260.7622, 0.1196, 25.3564)

configs.devMode = false

configs.levelPlace = {}
configs.levelPlace['pier'] = 0
configs.levelPlace['alamosea'] = 5
configs.levelPlace['cassidy'] = 10
configs.levelPlace['vinewood'] = 15
configs.levelPlace['damlake'] = 20
configs.levelPlace['ocean'] = 25

configs.zones = {
	pier = {
		blip = vec3(-1847.6647, -1250.2661, 8.6148),
		points = {
			vec(-1866.2253, -1237.6284, 9.0),
			vec(-1860.3474, -1230.6854, 9.0),
			vec(-1820.0255, -1264.3457, 9.0),
			vec(-1826.3176, -1271.1311, 9.0),
		},
		thickness = 3.0
	},
	alamosea = {
		blip = vec3(1523.8684, 3916.8906, 31.6789),
		points = {
			vec(1481.1219, 3958.1570, 32.0),
			vec(1465.2335, 3917.7554, 32.0),
			vec(1598.2128, 3852.3250, 32.0),
			vec(1624.3558, 3913.5000, 32.0),
		},
		thickness = 5.0
	},
	cassidy = {
		blip = vec3(-653.2263, 4406.8369, 16.9357),
		points = {
			vec(-558.2723, 4416.9858, 18.0),
			vec(-572.1439, 4385.5088, 18.0),
			vec(-760.6814, 4420.0073, 18.0),
			vec(-779.2716, 4446.8706, 18.0),
		},
		thickness = 7.0
	},
	vinewood = {
		blip = vec3(-193.1359, 791.3118, 198.1074),
		points = {
			vec(-117.7344, 768.3693, 197.0),
			vec(-145.1248, 791.9507, 197.0),
			vec(-182.6643, 804.5111, 197.0),
			vec(-200.7906, 824.2653, 197.0),
			vec(-235.2772, 793.9298, 197.0),
			vec(-147.9840, 730.1023, 197.0),
		},
		thickness = 4.0
	},
	damlake = {
		blip = vec3(1902.5231, 257.2974, 161.4383),
		points = {
			vec(1911.1228, 328.4314, 163.0),
			vec(1943.5974, 326.8988, 163.0),
			vec(1930.4757, 233.6930, 163.0),
			vec(1872.8610, 192.9230, 163.0),
			vec(1870.2466, 210.0108, 163.0),
			vec(1845.5741, 210.8648, 163.0),
		},
		thickness = 5.0
	},
	ocean = {
		blip = vec3(-1543.7336, 5868.1426, 10.9509),
		points = {
			vec(-1529.1721, 6180.6650, 4.0),
			vec(-1186.6193, 6023.9834, 4.0),
			vec(-1431.0909, 5494.4609, 4.0),
			vec(-1959.3368, 5794.7642, 4.0),
		},
		thickness = 15.0
	},
}

configs.fishingSell = { -- price per fish
	fish_pier_1 = 25,
	fish_pier_2 = 30,
	fish_pier_3 = 30,
	fish_pier_4 = 30,
	fish_pier_5 = 45,
	fish_pier_6 = 25,
	fish_pier_7 = 30,
	fish_pier_8 = 30,
	fish_pier_9 = 30,
	fish_pier_10 = 45,
	fish_alamosea_1 = 25,
	fish_alamosea_2 = 30,
	fish_alamosea_3 = 30,
	fish_alamosea_4 = 30,
	fish_alamosea_5 = 40,
	fish_alamosea_6 = 25,
	fish_alamosea_7 = 30,
	fish_alamosea_8 = 30,
	fish_alamosea_9 = 30,
	fish_alamosea_10 = 45,
	fish_cassidy_1 = 25,
	fish_cassidy_2 = 30,
	fish_cassidy_3 = 30,
	fish_cassidy_4 = 30,
	fish_cassidy_5 = 35,
	fish_cassidy_6 = 30,
	fish_cassidy_7 = 30,
	fish_cassidy_8 = 30,
	fish_cassidy_9 = 30,
	fish_cassidy_10 = 45,
	fish_vinewood_1 = 30,
	fish_vinewood_2 = 30,
	fish_vinewood_3 = 30,
	fish_vinewood_4 = 30,
	fish_vinewood_5 = 40,
	fish_vinewood_6 = 30,
	fish_vinewood_7 = 30,
	fish_vinewood_8 = 30,
	fish_vinewood_9 = 30,
	fish_vinewood_10 = 45,
	fish_damlake_1 = 30,
	fish_damlake_2 = 30,
	fish_damlake_3 = 30,
	fish_damlake_4 = 30,
	fish_damlake_5 = 40,
	fish_damlake_6 = 30,
	fish_damlake_7 = 30,
	fish_damlake_8 = 30,
	fish_damlake_9 = 30,
	fish_damlake_10 = 45,
	fish_ocean_1 = 30,
	fish_ocean_2 = 30,
	fish_ocean_3 = 30,
	fish_ocean_4 = 40,
	fish_ocean_5 = 50,
	fish_ocean_6 = 60,
	fish_ocean_7 = 30,
	fish_ocean_8 = 30,
	fish_ocean_9 = 30,
	fish_ocean_10 = 40,
	fish_ocean_11 = 40,
	fish_ocean_12 = 60,
}

-- 100 exp = 1 lvl
configs.fishList = {}
configs.fishList["pier"] = {
	{ item = 'fish_pier_1', rod = 1, exp = 2, chance = 40 },
	{ item = 'fish_pier_2', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_pier_3', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_pier_4', rod = 1, exp = 3, chance = 15 },
	{ item = 'fish_pier_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 1, exp = 4, chance = 1 },
	{ item = 'fish_pier_6', rod = 2, exp = 2, chance = 40 },
	{ item = 'fish_pier_7', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_pier_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_pier_9', rod = 2, exp = 3, chance = 10 },
	{ item = 'fish_pier_10', rod = 2, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 2, exp = 4, chance = 1 },
}
configs.fishList["alamosea"] = {
	{ item = 'fish_alamosea_1', rod = 1, exp = 2, chance = 30 },
	{ item = 'fish_alamosea_2', rod = 1, exp = 3, chance = 25 },
	{ item = 'fish_alamosea_3', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_alamosea_4', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_alamosea_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 1, exp = 4, chance = 1 },
	{ item = 'fish_alamosea_6', rod = 2, exp = 2, chance = 35 },
	{ item = 'fish_alamosea_7', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_alamosea_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_alamosea_9', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_alamosea_10', rod = 2, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 2, exp = 4, chance = 1 },
}
configs.fishList["cassidy"] = {
	{ item = 'fish_cassidy_1', rod = 1, exp = 2, chance = 30 },
	{ item = 'fish_cassidy_2', rod = 1, exp = 3, chance = 25 },
	{ item = 'fish_cassidy_3', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_cassidy_4', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_cassidy_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 1, exp = 4, chance = 1 },
	{ item = 'fish_cassidy_6', rod = 2, exp = 2, chance = 35 },
	{ item = 'fish_cassidy_7', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_cassidy_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_cassidy_9', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_cassidy_10', rod = 2, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 2, exp = 4, chance = 1 },
}
configs.fishList["vinewood"] = {
	{ item = 'fish_vinewood_1', rod = 1, exp = 2, chance = 30 },
	{ item = 'fish_vinewood_2', rod = 1, exp = 3, chance = 25 },
	{ item = 'fish_vinewood_3', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_vinewood_4', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_vinewood_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 1, exp = 4, chance = 1 },
	{ item = 'fish_vinewood_6', rod = 2, exp = 2, chance = 35 },
	{ item = 'fish_vinewood_7', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_vinewood_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_vinewood_9', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_vinewood_10', rod = 2, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 2, exp = 4, chance = 1 },
}
configs.fishList["damlake"] = {
	{ item = 'fish_damlake_1', rod = 1, exp = 2, chance = 30 },
	{ item = 'fish_damlake_2', rod = 1, exp = 3, chance = 25 },
	{ item = 'fish_damlake_3', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_damlake_4', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_damlake_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 1, exp = 4, chance = 1 },
	{ item = 'fish_damlake_6', rod = 2, exp = 2, chance = 35 },
	{ item = 'fish_damlake_7', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_damlake_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_damlake_9', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_damlake_10', rod = 2, exp = 4, chance = 4 },
	{ item = 'mussle', rod = 2, exp = 4, chance = 1 },
}
configs.fishList["ocean"] = {
	{ item = 'fish_ocean_1', rod = 1, exp = 2, chance = 40 },
	{ item = 'fish_ocean_2', rod = 1, exp = 3, chance = 20 },
	{ item = 'fish_ocean_3', rod = 1, exp = 4, chance = 20 },
	{ item = 'fish_ocean_4', rod = 1, exp = 4, chance = 12 },
	{ item = 'fish_ocean_5', rod = 1, exp = 4, chance = 4 },
	{ item = 'fish_ocean_6', rod = 1, exp = 5, chance = 3 },
	{ item = 'mussle', rod = 1, exp = 5, chance = 1 },
	{ item = 'fish_ocean_7', rod = 2, exp = 2, chance = 40 },
	{ item = 'fish_ocean_8', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_ocean_9', rod = 2, exp = 3, chance = 20 },
	{ item = 'fish_ocean_10', rod = 2, exp = 4, chance = 12 },
	{ item = 'fish_ocean_11', rod = 2, exp = 5, chance = 4 },
	{ item = 'fish_ocean_12', rod = 2, exp = 6, chance = 3 },
	{ item = 'mussle', rod = 2, exp = 6, chance = 1 },
}

-- locales
locales.pl = {
	blipTextFishingPlace = "Łowisko",
	blipTextFishingSell = "Sprzedaż ryb",
	gpsInfo = "Ustawiono lokalizacje GPS.",
	interactionSellFish = "Sprzedaj ryby",
	cannotFishingHere = "Nie możesz tutaj łowić.",
	haventFishBait = "Nie masz przy sobie przynęty.",
	haventLicense = "Nie masz licencji.",
	haventLevel = "Nie możesz tutaj łowić, twoje doświadczenie jest zbyt małe.",
	fishEnding = "Kończysz łowienie.",
	infoKeymap = "Zakończ łowienie",
	fishEscaped = "Ryba spadła z haczyka.",
	levelUp = "Zdobyłeś",
	levelUp2 = "level.",
	noItemsForSell = "Nie masz nic interesującego.",
	interactionRentBoat = "Wypożycz łódź",
	interactionRentBoat2 = "Zwróć łódź",
	infoBackBoat = "Nie masz łódzi do zwrócenia.",
	infoBackBoat2 = "Łódź jest za daleko.",
	infoBackBoat3 = "Brak miejsca aby wypożyczyć łódź.",
	noMoney = "Nie stać Cię na wypożyczenie łodzi.",
	-- update 30.05
	wait = "Odczekaj chwilę.",
}

locales.en = {
	blipTextFishingPlace = "Fishing Spot",
	blipTextFishingSell = "Sell Fish",
	gpsInfo = "GPS location set.",
	interactionSellFish = "Sell Fish",
	cannotFishingHere = "You cannot fish here.",
	haventFishBait = "You don't have bait with you.",
	haventLicense = "You don't have a license.",
	haventLevel = "You cannot fish here, your experience is too low.",
	fishEnding = "Ending fishing.",
	infoKeymap = "End Fishing",
	fishEscaped = "The fish escaped from the hook.",
	levelUp = "You have leveled up to",
	levelUp2 = "level.",
	noItemsForSell = "You have nothing interesting.",
	interactionRentBoat = "Rent a boat",
	interactionRentBoat2 = "Return the boat",
	infoBackBoat = "You don't have a boat to return.",
	infoBackBoat2 = "The boat is too far away.",
	infoBackBoat3 = "No place to rent a boat.",
	noMoney = "You can't afford to rent a boat.",
	-- update 30.05
	wait = "Wait a moment.",
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
		print(text)
	end
end

function getItemList() -- its client side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Items()
	end
	if configs.inventory == "qs-inventory" then 
		return exports['qs-inventory']:GetItemList()
	end
	if configs.inventory == "other" then 
		-- you need config this
	end
end

function searchItemClient(itemname) -- its client side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
	end
	if configs.inventory == "qs-inventory" then 
		return exports['qs-inventory']:Search(itemname)
	end
	if configs.inventory == "other" then 
		-- you need config this
	end
end

-- animations
function TabletIn() TabletPlayAnim('show') end
function TabletOut() TabletPlayAnim('hide') end

-- dont touch
function locale(name) return locales[configs.lang][name] end