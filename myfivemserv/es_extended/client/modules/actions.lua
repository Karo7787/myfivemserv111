local isInVehicle, isEnteringVehicle, isJumping, inPauseMenu = false, false, false, false
local playerPed = PlayerPedId()
local current = {}

local function GetPedVehicleSeat(ped, vehicle)
    for i = -1, 16 do
        if (GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -1
end

local function GetData(vehicle)
    if not DoesEntityExist(vehicle) then
        return
    end
    local model = GetEntityModel(vehicle)
    local displayName = GetDisplayNameFromVehicleModel(model)
    local netId = VehToNet(vehicle)
    return displayName, netId
end

CreateThread(function()
    while true do
        if playerPed ~= PlayerPedId() then
            playerPed = PlayerPedId()
            ESX.SetPlayerData('ped', playerPed)
            TriggerEvent('esx:playerPedChanged', playerPed)
            TriggerServerEvent('esx:playerPedChanged', PedToNet(playerPed))
        end
        Wait(200)
    end
end)