local locales = {}
local configs = {}
local freamwork = "esx" -- support 'esx', 'qbcore', 'standalone' !!important!! esx works only with exports["es_extended"]:getSharedObject()
local banking = "sfbanking" -- support 'sfbanking', 'standalone'
local lang = "pl" -- support 'eng', 'pl' or your lang
local notify = 'ox_lib' -- support 'sfnotify', 'esx', 'qbcore', 'ox_lib', 'standalone' (if use ox_lib uncomment line in fxmanifest.lua), 
local inventory = "ox_inventory" -- support 'ox_inventory' or 'standalone' !!important!! standalone need config and inventory must have metadata(for simcards)

configs.banknumberlength = 5 -- min 5, 6, 7, 8, 9 max // The number that will be generated after the first use of the sim card.
configs.cryptonumberlength = 5 -- min 5, 6, 7, 8, 9 max // The number that will be generated after the first use of the sim card.
configs.createCrimeCurrency = 'OCASH' -- default 'OCASH', 'ZOC' or your currency ;) (needed to create a new organization)
configs.createCrimeAmount = 15.0 -- default number float (needed to create a new organization) you can set 0
configs.cgroups = false -- working with sfphone, false if you havent resource sfphone
configs.needPhoneNumber = false -- if true you need to set the variable correctly in the playerData function, defaulted to sfphone
configs.itemNameTablet = "tablet" -- name item for open tablet, you can set false then we will not check if you have the item
configs.Quests = {
	Max = {
		Daily = 2,
		Week = 2
	},
		
	List = {
		[1] = {
			name = 'craftKokaina', -- dont change
			
			title = 'Tworzenie narkotyków',
			description = 'Wytwórz kokainę, uważaj na innych!',
			type = 'Daily',
			reward = {
				label = '2x Fioletowy Pendrive',
				items = {
					[1] = {
						type = "item",
						name = 'usb_purple',
						count = 2,
					}
				}
			},
			
			toComplete = 50		
		},
		
		[2] = {
			name = 'truckerHoldUp', -- dont change
			
			title = 'Złodziej z sąsiedztwa',
			description = 'Zapierdol fure, nie daj się złapać!',
			type = 'Daily',
			reward = {
				label = 'x2 Karta zakladnika',
				items = {
					[1] = {
						type = "item",
						name = 'card',
						count = 2,
					}
				}
			},
			
			toComplete = 5		
		},

		--[3] = {
			--name = 'furgonetkaHoldUp', -- dont change
			
			--title = 'Napad na furgonetkę',
			--description = 'Wykonaj napad na furgonetkę, nie daj się złapać!',
			--type = 'Daily',
			--reward = {
				--label = '1x Zielony Pendrive',
				--items = {
					--[1] = {
						--type = "item",
						--name = 'kokaina',
						--count = 30,
					--}
				--}
			--},
			
		-- 	toComplete = 5		
		-- },
		
		[4] = {
			name = 'robNpc', -- dont change
			
			title = 'Obrabuj obywateli',
			description = 'Okradaj obywatelów, uważaj na policję!',
			type = 'Week',
			reward = {
				label = '1x Czerwony pendrive',
				items = {
					[1] = {
						type = "item",
						name = 'peak_usb',
						count = 1,
					}
				}
			},
			
			toComplete = 250		
		},
		
		[5] = {
			name = 'craftKokainaweek', -- dont change
			
			title = 'Tworzenie narkotyków',
			description = 'Wytwórz kokainę, uważaj na innych!',
			type = 'Week',
			reward = {
				label = '4x Karta do Laptopa',
				items = {
					[1] = {
						type = "item",
						name = 'laptop_card',
						count = 4,
					}
				}
			},
			
			toComplete = 600		
		},		

		[6] = {
			name = 'sellKokaina', -- dont change
			
			title = 'Handluj narkotykami',
			description = 'Sprzedaj kokainę, uważaj na policję!',
			type = 'Week',
			reward = {
				label = '15.000$',
				items = {
					[1] = {
						type = "item",
						name = 'money',
						count = 15000,
					}
				}
			},
			
			toComplete = 500		
		},			

		[7] = {
			name = 'goDirtyPranie', -- dont change
			
			title = 'Smieciarz',
			description = 'Przeszukaj smietniki',
			type = 'Daily',
			reward = {
				label = 'Amunicja 9mm',
				items = {
					[1] = {
						type = "item",
						name = 'ammo-9',
						count = 150,
					}
				}
			},
			
			toComplete = 50			
		},
		[8] = {
			name = 'goMagazyn', -- dont change
			
			title = 'Magazynier',
			description = 'Napad na magazyn',
			type = 'Daily',
			reward = {
				label = 'Podejrzany Kluczyk',
				items = {
					[1] = {
						type = "item",
						name = 'klucze_do_krypto',
						count = 2,
					}
				}
			},
			
			toComplete = 5			
		},
		[9] = {
			name = 'gohouse', -- dont change
			
			title = 'Obrabuj dom',
			description = 'Przeszukaj meble w mieszkaniu',
			type = 'Daily',
			reward = {
				label = 'Podejrzany kluczyk',
				items = {
					[1] = {
						type = "item",
						name = 'klucze_do_krypto',
						count = 2,
					}
				}
			},
			
			toComplete = 10			
		},
		[10] = {
			name = 'gohouse2', -- dont change
			
			title = 'Obrabuj dom',
			description = 'Przeszukaj meble w mieszkaniu',
			type = 'week',
			reward = {
				label = 'Pistolet',
				items = {
					[1] = {
						type = "item",
						name = 'weapon_pistol',
						count = 1,
					}
				}
			},
			
			toComplete = 75			
		},
		--[11] = {
			--name = 'gopdm', -- dont change
			
			--title = 'PDM? Ha Łatwo',
			--description = 'Zajeb auto z PDM',
			--type = 'Daily',
			--reward = {
				--label = 'Potrzebny przedmiot ???',
				--items = {
					--[1] = {
						--type = "item",
						--name = 'klucze_do_krypto',
						--count = 2,
					--}
				--}
			--},
			
			--toComplete = 2			
		--},
		--[12] = {
			--name = 'gopdm2', -- dont change
			
			--title = 'PDM? Ha Łatwo',
			--description = 'Zajeb auto z PDM',
			--type = 'week',
			--reward = {
				--label = 'Potrzebny przedmiot ???',
				--items = {
					--[1] = {
						--type = "item",
						--name = 'klucze_do_krypto',
						--count = 2,
					--}
				--}
			--},
			
			--toComplete = 10			
		--},
		[13] = {
			name = 'robNpc2', -- dont change
			
			title = 'Obrabuj obywateli',
			description = 'Okradaj obywatelów, uważaj na policję!',
			type = 'Daily',
			reward = {
				label = '4x Sentex',
				items = {
					[1] = {
						type = "item",
						name = 'peak_usb',
						count = 4,
					}
				}
			},
			
			toComplete = 50		
		},	
	}
}
-- important, if you use standalone add trigger(client-side) after character load TriggerEvent("sfctab:playerLoaded")

