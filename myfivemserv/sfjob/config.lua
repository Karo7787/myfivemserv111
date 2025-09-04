local locales = {}
local configs = {}
local freamwork = "esx" -- support 'esx', 'qbcore', 'standalone' !!important!! esx works only with exports["es_extended"]:getSharedObject()
local banking = "sfbanking" -- support 'sfbanking', 'standalone'
local lang = "pl" -- support 'eng', 'pl' or your lang
local notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'standalone' (if use ox_lib uncomment line in fxmanifest.lua), 
local inventory = "ox_inventory" -- support 'ox_inventory' or 'standalone' !!important!! standalone need config
local target = "ox_target" -- support 'ox_target', 'qtarget' or 'standalone' !!important!! standalone need config

configs.ignoreNegativeValue = false -- if set true the company's bank account may have a negative value if there are no funds to pay remuneration
configs.percentForEmployee = 0.0 -- if set 0 player won't get his cash cut range is 0.0 to 0.5

configs.withdrawalFromBank = {} -- if you want players to pay their salaries in the bank, set it to true for a specific job. in client_editable.lua there is an interaction for ox_target
configs.withdrawalFromBank["bean"] = true
configs.withdrawalFromBank["papa"] = true
configs.withdrawalFromBank["uwucafe"] = true
configs.withdrawalFromBank["taxi"] = true

configs.salaryBankAccount = {} -- specify where the money for withdrawals should be collected from. true is the company's bank account, false is money from the server
configs.salaryBankAccount["bean"] = true
configs.salaryBankAccount["uwucafe"] = true
configs.salaryBankAccount["papa"] = true
configs.salaryBankAccount["taxi"] = true

-- locales
locales.pl = {
	job_started = "Rozpoczynasz zmianę.",
	job_ending = "Kończysz zmianę.",
	job_already_employed = "Ta osoba jest już zatroniona w tej firmie.",
	job_already_employed2 = "Jesteś już zatrudniony w tej firmie.",
	job_not_working_here = "Nie pracujesz tutaj.",
	job_now_employed = "Zatrudniono nową osobę.",
	job_now_employed2 = "Zostałeś zatrudniony w",
	job_drop_player = "Zwolniono obywatela.",
	job_drop_player2 = "Zostałeś zwolniony z",
	job_now_notworking = "Ta osoba już nie pracuje w tej firmie.",
	job_now_drop = "Zwolniłeś się.",
	job_now_notinjob = "Nie jestes tutaj zatrudniony.",
	cash_set = "Na kasie #",
    cash_set2 = "ustawiono kwotę",
	cash_not_set = "Na kasie nie jest ustawiona żadna kwota do zapłacenia.",
	cash_pay_success = "Zamówienie na kasie #",
	cash_pay_success2 = "zostało opłacone.",
	cash_pay_success3 = "Zamówienie zostało opłacone.",
	no_money = "Brak wystarczających środków.",
	pay_reason = "Zapłata za zamówienie.",
	employee_bonus = "Premia dla pracownika.",
	tray = "Taca z zamówieniem",
	paybonus_bank_log = "Wypłata pracownika",
	paybonus_success = "Otrzymałeś wypłatę w wysokości",
	paybonus_error = "Brak środków do wypłacenia.",
	paybonus_error2 = "Nie udało się wypłacić wynagrodzenia z powodu braku środków na koncie bankowym firmy.",
	-- update 29.04
	stats_1 = "Imię i nazwisko",
	stats_2 = "Ranga",
	stats_3 = "Czas pracy w minutach",
	stats_4 = "Całkowity czas pracy w minutach",
	stats_5 = "Data zatrudnienia",
	stats_6 = "Jednostka",
	stats_7 = "Odznaka",
	stats_8 = "Specjalizacje",
	stats_9 = "Statystyki",
}

