target = nil

PlayerServerId = GetPlayerServerId(PlayerId())
InNewspaperJob = false
DeliveredNewspaper = false

Citizen.CreateThread(function()
    Citizen.Wait(21000)
    CreateInteraction("newsPickupInteraction", {
        coords = Config.PickUpPeds.Coords.xyz,
        range = Config.PickUpPeds.StandaloneInteractRange or 2.0,
        controls = {
            {
                label = _L("newspapersStartJobStandalone"),
                disabled = Config.PickUpPeds.StandaloneControls.StartJob.disabled,
                key = Config.PickUpPeds.StandaloneControls.StartJob.key,
                action = StartJob,
                canInteract = CanStartStopJob
            },
            {
                label = _L("newspapersGetMoneyStandalone"),
                disabled = Config.PickUpPeds.StandaloneControls.GetMoney.disabled,
                key = Config.PickUpPeds.StandaloneControls.GetMoney.key,
                action = GetMoney,
                canInteract = CanGetMoney
            },
        }
    }, {
        fromModel = Config.PickUpPeds.Model,
        zone = {
            coords = Config.PickUpPeds.Coords,
        },
        options = {
            {
                icon = "fas fa-hands",
                label = _L("startJobInteraction"),
                action = StartJob,
                canInteract = CanStartStopJob,
                distance = Config.PickUpPeds.TargetsInteractRange or 2.0,
            },
            {
                icon = "fas fa-hands",
                label = _L("getMoneyInteraction"),
                action = GetMoney,
                canInteract = CanGetMoney,
                distance = Config.PickUpPeds.TargetsInteractRange or 2.0,
            },
        }
    })
end)

Citizen.CreateThread(function()
	Citizen.Wait(20000)
	LoadModel(Config.PickUpPeds.Model)
	SpawnPed(Config.PickUpPeds.Model, Config.PickUpPeds.Coords + vec4(0.0, 0.0, -0.95, 0.0))

	if Config.PickUpPeds.Blip then
		AddBlipForCoord2(
			Config.PickUpPeds.Blip.Text,
			Config.PickUpPeds.Blip.Sprite,
			Config.PickUpPeds.Blip.Color,
			Config.PickUpPeds.Blip.Scale,
			Config.PickUpPeds.Coords.xyz
		)
	end
end)

---@return boolean
CanStartStopJob = function()
    return true
end

---@return boolean
CanGetMoney = function()
    return InNewspaperJob and DeliveredNewspaper
end

---@param notification string
HudAddNotification = function(notification)
    if GetResourceState("es_extended") ~= "missing" then
        TriggerEvent("esx:showNotification", notification)
    elseif GetResourceState("qb-core") ~= "missing" then
        TriggerEvent("QBCore:Notify", notification)
    else
        ShowNotification("Paperroute", notification, "")
    end
end

---@param title string
---@param subtitle string
---@param message string
---@param backgroundColor number
---@param notifImage string
---@param iconType number
---@return number
ShowNotification = function(title, subtitle, message, backgroundColor, notifImage, iconType)
	AddTextEntry("tcpNotification", message)
    BeginTextCommandThefeedPost("tcpNotification")
    if backgroundColor then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle)
    return EndTextCommandThefeedPostMpticker(false, true)
end

RegisterNetEvent("mmpaperroute:notify", function(text)
    HudAddNotification(text)
end)

AddStateBagChangeHandler("InNewspaperJob", ("player:%s"):format(PlayerServerId), function(bagName, key, value, reserved, replicated)
	InNewspaperJob = value
end)

AddStateBagChangeHandler("DeliveredNewspaper", ("player:%s"):format(PlayerServerId), function(bagName, key, value, reserved, replicated)
	DeliveredNewspaper = value
end)