-- locales
locales.pl = {
	not_founding_organization = "Nie możesz założyć nowej organizacji.",
	no_tablet = "Nie masz przy sobie tabletu.",
	change_name_success = "Nazwa została zmieniona.",
	name_is_occupied = "Organizacja o tej nazwie już istnieje.",
    create_success = "Nowa organizacja została założona.",
	no_money_crypto = "Nie stać Cię na założenie nowej organizacji.",
	error = "Coś poszło nie tak.",
	already_bought = "Kupiłeś już to ulepszenie.",
	now_bought = "Ulepszenie organizacji zostało zakupione.",
	no_crypto = "Brak środków w portfelu.",
	no_funds = "Nie masz takich środków na koncie.",
	transfer_success = "Przelew został wykonany.",
	no_bank = "Takie konto bankowe nie istnieje.",
	no_crypto_account = "Taki portfel kryptowalut nie istnieje.",
	position_change_success = "Pozycja w organizacji została zmieniona.",
	remove_player = "Usunięto członka z organizacji.",
	error_mission = "Aby wziąć zlecenie musisz mieć aktywną kartę SIM, inaczej nie otrzymasz informacji.",
	mission_accepted = "Zlecenie zostało przyjęte.",
	mission_occupied = "Ktoś już wziął to zlecenie.",
	mission_cancel = "Zlecenie zostało anulowane.",
	added_player_error = "Nie możesz dodać tego gracza do swojej organizacji.",
	added_player_success = "Dodano członka do organizacji.",
	added_player_notfound = "Nie odnaleziono gracza.",
    info_mission = "Za chwilę otrzymasz SMS'a z informacją, czekaj na wiadomość.",
	no_permissions = "Brak uprawnień.",
	access_account_error = "Ta osoba ma już dostęp.",
	access_account_success = "Pomyślnie nadano dostęp.",
	access_take_success = "Pomyślnie odebrano dostęp.",
	access_take_error = "Ta osoba nie ma już dostępu.",
	quit_player = "Opuściłeś organizację.",
	no_organization = "Nie należysz do żadnej organizacji.",

	success_delete_group = "Twoja grupa została usunięta.",
	error_delete_group = "Nie możesz usunąc grupy kiedy misja jest aktywna.",
	forward_group_success = "Pomyślnie przekazano grupę dla innego członka.",
}

