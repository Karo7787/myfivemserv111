exports('OpenRadio', function()
    TriggerServerEvent('mrg_radiocar:server:OpenRadio')
end)

RegisterNetEvent('mrg_radiocar:client:OpenRadio', function(data)
    if (data.vehicle) then
        if exports['xsound']:soundExists(data.plate) then
            data.vehicle.time = exports['xsound']:getTimeStamp(data.plate)
            data.vehicle.duration = exports['xsound']:getMaxDuration(data.plate)
        else
            data.vehicle.time, data.vehicle.duration = 0, 0
        end
    end
    SendNUIMessage({action = 'OpenRadio', radio = data, lang = Config.Translation[Config.Language]})
    SetNuiFocus(true, true)
end)


ESX = exports.es_extended:getSharedObject();
Citizen.CreateThread(function()
    while true do
        if ESX.IsPlayerLoaded() then
            Wait(1000)
            color = exports["mrg_ui"]:GetColor()
            SendNUIMessage({action = 'updatecolor', color = color})
            break
        end
        Wait(100)
    end
end)
RegisterNetEvent('mrg_ui:changeColor', function(data)
    SendNUIMessage({action = 'updatecolor', color = data})
end)


RegisterNUICallback('CloseRadio', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('PlayMusic', function(data)
    local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    data.model = GetDisplayNameFromVehicleModel(GetEntityModel(plyVeh))
    TriggerServerEvent('mrg_radiocar:server:PlayMusic', data)
end)

RegisterNUICallback('StopMusic', function(data)
    TriggerServerEvent('mrg_radiocar:server:StopMusic', data)
end)

RegisterNUICallback('SaveMusic', function(data)
    TriggerServerEvent('mrg_radiocar:server:SaveMusic', data)
end)

RegisterNetEvent('mrg_radiocar:client:RadioTime', function(data)
    local duration = exports['xsound']:getMaxDuration(data.plate)
    local time = exports['xsound']:getTimeStamp(data.plate)
    SendNUIMessage({action = 'RadioTime', duration = duration, time = time})
end)

RegisterNUICallback('ToggleLoop', function(data)
    TriggerServerEvent('mrg_radiocar:server:ToggleLoop', data)
end)

RegisterNetEvent('mrg_radiocar:client:LoopRadio', function(data)
    exports['xsound']:setSoundLoop(data.name, data.toggle)
end)

RegisterNetEvent('mrg_radiocar:client:Dynamic', function(data)
    exports['xsound']:setSoundDynamic(data.name, true)
end)

RegisterNUICallback('ChangeVolume', function(data)
    TriggerServerEvent('mrg_radiocar:server:ChangeVolume', data)
end)