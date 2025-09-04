ESX = exports['es_extended']:getSharedObject()
PlayersCommand3d = {}
PlayersDescriptions = {}

local playerGroup = "user"

Citizen.CreateThread(function()
    Citizen.Wait(1000*5)
    while true do
        if PlayerLoad then 
            ESX.TriggerServerCallback("esx_rpchat:getGroup", function(PlayerGroup)
                playerGroup = PlayerGroup
            end)
        end
        Citizen.Wait(1000*120)
   end
end)


local PlayerLoad = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerLoad = true
    TriggerServerEvent("esx_rpchat:getDescription")
    CreateTemplates()
    Citizen.Wait(1000*5)
    ESX.TriggerServerCallback("esx_rpchat:getGroup", function(PlayerGroup)
        playerGroup = PlayerGroup
    end)
end)

RegisterCommand("cls", function()
	TriggerEvent("chat:addMessage", {
		templateId = "message",
		multiline = true,
		args = {"100, 0, 0", "fa-solid fa-comment-alt-dots", "INFORMACJA", "Rozpoczęto czyszczenie chatu", "SYSTEM"}
	})
    Citizen.Wait(2500)
    TriggerEvent("chat:clear")
end, false)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job, response)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	ESX.PlayerData.hiddenjob = hiddenjob
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group)
    playerGroup = group
end)


RegisterNetEvent("esx_rpchat:sendMessage", function(src, message, playerName, time)
    local player = GetPlayerFromServerId(src)
    if player == -1 then
        return
    end

    local pPed = GetPlayerPed(player)
    local mPed = PlayerPedId()
    local distance = #(GetEntityCoords(pPed) - GetEntityCoords(mPed))
    if player == PlayerId() or distance < 15.0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"212, 212, 212", "fa-solid fa-comment-alt-dots", "[" .. src .. "] " .. playerName, message, time},
        })
    end
end)

