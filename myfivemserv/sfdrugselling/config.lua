local locales = {}
local lang = 'pl' -- support 'en', 'pl' or your lang

configs = {}
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' 
configs.inventory = 'ox_inventory' -- support 'ox_inventory' or 'other' !!important!! other need config

configs.debugPlaces = false

configs.policeOnDuty = 2
configs.chancePedCallToPolice = 0.50 -- 0.0 to 1.0
configs.chancePedWantBuyDrugs = 0.80 -- 0.0 to 1.0

configs.itemsForSell = {
	['joint_purple_haze'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		}
	},
	['joint_skunk'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		} 
	},
	['joint_blue_dream'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		} 
	},
	['joint_lemon_haze'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		}
	},
	['joint_og_kush'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		} 
	},
	['joint_white_widow'] = { 
		money = { 250, 500 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		}
	},
	['meth_high_plot'] = { 
		money = { 1100, 1400 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			}
		}
	},
	['coke_toy'] = { 
		money = { 400, 800 }, 
		amount = { 1, 3 },
		items = {
			{
				item = "zabawkauwu",
				chance = 0.5,
				amount = { 1, 1 }
			},
			{
				item = "klucze_do_krypto",
				chance = 0.2,
				amount = { 1, 1 }
			}

		}
	},
}

configs.itemMoney = 'money' -- or something, maybe black_money?

configs.sellingEverywhere = true -- if you set it to true you will be able to sell anywhere

configs.propSell = true -- true or false
configs.propModelDrugs = "prop_weed_bottle"
configs.propModelMoney = "hei_prop_heist_cash_pile"

configs.placeForSelling = {} -- places to selling drugs
configs.placeForSelling["pier"] = { 
	vec(-2072.0554, -449.8498, 10.0),
	vec(-1550.1324, -898.8205, 10.0),
	vec(-1423.9200, -1005.3950, 10.0),
	vec(-1352.3180, -1115.8792, 10.0),
	vec(-1353.2247, -1224.0740, 10.0),
	vec(-1287.6805, -1401.0131, 10.0),
	vec(-1069.6326, -1708.7994, 10.0),
	vec(-1287.0865, -1798.6689, 10.0),
	vec(-2161.1628, -549.8979, 10.0),
}

-- locales
locales.pl = {
	interaction_ped = "Porozmawiaj",
	amount_input = "Wybierz kwotę",
	no_police = "Brak wystarczającej ilości jednostek PD na służbie.",
	too_much_money = "Za drogo, nie wezmę...",
	ped_left = "Klient odszedł.",
	ped_left_police = "Klient odszedł i zadzwonił po policje.",
}

locales.en = {
	interaction_ped = "Talk",
	amount_input = "Choose amount",
	no_police = "Not enough PD units on duty.",
	too_much_money = "Too expensive, I won't take it...",
	ped_left = "Customer left.",
	ped_left_police = "Customer left and called the police.",
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

function searchItemClient(itemname) -- its client side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
	end
	if configs.inventory == "other" then 
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

function searchItemServer(srcdata, itemname, metadata) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:Search(srcdata, 'count', itemname, metadata)
	end
	if configs.inventory == "other" then
        -- you need config this
		return false
	end
end

-- dont touch
function locale(name) return locales[lang][name] end