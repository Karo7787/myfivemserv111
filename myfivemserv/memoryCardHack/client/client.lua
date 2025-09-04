
ESX = exports['es_extended']:getSharedObject()

local MinigameActive = false
local MinigameFinished = false
local Success = false
local SuccessTrigger = nil
local FailTrigger = nil

function MemoryCardHack(cb) 
    if MinigameActive then return end

        SetNuiFocus(true, true)
        SendNUIMessage({type = 'otworz'})
        MinigameActive = true
        MinigameFinished = false

        while MinigameActive do
            Citizen.Wait(500)
        end

        if cb then
            cb(Success)
        end

        return Success
    end

exports('MemoryCardHack', MemoryCardHack)


RegisterNUICallback('udane', function(data, cb)
SetNuiFocus(false, false)
Success = true
MinigameFinished = false
MinigameActive = false
cb('ok')
end)

RegisterNUICallback('nieudane', function(data, cb)
SetNuiFocus(false, false)
MinigameActive = false
Success = false
cb('ok')
end)