RegisterNetEvent('esx_rpchat:sendProximityMessage')
AddEventHandler('esx_rpchat:sendProximityMessage', function(type, id, template, args, d3dcolor, action, icon)
    if action == nil then
        action = ""
    else
        action = "["..action.."] "
    end
    local mId = PlayerId()
    local tId = GetPlayerFromServerId(id)
    -- if tId == -1 then return end
    if type == "ooc" then
        local mPed = GetPlayerPed(mId)
        local tPed = GetPlayerPed(tId)
        local mCoords = GetEntityCoords(mPed)
        local tCoords = GetEntityCoords(tPed)
        local distance = #(mCoords - tCoords)
        if tId == mId then
            TriggerEvent("chat:addMessage", {
                templateId = "message",
                multiline = true,
                args = {"159, 159, 159", "fa-solid fa-comment-alt-dots", "[" .. id .. "] " .. args[2], args[3], args[4]},
            })
        elseif distance < Config.Distance then
            if NetworkIsPlayerActive(tId) then
                TriggerEvent("chat:addMessage", {
                    templateId = "message",
                    multiline = true,
                    args = {"159, 159, 159", "fa-solid fa-comment-alt-dots", "[" .. id .. "] " .. args[2], args[3], args[4]},
                })
            end
        end
    elseif type == "me" or type == "do" or type == "med" or type == "try" or type == "if" then
        local mPed = GetPlayerPed(mId)
        local tPed = GetPlayerPed(tId)
        local mCoords = GetEntityCoords(mPed)
        local tCoords = GetEntityCoords(tPed)
        local distance = #(mCoords - tCoords)
        if GetPedDrawableVariation(tPed, 1) ~= 0 then
            args[2] = "Osoba Zamaskowana"
        end 
        if tId == mId then
            TriggerEvent("chat:addMessage", {
                templateId = "message",
                multiline = true,
                args = {""..d3dcolor[1]..", "..d3dcolor[2]..", "..d3dcolor[3], icon and icon or "fa-solid fa-comment-alt-dots", "[" .. id .. "] " .. args[2], args[3], args[4]},
            })
        elseif distance < Config.Distance then
            if NetworkIsPlayerActive(tId) then
                TriggerEvent("chat:addMessage", {
                    templateId = "message",
                    multiline = true,
                    args = {""..d3dcolor[1]..", "..d3dcolor[2]..", "..d3dcolor[3], icon and icon or "fa-solid fa-comment-alt-dots", "[" .. id .. "] " .. args[2], args[3], args[4]},
                })
            end
        end
        -- local number = 1
        -- if PlayersCommand3d[id] ~= nil then
        --     number = #PlayersCommand3d[id] + 1
        -- else
        --     PlayersCommand3d[id] = {}
        -- end
        -- PlayersCommand3d[id][number] = {text = action..args[3], color = d3dcolor}
        -- Citizen.Wait(6000)
        -- if id and number and PlayersCommand3d[id][number] then
        --     PlayersCommand3d[id][number] = nil
        -- end
        -- if #PlayersCommand3d[id] == 0 then
        --     PlayersCommand3d[id] = nil
        -- end
    elseif type == "ogloszenie" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 61, 61", "fa-solid fa-bullhorn", "Ogłoszenie: " .. args[2], args[3], args[4]},
        })
    elseif type == "report" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 164, 61", "fa-solid fa-bullhorn", "Report: [" ..id.."] ".. args[2], args[3], args[4]},
        })
    elseif type == "ambulance" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"247, 77, 77", "fa-solid fa-bullhorn", "Ogłoszenie EMS", args[3], args[4]},
        })
    elseif type == "police" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"77, 173, 247", "fa-solid fa-bullhorn", "Ogłoszenie LSPD", args[3], args[4]},
        })
    elseif type == "mechanik" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"247, 213, 77", "fa-solid fa-bullhorn", "Ogłoszenie LSC", args[3], args[4]},
        })
    elseif type == "news" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"219, 255, 77", "fa-solid fa-bullhorn", "Ogłoszenie: "..args[2], args[3], ""},
        })
    elseif type == "error" then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"219, 255, 77", "fa-solid fa-x", "Błąd", args[1], args[2]},
        })
    elseif type == "wiezienie" then
        TriggerEvent('chat:addMessage', {
            template = Config.Templates['wiezienie'],
            args = args
        })
    end
end)

RegisterNetEvent('esx_rpchat:sendDescription')
AddEventHandler('esx_rpchat:sendDescription', function(k)
    PlayersDescriptions = k
end)

local meWait = 0
RegisterCommand("me", function(a, args)
    if meWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. meWait .. " sekund przed napisaniem następnego ME!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendMe", args)
    meWait = 5
    while meWait > 0 do
        Wait(1000)
        meWait = meWait - 1
    end
end)

local ifWait = 0
RegisterCommand("if", function(a, args)
    if ifWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. ifWait .. " sekund przed napisaniem następnego IF!", ""},
        })

        return
    end
    TriggerServerEvent("esx_rpchat:sendIf", args)
    ifWait = 5
    while ifWait > 0 do
        Wait(1000)
        ifWait = ifWait - 1
    end
end)

local medWait = 0
RegisterCommand("med", function(a, args)
    if medWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. medWait .. " sekund przed napisaniem następnego MED!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendMed", args)
    medWait = 5
    while medWait > 0 do
        Wait(1000)
        medWait = medWait - 1
    end
end)

local doWait = 0
RegisterCommand("do", function(a, args)
    if doWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. doWait .. " sekund przed napisaniem następnego DO!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendDo", args)
    doWait = 5
    while doWait > 0 do
        Wait(1000)
        doWait = doWait - 1
    end
end)

local tryWait = 0
RegisterCommand("try", function(a, args)
    if tryWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. tryWait .. " sekund przed napisaniem następnego TRY!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendTry", args)
    tryWait = 5
    while tryWait > 0 do
        Wait(1000)
        tryWait = tryWait - 1
    end
end)

