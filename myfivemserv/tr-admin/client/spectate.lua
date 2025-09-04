Spectate = {
    selectedPlayer = false,
    lastCoords = false
}
local function createSpectatorTeleportThread()
    CreateThread(function()
        while Spectate.selectedPlayer ~= false do
            -- If ped doesn't exist anymore try to resolve it again
            local targetPed = GetPlayerPed(GetPlayerFromServerId(Spectate.selectedPlayer))

            -- Update Teleport
            local newSpectateCoords = GetEntityCoords(targetPed)
            SetEntityCoords(PlayerPedId(), newSpectateCoords + vector3(0, 0, 10))
            Wait(500)
        end
    end)
end
function StartSpectate(serverId)
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do Wait(5) end

    local localPed = PlayerPedId()
    if not Spectate.lastCoords then
        Spectate.lastCoords = GetEntityCoords(localPed)
    end
    local serverId = tonumber(serverId)
    if serverId == GetPlayerServerId(PlayerId()) then
        DoScreenFadeIn(250)
        while IsScreenFadingIn() do Wait(5) end
        return
    end

    Spectate.selectedPlayer = serverId

    ESX.TriggerServerCallback("tr-admin:requestPlayerCoords", function(competed, coords)
        if not competed then
            Spectate.lastCoords = false
            Spectate.selectedPlayer = false
            return
        end

        RequestCollisionAtCoord(coords)
        SetEntityVisible(localPed, false)
        SetEntityCoords(localPed, coords + vector3(0, 0, 10))
        FreezeEntityPosition(localPed, true)
        Wait(500)

        local targetPed = GetPlayerPed(GetPlayerFromServerId(serverId))
        NetworkSetInSpectatorMode(true, targetPed)
        ShowNames = true
        DoScreenFadeIn(250)
        while IsScreenFadingIn() do Wait(5) end
        createSpectatorTeleportThread()
    end, serverId)
end
local DrawTitle = function(text, width, height)
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextDropshadow(1.0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextColour(255, 255, 255, 215)
    SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.04)

    DrawRect(0.425+(width/3), 0.01+(height/2), width, height, 11, 11, 11, 200)
end

-- RegisterCommand("-StopSpectate", function ()
--     Spectate.selectedPlayer = false

--     if Spectate.lastCoords then
--         local localPed = PlayerPedId()

--         RequestCollisionAtCoord(Spectate.lastCoords)
--         NetworkSetInSpectatorMode(false, localPed)
--         FreezeEntityPosition(localPed, false)
--         SetEntityCoords(localPed, Spectate.lastCoords)
--         SetEntityVisible(localPed, true)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustPressed(1, 38) then 
            if Spectate.selectedPlayer ~= false then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do Wait(500) end
                Spectate.selectedPlayer = false
                ShowNames = false

                if Spectate.lastCoords then
                    local localPed = PlayerPedId()

                    RequestCollisionAtCoord(Spectate.lastCoords)
                    NetworkSetInSpectatorMode(false, localPed)
                    FreezeEntityPosition(localPed, false)
                    SetEntityCoords(localPed, Spectate.lastCoords)
                    SetEntityVisible(localPed, true)
                end
                Wait(750)
                DoScreenFadeIn(250)
                while IsScreenFadingIn() do Wait(5) end
            end
        end
        if Spectate.selectedPlayer ~= false then
            local targetPed = GetPlayerPed(GetPlayerFromServerId(Spectate.selectedPlayer))
            local coords = GetEntityCoords(targetPed)
            local location = ""
            local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y,
            coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
            if GetStreetNameFromHashKey(var2) ~= '' then
                location = GetStreetNameFromHashKey(var1) .. ', ' .. GetStreetNameFromHashKey(var2)
            else
                location = GetStreetNameFromHashKey(var1)
            end
            DrawTitle("~y~"..GetPlayerName(GetPlayerFromServerId(Spectate.selectedPlayer)).."~w~\n\nHealth - ~y~"..GetEntityHealth(targetPed).."~w~\nArmor - ~y~"..GetPedArmour(targetPed).."~w~\n[~y~E~w~] - Quit", 0.23, 0.22)
        end
    end
end)

RegisterKeyMapping("-StopSpectate", locale("adminmenu.spectatestop"), "keyboard", "E")
