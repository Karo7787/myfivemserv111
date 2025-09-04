Config.Tackle = {}

--@param Enabled: boolean [true/false] - enable or disable the tackle feature
Config.Tackle.Enabled = true 

--@param Type: string - type of tackle, either 'animation' or 'ragdoll'
Config.Tackle.Type = 'ragdoll'

--@param Keys: number[] - which keys to press to tackle someone [at the same time]
-- https://docs.fivem.net/docs/game-references/controls/
Config.Tackle.Keys = {
    21, -- LEFT SHIT
    38 -- E
}

--@param Distance: number - distance to tackle someone
Config.Tackle.Distance = 3.0

--@param Timeout: number - cooldown in milliseconds before you can tackle again [10 sec default]
Config.Tackle.Timeout = 10000

--@param RestrictedJobs: table - jobs that can use the tackle feature, set to false if you don't want to restrict
Config.Tackle.RestrictedJobs = { -- set to false if you dont want restrict
    ['police'] = 0
}

--@param CanUseTackle: function - function that returns true/false if the player can use the tackle feature
Config.Tackle.CanUseTackle = function()
    if cache.vehicle and cache.vehicle ~= 0 then
        return false
    end

    if exports['p_policejob']:isTackling() then
        return false
    end

    if IsPedRagdoll(cache.ped) then
        return false
    end
    
    if not IsPedSprinting(cache.ped) then
        return false
    end

    return true
end