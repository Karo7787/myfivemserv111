local speedmultipliers = {
    kmh = 3.6,
    mph = 2.236936
}
local firstenabled = false

PlayerisAllowed = function (playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
        local _, weapon = GetCurrentPedWeapon(PlayerPedId())
        if Config.WeaponBlackList[weapon] then
            return false
        end
        vehicle = GetVehiclePedIsIn(playerPed, false)
        if Config.AllowedTypes[GetVehicleType(vehicle)] ~= nil and Config.AllowedTypes[GetVehicleType(vehicle)] then
            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                if Config.DriverAllowed then
                    if GetEntitySpeed(vehicle) * speedmultipliers[Config.SpeedUnit] < Config.MaxSpeed then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            else
                if GetEntitySpeed(vehicle) * speedmultipliers[Config.SpeedUnit] < Config.MaxSpeed then
                    if IsPlayerFreeAiming(PlayerId()) then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end
        else
            return false
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100 * Config.RefreshRate)
        playerPed = PlayerPedId()
        vehicle = GetVehiclePedIsIn(playerPed, false)
        if PlayerisAllowed(playerPed) then
			SetPlayerCanDoDriveBy(PlayerId(), true)
        else
			SetPlayerCanDoDriveBy(PlayerId(), false)
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Wait(1)
        playerPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(playerPed) then
            if IsPlayerFreeAiming(PlayerId()) then
                if GetFollowVehicleCamViewMode() ~= 4 and not firstenabled or firstenabled then
                    firstenabled = true
                    SetFollowVehicleCamViewMode(4)
                end
            else
                if GetFollowVehicleCamViewMode() == 4 and firstenabled then
                    firstenabled = false
                    SetFollowVehicleCamViewMode(0)
                end
            end
        else
            Citizen.Wait(500)
            if GetFollowVehicleCamViewMode() == 4 and firstenabled then
                firstenabled = false
                SetFollowVehicleCamViewMode(0)            
            end
        end
    end
end)


-- RegisterCommand("bluiCircleSum", function()
--     local success = exports.bl_ui:CircleSum(3, {
--         length = 4,
--         duration = 10000,
--     })
-- end)


-- RegisterCommand("bluiDigitDazzle", function()
--     local success = exports.bl_ui:DigitDazzle(1, {
--         length = 3,
--         duration = 30000,
--     })
-- end)

-- RegisterCommand("bluiLightsOut", function()
--     local success = exports.bl_ui:LightsOut(3, {
--         level = 2,
--         duration = 25000,
--     })
-- end)

-- RegisterCommand("bluiMineSweeper", function()
--     local success = exports.bl_ui:MineSweeper(3, {
--         grid = 4, -- grid 4x4
--         duration = 10000, -- 10sec to fail
--         target = 4, --target you need to remember
--         previewDuration = 2000 --preview duration (time for red mines preview to hide)
--     })
-- end)


-- RegisterCommand("bluiPathFind", function()
--     local success = exports.bl_ui:PathFind(3, {
--         numberOfNodes = 10,
--         duration = 25000,
--     })
-- end)

-- RegisterCommand("bluiPrintLock", function()
--     local success = exports.bl_ui:PrintLock(3, {
--         grid = 4,
--         duration = 25000,
--         target = 4
--     })
-- end)

-- RegisterCommand("bluiUntangle", function()
--     local success = exports.bl_ui:Untangle(3, {
--         numberOfNodes = 10,
--         duration = 25000,
--     })
-- end)

-- RegisterCommand("bluiWaveMatch", function()
--     local success = exports.bl_ui:WaveMatch(3, {
--         duration = 25000,
--     })
-- end)

-- RegisterCommand("bluiWordWiz", function()
--     local success = exports.bl_ui:WordWiz(3, {
--         length = 4,
--         duration = 25000,
--     })
-- end)



-- RegisterCommand("bluiWordWiz2", function()
--     local success = exports.bl_ui:KeyCircle(2, 50, 2)

-- end)

-- RegisterCommand("bluiWordWiz3", function()
--     local success = exports.bl_ui:KeySpam(2, 75)

-- end)

