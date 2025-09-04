local locales = {}
local configs = {}
local freamwork = "esx" -- support 'esx', 'qbcore', 'other' !!important!! esx works only with exports["es_extended"]:getSharedObject()
local banking = "sfbanking" -- support 'sfbanking', 'other'
local lang = "pl" -- support 'eng', 'pl' or your lang
local notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'other' (if use ox_lib uncomment line in fxmanifest.lua), 
local inventory = "ox_inventory" -- support 'ox_inventory', 'qb-inventory' or 'other' !!important!! other need config

configs.selectSSN = false -- if you set it to true then remember to configure the getPlayerSourceFromSSN function

configs.needItem = false -- you can set true or false
configs.itemIdNeedToOpen = "tabletjob" -- you can set item id if needItem == true
configs.repairTime = 0 -- timestamp on server not working properly? You can add or subtract time(seconds) 3600 = 1 hour
configs.accessForJob = {}
configs.accessForJob["pizzeria"] = true
configs.accessForJob["catcafe"] = true
configs.accessForJob["uwucafe"] = true
configs.accessForJob["pearls"] = true
configs.accessForJob["burgershot"] = true
configs.accessForJob["beanmachine"] = true
configs.accessForJob["upnatom"] = true
configs.accessForJob["popsdiner"] = true
configs.accessForJob["hornys"] = true
configs.accessForJob["vanilla"] = true
configs.accessForJob["bahama"] = true
configs.accessForJob["casinobar"] = true
configs.accessForJob["bean"] = true
configs.accessForJob["papa"] = true

configs.accessForJob["bennys"] = true
configs.accessForJob["taxi"] = true



-- locales
locales.pl = {
	no_access = "Musisz być zatrudniony lub nie masz uprawnień.",
	no_item = "Nie masz przy sobie tabletu.",
	permission_success = "Uprawnienia zostały poprawnie zmienione.",
	bonusout_success = "Wynagrodzenie zostało poprawnie zmienione.",
	del_kit_success = "Zestaw został poprawnie usunięty.",
	add_kit_success = "Zestaw został poprawnie dodany.",
	upgrade_have = "To ulepszenie zostało już zakupione.",
	upgrade_success = "Ulepszenie zostało poprawnie zakupione.",
	upgrade_error = "Nie stać cię na to ulepszenie.",
	ad_add_success = "Ogłoszenie zostało poprawnie dodane.",
	ad_del_success= "Ogłoszenie zostało poprawnie usunięte.",
	drop_emplo_success = "Pracownik został zwolniony.",
	change_emplo_success = "Stanowisko pracownika zostało poprawnie zmienione.",
	add_emplo_success = "Zatrudniono nowego pracownika.",
	emplo_long = "Obywatel jest za daleko.",
	emplo_noplaces = "Brak wolnych miejsc.",
	paybonus_1 = "Premia została wypłacona.",
	bussines_nomoney = "Nie udało się wypłacić premii.",
	payment_1 = "Faktura na kwotę",
	payment_2 = "została poprawnie wystawiona.",
	payment_nomoney = "Brak wystarczających środków na koncie klienta.",
	error = "Coś poszło nie tak.",
	access_account_success = "Dostęp do konta bankowego został poprawnie przyznany.",
	access_take_success = "Dostęp do konta bankowego został poprawnie odebrany.",
	buy_upgrade_bank = "Zakup ulepszenia",
	paybonus_bank_log = "Premia dla pracownika",
	payment_bank_log = "Faktura.",
	-- 04.09.2024 
	ad_edit_success= "Ogłoszenie zostało zapisane.",
}

locales.en = {
	no_access = "You must be employed or you do not have permission.",
	no_item = "You don't have your tablet with you.",
	permission_success = "Permissions have been changed successfully.",
	bonusout_success = "The salary has been changed successfully.",
	del_kit_success = "The kit was successfully deleted.",
	add_kit_success = "The kit has been successfully added.",
	upgrade_have = "This upgrade has already been purchased.",
	upgrade_success = "The upgrade has been successfully purchased.",
	upgrade_error = "You cannot afford this upgrade.",
	ad_add_success = "The ad has been successfully added.",
	ad_del_success= "The ad was successfully deleted.",
	drop_emplo_success = "The employee has been fired.",
	change_emplo_success = "The employee's job title has been changed successfully.",
	add_emplo_success = "A new employee has been hired.",
	emplo_long = "Player is too far away.",
	emplo_noplaces = "No vacancies.",
	paybonus_1 = "The bonus has been paid.",
	bussines_nomoney = "Bonus could not be paid.",
	payment_1 = "The invoice for the amount of",
	payment_2 = "was successfully issued",
	payment_nomoney = "There are insufficient funds in the customer account.",
	error = "Something went wrong.",
	access_account_success = "Access to your bank account has been successfully granted.",
	access_take_success = "Access to your bank account has been successfully received.",
	buy_upgrade_bank = "Purchase an upgrade",
	paybonus_bank_log = "Bonus for the employee",
	payment_bank_log = "Invoice.",
	-- 04.09.2024 
	ad_edit_success= "The ad has been saved.",
}

