local locales = {}
local lang = 'pl' -- support 'en', 'pl' or your lang

configs = {}
configs.notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua),
configs.inventory = 'ox_inventory' -- support 'ox_inventory' or 'other' !!important!! other need config

configs.debugPlaces = false
configs.plantingEverywhere = false -- if you set it to true you will be able to plant anywhere
configs.checkingToNearOtherObject = false -- checking whether an object is not too close to other objects

configs.limitRotateForPlant = 20.0 -- recommended 15.0-30.0
configs.minutesWithoutWaterToDry = 6 -- how many minutes the plant can be without water, after exceeding this time the plant will wither // recommended 5/10
configs.waterPercent = 2 -- if the plant is watered, how much % should it add to the plant's growth? // recommended 1/2
configs.waterTime = 25 -- how many % of growth should hydration be enough for? // recommended 10/30
configs.fertilizerBoost = 2 --if the plant is fertilized, how much more will it grow? // recommended 1/2
configs.fertilizerBoostTime = 20 -- how many % of growth should the fertilizer be enough for? // recommended 10/30

configs.plantDurationProgress = 5000 -- in ms

configs.weedProps = { -- Crops have 5 growth states, if you don't know what it's for, just don't touch it
    `bkr_prop_weed_01_small_01b`,
    `bkr_prop_weed_med_01a`,
    `bkr_prop_weed_med_01b`,
    `bkr_prop_weed_lrg_01a`,
    `bkr_prop_weed_lrg_01b`
}

configs.needAmountForRollJoint = 5 -- the number of grams needed to roll a joint
configs.rollJoint = {} -- what joints should be made from what plant
configs.rollJoint['weed_blue_dream'] = 'joint_blue_dream'
configs.rollJoint['weed_lemon_haze'] = 'joint_lemon_haze'
configs.rollJoint['weed_og_kush'] = 'joint_og_kush'
configs.rollJoint['weed_purple_haze'] = 'joint_purple_haze'
configs.rollJoint['weed_skunk'] = 'joint_skunk'
configs.rollJoint['weed_white_widow'] = 'joint_white_widow'

configs.weedFromSeed = {} -- what seeds grow what plant
configs.weedFromSeed['weed_seed_blue_dream'] = 'weed_blue_dream'
configs.weedFromSeed['weed_seed_lemon_haze'] = 'weed_lemon_haze'
configs.weedFromSeed['weed_seed_og_kush'] = 'weed_og_kush'
configs.weedFromSeed['weed_seed_purple_haze'] = 'weed_purple_haze'
configs.weedFromSeed['weed_seed_skunk'] = 'weed_skunk'
configs.weedFromSeed['weed_seed_white_widow'] = 'weed_white_widow'

configs.weedFromSeedAmount = {} -- the amount you get after harvesting the plant
configs.weedFromSeedAmount['weed_seed_blue_dream'] = 30 -- constant number
configs.weedFromSeedAmount['weed_seed_lemon_haze'] = { min = 30, max = 50 } -- random
configs.weedFromSeedAmount['weed_seed_og_kush'] = { min = 30, max = 50 } -- random
configs.weedFromSeedAmount['weed_seed_purple_haze'] = { min = 30, max = 50 } -- random
configs.weedFromSeedAmount['weed_seed_skunk'] = { min = 30, max = 50 } -- random
configs.weedFromSeedAmount['weed_seed_white_widow'] = { min = 30, max = 50 } -- random

configs.customItem = {} -- custom item after collecting the plant
configs.customItem['weed_seed_blue_dream'] = {
	{item = "weed_seed_blue_dream", amount = 1, chance = 0.2 }, -- from all items total chance max 1.0
	{item = "weed_seed_blue_dream", amount = 2, chance = 0.3 }  
}
configs.customItem['weed_seed_lemon_haze'] = {
	{item = "weed_seed_lemon_haze", amount = {min=1, max=3}, chance = 0.2 }, -- amount with random
}
configs.customItem['weed_seed_og_kush'] = {
	{item = "weed_seed_og_kush", amount = 1 }, -- with constant number
	{item = "weed_seed_skunk", amount = {min=1, max=3} }, -- with random
	{item = "weed_seed_white_widow", amount = {min=1, max=3}, chance = 0.5 }, -- with random and chance
}
configs.customItem['weed_seed_purple_haze'] = false
configs.customItem['weed_seed_skunk'] = false
configs.customItem['weed_seed_white_widow'] = false

