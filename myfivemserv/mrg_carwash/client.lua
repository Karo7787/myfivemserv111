ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
	for i=1, #Config.Locations, 1 do
		carWashLocation = Config.Locations[i]
		local blip = AddBlipForCoord(carWashLocation)
		SetBlipSprite(blip, 100)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("<font size= '11'>Myjnia Samochodowa</font>" ) 
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CanWashVehicle() then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local canSleep = true
			for i=1, #Config.Locations, 1 do
				local carWashLocation = Config.Locations[i]
				local distance = #(coords - carWashLocation)
				if distance < 10 then
					ESX.DrawBigMarker(carWashLocation)
					canSleep = false
				end
				if distance < 2 then
					canSleep = false
					_ShowHelpText("Naciśnij <span class='button'>E</span> aby umyć pojazd za 100$")
					if IsControlJustReleased(0, 38) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if GetVehicleDirtLevel(vehicle) > 2 then
							WashVehicle()
						else
							ESX.ShowNotification('Pojazd jest za czysty')
						end
					end
				end
			end
			if canSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function CanWashVehicle()
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end
	return false
end

function WashVehicle()
	ESX.TriggerServerCallback('fullrp_carwash:zaplac', function(zaplacil)
		if zaplacil then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			FreezeEntityPosition(vehicle, true)
			lib.progressBar({
				duration = 2000,
				label = 'Mycie pojazdu',
				useWhileDead = false,
				canCancel = true,
				move = false,
				disable = {
					car = true,
				},
			})
			SetVehicleDirtLevel(vehicle, 0.1)
			if not exports.mrg_achivements:CheckIsUnlocked("uzyj-myjni") then
				TriggerServerEvent("mrg_achivements:UnlockAchivements", "uzyj-myjni", 1)
			end
			if Config.EnablePrice then
				ESX.ShowNotification('Twój pojazd został umyty za 100$')
				FreezeEntityPosition(vehicle, false)
			else
				ESX.ShowNotification("Pojazd Umyty")
				FreezeEntityPosition(vehicle, false)
			end
			Citizen.Wait(5000)
		else
			ESX.ShowNotification('Nie posiadasz wystarczającej ilość pieniędzy')
			Citizen.Wait(5000)
		end
	end)
end

message = ""

_ShowHelpText = function(text)
    ShowHelp = true
    message = text
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if ShowHelp and not Showed then
            Showed = true
            exports["mrg_ui"]:ShowHelpNotification(message)
        end
        if not ShowHelp and Showed then
            Showed = false
            exports["mrg_ui"]:HideHelpNotification()
        end
        ShowHelp = false    
    end
end)