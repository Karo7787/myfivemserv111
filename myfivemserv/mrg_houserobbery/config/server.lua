return {
    -- ██████  ███████  █████  ██   ██     ███████  ██████ ██████  ██ ██████  ████████ ███████ 
    -- ██   ██ ██      ██   ██ ██  ██      ██      ██      ██   ██ ██ ██   ██    ██    ██      
    -- ██████  █████   ███████ █████       ███████ ██      ██████  ██ ██████     ██    ███████ 
    -- ██      ██      ██   ██ ██  ██           ██ ██      ██   ██ ██ ██         ██         ██ 
    -- ██      ███████ ██   ██ ██   ██     ███████  ██████ ██   ██ ██ ██         ██    ███████ 

    versionCheck = true,

    onlyAtNight = { -- You can rob houses only or get house missions only at night
        enabled = true,
        startHours = 21,
        endHours = 6,
    },

    skills = {
        enabled = false,
        system = 'evolent_skills', -- evolent_skills, flight-skills, cw-rep or pickle_xp
        skillName = 'houserobbery',
        tiers = {
            shell = { -- What level you need to be to get each tier
                [1] = 0,
                [2] = 20,
                [3] = 30
            },
            ipl = {
                [1] = 0,
                [2] = 20,
                [3] = 30
            }
        }
    },

    startPed = {
        coords = {
            vec4(331.03, 362.29, 105.65, 348.49),
        },
        cooldown = { -- The waiting time before getting another house robbery mission
            enabled = true,
            min = 20, -- Minimum cooldown time (in minutes)
            max = 30 -- Maximum cooldown time (in minutes)
        },
        item = { -- Item requirement to access the start npc
            required = true, -- Set to true if an item is needed
            name = 'peak_usb',
            amount = 1,
        },
        resetAfter = { -- The time after which target house is resetted if player hasnt robbed it already
            min = 10, -- 10 minutes
            max = 20, -- 20 minutes
        },
    },
    
    trader = {
        coords = {
            vec4(-222.64, -280.54, 48.00, 71.47),
        },
        maxItems = 30, -- Max amount of items you can trade before getting cooldown
        cooldown = { -- Cooldown for trading items
            enabled = true,
            min = 10, -- In minutes
            max = 20 -- In minutes
        },
        progressBar = true, -- Enable or disabloe progress bar
        items = {
            { item = 'peak_cleaning_kit', reward = 'money', min = 10, max = 20 },
            { item = 'peak_cigarettes_pack', reward = 'money', min = 10, max = 20 },
            { item = 'peak_phone', reward = 'money', min = 100, max = 200 },
            { item = 'peak_blox', reward = 'money', min = 15, max = 25 },
            { item = 'peak_lighter', reward = 'money', min = 20, max = 50 },
            { item = 'peak_whiskey', reward = 'money', min = 50, max = 50 },
            { item = 'peak_vodka', reward = 'money', min = 40, max = 80 },
            { item = 'peak_golden_ring', reward = 'money', min = 150, max = 200 },
            { item = 'peak_painting1', reward = 'money', min = 500, max = 750 },
            { item = 'peak_painting2', reward = 'money', min = 600, max = 900 },
            { item = 'peak_tablet', reward = 'money', min = 100, max = 150 },
            { item = 'peak_pearl_chain', reward = 'money', min = 100, max = 150 },
            { item = 'peak_golden_teeth', reward = 'money', min = 50, max = 75 },
            { item = 'peak_necklace', reward = 'money', min = 100, max = 150 },
            { item = 'peak_electronickit', reward = 'money', min = 80, max = 120 },
            { item = 'peak_certificate', reward = 'money', min = 50, max = 100 },
            { item = 'peak_fake_cash', reward = 'money', min = 200, max = 300 },
            { item = 'peak_keyboard', reward = 'money', min = 30, max = 60 },
            { item = 'peak_wallet', reward = 'money', min = 10, max = 50 },
            { item = 'peak_ev_battery', reward = 'money', min = 50, max = 100 },
            { item = 'peak_laptop', reward = 'money', min = 300, max = 500 },
            { item = 'peak_pcspeaker', reward = 'money', min = 50, max = 100 },
            { item = 'peak_toaster', reward = 'money', min = 20, max = 50 },
            { item = 'peak_microwave', reward = 'money', min = 50, max = 100 },
            { item = 'peak_tv', reward = 'money', min = 500, max = 600 },
            { item = 'peak_coffee_maker', reward = 'money', min = 150, max = 200 },
            { item = 'peak_artpiece', reward = 'money', min = 200, max = 300 },
            { item = 'peak_eguitar', reward = 'money', min = 200, max = 400 },
            { item = 'peak_suitcase', reward = 'money', min = 50, max = 150 },
            { item = 'peak_printer', reward = 'money', min = 100, max = 150 }
        }        
    },    
    
    groups = {
        enabled = true,
        system = 'slrn_groups', -- slrn_groups or yseries
        minAmount = 1, -- Minimum amount of players in a group to start a mission
        leader = true -- Player needs to be a group leader to start heist
    },

    logging = {
        enabled = true, -- Enable or disable logging. 
        system = 'discord', -- Specify the logging system: ox_lib (recommended) or discord (not recommended).
    
        -- Config specific to Discord logging
        name = 'MirageRP', -- Display name used for the Discord webhook.
        image = 'https://r2.fivemanage.com/mRGMLnWSeQJ90gOfps6Wt/peakscripts.png', -- URL of the image used for the webhook avatar and footer.
        webhookUrl = 'https://discord.com/api/webhooks/1257439474204282880/fwtSsLYFsBJrerVGsJ82J7axfNkEz7e7HCHM21OgXeFvXuJSdInv3esEyN_2ESwvNL27' -- Webhook URL for sending log messages to Discord.
    },
    
    rewards = {
        shell = {
            [1] = {  -- Shell Tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 80 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 70 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 70 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
            },
            [2] = {  -- Shell Tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 80 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 50 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 50 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
            },
            [3] = {  -- Shell Tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 80 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 50 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 50 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
            },
        },
        ipl = {
            [1] = {  -- Ipl tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 90 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 90 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 70 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 70 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 90 },
                },
            },
            [2] = {  -- Ipl tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 80 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 50 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 50 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                }
            },
            [3] = {  -- Ipl tier
                bonusItem = {
                    enabled = true,
                    item = 'obd2_scanner',
                    chance = 5,
                    min = 1, max = 1
                },
                cabin = {
                    { name = 'peak_ev_battery', min = 1, max = 1, chance = 50 },
                    { name = 'peak_wallet', min = 1, max = 1, chance = 70 },
                    { name = 'peak_keyboard', min = 1, max = 1, chance = 80 },
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
                kitchen = {
                    { name = 'peak_cleaning_kit', min = 1, max = 1, chance = 70 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 40 },
                    { name = 'ammo-9', min = 30, max = 50, chance = 10 },
                    { name = 'peak_phone', min = 1, max = 1, chance = 80 },
                    { name = 'peak_cigarettes_pack', min = 1, max = 1, chance = 30 },
                    { name = 'peak_lighter', min = 1, max = 1, chance = 70 },
                    { name = 'peak_blox', min = 1, max = 1, chance = 80 },
                    { name = 'peak_whiskey', min = 1, max = 1, chance = 50 },
                    { name = 'peak_vodka', min = 1, max = 1, chance = 50 },
                },
                chest = {
                    { name = 'peak_electronickit', min = 1, max = 5, chance = 50 },
                    { name = 'weapon_pistol', min = 1, max = 1, chance = 5 },
                    { name = 'peak_necklace', min = 1, max = 3, chance = 65 },
                    { name = 'peak_certificate', min = 1, max = 1, chance = 30 },
                    { name = 'peak_fake_cash', min = 1, max = 1, chance = 10 },
                    { name = 'peak_usb', min = 1, max = 1, chance = 5 },
                },
                livingroom = {
                    { name = 'peak_golden_ring', min = 1, max = 10, chance = 65 },
                    { name = 'peak_painting1', min = 1, max = 1, chance = 20 },
                    { name = 'peak_painting2', min = 1, max = 1, chance = 20 },
                    { name = 'peak_tablet', min = 1, max = 1, chance = 50 },
                    { name = 'peak_pearl_chain', min = 1, max = 3, chance = 55 },
                    { name = 'peak_golden_teeth', min = 1, max = 2, chance = 80 },
                },
            },
        },
    }    
}