locales.en = {
	not_founding_organization = "You cannot start a new organization.",
	no_tablet = "You don't have a tablet with you.",
	change_name_success = "The name has been changed.",
	name_is_occupied = "An organization with this name already exists.",
    create_success = "A new organization has been established.",
	no_money_crypto = "You cannot afford to start a new organization.",
	error = "Something went wrong.",
	already_bought = "You have already purchased this upgrade.",
	now_bought = "Organization upgrade has been purchased.",
	no_crypto = "There are no funds in the wallet.",
	no_funds = "You do not have such funds in your account.",
	transfer_success = "The transfer of funds has been completed.",
	no_bank = "Such a bank account does not exist.",
	no_crypto_account = "Such a cryptocurrency wallet does not exist.",
	position_change_success = "The position in the organization has changed.",
	remove_player = "A member has been removed from the organization.",
	error_mission = "To take an order, you must have an active SIM card, otherwise you will not receive information.",
	mission_accepted = "The order has been accepted.",
	mission_occupied = "Someone already took the job.",
	mission_cancel = "The order has been cancelled.",
	added_player_error = "You cannot add this player to your organization.",
	added_player_success = "A member has been added to the organization.",
	added_player_notfound = "Player not found.",
    info_mission = "In a moment you will receive an SMS with information, wait for the message.",
	no_permissions = "No permissions.",
	access_account_error = "This person already has access.",
	access_account_success = "Access successfully granted.",
	access_take_success = "Access was successfully revoked.",
	access_take_error = "This person no longer has access.",
	quit_player = "You left the organization.",
	no_organization = "You don't belong to any organization.",

	success_delete_group = "Your group has been deleted.",
	error_delete_group = "You cannot delete a group while a mission is active.",
	forward_group_success = "You have successfully transferred the group to another member.",
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

function searchItemClient(itemname) -- its client side
	if inventory == "ox_inventory" then 
		return exports.ox_inventory:Search('count', itemname)
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

function characterName(identifier) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local data = {}
	if freamwork == "esx" then
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
		if result[1] then
			data.firstname = result[1].firstname
			data.lastname = result[1].lastname
			return data
		else
			data.firstname = "N/D"
			data.lastname = "N/D"
			return data
		end
	end
	if freamwork == "qbcore" then
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
		if result[1] then
			data.firstname = result[1].charinfo.firstname
			data.lastname = result[1].charinfo.lastname
			return data
		else
			data.firstname = "N/D"
			data.lastname = "N/D"
			return data
		end
	end
	if freamwork == "standalone" then
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = identifier })
		if result[1] then
			data.firstname = result[1].first_name
			data.lastname = result[1].last_name
			return data
		else
			data.firstname = "N/D"
			data.lastname = "N/D"
			return data
		end
	end
