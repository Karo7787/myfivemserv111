local locales = {}
local lang = 'pl' -- support 'en', 'pl' or your lang

configs = {}
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua),
configs.inventory = 'ox_inventory' -- support 'ox_inventory' or 'other' !!important!! other need config

configs.obejectsModel = "prop_pot_plant_05b"
configs.timeGrow = 60 -- cooldown - time it takes for new leaves to grow (in seconds)
configs.obejectsModelBarrel = "prop_rad_waste_barrel_01"

configs.devMode = false -- true need for /createcokeprop and /createbarrelprop

-- locales
locales.pl = {
	devInfo = "Skopiowano do schowka.",
	interaction = "Zerwij liście",
	interaction2 = "Zbierz kryształ",
	interaction3 = "Wejdź",
	interaction4 = "Wyjdź",
	interaction5 = "Połącz składniki",
	interaction6 = "Zapakuj 1g",
	interaction7 = "Zapakuj w zabawkę",
	progress = "Ścinanie",
	progress2 = "Zbieranie",
	progress3 = "Wytwarzanie",
	progress4 = "Pakowanie",
	progress5 = "Pakowanie",
	noitems = "Nie masz przy sobie potrzebnych przedmiotów.",
	noleaves = "Nie ma czego zrywać.",
	nocrystal = "Nie ma czego zbierać.",
}

locales.en = {
    devInfo = "Copied to clipboard.",
	interaction = "Harvest leaves",
	interaction2 = "Collect crystal",
	interaction3 = "Enter",
	interaction4 = "Exit",
	interaction5 = "Combine ingredients",
	interaction6 = "Pack 1g",
	interaction7 = "Pack in toy",
	progress = "Cutting",
	progress2 = "Collecting",
	progress3 = "Crafting",
	progress4 = "Packing",
	progress5 = "Packing",
	noitems = "You don't have the necessary items with you.",
	noleaves = "There's nothing to harvest.",
	nocrystal = "There's nothing to collect.",
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
		--TriggerEvent('yournotify', text)
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

function searchItemServer(srcdata, itemname) -- its server side
	if configs.inventory == "ox_inventory" then
		return exports.ox_inventory:Search(srcdata, 'count', itemname)
	end
	if configs.inventory == "other" then
		-- you need config this
        return 0
	end
end

function removeItemServer(srcdata, itemname, amount) -- its server side
	if configs.inventory == "ox_inventory" then
		return exports.ox_inventory:RemoveItem(srcdata, itemname, amount)
	end
	if configs.inventory == "other" then
        -- you need config this
		return false
	end
end

function addItemServer(srcdata, itemname, amount) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:AddItem(srcdata, itemname, amount)
	end
	if configs.inventory == "other" then
        -- you need config this
		return false
	end
end

-- dont touch
function locale(name) return locales[lang][name] end