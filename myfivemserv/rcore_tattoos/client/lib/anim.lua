--- Calculates heading to look at from target position
-- @param targetPos - position to look at
-- @return heading to look at targetPos
function getHeadingFromTarget(targetPos)
    local ped = PlayerPedId()

    local pedPos = GetEntityCoords(ped)

    local x = targetPos.x - pedPos.x
    local y = targetPos.y - pedPos.y

    return GetHeadingFromVector_2d(x, y)
end

function playAnimIdle(ped, gender)
    ClearPedTasksImmediately(ped)
    TaskPlayAnim(ped, 'move_' .. gender .. '@generic', 'idle',1.0,-1.0, -1, 1, 1, true, true, true)
end