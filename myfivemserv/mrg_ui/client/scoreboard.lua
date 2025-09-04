local Scoreboard = {
    displaying = false,

    obj = nil,
    players = {},
    ping = 0
}
local playersDisplaying = {}
local r, g, b = 0, 0, 255;
local function DrawText3D(x, y, z, text, color, gscale)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2.5
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    
    if onScreen then
        SetTextScale(gscale * scale, (gscale+0.55) * scale)
        SetTextFont(0)
        SetTextColour(color[1], color[2], color[3], 200)
        SetTextDropshadow(0, 0, 5, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
		SetTextCentre(1)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
function HEXtoRGB(hexArg)

	hexArg = hexArg:gsub('#','')

	if(string.len(hexArg) == 3) then
		return tonumber('0x'..hexArg:sub(1,1)) * 17, tonumber('0x'..hexArg:sub(2,2)) * 17, tonumber('0x'..hexArg:sub(3,3)) * 17
	elseif(string.len(hexArg) == 6) then
		return tonumber('0x'..hexArg:sub(1,2)), tonumber('0x'..hexArg:sub(3,4)), tonumber('0x'..hexArg:sub(5,6))
	else
		return 0, 0, 0
	end

end
-- Citizen.CreateThread(function()
--     while true do
--         if ESX.IsPlayerLoaded() then
--             Wait(1000)
--             color = exports["mgr_hud"]:GetColor()
--             r, g, b = HEXtoRGB(color)
-- 			break
--         end
--         Wait(100)
--     end
-- end)


-- RegisterNetEvent('hud_color', function(data)
--     r, g, b = HEXtoRGB(data)
-- end)
local function DrawId()
    while Scoreboard.displaying do
        local sleep = 1
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist = 15
        local players = GetActivePlayers()
        if #players > 0 then
            r, g, b = HEXtoRGB(Color)
            for _, player in pairs(players) do
                local plyPed = GetPlayerPed(player)
                local plyCoords = GetEntityCoords(plyPed)
                if #(coords - plyCoords) <= dist then
                    local isVisible = true
                    if not IsEntityVisible(plyPed) then
                        isVisible = false
                    end

                    if isVisible then

                        if GlobalState['scoreboard_ssns'][GetPlayerServerId(player)] then
                            local boneCoords = GetPedBoneCoords(plyPed, 31086, -0.4, 0.0, 0.0)
                            if GlobalState['scoreboard_streamers'][GetPlayerServerId(player)] then
                                DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + 0.8, "#"..GetPlayerServerId(player).." ["..GlobalState['scoreboard_ssns'][GetPlayerServerId(player)].."]", (NetworkIsPlayerTalking(player) and {r, g, b} or {255, 255, 255}), 0.1)
                                DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + 0.73, "STREAMER", {190, 3, 252}, 0.1)
                            else
                                DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + 0.7, "#"..GetPlayerServerId(player).." ["..GlobalState['scoreboard_ssns'][GetPlayerServerId(player)].."]", (NetworkIsPlayerTalking(player) and {r, g, b} or {255, 255, 255}), 0.1)
                            end
                            if GlobalState['scoreboard_view'][GetPlayerServerId(player)] and PlayerId() ~= player then
                                DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + 1.0, "👀", {255, 255, 255}, 0.4)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end

local function DrawEye()
    while true do
        if GlobalState['scoreboard_view'] and not Scoreboard.displaying then
            sleep = 10
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = 15
            local players = GetActivePlayers()
            for _, player in pairs(players) do
                if GlobalState['scoreboard_view'][GetPlayerServerId(player)] and PlayerId() ~= player then
                    local plyPed = GetPlayerPed(player)
                    local plyCoords = GetEntityCoords(plyPed)
                    if #(coords - plyCoords) <= dist then
                        local isVisible = true
                        if not IsEntityVisible(plyPed) then
                            isVisible = false
                        end

                        if isVisible then
                            local boneCoords = GetPedBoneCoords(plyPed, 31086, -0.4, 0.0, 0.0)
                            DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + 0.8, "👀", {255, 255, 255}, 0.4)
                        end
                    end
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end

Citizen.CreateThread(function()
    DrawEye()    
end)

local function OpenScoreboard()
    TriggerServerEvent("checkPlayerPing")
    HUD.SendNUIMessage("openScoreboard", {
        counter     = GlobalState['scoreboard_counter'],
        code     = GlobalState['safe_code'],
        job = ESX.GetPlayerData().job,
        ping = Scoreboard.ping,
        slots       = 64
    })
end

local function CloseScoreboard()
    HUD.SendNUIMessage("closeScoreboard")
end

local function LoadDict(dict)
    while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

RegisterCommand('+scoreboard', function()
    Scoreboard.displaying = true
    TriggerServerEvent("kossek-scoreboard:SetShowing", true)
    TriggerEvent("pixel_antiCL:ToggleShow", true)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    OpenScoreboard()
    Citizen.CreateThread(function()
        DrawId()    
    end)
end)

RegisterCommand('-scoreboard', function()
    local playerPed = PlayerPedId()
    TriggerServerEvent("kossek-scoreboard:SetShowing", false)
    TriggerEvent("pixel_antiCL:ToggleShow", false)
    if Scoreboard.displaying then
        Scoreboard.displaying = false
    end

    CloseScoreboard()
end)

RegisterKeyMapping('+scoreboard', 'Show scoreboard', 'keyboard', Config.Key)

RegisterNetEvent("playerPingResult")
AddEventHandler("playerPingResult", function(ping)
    Scoreboard.ping = ping
end)