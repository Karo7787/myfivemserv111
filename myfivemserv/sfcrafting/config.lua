local locales = {}
local configs = {}
local freamworkjob = "esx" -- support 'sfjob', 'esx', 'qbcore', 'standalone' !!important!! esx works only with exports["es_extended"]:getSharedObject()
local lang = "pl" -- support 'eng', 'pl' or your lang
local notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'standalone' (if use ox_lib uncomment line in fxmanifest.lua), 
local inventory = "ox_inventory" -- support 'ox_inventory' or 'standalone' !!important!! standalone need config and inventory must have metadata(for simcards)
local target = 'ox_target' -- support 'qb-target', 'qtarget', 'ox_target', false, 'standalone'
configs.removeAfterAction = true -- if true the components will be removed after the action is performed, if false the components will be deleted even after the failed action
-- info for variable `id`: must be unique for target system
-- info for variable `job`: if you set "none" you don't need any work or name work e.g.: burgershot
-- info for variable `warehouse`: if you set "client" crafting items will be taken from player inventory, you can set e.g.: "burgershot-warehouse"
configs.useInteractions = true -- if you want to set interactions in this script set true, if not set false
configs.craftingTables = { -- if you don't use target you need `coords`, `name`, `job`, `warehouse`, `label` variables
	-- {id=1, coords=vec3(-1197.4574, -899.3101, 13.5206), size=vec3(2, 1, 1), rotation=35, name="table1", job="burgershot", warehouse="client", icon="fa-solid fa-utensils", label="Crafting"}, -- example
	-- {id=3, coords=vec3(94.67, 291.82, 110.21), size=vec3(2, 1, 1), rotation=30.28, name="atomcrafting", job="atom", warehouse="client", icon="fa-solid fa-screwdriver-wrench", label="Crafting"}, -- example
	-- {id=4, coords=vec3(836.32, -818.58, 26.35), size=vec3(2, 1, 1), rotation=30.28, name="mechanikcrafting", job="mechanik", warehouse="client", icon="fa-solid fa-screwdriver-wrench", label="Crafting"}, -- example
	-- {id=5, coords=vector3(809.88, -761.33, 26.78), size=vec3(2, 1, 1), rotation=6.41, name="papa", job="papa", warehouse="papalocker", icon="fa-solid fa-utensils", label="Crafting"},
	-- {id=6, coords=vector3(129.37, -1284.02, 29.27), size=vec3(2, 1, 1), rotation=6.41, name="vanilla", job="vanilla", warehouse="vanillalocker", icon="fa-solid fa-utensils", label="Crafting"},
	-- {id=7, coords=vector3(-1073.67, -1443.74, -1.42), size=vec3(2, 1, 1), rotation=6.41, name="sakura", job="sakura", warehouse="sakuralocker", icon="fa-solid fa-utensils", label="Crafting"}, -- example
	-- {id=8, coords=vector3(-1197.88, -1145.07, 7.83), size=vec3(2, 1, 1), rotation=6.41, name="bean", job="bean", warehouse="beanlocker", icon="fa-solid fa-utensils", label="Crafting"},
	-- {id=9, coords=vector3(-1290.99, -297.06, 36.05), size=vec3(2, 1, 1), rotation=6.41, name="arcade", job="arcade", warehouse="arcadelocker", icon="fa-solid fa-utensils", label="Crafting"},
	-- {id=10, coords=vector3(705.36, -959.54, 30.4), size=vec3(2, 1, 1), rotation=6.41, name="szwalnia", job="szwalnia", warehouse="client", icon="fa-solid fa-utensils", label="Crafting"},


}

Citizen.CreateThread(function()
	while EncryptedCraftingTables == nil do
		Wait(100)
	end
	for k, v in pairs(EncryptedCraftingTables) do
		table.insert(configs.craftingTables, v)
	end
end)

-- locales
locales.pl = {
    error = "Brakuje składników.",
	no_access = "Nie możesz nic tutaj zrobić.",
}

locales.en = {
	error = "Ingredients are missing.",
	no_access = "You can't do anything here.",
}

function notificationClient(text, text2) -- its client side
	if text2 ~= nil then text = text..text2 end
	if notify == "sfnotify" then
		TriggerEvent('sfnotify', 'info', text)
	end
	if notify == "sfnotify" then
		TriggerClientEvent('sfnotify', src, 'info', text)
	end
	if notify == "esx" then
		TriggerEvent('esx:showNotification', text, 'info')
	end
	if notify == "qbcore" then
		TriggerEvent('QBCore:Notify', text, 'primary')
	end
	if notify == "ox_lib" then
		lib.notify({description = text})
	end
	if notify == "standalone" then
		print(text)
	end
end

function notificationServer(srcdata, text, text2) -- its server side
	if text2 ~= nil then text = text..text2 end
	local src = srcdata
	if notify == "esx" then
		TriggerClientEvent('esx:showNotification', src, text, 'info')
	end
	if notify == "qbcore" then 
		TriggerClientEvent('QBCore:Notify', src, text, 'primary')
	end
	if notify == "ox_lib" then
		TriggerClientEvent('ox_lib:notify', src, {description = text})
	end
	if notify == "standalone" then
		--TriggerClientEvent('yournotify', src, text)
	end
end

-- freamwork settings --
SFX = nil
if freamwork == "esx" then
	SFX = exports["es_extended"]:getSharedObject()
end

if freamwork == "qbcore" then
	SFX = exports['qb-core']:GetCoreObject()
end


