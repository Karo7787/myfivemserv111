if Config.UseESX then
	Citizen.CreateThread(function()
		-- while not ESX do
		-- 	TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)

		-- 	Citizen.Wait(500)
		-- end
	end)
end
local Started = false

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local currentCash = 1000
local fuelSynced = false
local inBlacklisted = false
local compFuel = 0.0
local compFuel2 = 0.0

local enableField = false

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    close()
end)
-- Citizen.CreateThread(function()
--     while true do
--         if ESX.IsPlayerLoaded() then
--             Wait(1000)
--             color = exports["mgr_hud"]:GetColor()
--             SendNUIMessage({
--                 action = 'updatecolor',
--                 color = {
--                     primaryColor = color
--                 }
--             })
-- 			break
--         end
--         Wait(100)
--     end
-- end)

-- RegisterNetEvent('hud_color', function(data)
--     SendNUIMessage({
--         action = 'updatecolor',
-- 		color = {
-- 			primaryColor = data
-- 		}
--     })
-- end)

function open()
    SetNuiFocus(true, true)
	enableField = true

	SendNUIMessage({
		action = "open",
    })

	SendNUIMessage({
		action = "tankpreis",
		tankpreis = tostring(Round(Config.CostMultiplier, 2)) .. "0"
	})

	SendNUIMessage({
		action = "price",
		price = "$ " .. Round(0, 1)
	})

	SendNUIMessage({
		action = "currentfuel",
		currentfuel = Round(GetVehicleFuelLevel(GetPlayersLastVehicle()), 1)
	})

	SendNUIMessage({
		action = "max",
		max = Config.FuelClassesMax[GetVehicleClass(GetPlayersLastVehicle())] .. " L"
	})
end
  
function close()
	SetNuiFocus(false, false)
	enableField = false
	
	SendNUIMessage({
		action = "close"
	})
	isFueling = false
	Started = false
	ClearPedTasks(PlayerPedId())
	RemoveAnimDict("timetable@gardener@filling_can")

	SendNUIMessage({
		action = "currentfuel",
		currentfuel = Round(0, 1)
	})

	SendNUIMessage({
		action = "compfuel",
		currentfuel = Round(0, 1)
	})

	SendNUIMessage({
		action = "tankpreis",
		currentfuel = "0 L"
	})
end

RegisterNUICallback('escape', function(data, cb)
	close()
end)

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)

	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end

	for index = #Config.Blacklist, 1, -1 do
		table.remove(Config.Blacklist, index)
	end

	while true do
		Wait(2000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 2.5 then
			isNearPump = pumpObject

			if Config.UseESX then
				local playerData = ESX.GetPlayerData()
				for i=1, #playerData.accounts, 1 do
					if playerData.accounts[i].name == 'money' then
						currentCash = playerData.accounts[i].money
						break
					end
				end
			end
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

AddEventHandler('deinermutteristwef:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)
	while isFueling do
		Wait(150)

		local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
		local fuelToAdd = 0.3
		local extraCost = fuelToAdd * Config.CostMultiplier

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				Started = false
				isFueling = false
			end
		else
			compFuel = compFuel + fuelToAdd
			compFuel2 = compFuel2 + fuelToAdd
		end

		if currentFuel > Config.FuelClassesMax[GetVehicleClass(vehicle)] then
			currentFuel = Config.FuelClassesMax[GetVehicleClass(vehicle)]
			Started = false
			isFueling = false
		end

		currentCost = currentCost + extraCost

		if currentCash >= currentCost and compFuel <= Config.FuelClassesMax[GetVehicleClass(vehicle)] then
			SetFuel(vehicle, compFuel)
		else
			Started = false
			isFueling = false
		end
	end

	if pumpObject then
		TriggerServerEvent('fuel:pay', currentCost)
	end

	currentCost = 0.0
end)

RegisterNUICallback('unfuel', function(data, cb)
	if isFueling then
		Started = false
		isFueling = false
	end
end)
AddEventHandler('deinermutteristwef:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	if not isFueling then
		isFueling = true
		TriggerEvent('deinermutteristwef:startFuelUpTick', pumpObject, ped, vehicle)
	end
	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			local extraString = ""

			--[[if Config.UseESX then
				extraString = "\n" .. Config.Strings.TotalCost .. ": ~g~$" .. Round(currentCost, 1)
			end--]]

			SendNUIMessage({
				action = "price",
				price = "$ " .. Round(currentCost, 1)
			})
			--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.CancelFuelingPump .. extraString)
			--DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Round(compFuel, 1) .. "%")

			SendNUIMessage({
				action = "currentfuel",
				currentfuel = Round(compFuel, 1)
			})

			SendNUIMessage({
				action = "compfuel",
				compfuel = Round(compFuel2, 1)
			})
			
		end

		if DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
			Started = false
		end

		Wait(0)
	end

	compFuel2 = 0.0
end)

local vehicleToRefuel = GetPlayersLastVehicle()

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

RegisterNUICallback('enternotify', function(data, cb)
	ShowAboveRadarMessage("Halte ENTER zum tanken.")
end)

RegisterNUICallback('refuel', function(data, cb)
	if not Started then
		Started = true
		TriggerEvent('deinermutteristwef:refuelFromPump', isNearPump, PlayerPedId(), GetPlayersLastVehicle())
		compFuel = GetVehicleFuelLevel(GetPlayersLastVehicle())
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)

				DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true

						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, 883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							if currentCash > 0 then
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

								if IsControlJustReleased(0, 344) then
									isFueling = true

									open()
									LoadAnimDict("timetable@gardener@filling_can")
									if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
										TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
									end
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							end
						elseif not canFuel then
						else
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				else
					Wait(50)
				end
			end
		else
			Wait(50)
		end

		Wait(0)
	end
