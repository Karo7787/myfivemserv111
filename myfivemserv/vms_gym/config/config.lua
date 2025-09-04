Config = {}

Config.Core = "ESX"
Config.CoreExport = function()
    return exports['es_extended']:getSharedObject()
end

Config.Notification = function(title, message, time, icon, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports["vms_notify"]:Notification(title, message, time, "#27FF09", icon)
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "info" then
        if GetResourceState("vms_notify") == 'started' then
            exports["vms_notify"]:Notification(title, message, time, "#428AF5", icon)
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', time)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports["vms_notify"]:Notification(title, message, time, "#FF0909", icon)
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    end
end

Config.TextUI = {
    Enabled = false,
    Open = function(msg)
        exports["interact"]:Open("E", msg)
    end,
    Close = function(msg)
        exports["interact"]:Close()
    end,
}

Config.AutoExecuteQuery = true

Config.PlayerLoaded = "esx:playerLoaded"

Config.PlayerLoadedServer = "esx:playerLoaded"

Config.PlayerLogoutServer = "esx:playerDropped"

Config.JobUpdated = 'esx:setJob'

Config.SavingTimeout = 60 * 10 * 1000 

Config.Menu = 'ox_lib'
Config.ESXMenuDefault_Align = 'right'

Config.SendNotificationWhenSkillIncrase = true
Config.SendNotificationWhenSkillDecrease = true

Config.DistanceView = 2.25
Config.DistanceAccess = 0.5
Config.UseMarkers = false
Config.Use3DText = false
Config.UseHelpNotify = true

Config.UseTarget = true
Config.TargetResource = 'ox_target'
Config.Target = function(data, func)
    if Config.TargetResource == 'ox_target' then
        exports["ox_target"]:addBoxZone({
            coords = data.activityCoord,
            size = vec(2.0, 2.0, 4.3),
            debug = false,
            useZ = true,
            rotation = data.activityCoord.w,
            options = {
                {
                    distance = 2.0,
                    name = 'gym-'..data.name,
                    icon = 'fa-solid fa-dumbbell',
                    label = Config.Translate[Config.Language]['action.'..data.name],
                    onSelect = func
                }
            }
        })
    elseif Config.TargetResource == 'qb-target' then
        local id = math.random(1000000,1000000000000)
        exports['qb-target']:AddBoxZone('gym-'..data.name..'-'..id, data.activityCoord, 2.0, 2.0, {
            name = 'gym-'..data.name..'-'..id,
            heading = data.activityCoord.w,
            debugPoly = true,
            minZ = data.activityCoord.z,
            maxZ = data.activityCoord.z+3.5,
        }, {
            options = {
                {
                    num = 1,
                    icon = 'fas fa-example',
                    label = Config.Translate[Config.Language]['action.'..data.name],
                    targeticon = 'fa-solid fa-dumbbell',
                    action = func,
                    drawDistance = 10.0,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {30, 144, 255, 255},
                }
            },
            distance = 0.7,
        })
    else
      
    end
end

Config.EnableMemberships = true

Config.EnableGiveMembership = true
Config.GetClosestPlayersFunction = function()
    local playerInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 10.0) -- For ESX
    return playerInArea
end

Config.EnableStrenghtModifier = true

Config.EnableRunSpeedModifier = false

Config.EnableStaminaModifier = true

Config.EnableSkillDrivingEffects = false
Config.SkillDrivingEffectMinimumSpeed = 30.0

Config.UnitOfSpeed = 'kmh' -- 'kmh' or 'mph'

Config.AutoMembershipForEmployees = false

Config.UseCustomQuestionMenu = true
Config.CustomQuestionMenu = function(sellerId, membershipName, days, hours, price)
    local question = exports['vms_notify']:Question(
        Config.Translate[Config.Language]["question.title.buy_membership"], 
        hours ~= 0 and Config.Translate[Config.Language]["question.description.buy_membership_hours"]:format(price, hours) or Config.Translate[Config.Language]["question.description.buy_membership"]:format(price, days), 
        '#4f64ff', 
        'fa-solid fa-people-arrows'
    )
    Citizen.Await(question)
    if question == 'y' then -- vms_notify question export return 'y' when player accept and 'n' when player reject
        TriggerServerEvent("vms_gym:sv:acceptMembership", sellerId, membershipName, days, price)
    elseif question == 'n' then
        TriggerServerEvent("vms_gym:sv:rejectMembership", sellerId)
    end
