HUD = {
    Ped = nil,
    Loaded = false,
    Active = true,
    Hide = false,
    inVehicle = false,
    Seatbelt = false
}

local VoiceIndexes = {
    25,
    50,
    100
}


function IsCar(v, ignoreBikes, ignoreMotocycles)
	if ignoreBikes and (IsThisModelABike(GetEntityModel(v))) then
		return false
	end

	local vc = GetVehicleClass(v)
    if not ignoreMotocycles and vc == 8 then
		return false
    end
	return (vc >= 0 and vc <= 12) or vc == 17 or vc == 18 or vc == 20
end



lib.onCache('ped', function(ped)
    HUD.Ped = ped
end)
HUD.SendNUIMessage = function(action, data)
    return SendNUIMessage({
        action = action,
        data = data,
    })
end


HUD.StartNUI = function()
    HUD.Loaded = true
    Wait(600)
    while not GlobalState['scoreboard_ssns'][GetPlayerServerId(PlayerId())] do
        TriggerServerEvent("mrg_ui:RetrievePlayerSSN")
        Wait(100)
    end
    HUD.SendNUIMessage('startNUI', {
        ServerId = GetPlayerServerId(PlayerId()),
        ssn = GlobalState['scoreboard_ssns'][GetPlayerServerId(PlayerId())]
    })
end
Blip = nil
InVehicleMode = false
Talking = false
Minimap = nil
armour = 0
HUD.StartTheards = function()
    HUD.Ped = PlayerPedId()

    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
    SetRadarZoom(1000)
	
	Minimap = RequestScaleformMovie("minimap")
	
	Citizen.Wait(1000)
	
	CreateThread(function()
		while true do
			Citizen.Wait(5000)
						
			BeginScaleformMovieMethod(Minimap, "HIDE_SATNAV")
			EndScaleformMovieMethod()	

			BeginScaleformMovieMethod(Minimap, "SETUP_HEALTH_ARMOUR")
			ScaleformMovieMethodAddParamInt(3)
			EndScaleformMovieMethod()
		end	
	end)
	
	SetBlipAlpha(GetMainPlayerBlipId(), 0)
	SetBlipAlpha(GetNorthRadarBlip(), 0)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)		
            local pid = PlayerId()
            if NetworkIsPlayerTalking(pid) and not Talking then
                Talking = true
                HUD.SendNUIMessage('updateTalking', Talking)
            elseif not NetworkIsPlayerTalking(pid) and Talking then
                Talking = false
                HUD.SendNUIMessage('updateTalking', Talking)
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Wait(2500)            
            HUD.Active = not IsPauseMenuActive() and not Hide
            
            if Blip and DoesBlipExist(Blip) then
                RemoveBlip(Blip)
            end
    
            Blip = AddBlipForEntity(HUD.Ped)
            SetBlipSprite(Blip, (HUD.inVehicle ~= 0 and 545 or 1))
    
            SetBlipScale(Blip, 1.0)
            SetBlipCategory(Blip, 1)
            SetBlipPriority(Blip, 10)
            SetBlipColour(Blip, 55)
            SetBlipAsShortRange(Blip, true)
    
            SetBlipRotation(Blip, math.ceil(GetEntityHeading(HUD.Ped)))
            ShowHeadingIndicatorOnBlip(Blip, true)
            
            AddTextEntry('playerblip', 'Twoja pozycja')
            BeginTextCommandSetBlipName("playerblip")
            EndTextCommandSetBlipName(Blip)
        end
    end)
    UIRadar = false
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1750)
            HUD.inVehicle = GetVehiclePedIsIn(HUD.Ped, false)
            if HUD.inVehicle ~= 0 and not InVehicleMode then
                InVehicleMode = true
                DisplayRadar(true)	
                HUD.VehicleTheards()
                checkisCar = IsCar(HUD.inVehicle)
                HUD.SendNUIMessage("InVehicleMode", InVehicleMode)
            end
            if HUD.inVehicle ~= 0 and InVehicleMode then
                checkisCar = IsCar(HUD.inVehicle)
            end
            if HUD.inVehicle == 0 and InVehicleMode then
                InVehicleMode = false
                DisplayRadar(false)	
                checkisCar = true
                HUD.SendNUIMessage("InVehicleMode", InVehicleMode)
            end
            armour = GetPedArmour(HUD.Ped)
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(250)
            local health = math.floor(((GetEntityHealth(HUD.Ped) - 100) / (GetEntityMaxHealth(HUD.Ped) - 100) * 100))
            if ESX.PlayerData.dead then
                health = 0
            end
            HUD.SendNUIMessage('updateStatus', {
                oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
                health = health,
                voice = VoiceIndexes[LocalPlayer.state.proximity.index],
                armour = armour,
                sprint = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
            })
        end
    end)
