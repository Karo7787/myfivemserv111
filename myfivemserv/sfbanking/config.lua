local locales = {}
local configs = {}
local freamwork = "esx" -- support 'esx', 'qbcore', 'standalone' !!important!! esx works only with exports["es_extended"]:getSharedObject()
local lang = "pl" -- support 'en', 'pl' or your lang
local inventory = "ox_inventory" -- support 'ox_inventory' or 'standalone'
local notify = 'esx' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'standalone' (if use ox_lib uncomment line in fxmanifest.lua), 
local target = 'ox_target' -- support 'ox_target', 'qb-target', 'qtarget', false, 'standalone'
configs.banknumberlength = 5 -- min 5, 6, 7, 8, 9 max // The number that will be generated after click button in bank.
configs.cryptonumberlength = 5 -- min 5, 6, 7, 8, 9 max // The number that will be generated after click button in bank.
configs.repairTime = 0 -- timestamp on server not working properly? You can add or subtract time(seconds) 3600 = 1 hour
configs.logs = true -- enable or disable logs function sendLog()

configs.blips = false -- set true if you want blips, false if you dont need blips
configs.banks = { -- default coords for gabz bank. enter the bank interaction coordinates, id must be unique :)
	-- Kwadraciak
	{name="Bank", id=1, x=147.34, y=-1043.87, z=29.60},
	{name="Bank", id=2, x=145.71, y=-1043.33, z=29.60},
	{name="Bank", id=3, x=143.9, y=-1042.86, z=29.60},
	-- Urzędnicza
	{name="Bank", id=4, x=311.63, y=-282.20, z=54.41},
	{name="Bank", id=5, x=310.05, y=-281.60, z=54.41},
	{name="Bank", id=6, x=307.88, y=-280.83, z=54.41},
	--Pacyfik
	{name="Bank", id=7, x=257.15, y=227.31, z=106.37, central = true},
	{name="Bank", id=8, x=259.39, y=226.49, z=106.37, central = true},
	{name="Bank", id=9, x=261.87, y=225.59, z=106.28, central = true},
	{name="Bank", id=10, x=264.09, y=224.76, z=106.28, central = true},
	{name="Bank", id=11, x=266.52, y=223.99, z=106.28, central = true},
	{name="Bank", id=12, x=268.82, y=223.06, z=106.28, central = true},
	{name="Bank", id=13, x=265.11, y=212.83, z=106.28, central = true},
	{name="Bank", id=14, x=262.9, y=213.71, z=106.28, central = true},
	{name="Bank", id=15, x=260.41, y=214.66, z=106.28, central = true},
	{name="Bank", id=16, x=258.15, y=215.48, z=106.28, central = true},
	{name="Bank", id=17, x=255.69, y=216.36, z=106.28, central = true},
	{name="Bank", id=18, x=253.45, y=217.14, z=106.28, central = true},
	-- Pacyfik Wpłatomaty	
	{name="Wpłatomat", id=28, x=242.85, y=222.55, z=106.29},
	{name="Wpłatomat", id=29, x=242.43, y=221.30, z=106.29},
	{name="Wpłatomat", id=30, x=242.0, y=220.10, z=106.29},
	{name="Wpłatomat", id=31, x=241.65, y=218.82, z=106.18},
	{name="Wpłatomat", id=32, x=240.61, y=215.95, z=106.28},
	{name="Wpłatomat", id=33, x=240.11, y=214.72, z=106.28},
	{name="Wpłatomat", id=34, x=239.65, y=213.53, z=106.28},
	{name="Wpłatomat", id=35, x=239.20, y=212.30, z=106.28},
	-- Koło jubi
	{name="Bank", id=36, x=-353.35, y=-53.1, z=49.21},
	{name="Bank", id=37, x=-355.03, y=-52.53, z=49.21},
	{name="Bank", id=38, x=-357.16, y=-51.8, z=49.21},
	 -- Koło multimedialnego
	{name="Bank", id=39, x=-1212.12, y=-334.69, z=38.0},
	{name="Bank", id=40, x=-1213.59, y=-335.47, z=38.0},
	{name="Bank", id=41, x=-1215.6, y=-336.53, z=38.0},
 	-- Lewa autostrada
	{name="Bank", id=42, x=-2958.8, y=481.51, z=15.91},
	{name="Bank", id=43, x=-2958.89, y=479.78, z=15.91},
	{name="Bank", id=44, x=-2958.93, y=477.62, z=15.91},
	 -- Sandy
	{name="Bank", id=45, x=1176.4, y=2710.63, z=38.30},
	{name="Bank", id=46, x=1178.04, y=2710.63, z=38.30},
	{name="Bank", id=47, x=1180.3, y=2710.61, z=38.30},
	-- Paleto	
	{name="Bank", id=48, x=-110.26, y=6469.54, z=31.53},
	{name="Bank", id=49, x=-108.54, y=6471.21, z=31.53},
}
configs.blips = {
	{name="Bank", x=147.34, y=-1043.87, z=29.60}, -- Kwadraciak
	{name="Bank", x=313.99, y=-279.77, z= 54.17}, -- Urzędnicza
	{name="Bank", x=257.20, y=227.50, z=106.51}, -- Pacyfik
	{name="Bank", x=-351.21, y=-50.77, z=49.04}, -- Koło jubi
	{name="Bank", x=-1212.27, y=-331.37, z=37.78}, -- Koło multimedialnego
	{name="Bank", x=-2961.81, y=482.95, z=15.7}, -- Lewa autostrada
	{name="Bank", x=1175.07, y=2706.79, z=38.09}, -- Sandy
	{name="Bank", x=-110.270, y=6469.21, z=31.62},	-- Paleto						
}
if not IsDuplicityVersion() then    
    Citizen.CreateThread(function()
        for k, v in pairs(configs.blips) do
			local blip = AddBlipForCoord(v.x,v.y,v.z)
			SetBlipSprite(blip, 108)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.80)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, true)
	
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.name)
			EndTextCommandSetBlipName(blip)
        end
    end)
