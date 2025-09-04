ESX = nil
QBCore = nil

if Config.UseESX then
    ESX = exports.es_extended:getSharedObject();
    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
            --Gives The Player FireHose Perms
            TriggerEvent('fhose:canUseNozzles', true)
        else 
            --Remove The FireHose Perms
            TriggerEvent('fhose:canUseNozzles', false)
        end
    end
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
            --Gives The Player FireHose Perms
            TriggerEvent('fhose:canUseNozzles', true)
        else 
            --Remove The FireHose Perms
            TriggerEvent('fhose:canUseNozzles', false)
        end
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
        if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
            --Gives The Player FireHose Perms
            TriggerEvent('fhose:canUseNozzles', true)
        else
            --Remove The FireHose Perms
            TriggerEvent('fhose:canUseNozzles', false)
        end
    end)
end

AddEventHandler('fhose:onPumpBreak', function()
    ESX.ShowNotification("Zniszczyłeś wąż!")
    exports.mrg_firefighter:DisableFireTarget()
end)

AddEventHandler('Client:HoseCommandDisabled', function()
    exports.mrg_firefighter:DisableFireTarget()
end)

AddEventHandler('Client:HoseCommandEnabled', function()
    exports.mrg_firefighter:EnableFireTarget(0.1, function(index, dist)
        return dist < 20.0
    end)
end)

AddEventHandler('fhose:requestEquipPump', function()
    if Config.UseESX then
        --You can do checks here for inventory or other stuff
        TriggerEvent("fhose:equipPump")
    elseif Config.UseQBUS then
        --You can do checks here for inventory or other stuff
        TriggerEvent("fhose:equipPump")
	else 
        TriggerEvent("fhose:equipPump")
    end
end)

AddEventHandler('fhose:playSplashParticle', function(pdict, pname, posx, posy, posz, heading)
	Citizen.CreateThread(function()
        UseParticleFxAssetNextCall(pdict)
        local pfx = StartParticleFxLoopedAtCoord(pname, posx, posy, posz, 0.0, 0.0, heading, 1.0, false, false, false, false)
        Citizen.Wait(200)
        StopParticleFxLooped(pfx, 0)
    end)
end)

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end