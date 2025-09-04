local configFile = LoadResourceFile(GetCurrentResourceName(), "config/config.json")
local cfgFile = json.decode(configFile)

local localsFile = LoadResourceFile(GetCurrentResourceName(), "locals/"..cfgFile['locals']..".json")
local lang = json.decode(localsFile)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == 'CEventNetworkEntityDamage' then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
		TriggerEvent("ShockShield:playerDied", event, data)
		if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
			Weapon = ClientWeapons.WeaponNames[tostring(weapon)]
			if IsEntityAPed(attacker) and IsPedAPlayer(attacker) then
				Killer = NetworkGetPlayerIndexFromPed(attacker)
			elseif IsEntityAVehicle(attacker) and IsEntityAPed(GetPedInVehicleSeat(attacker, -1)) and IsPedAPlayer(GetPedInVehicleSeat(attacker, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(attacker, -1))
			elseif IsEntityAPed(attacker) and GetPedType(attacker) == 28 then
				Killer = PlayerId()
				if not exports['mrg_achivements']:CheckIsUnlocked('zgon-zwierze') then
					TriggerServerEvent("mrg_achivements:UnlockAchivements", "zgon-zwierze", 1)
				end
			else
				Killer = PlayerId()
			end
			if not exports['mrg_achivements']:CheckIsUnlocked('zgon') then
				TriggerServerEvent("mrg_achivements:UnlockAchivements", "zgon", 1)
			end
			if (Killer == PlayerId()) then
				DeathReason = lang['DeathReasons'].Suicide
			elseif (Killer == nil) then
				DeathReason = lang['DeathReasons'].Died
			else
				if ClientFunc.IsMelee(weapon) then
					DeathReason = lang['DeathReasons'].Murdered
				elseif ClientFunc.IsTorch(weapon) then
					DeathReason = lang['DeathReasons'].Torched
				elseif ClientFunc.IsKnife(weapon) then
					DeathReason = lang['DeathReasons'].Knifed
				elseif ClientFunc.IsPistol(weapon) then
					DeathReason = lang['DeathReasons'].Pistoled
				elseif ClientFunc.IsSub(weapon) then
					DeathReason = lang['DeathReasons'].Riddled
				elseif ClientFunc.IsRifle(weapon) then
					DeathReason = lang['DeathReasons'].Rifled
				elseif ClientFunc.IsLight(weapon) then
					DeathReason = lang['DeathReasons'].MachineGunned
				elseif ClientFunc.IsShotgun(weapon) then
					DeathReason = lang['DeathReasons'].Pulverized
				elseif ClientFunc.IsSniper(weapon) then
					DeathReason = lang['DeathReasons'].Sniped
				elseif ClientFunc.IsHeavy(weapon) then
					DeathReason = lang['DeathReasons'].Obliterated
				elseif ClientFunc.IsMinigun(weapon) then
					DeathReason = lang['DeathReasons'].Shredded
				elseif ClientFunc.IsBomb(weapon) then
					DeathReason = lang['DeathReasons'].Bombed
				elseif ClientFunc.IsVeh(weapon) then
					DeathReason = lang['DeathReasons'].MowedOver
				elseif ClientFunc.IsVK(weapon) then
					DeathReason = lang['DeathReasons'].Flattened
				else
					DeathReason = lang['DeathReasons'].Killed
				end
			end
			
			local odleglosc = math.floor(#(GetEntityCoords(GetPlayerPed(PlayerId())) - GetEntityCoords(GetPlayerPed(Killer))))
			if DeathReason == lang['DeathReasons'].Suicide or DeathReason == lang['DeathReasons'].Died then
				TriggerServerEvent('mrg_logs:playerDied', GetPlayerServerId(PlayerId()), 'Gracz: **' ..GetPlayerName(PlayerId()).. '**\nPowód: **' .. DeathReason .. '.** ', Weapon)
			else
				TriggerServerEvent('mrg_logs:playerDied', GetPlayerServerId(Killer), 'Gracz: **' ..GetPlayerName(Killer).. '**\nKogo: **' .. GetPlayerName(PlayerId()) ..'**\nPowód: **' .. DeathReason .. '** \nOdległość: **' .. odleglosc .. 'm**\nBroń: ', Weapon)
			end
        end
    end
end)

-- RegisterNetEvent("mrg_logs:onPlayerDeath", function()
-- 	print("DEAD")
-- 	local killer, killerweapon = NetworkGetEntityKillerOfPlayer(PlayerId())
-- 	local PedKiller = GetPedSourceOfDeath(PlayerId())
-- 	local killername = GetPlayerName(PedKiller)
-- 	local weapon = GetPedCauseOfDeath(PlayerId())		
-- 	print(killer, killerweapon, killername, weapon)
-- 	Weapon = ClientWeapons.WeaponNames[tostring(weapon)]
-- 	if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
-- 		Killer = NetworkGetPlayerIndexFromPed(PedKiller)
-- 	elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
-- 		Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
-- 	end
	
-- 	if (Killer == PlayerId()) then
-- 		DeathReason = lang['DeathReasons'].Suicide
-- 	elseif (Killer == nil) then
-- 		DeathReason = lang['DeathReasons'].Died
-- 	else
-- 		if ClientFunc.IsMelee(weapon) then
-- 			DeathReason = lang['DeathReasons'].Murdered
-- 		elseif ClientFunc.IsTorch(weapon) then
-- 			DeathReason = lang['DeathReasons'].Torched
-- 		elseif ClientFunc.IsKnife(weapon) then
-- 			DeathReason = lang['DeathReasons'].Knifed
-- 		elseif ClientFunc.IsPistol(weapon) then
-- 			DeathReason = lang['DeathReasons'].Pistoled
-- 		elseif ClientFunc.IsSub(weapon) then
-- 			DeathReason = lang['DeathReasons'].Riddled
-- 		elseif ClientFunc.IsRifle(weapon) then
-- 			DeathReason = lang['DeathReasons'].Rifled
-- 		elseif ClientFunc.IsLight(weapon) then
-- 			DeathReason = lang['DeathReasons'].MachineGunned
-- 		elseif ClientFunc.IsShotgun(weapon) then
-- 			DeathReason = lang['DeathReasons'].Pulverized
-- 		elseif ClientFunc.IsSniper(weapon) then
-- 			DeathReason = lang['DeathReasons'].Sniped
-- 		elseif ClientFunc.IsHeavy(weapon) then
-- 			DeathReason = lang['DeathReasons'].Obliterated
-- 		elseif ClientFunc.IsMinigun(weapon) then
-- 			DeathReason = lang['DeathReasons'].Shredded
-- 		elseif ClientFunc.IsBomb(weapon) then
-- 			DeathReason = lang['DeathReasons'].Bombed
-- 		elseif ClientFunc.IsVeh(weapon) then
-- 			DeathReason = lang['DeathReasons'].MowedOver
-- 		elseif ClientFunc.IsVK(weapon) then
-- 			DeathReason = lang['DeathReasons'].Flattened
-- 		else
-- 			DeathReason = lang['DeathReasons'].Killed
-- 		end
-- 	end
-- 	print(DeathReason)
-- 	local odleglosc = math.floor(#(GetEntityCoords(GetPlayerPed(PlayerId())) - GetEntityCoords(GetPlayerPed(Killer))))
-- 	if DeathReason == lang['DeathReasons'].Suicide or DeathReason == lang['DeathReasons'].Died then
-- 		TriggerServerEvent('mrg_logs:playerDied', GetPlayerServerId(PlayerId()), 'Gracz: **' ..GetPlayerName(PlayerId()).. '**\nPowód: **' .. DeathReason .. '.** ', Weapon)
-- 	else
-- 		TriggerServerEvent('mrg_logs:playerDied', GetPlayerServerId(Killer), 'Gracz: **' ..GetPlayerName(Killer).. '**\nKogo: **' .. GetPlayerName(PlayerId()) ..'**\nPowód: **' .. DeathReason .. '** \nOdległość: **' .. odleglosc .. 'm**\nBroń: ', Weapon)
-- 	end

-- 	Killer = nil
-- 	DeathReason = nil
-- 	weapon = nil
-- 	Weapon = nil
-- end)

WAITDMG = {}
WAITDMG.Weapons = {
		[`WEAPON_ADVANCEDRIFLE`] = 1.0,-- 4 hitów advancedrifle
		[`WEAPON_MILITARYRIFLE`] = 1.3,-- 3 hitów militaryrifle
		[`WEAPON_COMBATPDW`] = 0.8,--6 hitów combatpdw
		[`WEAPON_SPECIALCARBINE`] = 0.9,-- 4 hitów specialcarbine
		[`WEAPON_GUSENBERG`] = 1.0,-- 4 hitów gusenberg
		[`WEAPON_COMPACTRIFLE`] = 0.7,-- 5 hitów compactrifle
		[`WEAPON_CARBINERIFLE`] = 1.1,-- 5 hitów carbinerifle
		[`WEAPON_CARBINERIFLE_MK2`] = 1.0,-- 4 hitów carbinerifle_mk2
		[`WEAPON_HEAVYRIFLE`] = 1.25,-- 3 hitów heavyrifle
		[`WEAPON_COMPACTLAUNCHER`] = 2.0,-- 1 hitów rakietnica
		[`WEAPON_HOMINGLAUNCHER`] = 4.0,-- 1 hitów rakietnica
		[`WEAPON_EMPLAUNCHER`] = 0.0,-- 0 hitów
		[`WEAPON_DBSHOTGUN`] = 8.0,-- 1 hitów pompa
		[`WEAPON_SAWNOFFSHOTGUN`] = 3.5,-- 1 hitów pompa
		[`WEAPON_PUMPSHOTGUN`] = 3.5,-- 1 hitów pompa
		[`WEAPON_BULLPUPSHOTGUN`] = 8.0,-- 1 hitów pompa
		[`WEAPON_SMOKEGRENADE`] = 0.0,-- 0 hitów granat
		[`WEAPON_MINIGUN`] = 15.0,-- 1 hitów minigun
		[`WEAPON_MUSKET`] = 5.0,-- 1 hitów muszkiet
		[`WEAPON_SMG`] = 0.9,--6 hitów smg 
		[`WEAPON_MINISMG`] = 0.8,-- 7 hitów minismg
		[`WEAPON_MICROSMG`] = 0.8,-- 7 hitów microsmg
		[`WEAPON_ASSAULTRIFLE`] = 1.2,-- 3 hitów assualtrifle 
		[`WEAPON_ASSAULTRIFLE_MK2`] = 1.2,-- 3 hitów assualtrifle_mk2
		[`WEAPON_GADGETPISTOL`] = 0.2,-- 3 hitów gadgetpistol
		[`WEAPON_HEAVYPISTOL`] = 1.6,-- 4 hitów heavypistol 
		[`WEAPON_REVOLVER`] = 0.8,-- 2 hitów revolver
		[`WEAPON_DOUBLEACTION`] = 1.0,-- 3 hitów double action revolver
		[`WEAPON_MACHINEPISTOL`] = 0.55,-- 7 hitów machinepistol
}

RegisterNetEvent('mrg_logs:send')
TriggerServerEvent('mrg_logs:send')
AddEventHandler('mrg_logs:send', function(a)
local client_trigger = tostring(a)
Wait(0)
	CreateThread(function()
		local aiming, shooting, curMul, _, weapon = nil, nil, nil

		for weaponHash,weaponDamage in pairs(WAITDMG.Weapons) do SetWeaponDamageModifier(weaponHash, weaponDamage) end

		while true do
			aiming, shooting = IsControlPressed(0, 25), IsPedShooting(PlayerPedId())
			
			if aiming or shooting then            
				_, weapon = GetCurrentPedWeapon(PlayerPedId(), true)

				if _ then
					curMul = GetPlayerWeaponDamageModifier(PlayerId())
					SetWeaponDamageModifier(weapon, (WAITDMG.Weapons[weapon] or 1.0))
					if curMul > 1.0 then 
						if curMul-0.001 > (WAITDMG.Weapons[weapon] or 1.0) then
							TriggerServerEvent(client_trigger, curMul, (WAITDMG.Weapons[weapon] or 1.0))
							Citizen.Wait(60000)
						end
					end
				else
					Citizen.Wait(250)
				end
			else
				Citizen.Wait(10)
			end
			Citizen.Wait(0)
		end
	end)
end)