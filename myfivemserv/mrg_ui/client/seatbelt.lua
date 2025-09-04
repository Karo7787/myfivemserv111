
local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local wasInCar     = false
local multiply = {
    ["KMH"] = 3.6,
    ["MPH"] = 2.236936
}
Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
        end

CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if wasInCar then
            local car = GetVehiclePedIsIn(ped)
			local engineRunning = GetIsVehicleEngineRunning(car)

			if not HUD.Seatbelt and engineRunning and IsCar(car, true) and (GetEntitySpeed(car) * 3.6) > 30 then
				Citizen.Wait(250)
                HUD.SendNUIMessage("SendSeatbeltBeep")
                Citizen.Wait(2000)
			end
		end
	end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local ped = GetPlayerPed(-1)
        local car = GetVehiclePedIsIn(ped)
        
        if car ~= 0 and (wasInCar or IsCar(car)) then
            wasInCar = true
                    if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                    isUiOpen = true 			
                end
                
            speedBuffer[2] = speedBuffer[1]
            speedBuffer[1] = GetEntitySpeed(car)
            
            if speedBuffer[2] ~= nil 
                and not HUD.Seatbelt
                and GetEntitySpeedVector(car, true).y > 1.0  
                and speedBuffer[1] > (20 / multiply["KMH"]) 
                and speedBuffer[2] - speedBuffer[1] > speedBuffer[1] then
                
            local co = GetEntityCoords(ped)
            local fw = Fwv(ped)
            SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
            SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
            Citizen.Wait(1)
            SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
            end
            
            velBuffer[2] = velBuffer[1]
            velBuffer[1] = GetEntityVelocity(car)
        elseif wasInCar then
            wasInCar = false
            HUD.Seatbelt = false
            speedBuffer[1], speedBuffer[2] = 0.0, 0.0
                    if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                    isUiOpen = false 
                end
        end
    end
end)

RegisterKeyMapping("-seatbelt", "Pasy bezpieczeństwa", 'keyboard', "B")
    
RegisterCommand("-seatbelt", function()
    local car = GetVehiclePedIsIn(GetPlayerPed(-1))
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
        HUD.Seatbelt = not HUD.Seatbelt 
        if HUD.Seatbelt then 
            Citizen.CreateThread(function()
                while HUD.Seatbelt do
                    Wait(0)
                    DisableControlAction(0, 75)
                end
            end)
            TriggerEvent("InteractSound_CL:PlayOnOne", "belton", 1.0)
            lib.notify({
                title = "Pasy bezpieczeństwa",
                description = "Pasy bezpieczeństwa zostały zapięte",
                duration = 5000,
                type = "info"
            })
        else 
            TriggerEvent("InteractSound_CL:PlayOnOne", "beltoff", 1.0)
            lib.notify({
                title = "Pasy bezpieczeństwa",
                description = "Pasy bezpieczeństwa zostały odpięte",
                duration = 5000,
                type = "info"
            })
        end
    end
    
end, false) 



Checkseatbelt = function()
    return HUD.Seatbelt
end  
exports("CheckSeatbelt",Checkseatbelt)