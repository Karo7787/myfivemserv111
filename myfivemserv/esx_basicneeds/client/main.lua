ESX = exports["es_extended"]:getSharedObject()
local IsDead = false
local IsAnimated = false
local IsAlreadyDrug = false
local DrugLevel = -1
-- ENERGY DRINK
local energyDrinkTimeLeft = 0


local ox_inventory = exports.ox_inventory

exports('meth_low_plot', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_basicneeds:meth', 'low')
		end
	end)
end)

exports('meth_medium_plot', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_basicneeds:meth', 'medium')
		end
	end)
end)

exports('meth_high_plot', function(data, slot)
    ox_inventory:useItem(data, function(data)
		if data then
			TriggerEvent('esx_basicneeds:meth', 'high')
		end
	end)
end)

RegisterNetEvent("esx_basicneeds:TriggerVanillaAdding", function(type, value)
	if type == "health" then
		SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())+tonumber(value))
	end
end)


AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)
end)
RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)
	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

RegisterNetEvent('uzyjhaszu')
AddEventHandler('uzyjhaszu', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
    Citizen.Wait(5000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    ClearPedTasksImmediately(PlayerPedId())
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(PlayerPedId(), true)
    SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
    SetPedIsDrunk(PlayerPedId(), true)
    DoScreenFadeIn(1000)
    Citizen.Wait(45000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(PlayerPedId(), 0)
    SetPedIsDrunk(PlayerPedId(), false)
    SetPedMotionBlur(PlayerPedId(), false)
end)


-- RegisterNetEvent('need:zalozKamizelke')
-- AddEventHandler('need:zalozKamizelke', function(typ)
-- 	if typ == 'big' then
-- 		SetPedArmour(PlayerPedId(), 50)
-- 		--ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
-- 		TriggerEvent('hud:taskBar', 4000, 'Zakładanie kamizelki...')
-- 		Wait(1000)
-- 	elseif typ == 'middle' then
-- 		SetPedArmour(PlayerPedId(), 50)
-- 		--ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
-- 		TriggerEvent('hud:taskBar', 3000, 'Zakładanie kamizelki...')
-- 		Wait(1000)
-- 	elseif typ == 'small' then
-- 		SetPedArmour(PlayerPedId(), 25)
-- 		--ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
-- 		TriggerEvent('hud:taskBar', 2000, 'Zakładanie kamizelki...')
-- 		Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('esx_kebab:jedzenie')
-- AddEventHandler('esx_kebab:jedzenie', function()
-- 	SetPedArmour(PlayerPedId(), 25)
-- 	ESX.ShowNotification("Zjadłeś kebaba, poczułeś przypływ energii.")
-- end)


-- -- DRM
-- RegisterNetEvent('esx_nalesnik:zjedz')
-- AddEventHandler('esx_nalesnik:zjedz', function()
-- 	SetPedArmour(PlayerPedId(), 25)
-- 	ESX.ShowNotification("Zjadłeś Naleśnika, poczułeś przypływ energii.")
-- end)
-- DRM

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1800000, {255, 210, 0}, true, function(status)
		if not GetPlayerInvincible(PlayerId()) then
			status.remove(250)
		end
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1800000, {0, 198, 255}, true, function(status)
		if not GetPlayerInvincible(PlayerId()) then
			status.remove(250)
		end
	end)
	
	TriggerEvent('esx_status:registerStatus', 'drug', 0, {255, 0, 246}, false, function(status)
		if status.val > 1500 then
			status.remove(1500)
			return true
		else
			return false
		end
    end)

	CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if not GetPlayerInvincible(PlayerId()) then
				local playerPed  = PlayerPedId()
				local prevHealth = GetEntityHealth(playerPed)
				local health     = prevHealth

				TriggerEvent('esx_status:getStatus', 'hunger', function(status)
					if status.val == 0 then
						if prevHealth <= 50 then
							health = health - 5
						elseif prevHealth <= 150 then
							health = health - 3
						else
							health = health - 1
						end
					end
				end)

				TriggerEvent('esx_status:getStatus', 'thirst', function(status)
					if status.val == 0 then
						if prevHealth <= 50 then
							health = health - 5
						elseif prevHealth <= 150 then
							health = health - 3
						else
							health = health - 1
						end
					end
				end)

				if health ~= prevHealth then
					SetEntityHealth(playerPed,  health)
				end
			else
				Citizen.Wait(500)
			end
			
			TriggerEvent('esx_status:getStatus', 'drug', function(status)
				if status.val > 0 then
					local start = true

					if IsAlreadyDrug then
						start = false
					end

					local level = 0

					if status.val <= 999999 then
						level = 0
					else
						overdose()
					end

					IsAlreadyDrug = true
					DrugLevel = level
				end

				if status.val == 0 then
			  
					if IsAlreadyDrug then
						Normal()
					end

					IsAlreadyDrug = false
					DrugLevel     = -1
				end
			end)
			
		end
	end)

	
	CreateThread(function()
		while true do
			Citizen.Wait(250)

			local playerPed = PlayerPedId()
			if IsEntityDead(playerPed) and not IsDead then
				IsDead = true
			end
		end
	end)
end)

