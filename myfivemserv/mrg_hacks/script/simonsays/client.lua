local Failed = false
local Success = false

---@param buttonGrid number || description: "Whole Number Between 3-6. It determines the size of the grid. Example: 4 = 4x4 grid."
---@param length number || description: "Whole Number. It determines the maximum amount of time someone has to complete the puzzle."

local function StartSimonSays(buttonGrid, length)
    if not buttonGrid then
        buttonGrid = Config.DefaultGridSize
    end

    if not length then
        length = Config.DefaultLength
    end

    -- Anything over 6, disallow, because it is too big!
    if buttonGrid > 6 then buttonGrid = 6 end
    
    SendScriptMessage("simonsays", {starthack = true, buttonGrid = buttonGrid, length = length})
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
exports("simonsays_StartSimonSays", StartSimonSays)

RegisterNUICallback('simonsays/success', function(data)
    Success = true
    SetNuiFocus(false, false)
    Wait(2500)
    Success = false
end)

RegisterNUICallback('simonsays/failed', function(data)
    Failed = true
    SetNuiFocus(false, false)
    Wait(2500)
    Failed = false
end)