locales.en = {
	job_started = "You start a shift at work.",
	job_ending = "You finish your shift at work.",
	job_already_employed = "This person is already employed by this company.",
	job_already_employed2 = "You are already employed by this company.",
	job_not_working_here = "You don't work here.",
	job_now_employed = "A new person has been hired.",
	job_now_employed2 = "You have been employed in",
	job_drop_player = "A citizen was fired from his job.",
	job_drop_player2 = "You have been released from",
	job_now_notworking = "This person no longer works for this company.",
	job_now_drop = "You quit your job.",
	job_now_notinjob = "You are not employed here.",
	cash_set = "Cash register #",
	cash_set2 = "is set to",
	cash_not_set = "There is no amount to be paid on the checkout.",
	cash_pay_success = "Cash register order #",
	cash_pay_success2 = "has been paid.",
	cash_pay_success3 = "The order has been paid.",
	no_money = "Not enough funds.",
	pay_reason = "Payment for the order.",
	employee_bonus = "Bonus for the employee.",
	tray = "Order tray",
	paybonus_bank_log = "Employees salary",
	paybonus_success = "You received a payout of",
	paybonus_error = "No funds to withdraw.",
	paybonus_error2 = "Remuneration could not be paid due to lack of funds in the company's bank account.",
	-- update 29.04
	stats_1 = "Full name",
	stats_2 = "Rank",
	stats_3 = "Work time in minutes",
	stats_4 = "Total work time in minutes",
	stats_5 = "Hire date",
	stats_6 = "Unit",
	stats_7 = "Badge",
	stats_8 = "Specializations",
	stats_9 = "Statistics",
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
	if notify == "standalone" then
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
	if notify == "standalone" then
		--TriggerClientEvent('yournotify', src, text)
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

function searchItemClient(itemname) -- its client side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function searchItemServer(srcdata, itemname, metadata) -- its server side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Search(srcdata, 'count', itemname, metadata)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function removeItemServer(srcdata, itemname, amount) -- its server side
	if inventory == "ox_inventory" then 
		if itemname == "money" then
			exports['p_dojmdt']:payTax('buy', amount)
		end
		return exports.ox_inventory:RemoveItem(srcdata, itemname, amount)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function giveItemServer(srcdata, itemname, amount, metadata) -- its server side
	if inventory == "ox_inventory" then 
		exports.ox_inventory:AddItem(srcdata, itemname, amount, metadata, slot, cb)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function orderTray(job_name, id_tray) -- its client side
	if inventory == "ox_inventory" then 
		local res = exports.ox_inventory:openInventory('stash', { id = job_name.."-tray-"..id_tray })
		if not res then
			TriggerServerEvent("sfjob:registerStashTray", job_name.."-tray-"..id_tray, locale("tray").." #"..id_tray, 10, 5000, job_name, id_tray)
		end
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function createInteraction(crd, siz, rot, opt) -- its client side
	if target == "ox_target" then 
		exports.ox_target:addBoxZone({
			coords = crd,
			size = siz,
			rotation = rot,
			debug = false,
			options = opt
		})
	end
	if target == "qtarget" then 
		exports.qtarget:AddBoxZone("sfjob"..crd.x..math.random(1,999999), crd, siz.x, siz.y, {
			name = "sfjob"..crd.x..math.random(1,999999),
			heading = rot,
			debugPoly = false,
			minZ = crd.z - 0.9,
			maxZ = crd.z + 0.9,
		}, {
			options = {
				opt
			},
			distance = 2.5
		})
	end
	if target == "standalone" then 
		-- you need config this
	end
end

function openStash(job_name, displayname, id_stash, places, weight, grade) -- its client side
	if inventory == "ox_inventory" then 
		local result = exports.ox_inventory:openInventory('stash', {id = job_name.."-stash-"..id_stash})
		if not result then
			TriggerServerEvent("sfjob:registerStash", job_name.."-stash-"..id_stash, displayname, places, weight)
		end
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function stashServer(src_data, name, displayname, size, weight, group, grade) -- its server side
	if inventory == "ox_inventory" then
		if group then
			if grade then
				exports.ox_inventory:RegisterStash(name, displayname, size, weight, false, {[group] = grade})
			else
				exports.ox_inventory:RegisterStash(name, displayname, size, weight, false, {[group] = 0})
			end
		else
			exports.ox_inventory:RegisterStash(name, displayname, size, weight, false)
		end
	end
	if inventory == "standalone" then 
		-- you need config this
	end
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

if freamwork == "standalone" then
	configs.tableUser = 'characters'
	configs.columnUserId = 'id'
end

function getPlayerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local src = idserverplayer
	local data = {}
	if freamwork == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		if xPlayer then
			data.id = xPlayer.identifier
			data.name = xPlayer.getName()
			return data
		else
			print("error")
		end
	end
	if freamwork == "qbcore" then
		local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
		if PlayerData then
			data.id = PlayerData.citizenid 
			data.name = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname
			return data
		else
			print("error, please contact with support.")
		end
	end
	if freamwork == "standalone" then
		local user = exports["mybase"]:getModule("Player"):GetUser(src) -- example, you must change it
		local char = user:getCurrentCharacter() -- example, you must change it
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = char.id })
		if result[1] then
			data.id = result[1].id
			data.name = result[1].first_name.." "..result[1].last_name
			return data
		else
			print("error, please contact with support.")
		end
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
		if freamwork == "standalone" then
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
	if banking == "standalone" then
		-- you need config this
		return false
	end
end

function getAccountBankPlayer(identifier) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromId(identifier)
	end
	if banking == "standalone" then
		-- you need config this
		return false
	end
end

function getNumberBank(srcdata) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromSource(src)
	end
	if banking == "standalone" then
		-- you need config this
		return false
	end
end

function getMoneyFromBank(number_bank_account) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:getAmountBankFromNumber(number_bank_account)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function transferMoneyFromAccountToAccount(from_bank_number, to_bank_number, amount, reason, srcdata) -- its server side
	if banking == "sfbanking" then
		if reason == "Zapłata za zamówienie." then
			exports['p_dojmdt']:payTax('buy', amount)
		end
		return exports["sfbanking"]:transferMoneyFromAccountToAccount(from_bank_number, to_bank_number, amount, reason, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function addMoneyForJob(bank_number, amount, reason, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:addMoneyForPlayer(bank_number, amount, reason, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function removeMoneyForJob(bank_number, amount, reason, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:removeMoneyForPlayer(bank_number, amount, reason, 1, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

---####################--- bank end ---####################---

---####################--- create bank/crypto account ---####################---

function createAccounts(id_job) -- its server side
	if banking == "sfbanking" then
		local result = exports["sfbanking"]:registerAccount(0, "job", id_job)		
	end
	if banking == "standalone" then
		-- you need config this
	end
end

---####################--- end create bank/crypto account ---####################---

-- animations
function TabletIn() TabletPlayAnim('show') end
function TabletOut() TabletPlayAnim('hide') end

-- dont touch
function locale(name) return locales[lang][name] end
function config(name) return configs[name] end
function getBanking() return banking end