Config = {}

Config.Debug = false
Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.Target = 'ox_target' -- ox_target / qb-target
Config.Language = 'pl' -- pl / en
Config.LastStand = {
    isEnabled = true, -- last stand enabled?
    time = 30, -- time in seconds for bleeding out
    enableMovement = false -- can move while last stand?
}
Config.DisableVoiceOnDeath = false -- disable voice chat on death [not on last stand]?
Config.DamageUIBind = false -- set to false if you dont want

lib.locale(Config.Language or 'en')

Config.Jobs = { -- Which jobs can interact, use lockers, etc
    ['ambulance'] = 0,
    ['lsfd'] = 0
}

Config.TrimPlate = function(plate)
    return (string.gsub(plate, "^%s*(.-)%s*$", "%1"))
end

Config.CustomDeathScreen = function(state, time, deadStage)
    if deadStage == 1 then
        time = Config.LastStand.time
    end

    SendNUIMessage({action = 'DeathScreen', data = {state = state, time = time, deadStage = deadStage}})
end

Config.DisableDeathAnimationOn = function()
    local playerState = LocalPlayer.state
    if playerState.carriedBy then
        return true
    end

    return false
end

Config.TemporaryDeath = {
    enabled = true,
    weapons = {
        [`WEAPON_BAT`] = true,
        [`WEAPON_UNARMED`] = true,
        [`WEAPON_NIGHTSTICK`] = true,
    },
    time = 10, -- after 10 seconds player will stand up
    healthAfter = 100 -- 50% hp [max is 200]
}

Config.Blips = {
    {
        sprite = 61,
        color = 1,
        scale = 0.95,
        display = 2,
        label = 'Szpital',
        coords = vector3(71.44, -386.88, 39.38)
    }
}

Config.ToggleDuty = { -- where medics can toggle duty status
    {
        coords = vector3(68.01, -378.14, 39.38), radius = 0.75,
        allowedJobs = {['ambulance'] = 0},
    }
}

Config.Shops = {
    ['MedicShop'] = {
        label = 'Szafka medyczna',
        locations = {
            vector3(51.62, -387.47, 39.38)
        },
        requiredDuty = true,
        radius = 0.75,
        allowedJobs = {['ambulance'] = 0}, -- which jobs can access shop
        inventory = {
            {name = 'ice_bag', price = 0, amount = 99999},
            --{name = 'adrenaline', price = 0, amount = 99999},
            {name = 'bandage', price = 0, amount = 99999},
            {name = 'radio', price = 0, amount = 99999},
            {name = 'bodycam', price = 0, amount = 99999},
            {name = 'gps', price = 0, amount = 99999},
            {name = 'medic_bag', price = 0, amount = 99999},
        },
    }
}

Config.Radio = {
    [4] = {
        jobs = {['ambulance'] = true},
        label = "EMS"
    },
    [5] = {
        jobs = {['ambulance'] = true},
        label = "EMS"
    },
    [6] = {
        jobs = {['ambulance'] = true},
        label = "EMS"
    },
}

Config.OnPlayerDeath = function()
    LocalPlayer.state.invBusy = true
    LocalPlayer.state.invHotkeys = false
    LocalPlayer.state.canUseWeapons = false
    lib.disableRadial(true)
    lib.disableControls:Add({
        24, 257, 25, 263, 45, 22, 44, 37, 23, 21, 288, 289, 
        170, 167, 73, 199, 59, 71, 72, 36, 47, 264, 257, 140, 141, 142, 43, 75, 32, 33, 34, 35, 45
    })
    lib.disableRadial(true)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(true)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(false)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(true)
    end
end

Config.OnPlayerRevive = function()
    LocalPlayer.state.invBusy = false
    LocalPlayer.state.invHotkeys = true
    LocalPlayer.state.canUseWeapons = true
    if Config.Framework == 'ESX' then
        TriggerEvent('esx_basicneeds:resetStatus')
        TriggerServerEvent('esx:onPlayerSpawn')
        TriggerEvent('esx:onPlayerSpawn')
        TriggerEvent('playerSpawned')
        ESX.SetPlayerData('dead', false)
    else
        TriggerServerEvent('hud:server:RelieveStress', 100)
        TriggerServerEvent('hospital:server:resetHungerThirst')
    end
    lib.disableRadial(false)
    lib.disableControls:Clear({
        24, 257, 25, 263, 45, 22, 44, 37, 23, 21, 288, 289, 
        170, 167, 73, 199, 59, 71, 72, 36, 47, 264, 257, 140, 141, 142, 43, 75, 32, 33, 34, 35, 45
    })
    lib.disableRadial(false)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(false)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(true)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(false)
    end
end