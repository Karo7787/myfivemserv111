Config = {}

-- CHECK INSTALL FOLDER FIRST!
-- SUPPORTED FRAMEWORKS: ESX / QBCORE / QBOX [You can add yours in bridge folder]
-- SUPPORTED INVENTORIES: ox_inventory / qb-inventory / ps-inventory / qs-inventory / tgiann-inventory / codem-inventory / core_inventory [You can add yours in inventory folder]
-- SUPPORTED TARGETS: ox_target / qb-target [You can add yours in target folder]

Config.Language = 'pl' -- pl / en / de / fr / tr
Config.Logs = true -- true / false
Config.Debug = false
Config.Commands = true -- set to false if you want dont want to use commands
Config.OxRadial = false -- enable ox radial menu? (you can edit this in bridge/client)
Config.PoliceMenu = false -- set to true if you want to use F6 OX LIB MENU
Config.PoliceMenuKey = 'F6' -- key to open police menu
lib.locale(Config.Language or 'en')

Config.SSN = 'id' -- database column for character unique id

-- POLICE JOBS ON YOUR SERVER
--@param jobName [string]: grade [number]
Config.Jobs = {
    ['police'] = 0
}

--@param jobName [string]: grade [number]
Config.OutfitsAccess = { -- permissions for /police_outfit
    ['police'] = 14
}

-- POLICE STATIONS
Config.Stations = {
    ['Vespucci'] = {
        -- LIST OF BLIPS, IF YOU WANT TO REMOVE THEM, SET blips = {}
        blips = {
            {
                sprite = 60, color = 29, scale = 0.95, display = 2,
                label = 'Vespucci LSPD', coords = vector3(-1105.2534, -829.0480, 19.3209)
            },
        },
        -- LIST OF BELL RINGS, IF YOU WANT TO REMOVE THEM, SET bells = {}
        bells = {
            {
                coords = vector3(-1099.6564, -825.4279, 19.3209), radius = 0.75,
                jobs = {['police'] = true, ['sheriff'] = true}, -- which jobs will get alert
            },
            {
                coords = vector3(-1101.8953, -830.3524, 19.3209), radius = 0.75,
                jobs = {['police'] = true, ['sheriff'] = true}, -- which jobs will get alert
            },
            {
                coords = vector3(-1101.8123, -835.5895, 19.3209), radius = 0.75,
                jobs = {['police'] = true, ['sheriff'] = true}, -- which jobs will get alert
            },
            {
                coords = vector3(-1098.0245, -841.2703, 19.3209), radius = 0.75,
                jobs = {['police'] = true, ['sheriff'] = true}, -- which jobs will get alert
            }
        },
        -- LIST OF TRASHES TO REMOVE ITEMS, IF YOU WANT TO REMOVE THEM, SET trashes = {}
        trashes = {
            {
                coords = vector3(-1087.6753, -832.9869, 19.0317), radius = 0.75,
                allowedJobs = {['police'] = 0, ['sheriff'] = 0}, -- which jobs can access trashes
            },
            {
                coords = vector3(-1109.5726, -842.0461, 19.3529), radius = 0.75,
                allowedJobs = {['police'] = 0, ['sheriff'] = 0}, -- which jobs can access trashes
            }
        },
        -- LIST OF BODYCAMS MENU, IF YOU WANT TO REMOVE THEM, SET bodycams = {}
        bodycams = {
            {
                coords = vector3(-1086.7892, -837.0589, 23.1209), radius = 0.75,
                allowedJobs = {['police'] = 0, ['sheriff'] = 0}, -- which jobs can access bodycams
            }
        },
        -- SET TO {} IF YOU ON ESX!
        toggleDuty = { -- coords for duty toggle [ONLY QB AND QBOX!!!!!!]
            {
                coords = vector3(446.19, -991.22, 30.5), radius = 0.75,
                allowedJobs = {['police'] = 0, ['sheriff'] = 0},
            }
        }
    }
}

