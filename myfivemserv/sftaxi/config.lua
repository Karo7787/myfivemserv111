local locales = {}
configs = {}
configs.framework = 'esx' -- support 'esx', 'other'
configs.lang = 'pl' -- support 'en', 'pl' or your lang
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua), 
configs.inventory = "ox_inventory" -- support 'ox_inventory' or 'other' !!important!! other need config
configs.banking = "sfbanking" -- support 'sfbanking' or 'other' !!important!! other need config 

configs.blip = true
configs.blipSprite = 198
configs.blipScale = 0.9
configs.blipColour = 5
configs.blipText = "Taxi"
configs.blipCoords = vec3(899.9611, -178.9086, 73.8513)

configs.GiveItemToGlovebox = {
	chance = 50,
	items = {
		{ item = "weed_seed_blue_dream", count={ min = 1, max = 2 } },
		{ item = "weed_seed_purple_haze", count={ min = 1, max = 2 } },
		{ item = "weed_seed_skunk", count={ min = 1, max = 2 } },
		{ item = "weed_seed_white_widow", count={ min = 1, max = 2 } }
	}
}

configs.blipSprite_inJob = 280 -- blip for ped
configs.blipColour_inJob = 5 -- for ped

configs.blipSprite_inJob_drive = 280 -- blip for ped delivery point
configs.blipScale_inJob_drive = 0.6 -- for ped delivery point
configs.blipColor_inJob_drive = 5 -- for ped delivery point

configs.bossStash = false -- stash for boss

configs.percentForEmployee = 0.5 -- if set 0 player won't get his cash cut range is 0.0 to 1.0

configs.taxiModels = {
	-- ["spawn_name"] 
	["taxi"] = { costRent = 200 },
	["gbtaxistanierle"] = { costRent = 200 },
}

configs.taxiSpawnCoords = vector4(884.15, -153.93, 69.38, 154.4)

configs.routes = { -- ped delivery points
	vec4(1143.7654, -979.6363, 46.2540, 191.8901),
	vec4(1192.7731, -1453.0189, 35.0207, 289.0484),
	vec4(1023.9814, -2433.7446, 28.5234, 173.6929),
	vec4(-422.0857, -2786.4744, 6.0004, 7.9369),
	vec4(-1014.0587, -2705.3696, 13.7079, 270.2198),
	vec4(-1173.9751, -1772.6355, 3.8491, 155.0249),
	vec4(-1459.6711, -715.7308, 25.0265, 67.1933),
	vec4(-1356.2766, -147.9260, 48.5314, 358.3214),
	vec4(-848.1346, 456.6872, 87.1382, 314.0968),
	vec4(-661.3573, 812.3166, 199.6871, 166.4760),
	vec4(-1120.4752, 2679.2275, 18.4533, 249.1146),
	vec4(1777.4098, 3333.2998, 41.2154, 32.4732),
	vec4(1869.1079, 3918.1975, 32.9706, 241.0813),
	vec4(1691.3009, 4681.7388, 43.0671, 144.3394),
	vec4(1725.9010, 6406.6528, 34.2816, 31.9842),
	-- vec4(-13.3955, 6640.7617, 31.0148, 215.1402),
	-- vec4(-407.6066, 6043.0132, 31.2864, 300.3302),
	vec4(-2198.9873, 4265.9688, 48.2525, 238.4658),
	vec4(-2554.1667, 2322.3386, 33.0604, 221.0794),
	vec4(-3231.9412, 949.4437, 13.3719, 294.3829),
	vec4(-3017.2759, 88.6463, 11.6095, 180.3921),
	vec4(-410.9, 1175.53, 325.64, 257.44),
	vec4(921.32, 50.95, 80.9, 329.74),
	vec4(2564.28, 317.85, 108.46, 265.85)
}

configs.moneyForDistance = 100
configs.waitingForCustomer = 45 -- in sec

configs.setPedIntoVehicle = false -- if the ped is to sit in the vehicle, set it to true
configs.closeVehicleAfterSpawn = false -- if the car is to be closed after creation, set it to true !recommended if setPedIntoVehicle == false

configs.itemMoney = "money"