function notificationClient(text, text2) -- its client side
	if text2 ~= nil then text = text..text2 end
	if notify == "sfnotify" then
		TriggerEvent('sfnotify', 'info', text)
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
	if notify == "other" then
		print(text)
	end
end

function notificationServer(srcdata, text, text2) -- its server side
	if text2 ~= nil then text = text..text2 end
	local src = srcdata
	if notify == "sfnotify" then
		TriggerClientEvent('sfnotify', src, 'info', text)
	end
	if notify == "esx" then
		TriggerClientEvent('esx:showNotification', src, text, 'info')
	end
	if notify == "qbcore" then 
		TriggerClientEvent('QBCore:Notify', src, text, 'primary')
	end
	if notify == "ox_lib" then
		TriggerClientEvent('ox_lib:notify', src, {description = text})
	end
	if notify == "other" then
		--TriggerClientEvent('yournotify', src, text)
	end
end

function getMyJob() -- its client side
	return exports["sfjob"]:getActiveJob()
end

-- freamwork settings --
SFX = nil
if freamwork == "esx" then
	configs.tableUser = 'users'
	configs.columnUserId = 'identifier'
	SFX = exports["es_extended"]:getSharedObject()
end

if freamwork == "qbcore" then
	configs.tableUser = 'players'
	configs.columnUserId = 'citizenid'
	SFX = exports['qb-core']:GetCoreObject()
end

if freamwork == "other" then
	configs.tableUser = 'characters'
	configs.columnUserId = 'id'
end

function searchItemClient(itemname) -- its client side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
	end
	if inventory == "qb-inventory" then 
		local hasItem = SFX.Functions.HasItem(itemname)
		if hasItem then return 1 else return 0 end
	end
	if inventory == "other" then 
		-- you need config this
	end
end

function getItemList() -- its client side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Items()
	end
	if inventory == "qb-inventory" then 
		local items = SFX.Shared.Items
		return items
	end
	if inventory == "other" then 
		-- you need config this
	end
end

local dataNames = {}
function characterName(identifier) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local data = {}
	if dataNames[identifier] then
		return dataNames[identifier]
	else
		if freamwork == "esx" then
			local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
			if result[1] then
				dataNames[identifier] = result[1].firstname.." "..result[1].lastname
				return dataNames[identifier]
			else
				return "N/D"
			end
		end
		if freamwork == "qbcore" then
			local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
			if result[1] then
				dataNames[identifier] = result[1].charinfo.firstname.." "..result[1].charinfo.lastname
				return dataNames[identifier]
			else
				return "N/D"
			end
		end
		if freamwork == "other" then
			local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
			if result[1] then
				dataNames[identifier] = result[1].first_name.." "..result[1].last_name
				return dataNames[identifier]
			else
				return "N/D"
			end
		end
	end
end

function playerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local src = idserverplayer
	local data = {}
	if freamwork == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = xPlayer.identifier })
		if result[1] then
			data.id = result[1].identifier
			data.firstname = result[1].firstname
			data.lastname = result[1].lastname
			return data
		else
			print("error, please contact with support.")
		end
	end
	if freamwork == "qbcore" then
		local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = PlayerData.citizenid })
		if result[1] then
			data.id = result[1].citizenid
			data.firstname = PlayerData.charinfo.firstname
			data.lastname = PlayerData.charinfo.lastname
			return data
		else
			print("error, please contact with support.")
		end
	end
	if freamwork == "other" then
		local user = exports["mybase"]:getModule("Player"):GetUser(src) -- example, you must change it
		local char = user:getCurrentCharacter() -- example, you must change it
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = char.id })
		if result[1] then
			data.id = result[1].id
			data.firstname = result[1].first_name
			data.lastname = result[1].last_name
			return data
		else
			print("error, please contact with support.")
		end
	end