-- POLICE SHOPS [ARMOURIES]
Config.Shops = {
    ['Armory'] = { -- NAME MUST BE UNIQUE
        label = 'Zbrojownia', -- LABEL
        locations = {
            vector3(-1085.5817, -824.3136, 23.1528)
        },
        requiredDuty = false,
        radius = 0.75, -- RADIUS OF TARGET
        allowedJobs = {['police'] = 0, ['sheriff'] = 0}, -- which jobs can access shop
        inventory = {
            {name = 'evidence_camera', price = 0},
            {name = 'megaphone', price = 0},
            {name = 'wheel_clamp', price = 0},
            {name = 'breathalyzer', price = 0},
            {name = 'police_rappel' , price = 0},
            {name = 'WEAPON_RADAR', price = 0},
            {name = 'police_diving_suit', price = 0},
            {name = 'tracking_band', price = 0},
            {name = 'body_cam', price = 0},
            {name = 'gps', price = 0},
            {name = 'WEAPON_FLASHBANG', price = 150},
            {name = 'camera', price = 0},
            {name = 'radio', price = 0},
            {name = 'cable_ties', price = 0},
            {name = 'fingerprint_scanner', price = 0},
            {name = 'handcuffs', price = 0},
            {name = 'ammo-9', price = 5},
            {name = 'taser_cartridge', price = 5},
            {name = 'WEAPON_FLASHLIGHT', price = 50},
            {name = 'WEAPON_NIGHTSTICK', price = 50, metadata = {registered = true, serial = 'POL'}},
            {name = 'WEAPON_COMBATPISTOL', price = 250, license = 'weapon', grade = 0, metadata = {registered = true, serial = 'POL'}},
            {name = 'WEAPON_STUNGUN', price = 200, metadata = {registered = true, serial = 'POL'}},
        },
    }
}

-- WARDROBES FOR POLICE
Config.Wardrobes = {
    ['Vespucci'] = {
        coords = vector3(-1079.18, -825.14, 19.77),
        radius = 0.75,
        drawSprite = false,
    }
}

Config.Lockers = {
    ['MissionRow'] = {
        coords = vector3(468.25, -1009.97, 31.0),
        radius = 0.75,
        drawSprite = false,
        options = {
            {
                name = 'MissionRow_Locker', -- stash name and target name ;)
                label = locale('private_locker'),
                icon = 'fa-solid fa-box-open',
                distance = 2,
                groups = Config.Jobs,
                isLocker = true, -- set to false if not locker target
                lockerOwner = false, -- false = shared / true = private
                lockerLabel = locale('private_locker'), -- set only if isLocker
                lockerSlots = 50, lockerWeight = 500000,
                onSelect = function()
                    Inventory.openInventory('stash', 'MissionRow_Locker')
                end,
                canInteract = function()
                    local dutyData = Editable.CheckDuty()
                    return dutyData.status == 1
                end
            }
        }
    }
}

-- RADIO SYSTEM IN RADIAL MENU [OX_LIB RADIAL], SET TO {} IF YOU DONT WANT TO USE
Config.Radio = {}

Config.CameraShowHelpNotify = function()
    if GetResourceState('p_helper') == 'started' then
        exports['p_helper']:showHelper({
            {
                keys = {'X'},
                label = 'Cancel'
            },
            {
                keys = {'ENTER'},
                label = 'Zrób zdjęcie'
            },
        })
    else
        lib.showTextUI(locale('camera_helper'))
    end
end

Config.CameraHideHelpNotify = function()
    if GetResourceState('p_helper') == 'started' then
        exports['p_helper']:hideHelper()
    else
        lib.hideTextUI()
    end
end

Config.CameraAccess = false

-- YOU CAN SET CAMERA ITEM ACCESS FOR EACH JOB
-- Config.CameraAccess = {
--     ['police'] = 0,
--     ['sheriff'] = 0
-- }