end
configs.cryptoInBank = false -- set to true if the interaction is to be in banks
configs.crypto = { -- default coords. enter the crypto center interaction coordinates, id must be unique :)
	{name="CryptoCenter", id=1, x=-1971.83, y=-240.08, z=34.99, showBlip = false},					
}

configs.defaultCrypto = { -- default crypto sell/buy in crypto center
	{name = "ZOC", price = 100},
	{name = "OCASH", price = 1500},
}

configs.atms = {
	[1] = -1126237515,
	[2] = 506770882,
	[3] = -870868698,
	[4] = 150237004,
	[5] = -239124254,
	[6] = -1364697528, 
	[7] = GetHashKey("fm_fleeca_atm"),
	[8] = GetHashKey("fm_ltd_atm_01")
	
}

-- locales
locales.pl = {
	no_atm = "Nie ma bankomatu w pobliżu.",
	system_error = "Coś poszło nie tak.",
	amount_error = "Niepoprawna kwota.",
	money_error = "Nie masz tyle gotówki.",
	money_bank_error = "Nie masz tyle na koncie.",
	bank_transfer_1 = "Na numer konta bankowego",
	bank_transfer_2 = "wykonano przelew w wysokości",
	bank_no_account = "Takie konto bankowe nie istnieje.",
	atm = "Bankomat",
	bank = "Bank",
	cryptoCenter = "Crypto center",
	press = "Wciśnij [E] aby otworzyć",
	press2 = "Wciśnij [R] aby otworzyć",
	crypto_transfer_1 = "Na portfel",
	crypto_transfer_2 = "wykonano transfer w wysokości",
	no_crypto = "Brak środków na koncie.",
	no_crypto_account = "Taki portfel nie istnieje.",
	crypto_transfer_error = "Nie udało się wykonać transferu.",
	log_sell_crypto = "Sprzedaż kryptowaluty",
	crypto_sell_1 = "Sprzedałeś",
	crypto_sell_2 = "Otrzymałeś",
	log_buy_crypto = "Zakup kryptowaluty",
	crypto_buy_1 = "Zakupiłeś",
	crypto_buy_2 = "za",
	crypto_sell_error = "Nie udało się sprzedać kryptowaluty.",
	crypto_buy_error = "Nie udało się kupić kryptowaluty.",
	noaccount = "Nie posiadasz konta, udaj się do banku aby je założyć.",
	-- update 4.11.2023
	logs_depositmoney = "Wpłata na konto bankowe",
	logs_addmoney = "Dodano na konto bankowe",
	logs_withdrawalmoney = "Wypłata z konta bankowego",
	logs_removemoney = "Zabrano z konta bankowego",
	logs_amountmoney = "Kwota",
	logs_transfermoney = "Transfer z konta bankowego",
	logs_transfermoney2 = "na konto bankowe",
	logs_account = "Stworzone nowe konto",
	logs_account1 = "Bankowe",
	logs_account2 = "Crypto",
	logs_account3 = "Gracz",
	logs_account4 = "Inne",
	logs_cryptoadd = "Dodano kryptowalute na porfel",
	logs_cryptocurrency = "Waluta",
	logs_cryptoamount = "Ilość",
	logs_cryptoremove = "Usunięto kryptowalute z porfela",
	logs_cryptobuy = "Kupiono kryptowalute na portfel",
	logs_cryptosell = "Sprzedano kryptowalute z porfela",
	logs_cryptotransfer = "Transfer z porfela",
	logs_cryptotransfer2 = "na portfel",
	logs_note = "Notatka",
}