end

function playerData(idserverplayer) -- its server side -- IMPORTANT! never change the variable "data", you can change only result.
	local src = idserverplayer
	local data = {}
	if freamwork == "esx" then
		local xPlayer = SFX.GetPlayerFromId(src) 
		if xPlayer then
			data.id = xPlayer.identifier
			local phone = exports["lb-phone"]:GetEquippedPhoneNumber(xPlayer.source)
			data.phone_number = phone or 0
			return data
		else
			print("error")
		end
	end
	if freamwork == "qbcore" then
		local PlayerData = SFX.Functions.GetPlayer(src).PlayerData
		local result = exports.oxmysql:executeSync('SELECT * FROM `'..configs.tableUser..'` WHERE `'..configs.columnUserId..'` = @charid', { ['@charid'] = PlayerData.citizenid })
		if result[1] then
			data.id = result[1].citizenid
			data.phone_number = result[1].phone_number -- default for sfphone
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
			data.phone_number = result[1].phone_number -- default for sfphone
			return data
		else
			print("error, please contact with support.")
		end
	end
end


---####################--- bank ---####################---

function getNumberBank(srcdata) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromSource(src)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function getNumberBankFromId(id_crime) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberBankFromId("crime:"..id_crime)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
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
		return exports["sfbanking"]:transferMoneyFromAccountToAccount(from_bank_number, to_bank_number, amount, reason, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return false
	end
end
---####################--- bank end ---####################---

---####################--- crypto ---####################---
function getNumberCrypto(srcdata) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberCryptoFromSource(src)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function getNumberCryptoFromId(id_crime) -- its server side
	local src = srcdata
	if banking == "sfbanking" then
		return exports["sfbanking"]:getNumberCryptoFromId("crime:"..id_crime)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function getCryptoAmount(number_crypto_account, crypto_currency) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:getAmountCryptoFromNumber(number_crypto_account, crypto_currency)
	end
	if banking == "standalone" then
		-- you need config this
		return 0
	end
end

function removeCryptoAmount(number_crypto_account, crypto_currency, crypto_amount, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:removeCryptoForPlayer(number_crypto_account, crypto_currency, crypto_amount, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return false
	end
end

function transferCryptoFromAccountToAccount(from_crypto_number, to_crypto_number, currency, amount, srcdata) -- its server side
	if banking == "sfbanking" then
		return exports["sfbanking"]:transferCryptoFromAccountToAccount(from_crypto_number, to_crypto_number, currency, amount, srcdata)
	end
	if banking == "standalone" then
		-- you need config this
		return false
	end
end
---####################--- crypto end ---####################---

---####################--- create bank/crypto account ---####################---
function createAccounts(id_crime) -- its server side
	if banking == "sfbanking" then
		local result = exports["sfbanking"]:registerAccount(0, "crime", id_crime)		
	end
	if banking == "standalone" then
		-- you need config this
	end
end
---####################--- end create bank/crypto account ---####################---

function checkBeforeUpdate(srcdata, id_action, id_crime) -- its server side, check before update e.g.: player is on coords or have item or something. return true or false
	if id_action == 1 then -- id for buyBase from sql
		TriggerClientEvent("sfcbase:checkPositionBase", srcdata)
		Wait(800)
		local check = exports["sfcbase"]:checkPlayerInZone(srcdata)
		if check == false then
			notificationServer(srcdata, "Nie ma tutaj bazy.")
			return false
		else
			local confirm = lib.callback.await('sfcbase:confirmBuyBase', srcdata)
			if confirm then
				return true
			else
				return false	
			end
		end	
	elseif action == 9999 then -- example
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

function actionUpdate(srcdata, action, id_crime) -- its server side
	if action == 'buyMemberSlotsFirst' then -- example
		exports.oxmysql:execute('UPDATE `crimetab` SET `maxlimit` = `maxlimit` + @action WHERE `id` = @crimeid', {['@action'] = 2, ['@crimeid'] = id_crime })		
	end
	if action == 'buyMemberSlotsSecond' then -- example
		exports.oxmysql:execute('UPDATE `crimetab` SET `maxlimit` = `maxlimit` + @action WHERE `id` = @crimeid', {['@action'] = 7, ['@crimeid'] = id_crime })		
	end
	if action == 'buyMemberSlotsThird' then -- example
		exports.oxmysql:execute('UPDATE `crimetab` SET `maxlimit` = `maxlimit` + @action WHERE `id` = @crimeid', {['@action'] = 14, ['@crimeid'] = id_crime })		
	end

	if action == 'buyStashAllSlots' then -- example
	    local base  = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab_bases` WHERE `id_crime` = ?', {id_crime})[1]
		local base_upgrades = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab` WHERE `id` = ?', {id_crime})[1]?.updates
		local maxWeight = 75000
		local slots = 50
		if base_upgrades then
			for k, v in pairs(json.decode(base_upgrades)) do
				if k == "update-12" and v == "ok" then
					maxWeight = maxWeight + 25000
					slots = slots + 25
				end
				if k == "update-13" and v == "ok" then
					maxWeight = maxWeight + 150000
					slots = slots + 75
				end
				if k == "update-21" and v == "ok" then
					maxWeight = maxWeight + 300000
					slots = slots + 125
				end
			end
		end
		if base then
			exports.ox_inventory:SetSlotCount("sfcbase-all-bs-"..base.id_base, slots)
			exports.ox_inventory:SetMaxWeight("sfcbase-all-bs-"..base.id_base, maxWeight)
		end		
	end
	if action == 'buyStashAllSlots2' then -- example
	    local base  = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab_bases` WHERE `id_crime` = '..id_crime)[1]
		local base_upgrades = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab` WHERE `id` = '..id_crime)[1]?.updates
		local maxWeight = 75000
		local slots = 50
		if base_upgrades then
			for k, v in pairs(json.decode(base_upgrades)) do
				if k == "update-12" and v == "ok" then
					maxWeight = maxWeight + 25000
					slots = slots + 25
				end
				if k == "update-13" and v == "ok" then
					maxWeight = maxWeight + 150000
					slots = slots + 75
				end
				if k == "update-21" and v == "ok" then
					maxWeight = maxWeight + 300000
					slots = slots + 125
				end
			end
		end
		if base then
			exports.ox_inventory:SetSlotCount("sfcbase-all-bs-"..base.id_base, slots)
			exports.ox_inventory:SetMaxWeight("sfcbase-all-bs-"..base.id_base, maxWeight)
		end
	end
	if action == 'buyStashAllSlots3' then -- example
	    local base  = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab_bases` WHERE `id_crime` = '..id_crime)[1]
		local base_upgrades = exports.oxmysql.query_async(nil, 'SELECT * FROM `crimetab` WHERE `id` = '..id_crime)[1]?.updates
		local maxWeight = 75000
		local slots = 50
		if base_upgrades then
			for k, v in pairs(json.decode(base_upgrades)) do
				if k == "update-12" and v == "ok" then
					maxWeight = maxWeight + 25000
					slots = slots + 25
				end
				if k == "update-13" and v == "ok" then
					maxWeight = maxWeight + 150000
					slots = slots + 75
				end
				if k == "update-21" and v == "ok" then
					maxWeight = maxWeight + 300000
					slots = slots + 125
				end
			end
		end
		if base then
			exports.ox_inventory:SetSlotCount("sfcbase-all-bs-"..base.id_base, slots)
			exports.ox_inventory:SetMaxWeight("sfcbase-all-bs-"..base.id_base, maxWeight)
		end
	end
	if action == 'buyBase' then
		TriggerClientEvent("sfcbase:buyBaseForOrganisation", srcdata, id_crime)
	end
	if action == 'buyStashAll' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `stashall` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })	
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'stashall')
	end
	if action == 'buyStashBoss' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `stashboss` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'stashboss')
	end
	if action == 'buyStashPriv' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `stashpriv` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })	
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'stashpriv')
	end
	if action == 'buyClothes' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `clothes` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })		
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'clothes')
	end
	if action == 'buyGarage' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `garage` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })		
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'garage')
	end
	if action == 'buyCrafting' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `crafting` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })		
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'crafting')
	end
	if action == 'buyCameraBase' then
		exports.oxmysql:execute('UPDATE `crimetab_bases` SET `camera` = @action WHERE `id_crime` = @crimeid', {['@action'] = 1, ['@crimeid'] = id_crime })		
		TriggerEvent("sfcbase:updateBaseFromTablet", id_crime, 'camera')
	end
end

function checkBeforeMission(srcdata, idaction, id_crime) -- its server side, check before start mission e.g.: player is on coords or have item or something. return true or false
	if idaction == 1 then -- sffleecaheist
		local result = exports.sfflecaheist:canStartRobbery(srcdata, 'goh')
		if result then
			return true
		else
			return false
		end
	elseif idaction == 2 then -- sffleecaheist
		local result = exports.sfflecaheist:canStartRobbery(srcdata, 'rh')
		if result then
			return true
		else
			return false
		end
	elseif idaction == 3 then -- sffleecaheist
		local result = exports.sfflecaheist:canStartRobbery(srcdata, 'brtn')
		if result then
			return true
		else
			return false
		end
	elseif idaction == 4 then -- sffleecaheist
		local result = exports.sfflecaheist:canStartRobbery(srcdata, 'alta')
		if result then
			return true
		else
			return false
		end
	elseif idaction == 5 then -- sffleecaheist
		local result = exports.sfflecaheist:canStartRobbery(srcdata, 'ph')
		if result then
			return true
		else
			return false
		end	
	else
		return true	
	end
end

function actionMission(srcdata, action, id_crime) -- its server side
	if action == 'fleeca_goh' then
		exports.sfflecaheist:ctabStartRobbery(srcdata, 'goh')
	elseif action == 'fleeca_rh' then
		exports.sfflecaheist:ctabStartRobbery(srcdata, 'rh')
	elseif action == 'fleeca_brtn' then
		exports.sfflecaheist:ctabStartRobbery(srcdata, 'brtn')
	elseif action == 'fleeca_alta' then
		exports.sfflecaheist:ctabStartRobbery(srcdata, 'alta')
	elseif action == 'fleeca_ph' then
		exports.sfflecaheist:ctabStartRobbery(srcdata, 'ph')
	end
end


function setDataOtherScript(id_mission, id_crime, action) -- its server side, if finish or failed mission action = 0, if started mission action = 1 (if you using cgroups - action = id cgroup)
	-- TriggerEvent("myscript:setGroupForFleeca", id_mission, id_crime) -- example :)

	-- if action==0 then
	-- 	TriggerEvent("missions:setDefault", idmission) -- example
	-- else
	-- 	TriggerEvent("missions:startMisssion", id_mission, id_crime) -- example
	-- end
end

-- animations
function TabletIn() TabletPlayAnim('show') end
function TabletOut() TabletPlayAnim('hide') end

-- dont touch
function locale(name) return locales[lang][name] end
function config(name) return configs[name] end
function getBanking() return banking end