function Normal()
  CreateThread(function()
		local playerPed = PlayerPedId()
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		SetPedIsDrug(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	end)
end

function overdose()
	CreateThread(function()
		local playerPed = PlayerPedId()
		SetEntityHealth(playerPed, 0)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrug(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	end)
end

-- Weed Effect
RegisterNetEvent('xlem0n_drugs:onPot')
AddEventHandler('xlem0n_drugs:onPot', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(PlayerPedId())
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(PlayerPedId(), true)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(PlayerPedId(), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(PlayerPedId(), 0)
	SetPedIsDrunk(PlayerPedId(), false)
	SetPedMotionBlur(PlayerPedId(), false)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(item, prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_sandwich_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				-- Citizen.Wait(4000)
				TriggerEvent('hud:taskBar', 3000, 'Trwa jedzenie...')
				Wait(4000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
				if item then
					TriggerServerEvent('esx_basicneeds:TakeFoodItem', item)
				end
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:hamburger')
AddEventHandler('esx_basicneeds:hamburger', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, 180.0, 0.0, 0.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)
				TriggerEvent('hud:taskBar', 3000, 'Trwa jedzenie...')
				Wait(4000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatChocolate')
AddEventHandler('esx_basicneeds:onEatChocolate', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_choc_ego'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.035, 0.009, -30.0, -240.0, -120.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				TriggerEvent('hud:taskBar', 3000, 'Trwa jedzenie...')
				Wait(4000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatFruit')
AddEventHandler('esx_basicneeds:onEatFruit', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_food_ornge1a'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				TriggerEvent('hud:taskBar', 3000, 'Trwa jedzenie...')
				Wait(4000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onCola')
AddEventHandler('esx_basicneeds:onCola', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_sodacan_01a'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.105, -0.07, -0.045, -80.0, 0.0, -20.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a', function()
				TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 8.0, 3.0, -1, 51, 1, 0, 0, 0)
				TriggerEvent('hud:taskBar', 5500, 'Trwa picie...')
				Wait(5500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatCupCake')
AddEventHandler('esx_basicneeds:onEatCupCake', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_food_ornge1a'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.045, 0.06, 45.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				TriggerEvent('hud:taskBar', 3000, 'Trwa picie...')
				Wait(4000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)


RegisterNetEvent('esx_basicneeds:crisps')
AddEventHandler('esx_basicneeds:crisps', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex = GetPedBoneIndex(playerPed, 57005)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_cs_crisps_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
			while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
				Citizen.Wait(0)
			end

			TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8.0, -1, 48, 0.0, false, false, false)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.15, 0.01, -0.06, 80.0, 215.0, 180.0, true, true, false, true, 1, true)
			TriggerEvent('hud:taskBar', 3000, 'Trwa jedzenie...')
			Wait(4000)

			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
		end)
	end
end)

-------------
--- PICIE ---
-------------
RegisterNetEvent("hud:taskBar", function(time, title)
	lib.progressBar({
		duration = time,
		label = title,
		useWhileDead = true,
		canCancel = false
	})
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(item, prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x , y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, 2000, 48, 0, false, false, false)

				TriggerEvent('hud:taskBar', 2200, 'Trwa picie...')
				Wait(2200)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
				if item then
					TriggerServerEvent('esx_basicneeds:TakeFoodItem', item)
				end
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkKawa')
AddEventHandler('esx_basicneeds:onDrinkKawa', function()
	if not IsAnimated then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		IsAnimated = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(0)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			
			local player = PlayerId()
			local timer = 0
			while timer < 46 do
				ResetPlayerStamina(player)
				SetRunSprintMultiplierForPlayer(player, 1.1)
				Citizen.Wait(2000)
				timer = timer + 2
				SetRunSprintMultiplierForPlayer(player, 1.0)
			end
 		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEatBaton')
AddEventHandler('esx_basicneeds:onEatBaton', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_choc_meto'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(joaat(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				TriggerEvent('hud:taskBar', 2500, 'Trwa jedzenie...')
				Wait(2500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_cigarette:startSmoke')
AddEventHandler('esx_cigarette:startSmoke', function(prop, item)
	OpenCigMenu(prop, item)
end)


RegisterNetEvent('itemki-roza')
AddEventHandler('itemki-roza', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 57005)
	
	RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
	while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
		Citizen.Wait(0)
	end
	ClearPedSecondaryTask(playerPed)
	ESX.Game.SpawnObject('p_single_rose_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z + 2
	}, function(object)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
		TaskPlayAnim(playerPed, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
		while DoesEntityExist(object) do
			Wait(1)
			ESX.ShowHelpNotification('Naciśnij ~o~X ~w~aby usunać propa róży')
			if IsControlPressed(0, 73) then
				DeleteObject(object)
				ClearPedSecondaryTask(playerPed)
				break
			end
		end
	end)
end)

RegisterNetEvent('itemki-kocyk')
AddEventHandler('itemki-kocyk', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)

	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y - 0.9,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_yoga_mat_03',  {
		x = coords.x,
		y = coords.y + 0.9,
		z = coords.z - 1
	}, function(object)
	end)
	ESX.Game.SpawnObject('prop_champset',  {
		x = coords.x,
		y = coords.y,
		z = coords.z - 1
	}, function(object)
	end)
end)

RegisterNetEvent('esx_basicneeds:useAlcohol')
AddEventHandler('esx_basicneeds:useAlcohol', function(time, prop, level)
	local playerPed  = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 18905)
	RequestAnimDict('mp_player_intdrink')
	while not HasAnimDictLoaded('mp_player_intdrink') do
		Citizen.Wait(0)
	end
	ESX.Game.SpawnObject(prop, {
		x = coords.x,
		y = coords.y,
		z = coords.z + 0.2
	}, function(object)
		TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 8.0, -8.0, 5000, 48, 0, false, false, false)
		AttachEntityToEntity(object, playerPed, boneIndex,  0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
		TriggerEvent('hud:taskBar', 5000, 'Trwa picie...')
		Wait(5000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
		Drunk(level, true)
		Citizen.Wait(time)
		Reality()
	end)
end)

function Drunk(level, start)
	CreateThread(function()
		local playerPed = PlayerPedId()
		if start then
			DoScreenFadeOut(800)
			Wait(1000)
		end
		if level == 0 then
			RequestAnimSet("move_m@drunk@slightlydrunk")
			while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
				Wait(0)
			end
			SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
		elseif level == 1 then
			RequestAnimSet("move_m@drunk@moderatedrunk")
			while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
				Wait(0)
			end
			SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
		elseif level == 2 then
			RequestAnimSet("move_m@drunk@verydrunk")
			while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
				Wait(0)
			end
			SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
		end
		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		if start then
			DoScreenFadeIn(800)
		end
	end)
end
  
function Reality()
	CreateThread(function()
		local playerPed = PlayerPedId()
		DoScreenFadeOut(800)
		Wait(1000)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)
		DoScreenFadeIn(800)
	end)
end

rebullanim = false
redbullusing = false
RegisterNetEvent('esx_basicneeds:redbull')
AddEventHandler('esx_basicneeds:redbull', function()
	if not rebullanim and not redbullusing then
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 18905)

		rebullanim = true
		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(0)
			end

			AttachEntityToEntity(object, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, -1, 48, 0.0, false, false, false)
			Citizen.Wait(4000)

			rebullanim = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(object)
			TriggerServerEvent('esx_basicneeds:TakeRedbull')
			redbullusing = true
			local timer = 46
			while timer > 0 do
				ResetPlayerStamina(PlayerId())
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
				Citizen.Wait(2000)
				timer = timer - 2
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
			end
			redbullusing = false
			ESX.ShowNotification("Efekt redbulla upłynał")
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:kawads')
AddEventHandler('esx_basicneeds:kawads', function()
	local timer = 0
	while timer < 300 do
		ResetPlayerStamina(PlayerId())
		Citizen.Wait(2000)
		timer = timer + 2
	end
	ESX.ShowNotification("Efekt Kawy upłyną")
end)


function OpenCigMenu(prop_name, item)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cig_menu', {
        title   = 'Palenie',
        align   = 'center',
        elements = {
            {label = ('Zapal'), value = 'start'},
            {label = ('Wsadź do ust'), value = 'mouth'}
        }
    }, function(data, menu)
        menu.close()
        if data.current.value == 'start' then
			OpenCigMenu2(prop_name, item)
		elseif data.current.value == 'mouth' then
			TriggerServerEvent('esx_cig:removeitem', item)
			prop_name = prop_name
			ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 47419)
			local boneIndex2 = GetPedBoneIndex(ped, 28422)
					
			if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
				RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
				RequestAnimDict("amb@world_human_smoking_fat@male@male_a@enter")
				while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
					Citizen.Wait(100)
				end

				Wait(100)
				AttachEntityToEntity(prop, ped, boneIndex2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				TaskPlayAnim(ped, 'amb@world_human_smoking_fat@male@male_a@enter', 'enter', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(10000)
				ClearPedTasks(ped)
				AttachEntityToEntity(prop, ped, boneIndex, 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
				Wait(2000)
			end

			while DoesEntityExist(prop) do
				Wait(1)
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~p~skończyć palić')
				if IsControlPressed(0, 153) then
					ClearPedTasks(ped)
					DeleteObject(prop)
					break
				end
			end
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenCigMenu2(prop_name, item)
	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'styles', {
        title   = 'Style palenia',
        align   = 'center',
        elements = {
            {label = ('Uniwersalny'), value = 'uniwer'},
            {label = ('Meski'), value = 'meski'},
            {label = ('Damski'), value = 'damski'},
        }
	}, function(data, menu)
		local ped = PlayerPedId()
		prop_name = prop_name
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 28422)
		menu.close()
		TriggerServerEvent('esx_cig:removeitem', item)
        if data.current.value == 'uniwer' then
			if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
				RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
				RequestAnimDict("amb@world_human_smoking_fat@male@male_a@enter")
				while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
					Citizen.Wait(100)
				end

				Wait(100)
				AttachEntityToEntity(prop, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				TaskPlayAnim(ped, 'amb@world_human_smoking_fat@male@male_a@enter', 'enter', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(15000)
				TaskPlayAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(2000)

				while DoesEntityExist(prop) do
					Wait(1)
					ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~p~skończyć palić')
					if IsControlPressed(0, 153) then
						ClearPedTasks(ped)
						DeleteObject(prop)
						break
					end
				end
			end
        elseif data.current.value == 'meski' then
    		if not IsEntityPlayingAnim(ped, "amb@world_human_smoking_fat@male@male_a@base", "base", 3) then
				RequestAnimDict("amb@world_human_smoking_fat@male@male_a@base")
				RequestAnimDict("amb@world_human_smoking_fat@male@male_a@enter")
				while not HasAnimDictLoaded("amb@world_human_smoking_fat@male@male_a@base") do
					Citizen.Wait(100)
				end

				Wait(100)
				AttachEntityToEntity(prop, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				TaskPlayAnim(ped, 'amb@world_human_smoking_fat@male@male_a@enter', 'enter', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(15000)
				TaskPlayAnim(ped, 'amb@world_human_smoking_fat@male@male_a@base', 'base', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(2000)

				while DoesEntityExist(prop) do
					Wait(1)
					ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~p~skończyć palić')
					if IsControlPressed(0, 153) then
						ClearPedTasks(ped)
						DeleteObject(prop)
						break
					end
				end
			end
        elseif data.current.value == 'damski' then
			if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@female@idle_a", "idle_b", 3) then
				RequestAnimDict("amb@world_human_smoking@female@idle_a")
				RequestAnimDict("amb@world_human_smoking_fat@female@enter")
				while not HasAnimDictLoaded("amb@world_human_smoking@female@idle_a") do
					Citizen.Wait(100)
				end

				Wait(100)
				AttachEntityToEntity(prop, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				TaskPlayAnim(ped, 'amb@world_human_smoking_fat@male@male_a@enter', 'enter', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(15000)
				TaskPlayAnim(ped, 'amb@world_human_smoking@female@idle_a', 'idle_b', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
				Wait(2000)

				while DoesEntityExist(prop) do
					Wait(1)
					ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~p~skończyć palić')
					if IsControlPressed(0, 153) then
						ClearPedTasks(ped)
						DeleteObject(prop)
						break
					end
				end
			end
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('esx_basicneeds:armour', function()
	-- ESX.PlayAnim('clothingshirt', 'try_shirt_neutral_c', 8.0, -1, 0)
	ESX.Streaming.RequestAnimDict('clothingshirt')
	TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_neutral_c', 8.0, 1.0, -1, 0, 0.0, false, false, false)
	TriggerEvent('hud:taskBar', 3000, 'Trwa zakładanie kamizelki...')
	Wait(4000)
	SetPedArmour(PlayerPedId(), GetPlayerMaxArmour(PlayerId()))
	--SetPedComponentVariation(PlayerPedId(), 9, 7, 0, 0)
end)

RegisterNetEvent('esx_basicneeds:armour_crime', function()
	ESX.Streaming.RequestAnimDict('clothingshirt')
	TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_neutral_c', 8.0, 1.0, -1, 0, 0.0, false, false, false)
	TriggerEvent('hud:taskBar', 3000, 'Trwa zakładanie kamizelki...')
	Wait(4000)
	SetPedArmour(PlayerPedId(), 50)
	--SetPedComponentVariation(PlayerPedId(), 9, 7, 0, 0)
end)

RegisterNetEvent('esx_basicneeds:armour_crime2', function()
	ESX.Streaming.RequestAnimDict('clothingshirt')
	TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_neutral_c', 8.0, 1.0, -1, 0, 0.0, false, false, false)
	TriggerEvent('hud:taskBar', 3000, 'Trwa zakładanie kamizelki...')
	Wait(4000)
	SetPedArmour(PlayerPedId(), 75)
	--SetPedComponentVariation(PlayerPedId(), 9, 7, 0, 0)
end)

RegisterNetEvent('esx_basicneeds:meth', function(typemeth)
	ESX.Streaming.RequestAnimDict('clothingshirt')
	TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_neutral_c', 8.0, 1.0, -1, 0, 0.0, false, false, false)
	TriggerEvent('hud:taskBar', 3000, 'Trwa wciaganie mety...')
	Wait(4000)
	if typemeth == "low" then
		TriggerEvent('esx_status:remove', 'stress', 250000)
	elseif typemeth == "medium" then
		-- if GetPedArmour(PlayerPedId()) < 25 then
		-- 	SetPedArmour(PlayerPedId(), 25) 
		-- end
	elseif typemeth == "high" then
		if GetPedArmour(PlayerPedId()) < 40 then
			SetPedArmour(PlayerPedId(), 40) 
		end
	end
	TriggerServerEvent('esx_basicneeds:meth:tookItem', typemeth)
end)
RegisterNetEvent('esx_basicneeds:blant', function()
	ESX.Streaming.RequestAnimDict('clothingshirt')
	TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_neutral_c', 8.0, 1.0, -1, 0, 0.0, false, false, false)
	TriggerEvent('hud:taskBar', 3000, 'Trwa palenie blanta...')
	Wait(4000)
	SetPedArmour(PlayerPedId(), 10)
end)

local GetGroundCoords = function(coords)
    local rayCast               = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
    local _, hit, hitCoords     = GetShapeTestResult(rayCast)
    return (hit == 1 and hitCoords) or coords
end

safecoords = vector4(-1858.86, -1243.22, 8.62, 145.38)
RegisterNetEvent("esx_randomteleport:teleport", function()
	local coordsx = math.random(-2600, 2600)
	local coordsy = math.random(-1700, 5000)
	DoScreenFadeOut(500)
	Wait(600)
	local val = 350
	SetEntityCoords(PlayerPedId(), vector3(coordsx, coordsy, val))
	Wait(500)
	local done = GetGroundCoords(vector3(coordsx, coordsy, val))
	local duplicate = 0
	local oldz
	SetEntityInvincible(PlayerPedId(), true)
	while done.z == val and duplicate < 5 do
		Wait(500)
		if val >= 100 then
			val = val - 25
		end
		done = GetGroundCoords(vector3(coordsx, coordsy, val))
		SetEntityCoords(PlayerPedId(), done)
		if oldz == GetEntityCoords(PlayerPedId()).z then
			duplicate = duplicate + 1
			break
		end
		oldz = GetEntityCoords(PlayerPedId()).z
	end
	if duplicate == 5 then
		done = safecoords
	end
	SetEntityCoords(PlayerPedId(), done)
	SetEntityInvincible(PlayerPedId(), false)
	Wait(250)
	DoScreenFadeIn(500)

end)
RegisterNetEvent('esx_basicneeds:naprawka', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if not IsPedInAnyVehicle(playerPed, false) and IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		if DoesEntityExist(vehicle) and GetVehicleEngineHealth(vehicle) < 750 and GetVehicleType(vehicle) == "automobile" then
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			if lib.progressBar({
				duration = 20000,
				label = 'Naprawianie pojazdu',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then
				local id = NetworkGetNetworkIdFromEntity(vehicle)
				SetNetworkIdCanMigrate(id, false)

				local tries = 0
				while not NetworkHasControlOfNetworkId(id) and tries < 20 do
					tries = tries + 1
					NetworkRequestControlOfNetworkId(id)
					Citizen.Wait(50)
				end
				SetVehicleEngineHealth(vehicle, 750.0)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true)
				ClearPedTasksImmediately(playerPed)
				TriggerEvent("esx_naprawka:TookItem")
			end
		end
	end
end)


RegisterNetEvent('esx_basicneeds:heli_naprawka', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if not IsPedInAnyVehicle(playerPed, false) and IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		vehicle = ESX.Game.GetClosestVehicle(coords)
		if DoesEntityExist(vehicle) and GetVehicleEngineHealth(vehicle) < 750 and (GetVehicleType(vehicle) == "heli" or  GetVehicleType(vehicle) == "plane") then
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			if lib.progressBar({
				duration = 20000,
				label = 'Naprawianie pojazdu',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
			}) then
				local id = NetworkGetNetworkIdFromEntity(vehicle)
				SetNetworkIdCanMigrate(id, false)

				local tries = 0
				while not NetworkHasControlOfNetworkId(id) and tries < 20 do
					tries = tries + 1
					NetworkRequestControlOfNetworkId(id)
					Citizen.Wait(50)
				end
				SetVehicleEngineHealth(vehicle, 750.0)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true)
				ClearPedTasksImmediately(playerPed)
				TriggerEvent("esx_naprawka:TookHeliItem")
			end
		end
	end
end)