end)

if Config.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, gasStationCoords in pairs(Config.GasStations) do
				local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip(closestCoords)

			Wait(10000)
		end
	end)
elseif Config.ShowAllGasStations then
	Citizen.CreateThread(function()
		for _, gasStationCoords in pairs(Config.GasStations) do
			CreateBlip(gasStationCoords)
		end
	end)
end

local instrybutor = -2007231801
local instrybutor2 = 1339433404
local instrybutor3 = 1694452750
local instrybutor4 = 1933174915
local instrybutor5 = -462817101
local instrybutor6 = -469694731
local instrybutor7 = -164877493
Citizen.CreateThread(function()
   exports.qtarget:AddTargetModel({instrybutor,instrybutor2,instrybutor3,instrybutor4,instrybutor5,instrybutor6,instrybutor7}, {
	   options = {
		   {
			   event = "ccc",
			   icon = "fas fa-gas-pump",
			   label = "Zatankuj pojazd",
			   num = 1 
			},
			{
				event = "LazenRuchaMaleDzieci",
				icon = "fas fa-gas-pump",
				label = "Kup kanister (200$)",
				num = 2
		   }
	   },
	   distance = 3.0
   })
end)


RegisterNetEvent('zatankujse', function()
	local vehicle = GetPlayersLastVehicle()

	if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
	open()
	else
		ESX.ShowNotification('Wyjdz z pojazdu!')
	end
end)

AddEventHandler('ccc', function ()
	TriggerServerEvent('tankuj')
end)

if Config.EnableHUD then
	local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		-- AddTextComponentString(text)
		AddTextComponentString("<font face='Poppins-Medium' size= '11'>".. text .."</font>" )
		DrawText(x - 0.1+w, y - 0.02+h)
	end

	local mph = 0
	local kmh = 0
	local fuel = 0
	local displayHud = false

	local x = 0.01135
	local y = 0.002

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) and not (Config.RemoveHUDForBlacklistedVehicle and inBlacklisted) then
				local vehicle = GetVehiclePedIsIn(ped)
				local speed = GetEntitySpeed(vehicle)

				mph = tostring(math.ceil(speed * 2.236936))
				kmh = tostring(math.ceil(speed * 3.6))
				fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

				displayHud = true
			else
				displayHud = false

				Citizen.Wait(500)
			end

			Citizen.Wait(50)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if displayHud then
				-- DrawAdvancedText(0.2610 - x, 0.942 - y, 0.005, 0.0028, 0.4, fuel, 255, 255, 255, 255, 6, 1)
				-- DrawAdvancedText(0.148 - x, 0.942 - y, 0.005, 0.0028, 0.4, "                                           Paliwo       %", 255, 255, 255, 255, 6, 1)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end

AddEventHandler('LazenRuchaMaleDzieci', function()
	TriggerServerEvent('sekszpedalami')
end)



local fuelpertickcan = 0.1
petrolCan = nil

local function setPetrolCan(data)
	petrolCan = data and data.name == 'WEAPON_PETROLCAN' and data or nil
end

setPetrolCan(exports.ox_inventory:getCurrentWeapon())

AddEventHandler('ox_inventory:currentWeapon', setPetrolCan)

exports.ox_target:addGlobalVehicle({
    {
        event = "mrg_fuel:CarnisterFuel",
        icon = "fas fa-gas-pump",
        label = "Zatankuj",
        canInteract = function()
            return petrolCan ~= nil
        end
   }
})

RegisterNetEvent("mrg_fuel:CarnisterFuel", function(data)
	isFueling = true
	newfuel = 0
	vehicle = data.entity
	ped = PlayerPedId()
	coords = GetEntityCoords(vehicle)
	TaskGoToCoordAnyMeans(ped, coords.x, coords.y, coords.z, 1.0, 0, 0, 786603, 0xbf800000)
	Wait(1500)
	ClearPedTasks(ped)
	LoadAnimDict("weapon@w_sp_jerrycan")
	if not IsEntityPlayingAnim(ped, "weapon@w_sp_jerrycan", "fire", 3) then
		TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
	end
	if (fuelpertickcan * 10 > petrolCan.metadata.ammo) or (GetFuel(vehicle) > 98) then
		isFueling = false
	end
	Citizen.CreateThread(function()
		while isFueling do 
			if IsControlJustPressed(1, 73) then
				isFueling = false
			end
			Wait(1)
		end
	end)
	while isFueling do
		if (fuelpertickcan * 10 > petrolCan.metadata.ammo) or (GetFuel(vehicle) > 98) then
			isFueling = false
			lib.showTextUI(string.format("Tankowanie: %sL -> %sL", tonumber(string.format("%.2f",(fuelpertickcan * 3) * petrolCan.metadata.ammo)), newfuel))
		else
			newfuel = newfuel+(fuelpertickcan * 3)
			lib.showTextUI(string.format("Tankowanie: %sL -> %sL", tonumber(string.format("%.2f",(fuelpertickcan * 3) * petrolCan.metadata.ammo)), newfuel))
			TriggerServerEvent('mrg_fuel:updateFuelCan', fueltype, fuelpertickcan * 10)
		end
		Citizen.Wait(100)
	end
	if newfuel > 1 then
		local id = NetworkGetNetworkIdFromEntity(vehicle)
		SetNetworkIdCanMigrate(id, false)

		local tries = 0
		while not NetworkHasControlOfNetworkId(id) and tries < 20 do
			tries = tries + 1
			NetworkRequestControlOfNetworkId(id)
			Citizen.Wait(50)
		end
		
		SetFuel(vehicle, GetFuel(vehicle)+newfuel)
	end
	lib.hideTextUI()
	ClearPedTasks(ped)
end)
