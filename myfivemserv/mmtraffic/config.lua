Config = {}
Config.Model = `prop_consign_01d`
Config.Model2 = `prop_consign_01e`
Config.SighPickupText = "Nacisnij <span class='button'>E</span> by usunąć znak"
Config.SighPickupKeyControl = 51
Config.SighPickupMessageText = "Ruch zostal przywrocony"
Config.NoPermissionText = "Nie mozesz tego zrobic!"
Config.SignSpeedzoneRadius = 40.0
Config.TempSpeedzoneRadius = 40.0
ShowHelp = false
Showed = false
message = ""
-- use exports["mmtraffic"]:SetAccess(true) to allow player to use traffic sign and /traffic commands
-- use exports["mmtraffic"]:SetAccess(false) to disallow player to use traffic sign and /traffic commands

_ShowNotification = function(text)
    exports["mrg_ui"]:ShowHelpNotification(text)
end

_ShowHelpText = function(text)
    ShowHelp = true
    message = text
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if ShowHelp and not Showed then
            Showed = true
            exports["mrg_ui"]:ShowHelpNotification(message)
        end
        if not ShowHelp and Showed then
            Showed = false
            exports["mrg_ui"]:HideHelpNotification()
        end
        ShowHelp = false    
    end
end)