Config = {}

Config.Stations = {
    ["lsfd"] = {
        boss = 13,
        blip = {
            coords = vector4(-1044.25, -1399.29, 5.08, 247.69),
            sprite = 648,
            color = 49,
            scale = 0.9,
            text = "[Vespucci] Remiza LSFD"
        },
        alarm = {
            coords = vector3(-1048.27, -1398.15, 16.31),
            type = "siren2"
        },
        Locations = {
            ["private_stash"] = {
                [1] = vector4(-1040.33, -1410.88, 10.55, 150.95),
                [2] = vector4(-1041.41, -1414.62, 10.55, 166.11),
                [3] = vector4(-1042.42, -1418.41, 10.55, 167.32),
                [4] = vector4(-1043.44, -1422.15, 10.55, 160.2),
                [5] = vector4(-1044.46, -1425.93, 10.55, 167.11),
                [6] = vector4(-1045.45, -1429.69, 10.55, 156.14) 
            },
            ["stash"] = {
                [1] = vector4(-1035.66, -1392.2, 4.97, 153.54)
            },
            ["shop"] = {
                [1] = {
                    label = "Sklep",
                    coords = vector4(-1036.32, -1389.2, 4.97, 70.08),
                    items = {
                        { name = 'ice_bag',                 price = 0, license = 'lsfd_PARAMEDIC' },
                        { name = 'bandage',                 price = 0, license = 'lsfd_PARAMEDIC' },
                        { name = 'medic_bag',               price = 0, license = 'lsfd_PARAMEDIC' },
                        { name = 'bodycam',                 price = 0 },
                        { name = 'WEAPON_FIREEXTINGUISHER', price = 0 },
                        { name = 'scba',                    price = 0 },
                        { name = 'radio',                   price = 0 },
                        { name = 'gps',                     price = 0 }
                    }
                }
            }
        }
    },
}

Config.Scba = {
    scba_others = {
        ["male"] = 166,
        ["female"] = 166,
    },
    cloth_numbers = {
        ["male"] = {
            active = 288,
            inactive = 286
        },
        ["female"] = {
            active = 487,
            inactive = 488
        },
    }
}

Config.AdminPermissions = {"best"}

Config.Fire = {
    fireSpreadChance = 5,
    maximumSpreads = 0,
    damageUpdate = 2,
    spawner = {
        enableOnStartup = true,
        interval = 900000, 
        chance = 100,
        players = 3,
    },
    Explosions = {
        explosionTypes = {[3] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [17] = true, [27] = true, [28] = true, [31] = true, [49] = true},
        explosionEvent = function(source, data)
            local firefighters = Modules[3].GetFirefighters()
            if #firefighters >= Config.Fire.spawner.players then
                local coords = vector3(data.posX, data.posY, data.posZ+1.0)
                local pcoords = GetEntityCoords(GetPlayerPed(source))
                local dist = #(coords-pcoords)
                if dist < 100.0 then 
                    Modules[3].create(coords)
                    for k, v in pairs(Config.Stations) do
                        exports["mrg_firefighter"]:TriggerAlarm({Name = "Alarm_Department_"..k, Loc = v.alarm.coords, Radius = 200, Siren = v.alarm.type})
                    end
                    exports['piotreq_gmt']:SendAlert(-1, {
                        title = 'Pożar',
                        code = 'Fire',
                        coords = coords,
                        icon = 'fa-solid fa-mask-ventilator',
                        info = {
                           {icon = 'fa-solid fa-road', isStreet = true}
                        },
                        jobs = {['lsfd'] = true}, -- optional
                        blip = {
                           scale = 1.0,
                           sprite = 436,
                           color = 1,
                           name = "Pożar"
                        },
                        type = 'risk', -- default normal
                        canAnswer = false, -- default false
                        maxOfficers = 6, -- default 4
                        time = 10,-- 10 minutes, default 5
                        notifyTime = 8000, -- 8 seconds, default 7
                    })
                end
            end
        end
    },
    reward = 1000,
    damages = {
        truck = {
            ["firetruk"] = {
                damage = 0.5,
                range = 20.0,
            },
            ["slrr"] = {
                damage = 0.5,
                range = 20.0,
            },
        },
        extinguisher = {
            hash = `WEAPON_FIREEXTINGUISHER`,
            damage = 0.25,
            range = 5.0
        }
    }
}