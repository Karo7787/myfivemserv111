local fuel = 100
local engineHealth = 100
checkisCar = true

HUD.VehicleTheards = function()
	CreateThread(function()
		while InVehicleMode do
			if InVehicleMode then
				Citizen.Wait(1500)
				engineHealth = GetVehicleEngineHealth(HUD.inVehicle) / 10
				fuel = GetVehicleFuelLevel(HUD.inVehicle)
			end
		end
	end)
	CreateThread(function()
		while InVehicleMode do
			Citizen.Wait(50)
			HUD.SendNUIMessage("setVehicleProperties", {
				speed = math.ceil(GetEntitySpeed(HUD.inVehicle) * 3.6),
				rpm = (GetVehicleCurrentRpm(HUD.inVehicle) or 0 ) * 100,
				fuel = fuel,
				seatbelt = HUD.Seatbelt,
				enginehealth = engineHealth,
				show = {
					fuel = IsCar(HUD.inVehicle, false, true),
					seatbelt = IsCar(HUD.inVehicle),
					engine = IsCar(HUD.inVehicle, false, true)
				}
			})
		end
	end)
		
	CreateThread(function()
		while InVehicleMode do
			Citizen.Wait(2500)
		
			local ped, direction = PlayerPedId(), nil
			for k, v in pairs(Config.Directions) do
				direction = GetGameplayCamRot().z
				if math.abs(direction - k) < 30.0 then
					direction = v
					break
				end
			end
			
			local coords = GetEntityCoords(ped, true)
			local zone = GetNameOfZone(coords.x, coords.y, coords.z)
			local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
			local street1, street2 = GetStreetNameFromHashKey(s1), GetStreetNameFromHashKey(s2)
			HUD.SendNUIMessage('setRoad', {
				direction = (direction or 'N'),
				street = (Config.Zones[zone:upper()] or zone:upper()),
				zone = string.sub(street1, 0, 11) .. (street2 ~= "" and " / " .. string.sub(street2, 0, 11) or "")
			})
		end
	end)
end