locales.en = {
	no_atm = "Nie ma bankomatu w pobliżu.",
	system_error = "Something went wrong.",
	amount_error = "Invalid amount.",
	money_error = "You don't have that much cash.",
	money_bank_error= "You don't have enough in your account.",
	bank_transfer_1= "To your bank account number",
	bank_transfer_2= "amount has been transferred",
	bank_no_account= "Such a bank account does not exist.",
	atm = "ATM",
	bank = "Bank",
	cryptoCenter = "Crypto center",
	press = "Press [E] to open",
	press2 = "Press [F] to open",
	crypto_transfer_1 = "For your wallet",
	crypto_transfer_2 = "a transfer of the amount was made",
	no_crypto = "No funds in the wallet.",
	no_crypto_account = "Such a wallet does not exist.",
	crypto_transfer_error = "The transfer failed.",
	log_sell_crypto = "Cryptocurrency sales",
	crypto_sell_1 = "You sold",
	crypto_sell_2 = "You received it",
	log_buy_crypto = "Purchasing cryptocurrency",
	crypto_buy_1 = "You purchased",
	crypto_buy_2 = "for",
	crypto_sell_error = "Failed to sell cryptocurrency.",
	crypto_buy_error = "Failed to purchase cryptocurrency.",
	noaccount = "You don't have an account, go to the bank to set one up.",
	-- update 4.11.2023
	logs_depositmoney = "Deposit to bank account",
	logs_addmoney = "Added to bank account",
	logs_withdrawalmoney = "Withdrawal from bank account",
	logs_removemoney = "Removed from bank account",
	logs_amountmoney = "Amount",
	logs_transfermoney = "Transfer from bank account",
	logs_transfermoney2 = "to bank account",
	logs_account = "New account created",
	logs_account1 = "Banking",
	logs_account2 = "Crypto",
	logs_account3 = "Player",
	logs_account4 = "Other",
	logs_cryptoadd = "Cryptocurrency added to the wallet",
	logs_cryptocurrency = "Currency",
	logs_cryptoamount = "Amount",
	logs_cryptoremove = "Cryptocurrency removed from wallet",
	logs_cryptobuy = "Cryptocurrency purchased for wallet",
	logs_cryptosell = "Cryptocurrency from wallet sold",
	logs_cryptotransfer = "Transfer from wallet",
	logs_cryptotransfer2 = "to wallet",
	logs_note = "Note",
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


function playerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local src = idserverplayer
	local data = {}
	if freamwork == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		local myBankNumber = getNumberBank(src)
		local myCryptoNumber = getNumberCrypto(src)
		if xPlayer then
			data.id = xPlayer.identifier
			data.bank_number = myBankNumber
			data.crypto_number = myCryptoNumber
			return data
		else
			print("error")
		end
	end
	if freamwork == "qbcore" then
		local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
		local myBankNumber = getNumberBank(src)
		local myCryptoNumber = getNumberCrypto(src)
		if PlayerData then
			data.id = PlayerData.citizenid
			data.bank_number = myBankNumber
			data.crypto_number = myCryptoNumber
			return data
		else
			print("error, please contact with support.")
		end
	end
	if freamwork == "standalone" then
		local user = exports["mybase"]:getModule("Player"):GetUser(src) -- example, you must change it
		local char = user:getCurrentCharacter() -- example, you must change it
		local myBankNumber = getNumberBank(src)
		local myCryptoNumber = getNumberCrypto(src)
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = char.id })
		if result[1] then
			data.id = result[1].id
			data.bank_number = myBankNumber
			data.crypto_number = myCryptoNumber
			return data
		else
			print("error, please contact with support.")
		end
	end