-- locales
locales.pl = {
	interaction_rent = "Wypożycz auto",
	interaction_rent2 = "Zwróć auto",
	interaction_stopjob = "Zakończ zmianę",
	interaction_startjob = "Rozpocznij zmianę",
	stashBoss = "Szafka właściciela",
	interaction_info = "Informacje o pracy",
	info_about_job = "Aby otrzymać zlecenie wsiądź do taxi i poczekaj na zawiadomienie.",
	nomoney_rent = "Nie stać Cię na wypożyczenie.",
	rent_info = "Pojazd jest za daleko od miejsca parkingowego.",
	rent_info2 = "Nie masz żadnego pojazdu do zwrotu.",
	job_info_1 = "Zawieź mnie do wskazanego miejsca.",
	job_info_2 = "Zakończono zlecenie, oczekuj na kolejne.",
	blip_1 = "# Miejsce dostarczenia klienta",
	clothesPriv = "Ciuchy prywatne",
	clothesJob = "Ciuchy pracownicze",
	addClothesJob = "Dodaj strój pracowniczy",
	removeClothesJob = "Usuń strój pracowniczy",
	pay_reason = "Zapłata za przejazd.",
	pedNotFound = "Nie znaleziono żadnego klienta w pobliżu, udaj się w bardziej zaludnione miejsce.",
}

locales.en = {
    interaction_rent = "Rent a car",
	interaction_rent2 = "Return the car",
	interaction_stopjob = "End shift",
	interaction_startjob = "Start shift",
	stashBoss = "Owner's stash",
	interaction_info = "Work information",
	info_about_job = "To receive a job, get into a taxi and wait for notification.",
	nomoney_rent = "You can't afford to rent.",
	rent_info = "The vehicle is too far from the parking spot.",
	rent_info2 = "You don't have any vehicle to return.",
	job_info_1 = "Take me to the indicated location.",
	job_info_2 = "Job completed, wait for the next one.",
	blip_1 = "# Customer delivery location",
	clothesPriv = "Private clothes",
	clothesJob = "Work clothes",
	addClothesJob = "Add work attire",
	removeClothesJob = "Remove work attire",
	pay_reason = "Fare payment.",
	pedNotFound = "No customers found nearby, go to a more populated area.",
}

function notificationClient(text, text2) -- its client side
	if text2 ~= nil then text = text..text2 end
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

function notificationServer(srcdata, text, text2) -- its server side
	if text2 ~= nil then text = text..text2 end
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

function searchItemClient(itemname) -- its client side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
	end
	if configs.inventory == "other" then 
		-- you need config this
	end
end

function searchItemServer(srcdata, itemname, metadata) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Search(srcdata, 'count', itemname, metadata)
	end
	if configs.inventory == "other" then 
		-- you need config this
	end
end

function removeItemServer(srcdata, itemname, amount) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:RemoveItem(srcdata, itemname, amount)
	end
	if configs.inventory == "other" then 
		-- you need config this
	end
end

function giveItemServer(srcdata, itemname, amount, metadata) -- its server side
	if configs.inventory == "ox_inventory" then 
		exports.ox_inventory:AddItem(srcdata, itemname, amount, metadata, slot, cb)
	end
	if configs.inventory == "other" then 
		-- you need config this
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

function getPlayerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only value.
	local src = idserverplayer
	local data = {}
	if configs.framework == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		if xPlayer then
			data.name = xPlayer.getName()
			return data
		else
			print("error")
			return false
		end
	end
	if configs.framework == "qbcore" then
		local xPlayer = SFX.Functions.GetPlayer(src)
		if xPlayer and xPlayer.PlayerData then
			data.name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
			return data
		else
			print("error")
			return false
		end
	end
	if configs.framework == "other" then
		-- need config
		data.name = "Max Tester"
		return data
	end
end

---------- banking ----------
function getAccountBankJob(id_job) -- its server side
	if configs.banking == "sfbanking" then
		local result = exports["sfbanking"]:getNumberBankFromId("job:"..id_job)
		if result then
			return result
		else
			return false -- not found job account
		end
	end
	if configs.banking == "other" then
		-- you need config this
		return false
	end
end

function addMoneyForJob(bank_number, amount, reason, srcdata) -- its server side
	if configs.banking == "sfbanking" then
		return exports["sfbanking"]:addMoneyForPlayer(bank_number, amount, reason, srcdata)
	end
	if configs.banking == "other" then
		-- you need config this
		return 0
	end
end
---------- end banking ----------

-- dont touch
function locale(name) return locales[configs.lang][name] end