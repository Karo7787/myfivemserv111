ESX = exports.es_extended:getSharedObject();

local alertsActive = Config.NotiActive

function ChatNotification(icon, title, subtitle, message)
	TriggerEvent("chat:addMessage", {
		templateId = "message",
		multiline = true,
		args = {"245, 158, 66", "fa-solid fa-circle-info", title, message, "SYSTEM"}
	})
    return true
end

RegisterCommand("togglehelp", function()
    alertsActive = not alertsActive
    if alertsActive then
        ChatNotification("CHAR_SOCIAL_CLUB", "System Pomocy", "/togglehelp", "Włączono powiadomienia o pomocy")
    else
        ChatNotification("CHAR_SOCIAL_CLUB", "System Pomocy", "/togglehelp", "Wyłączono powiadomienia o pomocy")
    end
end)

RegisterCommand("tutorial", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openHelp"
    })
end)

RegisterNUICallback("closeHelp", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

Citizen.CreateThread(function()
    local randomHelp = math.random(#Config.Messages)
    while true do
        if alertsActive then
            ChatNotification("CHAR_SOCIAL_CLUB", "System Pomocy", "/togglehelp", Config.Messages[randomHelp])
            randomHelp = randomHelp + 1
            if randomHelp > #Config.Messages then
                randomHelp = 1
            end
        end
        Citizen.Wait(Config.WaitNoti * 60 * 1000) -- Convert minutes to milliseconds
    end
end)
