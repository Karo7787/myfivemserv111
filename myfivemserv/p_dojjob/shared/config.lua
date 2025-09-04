Config = {}

Config.Debug = false -- debug mode? script will print more information in console and debug targets
Config.Language = 'pl' -- en / de / pl / es / fr / it / ru / tr / ar
Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.Target = 'ox_target' -- ox_target / qb-target
Config.Commands = true -- enable commands?
Config.RadialMenu = false -- true / false [if you want to use ox_lib radial menu set true, otherwise set false]

Config.Jobs = { -- JOBS THAT CAN ACCESS RADIAL MENU
    ['doj'] = 0
}

Config.Blips = { -- BLIPS ON MAP
    -- FM CITY HALL
    -- {
    --     coords = vector3(-545.3547, -203.7277, 38.2151), -- blip coords
    --     label = 'Department of Justice', -- label on map
    --     sprite = 439, -- blip sprite https://docs.fivem.net/docs/game-references/blips/
    --     color = 46, -- blip color https://docs.fivem.net/docs/game-references/blips/
    --     scale = 0.85, -- blip scale
    -- },
    -- FM CITY HALL LS 
    -- {
    --     coords = vector3(-545.4425, -621.2889, 35.6050), -- blip coords
    --     label = 'Department of Justice', -- label on map
    --     sprite = 439, -- blip sprite https://docs.fivem.net/docs/game-references/blips/
    --     color = 46, -- blip color https://docs.fivem.net/docs/game-references/blips/
    --     scale = 0.85, -- blip scale
    -- },
}

Config.Lockers = {
    ['CityHall_1'] = { -- script will create locker with id CityHall_1_Locker
        coords = vector3(97.04, -879.25, 35.2),
        jobs = {['doj'] = 0}, -- jobs that can access this locker [jobName] = jobGrade
        slots = 50, -- slots in locker
        weight = 500000, -- weight in locker
        private = true, -- if true, every player will have their own locker, if false, all players will share the same locker
    },

    -- FM CITY HALL LS
    -- ['CityHall_LS_1'] = { -- script will create locker with id CityHall_1_Locker
    --     coords = vector3(-530.5, -621.3, 35.8),
    --     jobs = {['doj'] = 0}, -- jobs that can access this locker [jobName] = jobGrade
    --     slots = 50, -- slots in locker
    --     weight = 500000, -- weight in locker
    --     private = true, -- if true, every player will have their own locker, if false, all players will share the same locker
    -- },
}

Config.Wardrobes = {
    ['CityHall_1'] = {
        coords = vector3(65.3, -911.02, 35.5),
        jobs = {['doj'] = 0}, -- jobs that can access this wardrobe [jobName] = jobGrade
    },

    -- FM CITY HALL LS
    -- ['CityHall_LS_1'] = {
    --     coords = vector3(-571.32, -602.53, 36.0),
    --     jobs = {['doj'] = 0}, -- jobs that can access this wardrobe [jobName] = jobGrade
    -- },
}

Config.WardrobePermissions = { -- which jobs can create outfits
    ['doj'] = 0,
}

Config.DocumentLockers = { -- LOCKERS FOR DOCUMENTS [ACCESSING BY SOME ID]
    ['CityHall_1'] = { -- script will create locker with id CityHall_1_Document_Locker
        coords = vector3(96.67, -880.5, 35.2),
        jobs = {['doj'] = 0}, -- jobs that can access this locker [jobName] = jobGrade
        slots = 50, weight = 500000
    },

    -- FM CITY HALL LS
    -- ['CityHall_LS_1'] = { -- script will create locker with id CityHall_1_Document_Locker
    --     coords = vector3(-531.84, -621.31, 35.8),
    --     jobs = {['doj'] = 0}, -- jobs that can access this locker [jobName] = jobGrade
    --     slots = 50, weight = 500000
    -- },
}

Config.Garages = {
    ['CityHall_1'] = {
        jobs = {['doj'] = 0}, -- jobs that can access this garage [jobName] = jobGrade
        coords = vector4(88.3215, -840.8865, 33.3146, 343.0923),
        spawnPoints = {
            vector4(92.1848, -838.7094, 33.3146, 338.7983),
            vector4(95.8240, -840.1579, 33.3146, 338.7702),
            vector4(69.9207, -832.4156, 33.3146, 250.4202),
            vector4(71.1744, -828.5731, 33.3146, 250.0113),
            vector4(72.5086, -824.7050, 33.3146, 247.8170)
        },
        ped = {model = 's_m_y_airworker', anim = {}},
        gradeRestricted = true, -- if grade restricted you need to set vehicles for grades, if not you need to set vehicles for all

        -- VEHICLES FOR ALL GRADES
        -- vehicles = {
        --     ['washington'] = { -- spawn name
        --         label = 'Washington',
        --         mods = { -- https://github.com/overextended/ox_lib/blob/master/resource/vehicleProperties/client.lua [check all mods here]
        --             ['color1'] = 1, ['color2'] = 1,
        --             ['livery'] = 1
        --         },
        --     },
        -- },
        vehicles = {
            ['0'] = {
                ['washington'] = { -- spawn name
                    label = 'Washington',
                    mods = { -- https://github.com/overextended/ox_lib/blob/master/resource/vehicleProperties/client.lua [check all mods here]
                        ['color1'] = 1, ['color2'] = 1,
                        ['livery'] = 1
                    },
                }
            }
        }
    },

    -- FM CITY HALL LS
    -- ['CityHall_LS_1'] = {
    --     jobs = {['doj'] = 0}, -- jobs that can access this garage [jobName] = jobGrade
    --     coords = vector4(-497.4413, -599.7752, 33.9005, 271.0759),
    --     spawnPoints = {
    --         vector4(-494.1490, -602.5171, 33.9006, 268.5907),
    --         vector4(-494.5722, -606.6237, 33.9006, 268.9452),
    --         vector4(-496.1283, -579.1907, 34.0959, 181.4695),
    --         vector4(-492.0006, -579.4944, 34.0913, 178.9854),
    --         vector4(-487.7417, -579.4999, 34.0863, 176.2200)
    --     },
    --     ped = {model = 's_m_y_airworker', anim = {}},
    --     gradeRestricted = true, -- if grade restricted you need to set vehicles for grades, if not you need to set vehicles for all

    --     -- VEHICLES FOR ALL GRADES
    --     -- vehicles = {
    --     --     ['washington'] = { -- spawn name
    --     --         label = 'Washington',
    --     --         mods = { -- https://github.com/overextended/ox_lib/blob/master/resource/vehicleProperties/client.lua [check all mods here]
    --     --             ['color1'] = 1, ['color2'] = 1,
    --     --             ['livery'] = 1
    --     --         },
    --     --     },
    --     -- },
    --     vehicles = {
    --         ['0'] = {
    --             ['washington'] = { -- spawn name
    --                 label = 'Washington',
    --                 mods = { -- https://github.com/overextended/ox_lib/blob/master/resource/vehicleProperties/client.lua [check all mods here]
    --                     ['color1'] = 1, ['color2'] = 1,
    --                     ['livery'] = 1
    --                 },
    --             }
    --         }
    --     }
    -- },
}