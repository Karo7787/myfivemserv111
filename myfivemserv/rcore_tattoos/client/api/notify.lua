---@param msg         string    Message to show
---@param thisFrame boolean    Show only this frame
---@param beep         boolean    Play sound
---@param duration     number    Duration of help text
ShowHelp = false
Showed = false
--- from https://esx-framework.github.io/es_extended/client/functions/showhelpnotification/
function showHelpText(msg, thisFrame, beep, duration)
    if thisFrame then
        ShowHelp = true
        message = msg
    else
        if beep == nil then beep = true end
        exports["mrg_ui"]:ShowHelpNotification(msg)
        if duration == nil then
            duration = 5000
        end
        Citizen.CreateThread(function()
            Citizen.Wait(duration)
            exports["mrg_ui"]:HideHelpNotification()

        end)
    end
end

---@param title     string    Title of notification
---@param message     string    Notification text
---@param style     string    Style of notification (success, error)
function addNotification(title,message,style)
    title = title or _U('notification')
    message = message or _U('message')

    SendNUIMessage({
        type = "notification",
        title = title,
        message = message,
        style = style
    })
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if ShowHelp and not Showed then
            Showed = true
            exports["mrg_ui"]:ShowHelpNotification(msg)
        end
        if not ShowHelp and Showed then
            Showed = false
            exports["mrg_ui"]:HideHelpNotification()
        end
        ShowHelp = false    
    end
end)