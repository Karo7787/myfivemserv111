Cores = {
    {
        Name = "ESX",
        ResourceName = "es_extended",
        GetFramework = function() return exports["es_extended"]:getSharedObject() end
    }
    -- { -- Old ESX
    --     Name = "ESX",
    --     ResourceName = "es_extended",
    --     GetFramework = function() ESX = nil while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) end return ESX end
    -- },
    
}