function getMyJob() -- its client side
	if freamworkjob == "sfjob" then
		return exports["sfjob"]:getActiveJob()
	end
	if freamworkjob == "esx" then
		local SFX = exports["es_extended"]:getSharedObject()
		return SFX.PlayerData.job.name
	end
	if freamworkjob == "qbcore" then
		local SFX = exports['qb-core']:GetCoreObject()
		return SFX.Functions.GetPlayerData().job
	end
	if freamworkjob == "standalone" then
		-- you need config this
		return "unemployed"
	end
end

function getItemList() -- its client side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Items()
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function searchItem(name_inventory, item_name) -- its server side
	if inventory == "ox_inventory" then 
		local dataa = exports.ox_inventory:Search(name_inventory, 'count', item_name)
		return dataa
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function getInventory(name_inventory, src_data) -- its server side
	if inventory == "ox_inventory" then 
		if name_inventory == "client" then
			return exports.ox_inventory:GetInventory(src_data, false)
		else
			return exports.ox_inventory:GetInventory(name_inventory, false)
		end
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function removeItem(name_inventory, item_name, item_amount) -- its server side
	if inventory == "ox_inventory" then
		exports.ox_inventory:RemoveItem(name_inventory, item_name, item_amount)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function addItem(src_data, item_name, item_amount) -- its server side
	if inventory == "ox_inventory" then
		exports.ox_inventory:AddItem(src_data, item_name, item_amount)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function actionCraft(table_name, multiplier) -- its client side
	-- taskbar, animation,minigames or something :)

	if table_name == "pizzeriaFood" then
		-- taskbar, animation, minigames or something
		if lib.progressBar({
			duration = 5000*multiplier,
			label = 'Crafting',
			useWhileDead = false,
		}) then 
			return true
		else
			return false
		end
	elseif table_name == "pizzeriaDrinks" then
		-- taskbar, animation, minigames or something
		if lib.progressBar({
			duration = 5000*multiplier,
			label = 'Crafting',
			useWhileDead = false,
		}) then 
			return true
		else
			return false
		end
	else
		if lib.progressBar({
			duration = 5000*multiplier,
			label = 'Crafting',
			useWhileDead = false,
		}) then 
			return true
		else
			return false
		end
	end
end

function setTargets() -- its client side
	if target == 'qb-target' then 
		for _, data in pairs(configs.craftingTables) do
			if data.job=="none" then
				exports['qb-target']:AddCircleZone("sfcrafting"..data.id, data.coords, 1.5, { 
					name = "sfcrafting"..data.id,
					debugPoly = false,
					}, {
					options = {
						{
							type = "client",
							action = function()
								openCrafting(data.name, data.job, data.warehouse)
							end,
							icon = data.icon,
							label = data.label,
						}
					},
					distance = 2.0,
				})
			else
				exports['qb-target']:AddCircleZone("sfcrafting"..data.id, data.coords, 1.5, { 
					name = "sfcrafting"..data.id,
					debugPoly = false,
					}, {
					options = {
						{
							type = "client",
							action = function()
								openCrafting(data.name, data.job, data.warehouse)
							end,
							canInteract = function(entity, distance, datax)
								if getMyJob() == data.job then
									return true
								end
							end,
							icon = data.icon,
							label = data.label,
						}
					},
					distance = 2.0,
				})
			end
		end
	end
	if target == 'ox_target' then 
		for _, data in pairs(configs.craftingTables) do
			if data.job=="none" then
				exports.ox_target:addBoxZone({
					coords = data.coords,
					size = data.size,
					rotation = data.rotation,
					debug = false,
					options = {
						{
							name = "sfcrafting"..data.id,
							onSelect = function ()
								openCrafting(data.name, data.job, data.warehouse)
							end,
							icon = data.icon,
							label = data.label,
							distance = 2.0,
						}
					}
				})
			else
				exports.ox_target:addBoxZone({
					coords = data.coords,
					size = data.size,
					rotation = data.rotation,
					debug = false,
					options = {
						{
							name = "sfcrafting"..data.id,
							onSelect = function ()
								openCrafting(data.name, data.job, data.warehouse)
							end,
							canInteract = function(entity, distance, coords, name, bone)
								if getMyJob() == data.job then
									return true
								end
							end,
							icon = data.icon,
							label = data.label,
							distance = 2.0,
						}
					}
				})
			end
		end
	end
	if target == 'qtarget' then 
		for _, data in pairs(configs.craftingTables) do
			if data.job=="none" then
				exports.qtarget:AddBoxZone("sfcrafting"..data.id, data.coords, data.size.x, data.size.y, {
					name="sfcrafting"..data.id,
					heading=data.rotation,
					debugPoly=false,
					minZ=data.coords.z-data.size.z,
					maxZ=data.coords.z+data.size.z,
					}, {
						options = {
							{
								action = function ()
									TriggerEvent("sfcrafting:openCrafting", data.name, data.job, data.warehouse)
								end,
								icon = data.icon,
								label = data.label
							}
						},
						distance = 2.0
				})
			else
				exports.qtarget:AddBoxZone("sfcrafting"..data.id, data.coords, data.size.x, data.size.y, {
					name="sfcrafting"..data.id,
					heading=data.rotation,
					debugPoly=false,
					minZ=data.coords.z-data.size.z,
					maxZ=data.coords.z+data.size.z,
					}, {
						options = {
							{
								action = function ()
									TriggerEvent("sfcrafting:openCrafting", data.name, data.job, data.warehouse)
								end,
								canInteract = function(entity, distance, coords, name, bone)
									if getMyJob() == data.job then
										return true
									end
								end,
								icon = data.icon,
								label = data.label
							}
						},
						distance = 2.0
				})
			end
		end
	end	
	if target == false then 
		return "falsewhile"
	end
	if target == "standalone" then 
		-- you need config this, never put here while :)
	end
end

-- dont touch
function locale(name) return locales[lang][name] end
function config(name) return configs[name] end