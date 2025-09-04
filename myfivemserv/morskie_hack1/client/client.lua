--- VISUAL STUDIO CODE 
--- @diagnostic disable: missing-parameter


local MinigameActive = false
local Result = nil


StartHack1 = function(points, time, dev)
    if MinigameActive then return end

    MinigameActive = true

    SetNuiFocus(true, true)
	SendNUIMessage({
		type = 'openHack',
		devMode = dev,
		points = points,
		time = time,
	})

    while MinigameActive do
        Citizen.Wait(100)
    end

    return Result
end

RegisterNUICallback('finished', function(data, cb)
    Result = data.result
    MinigameActive = false
    SetNuiFocus(false, false)
    cb('ok')
	print(Result)
end)

exports("StartMinigame1", function(shiet, shiet2, shiet3)
    return StartHack1(shiet, shiet2, shiet3);
end)