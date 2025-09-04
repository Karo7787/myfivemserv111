return {
    interact = 'ox_target', -- ox_target, interact, sleepless_interact

    minCooldown = 30, -- In minutes
    maxCooldown = 60, -- In minutes

    debugPoly = false,

    blip = {
        enabled = true,
        location = vec3(839.0181, -1923.1303, 30.8329), 
        sprite = 473,
        display = 4,
        scale = 0.6,
        colour = 18,
        label = 'Magazyn',
    },

    warehouseObjects = { 
        `prop_boxpile_05a`,
        `prop_boxpile_04a`,
        `prop_boxpile_06b`,
        `prop_boxpile_02c`,
        `prop_boxpile_02b`,
        `prop_boxpile_01a`,
        `prop_boxpile_08a`,
    },
    
    guardConfig = {
        spawnGuards = true,
        accuracy = 100,
        armor = 200,
        health = 200,
        sufferHeadshots = false,
        alertness = 2,
        aggresiveness = 2,

    },

    guardList = {
        {
            model = `s_m_m_security_01`, 
            coords = vector4(993.77, -3097.73, -39.0, 183.11), 
            weapon = `WEAPON_CARBINERIFLE`, 
        },
        {
            model = `s_m_m_security_01`, 
            coords = vector4(993.7, -3100.73, -39.0, 201.93), 
            weapon = `WEAPON_CARBINERIFLE`, 
        }
    }
    
}
