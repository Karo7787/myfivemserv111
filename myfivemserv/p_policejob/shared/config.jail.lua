Config.Jail = {}

Config.Jail.EnableJail = true -- enable jail system
Config.Jail.NeedDuty = true -- officer need to be on duty?
Config.Jail.RemoveItems = 'locker' -- 'locker' / 'wipe' / false ['locker' = all items will go to locker, 'wipe' = all items will be removed, false = nothing will happen]
Config.Jail.WhitelistedItems = { -- items that will not be removed [set to false if none]
    ['money'] = true,
}
Config.Jail.JailTimer = true -- enable jail timer [visible text ui on top of the screen]
Config.Jail.ReduceOfflineTime = false -- reduce offline time [if player is offline, time will be reduced]

-- SCRIPT WILL TELEPORT YOU AFTER DEATH TO ONE OF AVAILABLE BEDS :)
Config.Jail.Hospital = {
    enabled = true, -- enable hospital system?
    treatTime = 30, -- time it takes to treat a player
    reviveEvent = 'p_ambulancejob:RevivePlayer', -- client event to revive player without any args
    beds = {
        vector4(1785.9260, 2613.8350, 51.0082, 180.4699),
        vector4(1788.3591, 2613.9778, 51.0082, 180.5261),
        vector4(1790.6190, 2614.0393, 51.0082, 180.2590),
        vector4(1790.2001, 2609.7688, 50.9699, 359.4071),
        vector4(1787.8474, 2609.7656, 50.9700, 0.0675),
        vector4(1785.6639, 2609.8467, 50.9700, 0.6679)
    }
}

Config.Jail.Access = {
    ['jail'] = { -- jail command [/jail id months fine reason]
        ['owner'] = true, -- player with owner group/permission can use
        ['admin'] = true, -- player with admin group/permission can use
    },
    ['unjail'] = { -- unjail command [/unjail id]
        ['owner'] = true, -- player with owner group/permission can use
        ['admin'] = true, -- player with admin group/permission can use
    },
    ['shortjail'] = { -- shortjail command [it will short player jail time /short jail id months]
        ['owner'] = true, -- player with owner group/permission can use
        ['admin'] = true, -- player with admin group/permission can use
    }
}

Config.Jail.Outfit = {
    ["male"] = {
        { type = "component", id = 8, drawable = 15, variation = 0 },   -- tshirt
        { type = "component", id = 11, drawable = 900, variation = 0 }, -- torso
        { type = "component", id = 10, drawable = 0, variation = 0 },   -- decals
        { type = "component", id = 3, drawable = 0, variation = 0 },    -- arms
        { type = "component", id = 4, drawable = 393, variation = 0 },  -- pants
        { type = "component", id = 6, drawable = 54, variation = 0 },  -- shoes
        { type = "component", id = 1, drawable = 0, variation = 0 },    -- mask
        { type = "component", id = 7, drawable = 0, variation = 0 },    -- chain
        { type = "prop", id = 0, drawable = -1, variation = 0 },        -- helmet
        { type = "prop", id = 2, drawable = 2, variation = 0 }          -- ears
    },
    ["female"] = {
        { type = "component", id = 8, drawable = 3, variation = 0 },   -- tshirt
        { type = "component", id = 11, drawable = 1134, variation = 0 }, -- torso
        { type = "component", id = 10, drawable = 0, variation = 0 },   -- decals
        { type = "component", id = 3, drawable = 4, variation = 0 },   -- arms
        { type = "component", id = 4, drawable = 363, variation = 0 },  -- pants
        { type = "component", id = 6, drawable = 24, variation = 0 },  -- shoes
        { type = "component", id = 1, drawable = 0, variation = 0 },    -- mask
        { type = "component", id = 7, drawable = 0, variation = 0 },    -- chain
        { type = "prop", id = 0, drawable = -1, variation = 0 },        -- helmet
        { type = "prop", id = 2, drawable = 2, variation = 0 }          -- ears
    }
}

Config.Jail.ConvertMonths = function(months)
    if not months then 
        months = 0
    end
    return math.floor(months * 60) -- month = 1 minute
end

Config.Jail.ConvertMonths_2 = function(time)
    if not time then 
        time = 0
    end
    return math.floor(time / 60) -- seconds to month (1 minute)
end

Config.Jail.SetUniform = function()
    TriggerEvent("p_policejob:setuniform")
end

RegisterNetEvent("p_policejob:setuniform", function()
    local uniformObject
            
    local playerSex = Core.GetPlayerSex()
    local sex = nil
    if playerSex == 'm' or playerSex == 0 then
        sex = 'male'
    else
        sex = 'female'
    end

    uniformObject = Config.Jail.Outfit[sex]
    Citizen.Wait(2500)
    TriggerEvent("mrg_skin:skin:change", uniformObject)
end)

