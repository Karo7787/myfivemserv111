RegisterCommand("phonedebug", function()
    Config.Debug = not Config.Debug

    SendReactMessage("toggleDebug", Config.Debug)
    print("DEBUG:", Config.Debug)
end, false)

local function RegisterDebugCommand(command, fn)
    RegisterCommand("phone" .. command, function(...)
        if not Config.Debug then
            return
        end

        fn(...)
    end, false)
end

RegisterDebugCommand("getcache", function()
    SendReactMessage("printCache")
end)

RegisterDebugCommand("getstacks", function()
    SendReactMessage("printStacks")
end)

if not Config.Debug then
    return
end

RegisterDebugCommand("notification", function()
    ---@type Notification
    local notification = {
        app = "Settings",
        title = "Test notification",
        content = "This is a test notification",
    }

    exports["lb-phone"]:SendNotification(notification)
end)

RegisterDebugCommand("togglecharging", function()
    exports["lb-phone"]:ToggleCharging(not exports["lb-phone"]:IsCharging())
end)

RegisterDebugCommand("setbattery", function(_, args)
    local battery = tonumber(args[1])

    if not battery or battery < 0 or battery > 100 then
        print("Invalid battery value. Must be between 0 and 100.")
        return
    end

    exports["lb-phone"]:SetBattery(battery)
end)


RegisterNetEvent("lb-phone:birdy:newPost", function(post)
    ESX.TriggerServerCallback("morskie-lb-phone:UserIfLoggedTo", function(success, account)
        if success and not post.reply_to then
            if post.attachments then
                if post.content then
                    post.content = post.content .." Załącznik"
                else
                    post.content = "Załącznik"
                end
            end
            exports["lb-phone"]:SendNotification({
                app = "Twitter",
                title = "@"..post.display_name,
                content = post.content,
            })
        end        
    end, "Twitter")
end)