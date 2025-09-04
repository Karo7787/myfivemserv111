-- Notification System
if Config.Notification == 'custom' then
    --- @param notification string The notification text.
    --- @param notificationType string The type of the notification (e.g., 'success', 'error').
    --- @param duration number The duration the notification should stay on screen (in milliseconds).
    function Notification(notification, notificationType, duration)
        -- Your custom notification system
    end
end

-- Progressbar System
if Config.Progressbar == 'custom' then
    --- @param name string The name of the progress bar.
    --- @param label string The label text to display.
    --- @param duration number Duration of the progress bar (in milliseconds).
    --- @param success function Callback function if the progress completes successfully.
    function Progressbar(name, label, duration, success)
        -- Your custom progressbar system
    end
end

-- Dispatch System
if Config.Dispatch.Resource == 'custom' then
    function Dispatch()
        local coords = GetEntityCoords(PlayerPedId())
        local PoliceJobs = {}
        TriggerServerEvent("projectx-sellshop:server:PdNotify")
    end
end

-- HasItem Function
if Config.Inventory == 'custom' then
    --- @param item string The item name to check.
    function HasItem(item)
        -- Your custom inventory system
    end
end

-- GetItemCount Function
if Config.Inventory == 'custom' then
    --- @param item string The item name to check.
    function GetItemCount(item)
        -- Your custom inventory system
    end
end

-- Drawtext System
if Config.Drawtext == 'custom' then
    --- @param bool boolean Whether to show (true) or hide (false) the text.
    --- @param text string The text to display.
    function DrawText(bool, text)
        -- Your custom drawtext system
    end
end

--- Client-side event to add XP when selling an item. | NOT USED IF Config.ClientSideXP IS FALSE
--- @param shop string The shop name.
--- @param item string The item being sold.
--- @param itemamount number The amount of the item being sold.
RegisterNetEvent('projectx-sellshop:client:AddExp', function(shop, item, exp)
    if Config.UseXP and Config.ClientSideXP then
        -- Your custom client-side XP function
    end
end)