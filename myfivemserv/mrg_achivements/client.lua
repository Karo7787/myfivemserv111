local ConfigLoaded = false
-- local CanClaim = true
local PlayerAchivements = nil
local isDead = 0

-- RegisterCommand("testing", function ()
--     if not ConfigLoaded then
--         SendNUIMessage({
--             action = 'LoadConfig',
--             config = Config.Achivements
--         })
--         ConfigLoaded = true
--     end
--     ESX.TriggerServerCallback('mrg_achivements:GetAchivements', function(CallbackData) 
--         PlayerAchivements = CallbackData
--         SendNUIMessage({
--             action = 'Open',
--             playerAchivments = CallbackData
--         })
--         SetNuiFocus(true, true)
--     end)
-- end)

exports('OpenAchivements', function()
    if not ConfigLoaded then
        SendNUIMessage({
            action = 'LoadConfig',
            config = Config.Achivements
        })
        ConfigLoaded = true
    end
    ESX.TriggerServerCallback('mrg_achivements:GetAchivements', function(CallbackData) 
        PlayerAchivements = CallbackData
        SendNUIMessage({
            action = 'Open',
            playerAchivments = CallbackData
        })
        SetNuiFocus(true, true)
    end)
end)

RegisterNUICallback('Close', function()
    SetNuiFocus(false, false)
end)

-- RegisterCommand("chuj2", function()
--     if not exports['mrg_achivements']:CheckIsUnlocked('zakup-w-vehicle') then
--         TriggerServerEvent("mrg_achivements:UnlockAchivements", "zakup-w-vehicle", 1)
--     end
--end)

RegisterNetEvent('mrg_achivements:UnlockAchivement', function(AchivementID)
    if not ConfigLoaded then
        SendNUIMessage({
            action = 'LoadConfig',
            config = Config.Achivements
        })
        ConfigLoaded = true
    end
    SendNUIMessage({
        action = 'updatePosition',
        death = LocalPlayer.state.isDead
    })
    SendNUIMessage({
        action = 'achivmentUnlocked',
        id = AchivementID
    })
end)

RegisterNUICallback('ClaimReward', function(data)
    TriggerServerEvent('mrg_achivements:ClaimReward', data.AchivementID)
end)

exports('CheckIsUnlocked', function(AchivementID)
    ESX.TriggerServerCallback('mrg_achivements:GetAchivements', function(CallbackData) 
        PlayerAchivements = CallbackData
    end)
    Citizen.Wait(1000)
    for k, v in pairs(PlayerAchivements) do
        if v.id == AchivementID then
            return v.dateUnlocked ~= 'N/A'
        end
    end
    return false
end)