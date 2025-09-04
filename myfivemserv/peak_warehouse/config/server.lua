return {
    requiredItem = {
        name = 'weapon_pipebomb',
        amount = 1,
        remove = {
            onFail = true,
            onUse = true,
        }
    },

    lootMin = 1, -- Minimum amount of different items player can get
    lootMax = 1, -- Maximum amount of different items player can get

    items = {
        { name = 'plytacd', chance = 80, min = 2, max = 4 },
        { name = 'weapon_smokegrenade', chance = 60, min = 1, max = 2 },
        { name = 'watch1', chance = 70, min = 1, max = 2 },
        { name = 'x_hammer', chance = 80, min = 3, max = 5 },
        { name = 'gold', chance = 40, min = 1, max = 3 },
        { name = 'usb_blue', chance = 90, min = 1, max = 3 },
        { name = 'peak_usb', chance = 70, min = 1, max = 2 },
        { name = 'money', chance = 70, min = 500, max = 1000 },
    },

    requiredCops = 2,

    interactLocations = {
        interior = { coords = vec3(1027.5515, -3101.7664, -38.9999) },
        policeReset = { coords = vec3(850.1256, -1926.7499, 30.3147) },
        laptop = { coords = vec3(995.2347, -3100.0031, -39.1758), isBusy = false, isHacked = false },
        electricalBox = { coords = vec3(835.8817, -1923.2244, 30.7248), isBusy = false, isExploded = false },
        entrance = { coords = vec3(839.0181, -1923.5303, 30.8329), isOpen = false },
        backEntrance = { coords = vec3(853.9672, -1852.6887, 29.7877), isOpen = false, },
        exit = { coords = vec3(1028.0412, -3101.4567, -38.1793), isOpen = false },
        backExit = { coords = vec3(992.0262, -3097.8188, -38.8184), isOpen = false },
    },

    boxLocations = { 
        [1] = { coords = vec3(1018.1041, -3108.5, -40), isBusy = false, isRobbed = false },
        [2] = { coords = vec3(1015.5176, -3108.5, -40), isBusy = false, isRobbed = false },
        [3] = { coords = vec3(1013.2429, -3108.5, -40), isBusy = false, isRobbed = false },
        [4] = { coords = vec3(1010.8519, -3108.5, -40), isBusy = false, isRobbed = false },
        [5] = { coords = vec3(1008.5016, -3108.5, -40), isBusy = false, isRobbed = false },
        [6] = { coords = vec3(1006.1173, -3108.5, -40), isBusy = false, isRobbed = false },
        [7] = { coords = vec3(1003.4443, -3108.5, -40), isBusy = false, isRobbed = false },
        [8] = { coords = vec3(1018.1041, -3102.7, -40), isBusy = false, isRobbed = false },
        [9] = { coords = vec3(1015.5176, -3102.7, -40), isBusy = false, isRobbed = false },
        [10] = { coords = vec3(1013.2429, -3102.7, -40), isBusy = false, isRobbed = false },
        [11] = { coords = vec3(1010.8519, -3102.7, -40), isBusy = false, isRobbed = false },
        [12] = { coords = vec3(1008.5016, -3102.7, -40), isBusy = false, isRobbed = false },
        [13] = { coords = vec3(1006.1173, -3102.7, -40), isBusy = false, isRobbed = false },
        [14] = { coords = vec3(1003.4443, -3102.7, -40), isBusy = false, isRobbed = false },
        [15] = { coords = vec3(1018.1041, -3097, -40), isBusy = false, isRobbed = false },
        [16] = { coords = vec3(1015.5176, -3097, -40), isBusy = false, isRobbed = false },
        [17] = { coords = vec3(1013.2429, -3097, -40), isBusy = false, isRobbed = false },
        [18] = { coords = vec3(1010.8519, -3097, -40), isBusy = false, isRobbed = false },
        [19] = { coords = vec3(1008.5016, -3097, -40), isBusy = false, isRobbed = false },
        [20] = { coords = vec3(1006.1173, -3097, -40), isBusy = false, isRobbed = false },
        [21] = { coords = vec3(1003.4443, -3097, -40), isBusy = false, isRobbed = false },
    },

    logging = {
        enabled = true,
        system = 'discord', -- ox_lib logger or discord (not recommended)

        -- Only used for discord logging
        webhookURL = 'https://discord.com/api/webhooks/1257439474204282880/fwtSsLYFsBJrerVGsJ82J7axfNkEz7e7HCHM21OgXeFvXuJSdInv3esEyN_2ESwvNL27'
    },
}
