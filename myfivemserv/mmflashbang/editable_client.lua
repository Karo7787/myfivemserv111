CanPlayerBeFlashed = function()
    -- your logic here

    return true
end

---@param flashEffect string
-- flashEffect can have 3 states: noeffect, weakeffect, flash
-- this function has to return one of those states for script
-- to work properly
OverrideFlashEffect = function(flashEffect)
    -- your logic here

    return flashEffect
end