end

local dataBank = {}
function getNumberBank(srcdata) -- its server side
	local src = srcdata
	local playerID
	if dataBank[src] then
		return dataBank[src]
	else
		if freamwork == "esx" then
			local xPlayer = SFX.GetPlayerFromId(src) 
			playerID = xPlayer.identifier
		end
		if freamwork == "qbcore" then
			local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
			playerID = PlayerData.citizenid
		end
		if freamwork == "standalone" then
			local user = exports["mybase"]:getModule("Player"):GetUser(src) -- example, you must change it
			local char = user:getCurrentCharacter() -- example, you must change it
			playerID = char.id
		end
		
		local result = exports.oxmysql:executeSync('SELECT `bank_number` FROM `sfbanking` WHERE `cid` = @numb', { ['@numb'] = playerID })
		if result[1] then
			dataBank[src] = result[1].bank_number
			return result[1].bank_number
		else
			return false -- not found bank account
		end
	end
end

local dataCrypto = {}
function getNumberCrypto(srcdata) -- its server side
	local src = srcdata
	local playerID
	if dataCrypto[src] then
		return dataCrypto[src]
	else
		if freamwork == "esx" then
			local xPlayer = SFX.GetPlayerFromId(src) 
			playerID = xPlayer.identifier
		end
		if freamwork == "qbcore" then
			local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
			playerID = PlayerData.citizenid
		end
		if freamwork == "standalone" then
			local user = exports["mybase"]:getModule("Player"):GetUser(src) -- example, you must change it
			local char = user:getCurrentCharacter() -- example, you must change it
			playerID = char.id
		end
		
		local result = exports.oxmysql:executeSync('SELECT `crypto_number` FROM `sfbanking` WHERE `cid` = @numb', { ['@numb'] = playerID })
		if result[1] then
			dataCrypto[src] = result[1].crypto_number
			return result[1].crypto_number
		else
			return false -- not found bank account
		end
	end
end

function giveItem(srcdata, itemname, amount, metadata) -- its server side
	if inventory == "ox_inventory" then 
		exports.ox_inventory:AddItem(srcdata, itemname, amount, metadata, slot, cb)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function searchItem(srcdata, itemname, metadata) -- its server side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Search(srcdata, 'count', itemname, metadata)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function removeItem(srcdata, itemname, amount) -- its server side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:RemoveItem(srcdata, itemname, amount)
	end
	if inventory == "standalone" then 
		-- you need config this
	end
end

