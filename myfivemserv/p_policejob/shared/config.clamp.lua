while not Config do Wait(100) end

Config.Clamp = {}

--@param Enabled: boolean - enable/disable wheel clamps
Config.Clamp.Enabled = true

Config.Clamp.AllowedJobs = Config.Jobs -- same as Config.Jobs, but can be overridden if needed

--@param entity: number [Entity ID]
Config.Clamp.onWheelClamped = function(entity) -- this will execute for everyone on client side after wheel clamp is set
    -- add some custom logic here if needed [removing car keys or something else]
end

--@param entity: number [Entity ID]
Config.Clamp.onWheelUnclamped = function(entity) -- this will execute for everyone on client side after wheel clamp is removed
    -- add some custom logic here if needed [adding car keys or something else]
end

