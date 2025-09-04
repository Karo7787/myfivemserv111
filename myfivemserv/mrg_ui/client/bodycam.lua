BodyCamVisible = false
local lastState = nil
CreateThread(function()
	while true do
		local thisState = not IsPauseMenuActive() and BodyCamVisible
		if thisState ~= lastState then
            HUD.SendNUIMessage("toggleBodycam", {
                show = thisState
            })
			lastState = thisState
		end
		Wait(250)
	end
end)


local ToggleBodyCam = function(name)
	BodyCamVisible = not BodyCamVisible
	HUD.SendNUIMessage("updateBodycam", {
        name = name,
        department = ESX.PlayerData.job.grade_label .." - "..ESX.PlayerData.job.label,
        color = Config.BodycamColors[ESX.PlayerData.job.name] and Config.BodycamColors[ESX.PlayerData.job.name] or Config.BodycamColors["default"]
    })
end
RegisterNetEvent("mrg_ui:removeBodycam", function()
    BodyCamVisible = false
end)
RegisterNetEvent("mrg_ui:bodycam:update", ToggleBodyCam)
exports("TogglePiotreqBodyCam", function(data)
    
	BodyCamVisible = data.state
    if data.data then
    	HUD.SendNUIMessage("updateBodycam", {
            name = '['..data.data.badge..'] '..data.data.name,
            department = ESX.PlayerData.job.grade_label .." - "..ESX.PlayerData.job.label,
            color = Config.BodycamColors[ESX.PlayerData.job.name] and Config.BodycamColors[ESX.PlayerData.job.name] or Config.BodycamColors["default"]
        })
    end
end)