local reportWait = 0
RegisterCommand("report", function(a, args)
    if reportWait > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. reportWait .. " sekund przed napisaniem następnego reporta!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendReport", args)
    reportWait = 15
    while reportWait > 0 do
        Wait(1000)
        reportWait = reportWait - 1
    end
end)

local DPPACKFrakcje = {
    ['mechanik'] = 0,
    ['police'] = 0,
    ['ambulance'] = 0,
}

RegisterCommand("ems", function(a, args)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade_name == 'boss' then
        if DPPACKFrakcje[ESX.PlayerData.job.name] > 0 then
            TriggerEvent("chat:addMessage", {
                templateId = "message",
                multiline = true,
                args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. DPPACKFrakcje[ESX.PlayerData.job.name] .. " sekund przed napisaniem następnego ogłoszenia!", ""},
            })
            return
        end
        TriggerServerEvent("esx_rpchat:sendOgloszenieFrakcyjne", args)
        DPPACKFrakcje[ESX.PlayerData.job.name] = 30
        while DPPACKFrakcje[ESX.PlayerData.job.name] > 0 do
            Wait(1000)
            DPPACKFrakcje[ESX.PlayerData.job.name] = DPPACKFrakcje[ESX.PlayerData.job.name] - 1
        end
    end
end)

AD = 0

RegisterCommand("ad", function(a, args)
    if AD > 0 then
        TriggerEvent("chat:addMessage", {
            templateId = "message",
            multiline = true,
            args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj "..AD.. " sekund przed napisaniem następnego ogłoszenia!", ""},
        })
        return
    end
    TriggerServerEvent("esx_rpchat:sendNews", args)
    AD = 30
    while AD > 0 do
        Wait(1000)
        AD = AD - 1
    end
end)

RegisterCommand("lspd", function(a, args)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
        if DPPACKFrakcje[ESX.PlayerData.job.name] > 0 then
            TriggerEvent("chat:addMessage", {
                templateId = "message",
                multiline = true,
                args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. DPPACKFrakcje[ESX.PlayerData.job.name] .. " sekund przed napisaniem następnego ogłoszenia!", ""},
            })
            return
        end
        TriggerServerEvent("esx_rpchat:sendOgloszenieFrakcyjne", args)
        DPPACKFrakcje[ESX.PlayerData.job.name] = 30
        while DPPACKFrakcje[ESX.PlayerData.job.name] > 0 do
            Wait(1000)
            DPPACKFrakcje[ESX.PlayerData.job.name] = DPPACKFrakcje[ESX.PlayerData.job.name] - 1
        end
    end
end)

RegisterCommand("lsc", function(a, args)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanik' and ESX.PlayerData.job.grade_name == 'boss' then
        if DPPACKFrakcje[ESX.PlayerData.job.name] > 0 then
            TriggerEvent("chat:addMessage", {
                templateId = "message",
                multiline = true,
                args = {"255, 82, 66", icon and icon or "fa-solid fa-comment-alt-dots", "Błąd", "Odczekaj " .. DPPACKFrakcje[ESX.PlayerData.job.name] .. " sekund przed napisaniem następnego ogłoszenia!", ""},
            })

            return
        end
        TriggerServerEvent("esx_rpchat:sendOgloszenieFrakcyjne", args)
        DPPACKFrakcje[ESX.PlayerData.job.name] = 30
        while DPPACKFrakcje[ESX.PlayerData.job.name] > 0 do
            Wait(1000)
            DPPACKFrakcje[ESX.PlayerData.job.name] = DPPACKFrakcje[ESX.PlayerData.job.name] - 1
        end
    end
end)

Draw3dMessage = function(position, text, color, rect)
    local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    if rect then
        local factor = text:len() / 325
	    DrawRect(_x, _y + 0.0125, 0.008 + factor, 0.025, color[1], color[2], color[3], 200)
    end
end

