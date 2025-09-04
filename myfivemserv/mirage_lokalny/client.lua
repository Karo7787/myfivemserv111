ESX = exports["es_extended"]:getSharedObject()

local Active = false
local test = nil
local test1 = nil
local spam = true

RegisterCommand("help", function(source, args, raw)
	if tonumber(LocalPlayer.state.deathStage) == 2 then
		if not spam then
			Notify("Co ty owsiki w tyłu masz?")
			return
		end
		ESX.TriggerServerCallback('hhfw:docOnline', function(EMSOnline, hasEnoughMoney)
			if EMSOnline <= Config.Doctor and hasEnoughMoney and spam then
				SpawnVehicle(GetEntityCoords(PlayerPedId()))
				TriggerServerEvent('hhfw:charge')
				Notify("Medyk juz do ciebie jedzie")
			else
				if EMSOnline > Config.Doctor then
					Notify("Za duzo medykow na sluzbie", "error")
				elseif not hasEnoughMoney then
					Notify("Za malo pieniedzy")
				else
					Notify("Poczekaj medyk jest w drodze")
				end	
			end
		end)
	else
		Notify("Tego mozesz uzyc tylko wtedy kiedy masz BW")
	end
end)



function SpawnVehicle(x, y, z)  
	spam = false
	local vehhash = GetHashKey("ambulance")                                                     
	local loc = GetEntityCoords(PlayerPedId())
	RequestModel(vehhash)
	while not HasModelLoaded(vehhash) do
		Wait(1)
	end
	RequestModel('s_m_m_doctor_01')
	while not HasModelLoaded('s_m_m_doctor_01') do
		Wait(1)
	end
	local spawnRadius = 40                                                    
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(loc.x + math.random(-spawnRadius, spawnRadius), loc.y + math.random(-spawnRadius, spawnRadius), loc.z, 0, 3, 0)
	mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)                        
	if DoesEntityExist(mechVeh) then
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(mechVeh)
		SetVehicleNumberPlateText(mechVeh, "HHFW")
		SetEntityAsMissionEntity(mechVeh, true, true)
		SetVehicleEngineOn(mechVeh, true, true, false)
        
        mechPed = CreatePedInsideVehicle(mechVeh, 26, GetHashKey('s_m_m_doctor_01'), -1, true, false)              	
        
        mechBlip = AddBlipForEntity(mechVeh)                                                        	
        SetBlipFlashes(mechBlip, true)  
        SetBlipColour(mechBlip, 5)


		PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
		Wait(2000)
		TaskVehicleDriveToCoord(mechPed, mechVeh, loc.x, loc.y, loc.z, 20.0, 0, GetEntityModel(mechVeh), 524863, 2.0)
		test = mechVeh
		test1 = mechPed
		Active = true
    end
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)
        if Active then
            local loc = GetEntityCoords(GetPlayerPed(-1))
			local lc = GetEntityCoords(test)
			local ld = GetEntityCoords(test1)
            local dist = Vdist(loc.x, loc.y, loc.z, lc.x, lc.y, lc.z)
			local dist1 = Vdist(loc.x, loc.y, loc.z, ld.x, ld.y, ld.z)
            if dist <= 10 then
				if Active then
					TaskGoToCoordAnyMeans(test1, loc.x, loc.y, loc.z, 1.0, 0, 0, 786603, 0xbf800000)
				end
				if dist1 <= 2 then 
					Active = false
					ClearPedTasksImmediately(test1)
					DoctorNPC()
				end
            end
        end
    end
end)


function DoctorNPC()
	RequestAnimDict("mini@cpr@char_a@cpr_str")
	while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
		Citizen.Wait(1000)
	end

	TaskPlayAnim(test1, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
	--exports['progressBars']:startUI(Config.ReviveTime, "The doctor is giving you medical aid")
    if lib.progressBar({
		duration = Config.ReviveTime,
		label = 'Ratownik udziela ci pierwszej pomocy',
		useWhileDead = true,
		canCancel = false
	}) then
		ClearPedTasks(test1)
		Citizen.Wait(500)
		TriggerEvent('p_ambulancejob:RevivePlayer')
		if not exports['mrg_achivements']:CheckIsUnlocked('hospital-help') then
			TriggerServerEvent("mrg_achivements:UnlockAchivements", "hospital-help", 1)
		end
		StopScreenEffect('DeathFailOut')	
		Notify("Twoje leczenie dobieglo konca, twoj rachunek zostal obciazony: "..Config.Price)
		RemovePedElegantly(test1)
		DeleteEntity(test)
		spam = true
	end
end


function Notify(msg)
    ESX.ShowNotification(msg)
end
