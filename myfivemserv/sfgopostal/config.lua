local locales = {}
configs = {}
configs.framework = 'esx' -- support 'esx', 'other'
configs.lang = 'pl' -- support 'en', 'pl' or your lang
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua), 
configs.inventory = "ox_inventory" -- support 'ox_inventory' or 'other' !!important!! other need config

configs.blip = true
configs.blipSprite = 477
configs.blipScale = 0.9
configs.blipColour = 26
configs.blipText = "GoPostal"

configs.blipSprite_inJob = 541
configs.blipScale_inJob = 0.7
configs.blipColour_inJob = 27

configs.amountPacksForJob = 5

configs.coordsDelivery = {
	{ coords = vec4(-590.9418, -892.5778, 25.9242, 269.7235), amountMoney = 850, },
	{ coords = vec4(465.9013, -1673.1174, 29.5085, 242.9907), amountMoney = 1200, },
	{ coords = vec4(204.9935, -1828.3406, 28.4563, 139.6575), amountMoney = 1000, },
	{ coords = vec4(2545.31, 2592.04, 37.96, 108.71), amountMoney = 1800, },
	{ coords = vec4(911.02, 3644.84, 32.68, 185.53), amountMoney = 1400, },
	{ coords = vec4(-201.72, 6354.34, 31.49, 223.21), amountMoney = 2200, },
	{ coords = vec4(-315.51, 6193.96, 31.56, 45.16), amountMoney = 2500, },
	{ coords = vec4(-1256.52, -1079.84, 8.39, 330.62), amountMoney = 1200, },
	{ coords = vec4(1138.99, -962.68, 47.53, 332.03), amountMoney = 1000, },
}

configs.durationProgress = {} -- in ms
configs.durationProgress['takePack'] = 5000
configs.durationProgress['dropPack'] = 5000

configs.costForRentCar = 200
configs.setPedIntoVehicle = false -- if the ped is to sit in the vehicle, set it to true
configs.closeVehicleAfterSpawn = false -- if the car is to be closed after creation, set it to true !recommended if setPedIntoVehicle == false

configs.itemMoney = "money"

-- locales
locales.pl = {
	interaction_rent = "Wypożycz auto",
	interaction_rent2 = "Zwróć auto",
	interaction_stopjob = "Zakończ zmianę",
	interaction_startjob = "Rozpocznij zmianę",
	interaction_getJob = "Weź zlecenie",
	interaction_collectMoney = "Odbierz wynagrodzenie",
	interaction_dropPack = "Odłóż paczkę",
	interaction_car = "Odłóż paczkę",
	interaction_car2 = "Weź paczkę",
	nomoney_rent = "Nie stać Cię na wypożyczenie.",
	collecting_info = "Dzięki za dostawę. Jedź do bazy odebrać wynagrodzenie.",
	collecting_info2 = "Otrzymałeś zlecenie, zawieź paczki do wskazanego miejsca na GPS.",
	progress_collect = "Wyciąganie paczki",
	progress_deposit = "Odkładanie paczki",
	rent_info = "Pojazd jest za daleko od miejsca parkingowego.",
	rent_info2 = "Nie masz żadnego pojazdu do zwrotu.",
	blip_1 = "# Miejsce dostawy",
}

locales.en = {
    interaction_rent = "Rent a car",
	interaction_rent2 = "Return the car",
	interaction_stopjob = "End shift",
	interaction_startjob = "Start shift",
	interaction_getJob = "Take job",
	interaction_collectMoney = "Collect payment",
	interaction_dropPack = "Put down the package",
	interaction_car = "Put down the package",
	interaction_car2 = "Pick up the package",
	nomoney_rent = "You can't afford to rent.",
	collecting_info = "Thanks for the delivery. Go to the base to collect your payment.",
	collecting_info2 = "You've received a job, deliver the packages to the indicated location on GPS.",
	progress_collect = "Collecting package",
	progress_deposit = "Depositing package",
	rent_info = "The vehicle is too far from the parking spot.",
	rent_info2 = "You don't have any vehicle to return.",
	blip_1 = "# Delivery location",
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

-- dont touch
function locale(name) return locales[configs.lang][name] end