local locales = {}
configs = {}
configs.framework = 'esx' -- support 'esx', 'other'
configs.lang = 'pl' -- support 'en', 'pl' or your lang
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua), 
configs.inventory = "ox_inventory" -- support 'ox_inventory' or 'other' !!important!! other need config

configs.blip = true
configs.blipSprite = 85
configs.blipScale = 0.9
configs.blipColour = 69
configs.blipText = "Farmer"

configs.blipSprite_inJob = 540
configs.blipScale_inJob = 0.7
configs.blipColour_inJob = 24

configs.vegetableGrowingTime = 300 -- in seconds
configs.sellItemsCoords = vector4(158.5, -2928.24, 7.24, 268.78) -- cooords for selling items

configs.maxAmountHarvested = {}
configs.maxAmountHarvested['cabbage'] = 4 -- 2/4/6/8/10/12/14/16/[..]
configs.maxAmountHarvested['eggplant'] = 6 -- 3/6/9/12/15/[..]
configs.maxAmountHarvested['apple'] = 10 -- 10/20/30/40/[..]

configs.durationProgress = {} -- in ms
configs.durationProgress['cabbage'] = 6000
configs.durationProgress['eggplant'] = 3000
configs.durationProgress['apple'] = 3000
configs.durationProgress['puttingoff'] = 5000

configs.costForRentCar = 200
configs.setPedIntoVehicle = false -- if the ped is to sit in the vehicle, set it to true
configs.closeVehicleAfterSpawn = false -- if the car is to be closed after creation, set it to true !recommended if setPedIntoVehicle == false

configs.itemsReceived = {}
configs.itemsReceived['cabbage'] = "farm_cabbage"
configs.itemsReceived['eggplant'] = "farm_eggplant"
configs.itemsReceived['apple'] = "farm_apple"

configs.priceForItem = {} -- price for 1 piece
configs.priceForItem['farm_cabbage'] = 100
configs.priceForItem['farm_eggplant'] = 100
configs.priceForItem['farm_apple'] = 75

configs.itemMoney = "money"

configs.animProgress = {}
configs.animProgress['cabbage'] = {
	dict = 'amb@world_human_gardener_plant@male@base',
	clip = 'base',
	flag = 11,
}
configs.animProgress['eggplant'] = {
	dict = 'missheist_agency2aig_13',
	clip = 'pickup_briefcase_upperbody',
}
configs.animProgress['apple'] = {
	dict = 'missheist_agency2aig_13',
	clip = 'pickup_briefcase_upperbody',
}

-- locales
locales.pl = {
	interaction_rent = "Wypożycz auto",
	interaction_rent2 = "Zwróć auto",
	interaction_stopjob = "Zakończ zmianę",
	interaction_startjob = "Rozpocznij zmianę",
	interaction_sellitems = "Sprzedaj produkty",
	interaction_shaketree = "Potrząśnij drzewem",
	interaction_collect = "Zbierz",
	interaction_car = "Odłóż zbiory",
	interaction_car2 = "Odłóż kosz",
	interaction_car3 = "Weź kosz",
	nomoney_rent = "Nie stać Cię na wypożyczenie.",
	noproducts_sell = "Nie masz odpowiedniej ilości produktów przy sobie.",
	collecting_info = "Wystarczy zbierania, udaj się sprzedać zbiory.",
	collecting_info2 = "Wystarczy zbierania na tym polu, udaj się na następne.",
	progress_shake = "Trzęsienie drzewem",
	progress_collect = "Zbieranie",
	progress_deposit = "Odkładanie",
	bag_info = "Nie masz kosza, do czego chcesz zbierać?",
	bag_info2 = "Kosz jest pełny, odłóż zbiory do auta.",
	sell_info = "Dzięki! Masz tu swoje wynagrodzenie. Teraz udaj się ponownie na farme.",
	rent_info = "Pojazd jest za daleko od miejsca parkingowego.",
	rent_info2 = "Nie masz żadnego pojazdu do zwrotu.",
	shakeTree_info = "Niestety nic nie spada z drzewa.",
	blip_1 = "# Zbiór bakłażanów",
	blip_2 = "# Zbiór kapusty",
	blip_3 = "# Zbiór jabłek",
	blip_4 = "# Sprzedaż zebranych produktów",
	error_collecting = "Niestety nic nie zebrałeś."
}

locales.en = {
    interaction_rent = "Rent a car",
    interaction_rent2 = "Return the car",
    interaction_stopjob = "End shift",
    interaction_startjob = "Start shift",
    interaction_sellitems = "Sell products",
    interaction_shaketree = "Shake tree",
    interaction_collect = "Collect",
    interaction_car = "Deposit harvest",
    interaction_car2 = "Deposit basket",
    interaction_car3 = "Take basket",
    nomoney_rent = "You can't afford to rent.",
    noproducts_sell = "You don't have enough products with you.",
    collecting_info = "Enough harvesting, go sell your harvest.",
    collecting_info2 = "Enough harvesting on this field, move to the next one.",
    progress_shake = "Shaking tree",
    progress_collect = "Collecting",
	progress_deposit = "Putting aside",
    bag_info = "You don't have a basket, what do you want to collect with?",
    bag_info2 = "The basket is full, deposit the harvest into the car.",
    sell_info = "Thank you! Here's your payment. Now head back to the farm.",
    rent_info = "The vehicle is too far from the parking spot.",
    rent_info2 = "You don't have any vehicle to return.",
    shakeTree_info = "Unfortunately, nothing falls from the tree.",
	blip_1 = "# Eggplant Harvest",
	blip_2 = "# Cabbage Harvest",
	blip_3 = "# Apple Harvest",
	blip_4 = "# Sale of harvested products",
	error_collecting = "Unfortunately you didn't collect anything."
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