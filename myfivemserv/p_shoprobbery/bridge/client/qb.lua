if Config.Framework ~= 'QB' then
    return
end


local QBCore = exports['qb-core']:GetCoreObject()

Core.ShowNotification = function(text)
    QBCore.Functions.Notify(text)
end