end

Config.UseProgressbar = false
Config.Progressbar = function(actionName, time)
    exports['progressbar']:Progress({
        name = actionName,
        label = Config.Translate[Config.Language]["progressbar."..actionName],
        duration = time,
        canCancel = false,
        controlDisables = {
            disableMouse = false,
            disableMovement = true,
            disableCarMovement = true,
            disableCombat = true,
        }
    })
end

Config.UseSkillbar = true
Config.Skillbar = function(actionName, cb)
	local success = lib.skillCheck("hard",
        {'1', '2'}
    )
    cb(success)
end

Config.BossMenu = function(jobName)
    if Config.Core == "ESX" then
        TriggerEvent('esx_society:openBossMenu', jobName, function(data, menu)
            menu.close()
        end, {wash = false})
    elseif Config.Core == "QB-Core" then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    end
end

Config.StatisticCommand = '+statistics'
Config.StatisticDescription = 'Otwórz menu statystyk'

Config.StatisticsMenu = {
    ['strenght'] = true,
    ['condition'] = true,
    ['shooting'] = true,
    ['driving'] = true,
    ['flying'] = false,
}

Config.Blip = { -- https://docs.fivem.net/docs/game-references/blips/
    ["Sprite"] = 311,
    ["Scale"] = 0.85,
    ["Color"] = 46,
    ["Display"] = 4
}

Config.Keys = { -- https://docs.fivem.net/docs/game-references/controls/
    enter = 38, -- E
    train = 22, -- SPACE
    stop = 73-- X
}

Config.Markers = {
	['BossMenu'] = {
		id = 29,
		color = {95, 255, 95, 125},
		size = vec(0.33, 0.33, 0.33),
		bobUpAndDown = false,
		rotate = true
	},
	['FreeSeat'] = {
		id = 20,
        color = {59, 227, 137, 125},
        rotation = {180.0, 0.0, 0.0},
		size = vec(0.15, 0.15, 0.15),
		bobUpAndDown = false,
		rotate = true
	},
}

Config.Animations = {
    ['pull-up'] = {
        enter = {'amb@prop_human_muscle_chin_ups@male@enter', 'enter', 1800},
        idle = {'amb@prop_human_muscle_chin_ups@male@idle_a', 'idle_a', -1},
        training = {'amb@prop_human_muscle_chin_ups@male@base', 'base', 2900},
        exit = {'amb@prop_human_muscle_chin_ups@male@exit', 'exit', 2000},
    },
    ['bench'] = {
        enter = {'amb@prop_human_seat_muscle_bench_press@enter', 'enter', 0},
        idle = {'amb@prop_human_seat_muscle_bench_press@base', 'base', -1},
        training = {'amb@prop_human_seat_muscle_bench_press@idle_a', 'idle_a', 2350},
        exit = {'amb@prop_human_seat_muscle_bench_press@exit', 'exit', 2500},
    },
    ['barbell'] = {
        idle = {'amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a', -1},
        training = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 4500},
    },
    ['push-up'] = {
        enter = {'amb@world_human_push_ups@male@enter', 'enter', 3500},
        idle = {'amb@world_human_push_ups@male@idle_a', 'idle_a', -1},
        training = {'amb@world_human_push_ups@male@base', 'base', 1100},
        exit = {'amb@world_human_push_ups@male@exit', 'exit', 4050},
    },
    ['dumbbells'] = {
        idle = {'amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a', -1},
        training = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 4500},
    },
    ['treadmill'] = {
        idle = {'move_m@hurry@c', 'walk', -1},
        training = {'move_m@brave@a', 'run', 4000},
    },
}

Config.RefreshTimeAddStats = 10000 
Config.AddStatsValues = {
    ['Running'] = 3,
    ['Swimming'] = {5, 8},
    ['Cycling'] = {minimumSpeed = 15, value = {6, 8}},
    
    ['Shooting'] = {1, 2},

    ['Driving'] = {minimumSpeed = 140, value = {2, 7}},

    ['Flying'] = {minimumSpeed = 180, value = {5, 10}},
}