function setTargets() -- its client side
	if target == 'qb-target' then 
		local models = { -- atms
			-1126237515,
            506770882,
            -870868698,
            150237004,
            -239124254,
            -1364697528
		}
		exports['qb-target']:AddTargetModel(models, {
			options = { 
			  	{
					type = "client",
					event = "sfbanking:checkAtm",
					icon = 'fas fa-credit-card',
					label = locale("atm"),
				}
			},
			distance = 2.5,
		})
		for _, data in pairs(configs.banks) do
			if configs.cryptoInBank == false then
				exports['qb-target']:AddCircleZone("sfbanking"..data.id, vector3(data.x, data.y, data.z), 1.0, { 
					name = "sfbanking"..data.id,
					debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
				}, {
					options = {
						{
							type = "client",
							event = "sfbanking:openbank", 
							icon = 'fas fa-university',
							label = data.name,
						}
					},
					distance = 2.0,
				})
			else
				exports['qb-target']:AddCircleZone("sfbanking"..data.id, vector3(data.x, data.y, data.z), 1.0, { 
					name = "sfbanking"..data.id,
					debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
				}, {
					options = {
						{
							type = "client",
							event = "sfbanking:openbank", 
							icon = 'fas fa-university',
							label = locale("bank"),
						},
						{
							type = "client",
							event = "sfbanking:opencrypto", 
							icon = 'fas fa-wallet',
							label = locale("cryptoCenter"),
						},
					},
					distance = 2.0,
				})
			end
		end
		for _, data in pairs(configs.crypto) do
			exports['qb-target']:AddCircleZone("sfbanking-cryptosolo-"..data.id, vector3(data.x, data.y, data.z), 1.0, { 
				name = "sfbanking-cryptosolo-"..data.id,
				debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
			}, {
				options = {
					{
						type = "client",
						event = "sfbanking:opencrypto", 
						icon = 'fas fa-wallet',
						label = locale("cryptoCenter"),
					},
				},
				distance = 2.0,
			})	
		end
	end
	if target == 'ox_target' then 
		local models = { -- atms
			-1126237515,
            506770882,
            -870868698,
            150237004,
            -239124254,
            -1364697528,
			GetHashKey("fm_fleeca_atm"),
			GetHashKey("fm_ltd_atm_01")
		}
		exports.ox_target:addModel(models, {
			{
				icon = "fas fa-credit-card",
				label = locale("atm"),
				event = "sfbanking:checkAtm",
				canInteract = function(entity, coords, distance)
					return true
				end,
			},
		})
		for _, data in pairs(configs.banks) do
			if configs.cryptoInBank == false then
				local options = {
					{
						name = "sfbanking"..data.id,
						event = "sfbanking:openbank", 
						icon = 'fas fa-university',
						label = data.name,
					}
				}
				if data.central then
					table.insert(options, 
				        {
							name = "sfbanking_collectpaycheck"..data.id,
							onSelect = function ()
								TriggerServerEvent("sfjob:collectPaycheck")
								TriggerServerEvent('piotreq_jobcore:TakePayout')
							end,
							icon = "fas fa-hand-holding-usd",
							label = "Odbierz wyplate",
						}
					)
				end
				exports.ox_target:addBoxZone({
					coords = vec3(data.x, data.y, data.z),
					size = vec3(1, 1, 1),
					rotation = 0,
					debug = false,
					options = options
				})
			else
				exports.ox_target:addBoxZone({
					coords = vec3(data.x, data.y, data.z),
					size = vec3(2, 2, 2),
					rotation = 0,
					debug = false,
					options = {
						{
							name = "sfbanking"..data.id,
							event = "sfbanking:openbank", 
							icon = 'fas fa-university',
							label = locale("bank"),
						},
						{
							name = "sfbanking-crypto-"..data.id,
							event = "sfbanking:opencrypto", 
							icon = 'fas fa-wallet',
							label = locale("cryptoCenter"),
						},
					}
				})
			end
		end
		for _, data in pairs(configs.crypto) do
			exports.ox_target:addBoxZone({
				coords = vec3(data.x, data.y, data.z),
				size = vec3(2, 2, 2),
				rotation = 0,
				debug = false,
				options = {
					{
						name = "sfbanking-cryptosolo-"..data.id,
						event = "sfbanking:opencrypto", 
						icon = 'fas fa-wallet',
						label = locale("cryptoCenter"),
					}
				}
			})
		end
	end
	if target == 'qtarget' then 
		local models = { -- atms
			-1126237515,
            506770882,
            -870868698,
            150237004,
            -239124254,
            -1364697528
		}
		exports.qtarget:AddTargetModel(models, {
			options = {
				{
					icon = "fas fa-credit-card",
					label = locale("atm"),
					event = "sfbanking:checkAtm",
				},
			},
			distance = 2.0
		})
		for _, data in pairs(configs.banks) do
			if configs.cryptoInBank == false then
				exports.qtarget:AddBoxZone("sfbanking"..data.id, vec3(data.x, data.y, data.z), 1, 1, {
					name = "sfbanking"..data.id,
					heading = 0.0,
					debugPoly = false,
					minZ = data.z - 0.9,
					maxZ = data.z + 0.9,
				}, {
					options = {
						{
							icon = 'fas fa-university',
							label = locale("bank"),
							event = "sfbanking:openbank",
						},
					},
					distance = 2.5
				})
			else
				exports.qtarget:AddBoxZone("sfbanking-crypto-"..data.id, vec3(data.x, data.y, data.z), 1, 1, {
					name = "sfbanking-crypto-"..data.id,
					heading = 0.0,
					debugPoly = false,
					minZ = data.z - 0.9,
					maxZ = data.z + 0.9,
				}, {
					options = {
						{
							icon = 'fas fa-university',
							label = locale("bank"),
							event = "sfbanking:openbank",
						},
						{
							icon = 'fas fa-wallet',
							label = locale("cryptoCenter"),
							event = "sfbanking:opencrypto",
						},
					},
					distance = 2.5
				})
			end
		end
		for _, data in pairs(configs.crypto) do
			exports.qtarget:AddBoxZone("sfbanking-cryptosolo-"..data.id, vec3(data.x, data.y, data.z), 1, 1, {
				name = "sfbanking-cryptosolo-"..data.id,
				heading = 0.0,
				debugPoly = false,
				minZ = data.z - 0.9,
				maxZ = data.z + 0.9,
			}, {
				options = {
					{
						icon = 'fas fa-wallet',
						label = locale("cryptoCenter"),
						event = "sfbanking:opencrypto",
					},
				},
				distance = 2.5
			})
		end
	end
	if target == false then 
		return "falsewhile"
	end
	if target == "standalone" then 
		-- you need config this, never put here while :)
	end
