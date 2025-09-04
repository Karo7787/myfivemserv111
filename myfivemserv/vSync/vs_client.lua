ESX = exports.es_extended:getSharedObject()
CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false
local hour = 0
local minute = 0
local Config = {
    timeScale = 5000,
    timeScaleNight = 2500,
    nightTime = {
        beginning = 22,
        ending = 6
    }
}

local currentScale = Config.timeScale
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if (hour > Config.nightTime.beginning or hour < Config.nightTime.ending) and currentScale ~= Config.timeScaleNight then
            currentScale = Config.timeScaleNight
            timeScale = currentScale
        elseif (hour < Config.nightTime.beginning and hour > Config.nightTime.ending) and currentScale ~= Config.timeScale then
            currentScale = Config.timeScale
            timeScale = currentScale
        end
        NetworkOverrideClockMillisecondsPerGameMinute(timeScale)
    end
end)

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        SetArtificialLightsState(blackout)
        SetArtificialLightsStateAffectsVehicles(false)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                SetVehicleUseAlternateHandling(GetVehiclePedIsIn(PlayerPedId(), false), false)
            end
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Zmieniono pogode', {{ name="weatherType", help="Dostępny tryby: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Zmieniono godzine.', {{ name="hours", help="Numer od 0 do 23"}, { name="minutes", help="Numer od 0 do 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Zatrzymaj / Wznów czas.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Włączona / Wyłączona Pogoda.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Ustawiono na godzine 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Ustawiono na godzine 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Ustawiono na godzine 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Ustawiono na godzine 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Włączono blackout.')
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ESX.ShowNotification(message)
end)