Config.RefreshTimeRemoveStats = 120000
Config.RemoveStatsValues = {
    ['RemoveCondition'] = 1,

    ['RemoveStrength'] = 0.5,
}

Config.Gyms = {
    [1] = {
        business = true,
        ownerJob = 'gym',
        jobMenuPos = vector3(-1260.5615, -351.6161, 36.9596),
        menuGrades = nil, -- nil: any player with this job | string: 'boss' | table: {'boss', 'manager'}
        bossMenuGrades = 'boss', -- string: 'boss' or table: {'boss', 'manager'}
        blipCoords = vector3(-1203.32, -1562.73, 4.61), -- don't remove it, set it in the center of the gym
        blipName = 'Siłownia',
        blipEnabled = true,
        requiredMembership = 'plaza_gym', -- false or name of membership like: 'plaza_gym'
        memberships = {
            {hours = 2, price = 50},
            {hours = 12, price = 100},
            {days = 1, price = 200},
            {days = 7, price = 1000},
            {days = 14, price = 1400},
            {days = 24, price = 2000},
            {days = 31, price = 2500},
        },
        points = {
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1267.3033, -355.1079, 35.3676, 191.1955),
                position = vec(-1201.55, -1562.81, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1207.11, -1560.81, 3.10, 212.49),
                position = vec(-1206.53, -1561.62, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1201.3, -1575.02, 3.10, 216.27),
                position = vec(-1200.68, -1575.89, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1261.9127, -354.3905, 35.3676, 214.4937),
                position = vec(-1197.13, -1567.6, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'pull-up',
                activityCoord = vector4(1696.9622, 2437.5459, 44.7367, 93.9654),
                position = vec(-1204.74, -1564.35, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'pull-up',
                activityCoord = vector4(-1271.8479, -360.2373, 35.9596, 123.8662),
                position = vec(-1204.74, -1564.35, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'pull-up',
                activityCoord = vector4(1648.9182, 2529.6929, 44.5649, 231.3186),
                position = vec(-1204.74, -1564.35, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'pull-up',
                activityCoord = vector4(-1204.74, -1564.35, 3.585, 35.88),
                position = vec(-1204.74, -1564.35, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'pull-up',
                activityCoord = vector4(-1200.02, -1571.14, 3.585, 213.62),
                position = vec(-1200.19, -1570.93, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1266.6826, -365.2421, 35.8923, 299.9220),
                position = vec(-1198.97, -1574.5, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1268.5542, -361.4196, 35.8923, 289.3905),
                position = vec(-1197.01, -1572.9, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1202.67, -1565.53, 3.61, 32.46),
                position = vec(-1202.67, -1565.53, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'bench',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(1690.7753, 2439.9370, 44.1170, 267.0608),
                position = vec(-1202.67, -1565.53, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'bench',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(1642.8923, 2535.4629, 44.0933, 228.1296),
                position = vec(-1202.67, -1565.53, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'bench',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(1640.5214, 2532.9411, 44.09486, 225.1603),
                position = vec(1640.5214, 2532.8411, 45.9486, 225.1603),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1210.31, -1561.34, 3.61, 77.1),
                position = vec(-1210.31, -1561.34, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'push-up',
                activityCoord = vector4(-1204.48, -1561.15, 3.61, 29.36),
                position = vec(-1204.48, -1561.15, 4.5),
                removeStamina = 3,
                addSkill = {skill = "strenght", value = 1}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1202.6, -1572.78, 3.61, 127.31),
                position = vec(-1202.6, -1572.78, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(1697.3069, 2439.7183, 44.7367, 270.9597),
                position = vec(1697.3069, 2439.7183, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1209.33, -1559.18, 3.61, 48.95),
                position = vec(-1209.33, -1559.18, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1267.1188, -357.0518, 35.9608, 129.4922),
                position = vec(1644.6543, 2537.4563, 44.5649, 242.3428),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(1642.9678, 2523.9065, 44.5649, 227.0316),
                position = vec(1642.9678, 2523.9065, 45.5649, 227.0316),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1198.32, -1565.38, 3.62, 240.3),
                position = vector3(-1198.32, -1565.41, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
        },
    },
}