end

function sendLog(info, text, source) -- logs e.g.: to discord, source can be 0 if not send source player
	if configs.logs then
		local srcdata = nil 
		if tonumber(source) ~= 0 then srcdata = source end
		-- exports['tester']:SendLog(srcdata, text, '3447003')
		if srcdata then
			if info == "account" then
				--print(text)
			end
			if info == "bank_add" then
				exports['mrg_logs']:SendLog(srcdata, text, 'deposit')
			end
			if info == "bank_remove" then
				exports['mrg_logs']:SendLog(srcdata, text, 'withdraw')
			end
			if info == "bank_transfer" then
				exports['mrg_logs']:SendLog(srcdata, text, 'transactions')
			end
			if info == "crypto_sell" then
				exports['mrg_logs']:SendLog(srcdata, text, 'crypto')
			end
			if info == "crypto_buy" then
				exports['mrg_logs']:SendLog(srcdata, text, 'crypto')
			end
			if info == "crypto_add" then
				exports['mrg_logs']:SendLog(srcdata, text, 'crypto')
			end
			if info == "crypto_remove" then
				exports['mrg_logs']:SendLog(srcdata, text, 'crypto')
			end
			if info == "crypto_transfer" then
				exports['mrg_logs']:SendLog(srcdata, text, 'crypto')
			end
		end
	end
end

-- dont touch
function locale(name) return locales[lang][name] end
function config(name) return configs[name] end