-- locales
locales.pl = {
	error_1 = "Za blisko innych obiektów.",
	error_2 = "Nie możesz posadzić tego w wodzie.",
	error_3 = "Za krzywo, nie możesz tego tu posadzić.",
	error_4 = "Konewka jest pełna.",
	error_5 = "Aby napełnić konewkę musisz być w wodzie.",
	error_6 = "Nie masz potrzebnych przedmiotów.",
	error_7 = "Nie możesz sadzić w tym miejscu.",
	error_8 = "Brakuje Ci czegoś do skręcenia jointa.",
	error_9 = "Nie masz czym podlać rośliny.",
	error_10 = "Nie masz przy sobie nawozu.",
	error_11 = "Nie masz czym ściąć krzaka.",
	press_info = "[E] - aby zasadzić roślinę | [X] - aby anulować",
	progress_label_1 = "Napełnianie konewki",
	progress_label_2 = "Skręcanie jointa",
	progress_label_3 = "Podlewanie",
	progress_label_4 = "Nawożenie",
	progress_label_5 = "Niszczenie",
	progress_label_6 = "Zbieranie",
	progress_label_7 = "Sadzenie",
	interact_label = "Sprawdź status",
	menu_text_1 = "Nie",
	menu_text_2 = "Tak",
	menu_text_3 = "wzrostu",
	menu_text_4 = "Uschła",
	menu_text_5 = "Gotowa do zbioru",
	menu_text_6 = "Status rośliny",
	menu_text_7 = "Nawodnienie",
	menu_text_8 = "Nawóz",
	menu_text_9 = "Podlej roślinę",
	menu_text_10 = "Nawieź roślinę",
	menu_text_11 = "Zniszcz roślinę",
	menu_text_12 = "Zbierz",
	menu_text_13 = "Informacje o roślinie",
}

locales.en = {
    error_1 = "Too close to other objects.",
    error_2 = "You can't plant this in water.",
    error_3 = "Too crooked, can't plant here.",
    error_4 = "The watering can is full.",
    error_5 = "To fill the watering can, you need to be in water.",
    error_6 = "You don't have the necessary items.",
    error_7 = "You can't plant in this location.",
    error_8 = "You're missing something to roll a joint.",
    error_9 = "You don't have anything to water the plant with.",
    error_10 = "You don't have any fertilizer with you.",
    error_11 = "You don't have anything to trim the bush with.",
    press_info = "[E] - to plant a plant | [X] - to cancel",
    progress_label_1 = "Filling the watering can",
    progress_label_2 = "Rolling a joint",
    progress_label_3 = "Watering",
    progress_label_4 = "Fertilizing",
    progress_label_5 = "Destroying",
    progress_label_6 = "Harvesting",
    progress_label_7 = "Planting",
    interact_label = "Check status",
    menu_text_1 = "No",
    menu_text_2 = "Yes",
    menu_text_3 = "Growth",
    menu_text_4 = "Withered",
    menu_text_5 = "Ready to harvest",
    menu_text_6 = "Plant status",
    menu_text_7 = "Watering",
    menu_text_8 = "Fertilizing",
    menu_text_9 = "Water the plant",
    menu_text_10 = "Fertilize the plant",
    menu_text_11 = "Destroy the plant",
    menu_text_12 = "Harvest",
    menu_text_13 = "Plant information",
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

function getPlayerItems() -- its client side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:GetPlayerItems()
	end
	if configs.inventory == "other" then 
		return {}
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

function setDurabilityItemServer(srcdata, slot, newDurability) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:SetDurability(srcdata, slot, newDurability)
	end
	if configs.inventory == "other" then
        -- you need config this
		return false
	end
end

function getItemFromSlot(srcdata, slot) -- its server side
	if configs.inventory == "ox_inventory" then 
		return exports.ox_inventory:GetSlot(srcdata, slot)
	end
	if configs.inventory == "other" then 
		return false
	end
end


function sendLog(srcdata, action, data) -- its server side
	-- action (data): create_plant (data.typeWeed, data.coords), collected_plant (data.items, data.typeWeed, data.coords), destroyed_plant (data.typeWeed, data.coords)

	-- if action == "create_plant" then
	-- 	print("Player ID "..srcdata.." planted weed on coords "..data.coords..". Type weed: "..data.typeWeed)
	-- end
	-- if action == "collected_plant" then
	-- 	print("Player ID "..srcdata.." collected plant on coords "..data.coords..". Type weed: "..data.typeWeed..". Collected items: "..json.encode(data.items))
	-- end
	-- if action == "destroyed_plant" then
	-- 	print("Player ID "..srcdata.." destroyed plant on coords "..data.coords..". Type weed: "..data.typeWeed)
	-- end
end
-- dont touch
function locale(name) return locales[lang][name] end