Citizen.CreateThread(function()
    local PlayerVisibleCommand3d = {}
    while true do
        Citizen.Wait(5)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for b, id in ipairs(GetActivePlayers()) do
            local desc = PlayersCommand3d[GetPlayerServerId(id)]
            if desc then
                local a = GetPlayerServerId(id)
                PlayerVisibleCommand3d[a] = 0
                for k,v in pairs(desc) do
                    local targetPed = GetPlayerPed(GetPlayerFromServerId(a))
                    if DoesEntityExist(targetPed) then
                        if HasEntityClearLosToEntity(playerPed, targetPed, 1) then
                            local targetCoords = GetEntityCoords(targetPed)
                            local textCoords = 0.95 + (PlayerVisibleCommand3d[a] * 0.14)
                            local distance = #(playerCoords - targetCoords)
                            if distance < Config.Distance then
                                Draw3dMessage({x = targetCoords.x, y = targetCoords.y, z = targetCoords.z + textCoords}, v.text, v.color, true)
                                PlayerVisibleCommand3d[a] = PlayerVisibleCommand3d[a] + 1
                            end
                        end
                    end
                end
                PlayerVisibleCommand3d[a] = 0
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for k, id in ipairs(GetActivePlayers()) do
            local desc = PlayersDescriptions[GetPlayerServerId(id)]
            if desc then
                local targetPed = GetPlayerPed(id)
                if DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)
                    if distance < Config.Distance then
                        if HasEntityClearLosToEntity(playerPed, targetPed, 1) then
                            Draw3dMessage({x = targetCoords.x, y = targetCoords.y, z = targetCoords.z}, desc, {55, 55, 55})
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('esx_rpchat:moneta', function(id, wynik)
    if wynik < 50 then
        local number = 1
        if PlayersCommand3d[id] ~= nil then
            number = #PlayersCommand3d[id] + 1
        else
            PlayersCommand3d[id] = {}
        end
        PlayersCommand3d[id][number] = {text = "[MONETA] Wyrzucił/a Orła", color = {245, 209, 66}}
        Citizen.Wait(15000)
        if id and number and PlayersCommand3d[id][number] then
            PlayersCommand3d[id][number] = nil
        end
        if #PlayersCommand3d[id] == 0 then
            PlayersCommand3d[id] = nil
        end
	elseif wynik > 50 then
        local number = 1
        if PlayersCommand3d[id] ~= nil then
            number = #PlayersCommand3d[id] + 1
        else
            PlayersCommand3d[id] = {}
        end
        PlayersCommand3d[id][number] = {text = "[MONETA] Wyrzucił/a Reszkę", color = {245, 209, 66}}
        Citizen.Wait(15000)
        if id and number and PlayersCommand3d[id][number] then
            PlayersCommand3d[id][number] = nil
        end
        if #PlayersCommand3d[id] == 0 then
            PlayersCommand3d[id] = nil
        end
	elseif wynik == 50 then
        local number = 1
        if PlayersCommand3d[id] ~= nil then
            number = #PlayersCommand3d[id] + 1
        else
            PlayersCommand3d[id] = {}
        end
        PlayersCommand3d[id][number] = {text = "[MONETA] Moneta stanęła na kan", color = {245, 209, 66}}
        Citizen.Wait(15000)
        if id and number and PlayersCommand3d[id][number] then
            PlayersCommand3d[id][number] = nil
        end
        if #PlayersCommand3d[id] == 0 then
            PlayersCommand3d[id] = nil
        end
	end

end)

RegisterNetEvent('esx_rpchat:dice', function(id, wynik)
    local number = 1
    if PlayersCommand3d[id] ~= nil then
        number = #PlayersCommand3d[id] + 1
    else
        PlayersCommand3d[id] = {}
    end
    PlayersCommand3d[id][number] = {text = "[KOSTKA] Wyrzucona liczba oczek: "..wynik, color = {99, 99, 99}}
    Citizen.Wait(15000)
    if id and number and PlayersCommand3d[id][number] then
        PlayersCommand3d[id][number] = nil
    end
    if #PlayersCommand3d[id] == 0 then
        PlayersCommand3d[id] = nil
    end

end)