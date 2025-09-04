local Failed = false
local Success = false

local function StartFish()
    
    SendScriptMessage("fish", {type = "ui", status = true})
    SetNuiFocus(true, true)

    while not Failed or not Success do
        Wait(1000)
        -- This will kind of fill the console up, so you can remove it if wanted.

        if Failed == true or Success == true then
            break
        end
    end

    if Failed then
        return false
    elseif Success then
        return true
    end

    -- Default to returning false, although this code should not be executed.
    return false

end 
exports("fish_StartMinigame", StartFish)

RegisterNUICallback('fish/success', function(data)
    Success = true
    SendScriptMessage("fish", {type = "ui", status = false})
    SetNuiFocus(false, false)
    Wait(2500)
    Success = false
end)

RegisterNUICallback('fish/exit', function(data)
    Failed = true
    SendScriptMessage("fish", {type = "ui", status = false})
    SetNuiFocus(false, false)
    Wait(2500)
    Failed = false
end)