Config.Jail.Zone = {
    jailCoords = vector4(1755.2000, 2492.9490, 45.6513, 212.2371), -- tp here on jail
    unJailCoords = vector4(1846.5839, 2585.7852, 45.6720, 273.4318), -- tp here on ujail
    points = { -- BORDER POINTS OF JAIL MAP [https://overextended.dev/ox_lib/Modules/Zones/Shared#libzonespoly]
        vector3(1851.6860, 2612.5491, 40.6460),
        vector3(1852.1394, 2701.5581, 40.6460),
        vector3(1773.6439, 2767.1697, 40.6460),
        vector3(1648.2583, 2762.4854, 40.6460),
        vector3(1566.2778, 2682.9824, 40.6460),
        vector3(1530.6156, 2586.8628, 40.6460),
        vector3(1537.3165, 2467.2065, 40.6460),
        vector3(1657.2385, 2390.4211, 40.6460),
        vector3(1763.3314, 2406.4651, 40.6460),
        vector3(1827.3147, 2472.8708, 40.6460),
        vector3(1817.7594, 2533.5786, 40.6460),
        vector3(1820.1619, 2567.2734, 40.6460),
        vector3(1852.0808, 2567.8420, 40.6460),
        vector3(1852.4672, 2625.8269, 40.6460)
    },
    thickness = 50 -- thickness of border
}

Config.Jail.Cutscene = {
    isEnabled = true, -- enable cutscene? [if false it will teleport you to jail]
    playerPos = vector4(402.915, -996.759, -99.0002, 185.2249), -- player position
    cameraPos = { 
        x = 402.9453, y = -998.3599, z = -98.7041, -- camera coords
        rotationX = -5.4330, rotationY = 0.0, rotationZ = 0.31496 -- camera rotation
    },
}

Config.Jail.Tutorial = {
    isEnabled = false,
    points = {
        [1] = {
            duration = 5000,
            camCoords = vector3(1844.3916, 2580.3611, 46.8879),
            pointCoords = vector3(1839.5210, 2581.6890, 45.8905),
            camFov = 50.0,
            marker = {
                coords = vector3(1839.5165, 2581.7146, 45.9906),
                rot = vector3(0.0, 180.0, 0.0),
                type = 3,
                color = {255, 255, 255, 100}, -- rgba
                scale = 0.5,
            },
            text = 'Jail Locker - You can get your items here after finishing your sentence',
        },
        [2] = {
            duration = 4500,
            camCoords = vector3(1755.9613, 2500.9077, 46.7515),
            pointCoords = vector3(1755.5260, 2498.2148, 45.8214),
            text = 'Info Center - You can check your sentence or get a work to short your time',
            camFov = 60.0,
            marker = {
                coords = vector3(1755.2795, 2497.3257, 46.5559),
                rot = vector3(0.0, 180.0, 0.0),
                type = 3,
                color = {255, 255, 255, 100}, -- rgba
                scale = 0.5,
            },
        },
        [3] = {
            duration = 4000,
            camCoords = vector3(1595.3795, 2537.5793, 47.7293),
            pointCoords = vector3(1591.3011, 2541.7803, 45.9285),
            text = 'Laundry - One of place where you can work to short your sentence',
            camFov = 60.0,
        },
        [4] = {
            duration = 4000,
            camCoords = vector3(1567.7051, 2548.1458, 46.8292),
            pointCoords = vector3(1580.4064, 2548.0740, 45.6993),
            text = 'Woodwork - One of place where you can work to short your sentence',
            camFov = 60.0,
        },
    }
}

-- IT WILL EXECUTE WHEN PLAYER GET FINED [SERVER SIDED ONLY!]
Config.Jail.OnPlayerFine = function(playerId, fine, officerName, officerId) -- SERVER SIDE
    -- do something
end

-- IT WILL EXECUTE WHEN PLAYER GET JAILED [SERVER SIDED ONLY!]
Config.Jail.OnPlayerJailed = function(player, months, fine, officerName, officerId) -- SERVER SIDE
    if not exports.mrg_achivements:CheckIsUnlocked(player, "wiezienie") then
        exports.mrg_achivements:UnlockAchivements(player, "wiezienie", 1)
    end
    if not exports.mrg_achivements:CheckIsUnlocked(player, "wiezienie2") then
        exports.mrg_achivements:UnlockAchivements(player, "wiezienie2", 1)
    end
end

-- IT WILL EXECUTE WHEN PLAYER GET UNJAILED [SERVER SIDED ONLY!]
Config.Jail.OnPlayerUnJailed = function(player) -- SERVER SIDE
    TriggerClientEvent('p_policejob/jail/clearJob', player)
    if GetResourceState('illenium-appearance') == 'started' then
        TriggerClientEvent('illenium-appearance:client:reloadSkin', player, true)
    else
        if GetResourceState('es_extended') == 'started' then
            local xPlayer = ESX.GetPlayerFromId(player)
            local row = MySQL.single.await('SELECT skin FROM users WHERE identifier = ?', {xPlayer.identifier})
            if row and row.skin then
                local plySkin = json.decode(row.skin)
                TriggerClientEvent('skinchanger:loadClothes', player, plySkin, plySkin)
            end
        else
            local QBCore = exports['qb-core']:GetCoreObject()
            local Player = QBCore.Functions.GetPlayer(player)
            local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
            if result[1] ~= nil then
                TriggerClientEvent("qb-clothes:loadSkin", player, false, result[1].model, result[1].skin)
            else
                TriggerClientEvent("qb-clothes:loadSkin", player, true)
            end
        end
    end
    -- do something
end

Config.Jail.Lockers = {
    ['MissionRow'] = {
        coords = vector3(-1078.8, -819.88, 23.15),
        radius = 0.75,
        drawSprite = true,
        options = {
            {
                name = 'MissionRow_Jail_Locker',
                label = locale('jail_locker'),
                icon = 'fa-solid fa-id-card',
                distance = 2,
                drawSprite = true,
                groups = {['police'] = 1},
                onSelect = function()
                    OpenPlayerLocker()
                end,
                canInteract = function()
                    local dutyData = Core.CheckDuty()
                    return dutyData.status == 1
                end
            },
            {
                name = 'MissionRow_Evidence_Locker',
                label = locale('evidence_locker'),
                icon = 'fa-solid fa-id-card',
                distance = 2,
                drawSprite = true,
                groups = {['police'] = 1},
                onSelect = function()
                    OpenPlayerEvidence()
                end,
                canInteract = function()
                    local dutyData = Core.CheckDuty()
                    return dutyData.status == 1
                end
            }
        }
    }
}

Config.Jail.PersonalPrisonLocker = {
    coords = vector3(1840.21, 2578.47, 46.07),
    radius = 0.75,
    label = locale('jail_locker'),
    icon = 'fa-solid fa-id-card',
    distance = 2,
    drawSprite = true,
}

-- INFO CENTER [CHECK SENTENCE AND JAIL JOBS]
Config.Jail.Ped = {
    model = 's_m_y_cop_01',
    anim = {},
    coords = vector4(1755.2795, 2497.3257, 45.6559, 300.7351) -- coords of ped and target
}

Config.Jail.Jobs = {
    ["Sprzątanie"] = {
        [1] = {
            target = {label = "Zamiataj podłogę", icon = 'fa-solid fa-broom'},
            locations = {
                vector3(1767.6052, 2501.1599, 44.7407),
                vector3(1765.1724, 2498.3315, 44.7407),
                vector3(1762.1005, 2496.5417, 44.7407),
                vector3(1755.3977, 2492.9087, 44.7407),
                vector3(1752.5946, 2491.2573, 44.7407),
                vector3(1749.4236, 2489.4070, 44.7407)
            },
            blipData = {
                sprite = 566, color = 5, label = "Sprzątanie", scale = 0.8
            },
            onStart = function()
                Editable.showHelpNotify("Sprzątanie", "Zamiataj podłogę w wyznaczonych miejscach.")
            end,
            progress = {
                duration = 5000,
                label = "Zamiatanie podłogi...",
                anim = {
                    dict = "anim@amb@drug_field_workers@rake@male_a@base",
                    clip = "base",
                    flag = 1
                },
                prop = {
                    model = `prop_tool_broom`,
                    bone= 28422,
                    pos = vector3(-0.01, 0.04, -0.03),
                    rot = vector3(0.0, 0.0, 0.0)
                },
                disable = {
                    move = true,
                    combat = true,
                    car = true
                }
            },
            onEnd = function()
                jailJobs.stopAnim()
            end,
            months = {min = 1, max = 2}
        }
    },
    ["Kuchnia"] = {
        [1] = { -- Zbieranie składników
            target = {label = "Zbierz składniki", icon = 'fa-solid fa-carrot'},
            locations = {
                vector3(1785.7053, 2564.3765, 45.6731)
            },
            blipData = {
                sprite = 514, color = 46, label = "Kuchnia", scale = 0.8
            },
            onStart = function()
                Editable.showHelpNotify("Kuchnia", "Zbierz potrzebne składniki do przygotowania dania.")
            end,
            progress = {
                duration = 5000, label = "Zbieranie składników...",
                anim = {dict = 'amb@world_human_stand_fire@male@idle_a', clip = 'idle_a', flag = 1},
                disable = {move = true, combat = true, car = true},
            },
            onEnd = function()
            end,
        },
    
        [2] = { -- Gotowanie
            target = {label = "Gotuj", icon = 'fa-solid fa-fire-burner'},
            locations = {
                vector3(1780.9863, 2564.6482, 45.5927)
            },
            blipData = {
                sprite = 514, color = 46, label = "Kuchnia", scale = 0.8
            },
            onStart = function()
                Editable.showHelpNotify("Kuchnia", "Rozpocznij gotowanie dania.")
            end,
            onSelect = function()
                local result
                for i=1, 3 do
                    result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                    if not result then break end
                    Wait(1000)
                end
                return result
            end,
            progress = {
                duration = 7000, label = "Gotowanie...",
                anim = {scenario = 'PROP_HUMAN_BBQ'},
                disable = {move = true, combat = true, car = true},
            },
            onEnd = function()
            end,
        },
    
        [3] = { -- Dodatki
            target = {label = "Dodaj dodatki", icon = 'fa-solid fa-pepper-hot'},
            locations = {
                vector3(1781.5797, 2560.6870, 45.6731)
            },
            blipData = {
                sprite = 514, color = 46, label = "Kuchnia", scale = 0.8
            },
            onStart = function()
                Editable.showHelpNotify("Kuchnia", "Dodaj odpowiednie dodatki.")
            end,
            progress = {
                duration = 5000, label = "Dodawanie dodatków...",
                anim = {dict = 'amb@world_human_stand_fire@male@idle_a', clip = 'idle_a', flag = 1},
                disable = {move = true, combat = true, car = true},
            },
            onEnd = function()
            end,
        },
    
        [4] = { -- Dostawa
            target = {label = "Dostarcz jedzenie", icon = 'fa-solid fa-motorcycle'},
            locations = {
                vector3(1785.5145, 2554.4749, 45.6731)
            },
            blipData = {
                sprite = 514, color = 46, label = "Kuchnia", scale = 0.8
            },
            onStart = function()
                Editable.showHelpNotify("Kuchnia", "Dostarcz przygotowane jedzenie.")
            end,
            progress = {
                duration = 7000, label = "Dostarczanie jedzenia...",
                anim = {dict = 'mini@repair', clip = 'fixing_a_ped', flag = 1},
                disable = {move = true, combat = true, car = true},
            },
            onEnd = function()

            end,
            months = {min = 1, max = 3}
        },
    }
}

-- JAIL UTILITIES

Config.Jail.Utils = {}

Config.Jail.Utils.Showers = {
    {coords = vec3(1697.4, 2578.94, 45.4), radius = 0.9, duration = 10000},
    {coords = vec3(1697.26, 2577.38, 45.4), radius = 0.9, duration = 10000},
    {coords = vec3(1697.36, 2575.73, 45.5), radius = 0.9, duration = 10000},
}

Config.Jail.Utils.Kitchens = {
    ['Kitchen_1'] = {
        coords = vec3(1735.6, 2587.45, 45.7),
        items = {
            ['water'] = {label = locale('water')},
            ['burger'] = {label = locale('burger')},
        }
    }
}

Config.Jail.Utils.Undress = function()
    local p = promise.new()
    local oldSkin = Editable.GetPlayerSkin()
    local firstDict = lib.requestAnimDict('missmic4')
    local secondDict = lib.requestAnimDict('re@construction')
    TaskPlayAnim(cache.ped, firstDict, 'michael_tux_fidget', -8.0, 8.0, 2000, 51)
    Editable.setClothes({
        ['arms'] = 15,
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 15, ['torso_2'] = 0,
        ['bproof_1'] = 0, ['bproof_2'] = 0
    })
    Citizen.Wait(2000)
    TaskPlayAnim(cache.ped, secondDict, 'out_of_breath', -8.0, 8.0, 2000, 51)
    Citizen.Wait(1000)
    Editable.setClothes({
        ['arms'] = 15,
        ['pants_1'] = 14, ['pants_2'] = 0,
        ['shoes_1'] = 34, ['shoes_2'] = 0,
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 15, ['torso_2'] = 0,
        ['bproof_1'] = 0, ['bproof_2'] = 0
    })
    ClearPedTasks(cache.ped)
    Citizen.Wait(250)
    p:resolve(oldSkin)

    local await = Citizen.Await(p)
    RemoveAnimDict(firstDict)
    RemoveAnimDict(secondDict)
    return await
end