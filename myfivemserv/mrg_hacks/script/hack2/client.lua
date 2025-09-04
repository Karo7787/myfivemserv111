--- VISUAL STUDIO CODE 
--- @diagnostic disable: missing-parameter


local MinigameActive = false
local Result = nil


StartHack2 = function(count, dev)
    if MinigameActive then return end

    MinigameActive = true

    SetNuiFocus(true, true)
	SendScriptMessage("hack2", {
		type = 'openHack',
		devMode = dev,
		questions = count,
	})

    while MinigameActive do
        Citizen.Wait(100)
    end

    return Result
end

RegisterNUICallback('hack2/finished', function(data, cb)
    Result = data.result
    MinigameActive = false
    SetNuiFocus(false, false)
    cb('ok')
	print(Result)
end)

exports("hack2_StartMinigame2", function(shiet, shiet2)
    return StartHack2(shiet, shiet2);
end)