end

HUD.UpdateStatus = function(data)
    if HUD.Loaded then
        local hunger, thirst
        for i = 1, #data do
            if data[i].name == 'thirst' then 
                thirst = math.floor(data[i].percent) 
            elseif data[i].name == 'hunger' then 
                hunger = math.floor(data[i].percent) 
            end
        end

        return HUD.SendNUIMessage('updateStatus', {
            hunger = hunger,
            thirst = thirst
        })
    end
end


AddEventHandler('esx_status:onTick', HUD.UpdateStatus)


function SendNotification(options)
    HUD.SendNUIMessage("sendNotify", {
        type = options.type or "info",
        message = options.message,
        title = options.title or "Powiadomienie",
        time = options.duration or 10000,
    })
end
exports("SendNotification", SendNotification)


local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_sfnotify_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

RegisterNetEvent("sfnotify", function (type, message, title, duration)
    HUD.SendNUIMessage("sendNotify", {
        type = type,
        message = message,
        title = title,
        time = duration,
    })
end)


exportHandler("notify", function (type, message, title, duration)
    HUD.SendNUIMessage("sendNotify", {
        type = type,
        message = message,
        title = title,
        time = duration,
    })
end)
local ForceCinematic = false
RegisterCommand("hud", function()
    if not ForceCinematic then
        SetNuiFocus(true, true)
        return HUD.SendNUIMessage('openSettings', {})
    else
        return false
    end
end)

RegisterNUICallback('closeSettings', function()
    SetNuiFocus(false, false)
end)

Color = "#f99406"
RegisterNUICallback('changeColor', function(data)
    Color = data.color
    TriggerEvent("mrg_ui:changeColor", data.color)
end)
exports("GetColor", function()
    return Color
end)

function Progbar(label, time)
    SendNUIMessage({
		action = "showProgressBar";
		label = label;
		duration = time;
	})
end
exports("Progbar", Progbar)
exports("Cinematic", function(data)
    ForceCinematic = data
    SendNUIMessage({
		action = "showCinematic";
		data = ForceCinematic
	})
end)


exports("CancelProgbar", function()
    SendNUIMessage({
        action = 'cancelProgressBar'
    })
end)

RegisterNUICallback('sendRequest', function(data, cb)
    TriggerEvent("progressCompleted")
end)

RegisterCommand("TestProgress", function()
    Progbar("Test", 5000)
end)

exports("ShowHelpNotification", function(message)
    SendNUIMessage({
        action = "HelpNotification",
        show = true,
        msg = message,
    })
end)

exports("HideHelpNotification", function()
    SendNUIMessage({
        action = "HelpNotification",
        show = false,
        msg = "",
    })
end)
exports("Progbar", Progbar)

exports("CancelProgbar", function()
    SendNUIMessage({
        action = 'cancelProgressBar'
    })
end)

exports("HideUI", function(toggle)
    HUD.SendNUIMessage("setVisible", {
        enabled = not toggle
    })
end)