end


---####################--- bank ---####################---

function getAccountBankJob(id_job) -- its server side
	if banking == "sfbanking" then
		local result = exports["sfbanking"]:getNumberBankFromId("job:"..id_job)
		if result then
			return result
		else
			return false -- not found job account
		end
	end
	if banking == "other" then
		-- you need config this
		return false
	end
end

function getAccountBankPlayer(identifier) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromId(identifier)
	end
	if banking == "other" then
		-- you need config this
		return false
	end
end

function getMoneyFromBank(number_bank_account) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:getAmountBankFromNumber(number_bank_account)
	end
	if banking == "other" then
		-- you need config this
		return 0
	end
end

function getNumberBank(srcdata) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromSource(src)
	end
	if banking == "other" then
		-- you need config this
		return false
	end
end

function transferMoneyFromAccountToAccount(from_bank_number, to_bank_number, amount, reason, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:transferMoneyFromAccountToAccount(from_bank_number, to_bank_number, amount, reason, srcdata)
	end
	if banking == "other" then
		-- you need config this
		return 0
	end
end

function removeMoneyForJob(bank_number, amount, reason, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:removeMoneyForPlayer(bank_number, amount, reason, 3, srcdata)
	end
	if banking == "other" then
		-- you need config this
		return 0
	end
end

---####################--- bank end ---####################---

function checkBeforeUpdate(srcdata, id_action, workname) -- its server side, check before update e.g.: player is on coords or have item or something. return true or false
	if id_action == 9999999999 then -- example
		local player = GetPlayerPed(srcdata)
		local coords_player = GetEntityCoords(player)
		local secondVec = vector3(5.0, 5.0, 5.0)
		local dist = #(coords_player - secondVec)
		if dist < 10.0 then
			-- check interior is not use in e.g.: sql ? 
			return true
		else
			return false
		end	
	else
		return true	
	end
end

function actionUpdate(srcdata, action, workname) -- its server side
	-- local success = exports['p_dojmdt']:addMoney(data)
	local result = exports.oxmysql:executeSync("SELECT JSON_OBJECT('id', ju.id, 'name', ju.name, 'description', ju.description, 'cost', ju.cost, 'action', ju.action, 'need', ju.need, 'workname', ju.workname) AS ju, JSON_OBJECT('id', js.id, 'workname', js.workname, 'name', js.name, 'date_creation', js.date_creation, 'maxlimit', js.maxlimit, 'updates', js.updates, 'system', js.system) AS js FROM (SELECT * FROM jobs_updates WHERE action = @action) AS ju, (SELECT * FROM jobs_settings WHERE workname = @workname LIMIT 1) AS js;", { ['@action'] = action, ["@workname"] = workname })
	if result then
		for k, v in pairs(result) do
			local ju = json.decode(v.ju)
			local js = json.decode(v.js)
			if ju.workname == "all" or ju.workname == workname then
				local success = exports['p_dojmdt']:addMoney({from = js.name, title = "Ulepszenie firmy: "..ju.name, amount = ju.cost, jobName = 'doj', jobLabel = 'DOJ'})
				break;
			end
		end
	end
	-- all jobs
	if action == 'people1' then -- example
		exports["sfjob"]:changeDataSettingsJob(workname, "maxlimit", 4) -- function from sfjob, read docs.
	end
	if action == 'people2' then -- example
		exports["sfjob"]:changeDataSettingsJob(workname, "maxlimit", 6) -- function from sfjob, read docs.
	end

	if action == 'buyStash1' then -- example
		local bussinessdata = exports.ox_inventory:GetInventory(workname.."-stash-warehouse")
		exports.ox_inventory:SetMaxWeight(workname.."-stash-warehouse", bussinessdata.maxWeight+25000)
        exports.ox_inventory:SetSlotCount(workname.."-stash-warehouse", bussinessdata.slots+25)
	end
	if action == 'buyStash2' then -- example
		local bussinessdata = exports.ox_inventory:GetInventory(workname.."-stash-warehouse")
		exports.ox_inventory:SetMaxWeight(workname.."-stash-warehouse", bussinessdata.maxWeight+50000)
        exports.ox_inventory:SetSlotCount(workname.."-stash-warehouse", bussinessdata.slots+50)
	end
	if action == 'buyStash3' then -- example
		local bussinessdata = exports.ox_inventory:GetInventory(workname.."-stash-warehouse")
		exports.ox_inventory:SetMaxWeight(workname.."-stash-warehouse", bussinessdata.maxWeight+75000)
        exports.ox_inventory:SetSlotCount(workname.."-stash-warehouse", bussinessdata.slots+75)
	end
	if action == 'buyStash4' then -- example
		local bussinessdata = exports.ox_inventory:GetInventory(workname.."-stash-warehouse")
		exports.ox_inventory:SetMaxWeight(workname.."-stash-warehouse", bussinessdata.maxWeight+100000)
        exports.ox_inventory:SetSlotCount(workname.."-stash-warehouse", bussinessdata.slots+100)
	end

	-- pizzeria
	if action == 'pizzeriaFridge' then -- example
		exports["sfjob"]:setCustomStash("pizzeria-stash-fridge", 0, 200000)
	end
	if action == 'pizzeriaWarehouse' then -- example
		exports["sfjob"]:setCustomStash("pizzeria-stash-fridge-main", 0, 500000)
	end

	-- cat cafe
	if action == 'catcafeFridge' then -- example
		exports["sfjob"]:setCustomStash("catcafe-stash-fridge", 0, 200000)
	end
	if action == 'catcafeWarehouse' then -- example
		exports["sfjob"]:setCustomStash("catcafe-stash-fridge-main", 0, 500000)
	end

	-- pearls seafood
	if action == 'pearlsFridge' then -- example
		exports["sfjob"]:setCustomStash("pearls-stash-fridge", 0, 200000)
	end
	if action == 'pearlsWarehouse' then -- example
		exports["sfjob"]:setCustomStash("pearls-stash-fridge-main", 0, 500000)
	end

	-- burger shot
	if action == 'burgershotFridge' then -- example
		exports["sfjob"]:setCustomStash("burgershot-stash-fridge", 0, 200000)
	end
	if action == 'burgershotWarehouse' then -- example
		exports["sfjob"]:setCustomStash("burgershot-stash-fridge-main", 0, 500000)
	end
	
	-- bean machine
	if action == 'beanmachineFridge' then -- example
		exports["sfjob"]:setCustomStash("beanmachine-stash-fridge", 0, 200000)
	end
	if action == 'beanmachineWarehouse' then -- example
		exports["sfjob"]:setCustomStash("beanmachine-stash-fridge-main", 0, 500000)
	end

	-- hornys
	if action == 'hornysFridge' then -- example
		exports["sfjob"]:setCustomStash("hornys-stash-fridge", 0, 200000)
	end
	if action == 'hornysWarehouse' then -- example
		exports["sfjob"]:setCustomStash("hornys-stash-fridge-main", 0, 500000)
	end
	
	-- upnatom
	if action == 'upnatomFridge' then -- example
		exports["sfjob"]:setCustomStash("upnatom-stash-fridge", 0, 200000)
	end
	if action == 'upnatomWarehouse' then -- example
		exports["sfjob"]:setCustomStash("upnatom-stash-fridge-main", 0, 500000)
	end

	-- popsdiner
	if action == 'popsdinerFridge' then -- example
		exports["sfjob"]:setCustomStash("popsdiner-stash-fridge", 0, 200000)
	end
	if action == 'popsdinerWarehouse' then -- example
		exports["sfjob"]:setCustomStash("popsdiner-stash-fridge-main", 0, 500000)
	end

	-- bennys
	if action == 'bennysStash' then -- example
		exports["sfjob"]:setCustomStash("bennys-stash-stash", 0, 200000)
	end
	if action == 'bennysStashMain' then -- example
		exports["sfjob"]:setCustomStash("bennys-stash-stash-main", 0, 500000)
	end

end

-- update 04.09
function getPlayerSourceFromSSN(ssn)
	-- you need to edit it
	-- you must return the player ID (source) if online or 0/false if offline
	return false
end

-- update 15.10
function setStatsForInvoices(source, job)
	-- exports.sfjob:setStats(source, job, "Invoices", 1)
end

-- animations
function TabletIn() TabletPlayAnim('show') end
function TabletOut() TabletPlayAnim('hide') end

-- dont touch
function locale(name) return locales[lang][name] end
function config(name) return configs[name] end
function getBanking() return banking end