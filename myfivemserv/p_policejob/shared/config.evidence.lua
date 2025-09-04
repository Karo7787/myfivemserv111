Config.Evidence = {}

Config.Evidence.Enabled = true -- toggle evidence system

Config.Evidence.Interact = 'target' -- target / 3d_text
Config.Evidence.TargetExpire = 120 -- [if u are using target] how long evidences will be visible after player hide flashlight

-- finger print scanner
Config.Evidence.Scanner = {
    useRequest = true, -- if true, it will send request to player to scan his fingerprint
    useMugshot = true, -- if true, it will use mugshot from player [required MugShotBase64 from github]
}

Config.Evidence.preventEvidence = function()
    return false
end

Config.Evidence.Evidences = {
    ['gunpowder'] = {
        checkGloves = true, -- check if player has gloves on
        expire = 10 -- 10 minutes [from player hands]
    },
    ['projectile'] = {
        color = {255, 0, 0, 200}, -- RGBA
        range = 20, -- from what distance the evidence will be visible
        length = 3.5, -- line length
        expire = 60, -- 60 minutes
    },
    ['bullet'] = {
        color = {200, 100, 0, 100}, -- RGBA
        range = 20, -- from what distance the evidence will be visible
        prop = 'e_ch_a', -- yellow
        expire = 60, -- 60 minutes
    },
    ['blood'] = {
        color = {255, 0, 0, 200}, -- RGBA
        range = 20, -- from what distance the evidence will be visible
        prop = 'e_ch_b', -- red
        cooldown = 10, -- cooldown in seconds
        chance = 100, -- chance to spawn blood evidence after getting hit
        expire = 60, -- 60 minutes
    },
    ['fingerprint'] = { -- use export from our docs to add this evidence
        color = {0, 0, 255, 200}, -- RGBA
        range = 20, -- from what distance the evidence will be visible
        expire = 60, -- 60 minutes
    },
    ['vehicle_fingerprint'] = {
        chance = 100,
        expire = 60, -- 60 minutes
    },
    ['weed_sample'] = {
        color = {10, 200, 10, 200}, -- RGBA
        range = 20, -- from what distance the evidence will be visible
        prop = 'sf_prop_sf_bag_weed_open_01c', -- red
        expire = 60, -- 60 minutes
    },
}

Config.Evidence.Laboratories = {
    ['MissionRow'] = {
        coords = vector3(-1073.1, -817.2, 11.54),
        process = {
            ['blood'] = 10,
            ['bullet'] = 10,
            ['fingerprint'] = 10,
            ['footprint'] = 10,
            ['weed_sample'] = 10,
        }
    }
}

Config.Evidence.Registry = {
    ['MissionRow'] = {
        coords = vector3(-1062.16, -809.77, 11.54), -- coords for registry
    }
}

Config.Evidence.currentProps = {} -- table to store current props for evidences [dont touch it!!!!!!!!]

Config.Evidence.CustomFunctions = {
    ['weed_sample'] = function(data) -- 'weed_sample' is item name which will be added after collecting it
        if Config.Evidence.Evidences[data.type]?.prop and not Config.Evidence.currentProps[data.id] then
            Config.Evidence.currentProps[data.id] = true
            local paperModel = lib.requestModel(Config.Evidence.Evidences[data.type].prop)
            local tempObj = CreateObject(paperModel, data.coords, false, false, false)
            SetEntityRotation(tempObj, 90.0, 90.0, 90.0, 2, true)
            FreezeEntityPosition(tempObj, true)
            PlaceObjectOnGroundProperly(tempObj)
            SetEntityAlpha(tempObj, 220)
            SetEntityAsMissionEntity(tempObj, true, true)
            SetModelAsNoLongerNeeded(paperModel)
            Config.Evidence.currentProps[data.id] = tempObj
            if Config.Evidence.Interact == 'target' then
                Target.addLocalEntity(Config.Evidence.currentProps[data.id], 
                {
                    {
                        name = 'p_policejob/take_evidence_weed_sample',
                        label = locale('pickup_evidence'),
                        icon ='fa-solid fa-weed',
                        distance = 2.0,
                        onSelect = function()
                            local isPolice = Config.Jobs[Core.GetPlayerJob()?.name] ~= nil
                            local animDict = lib.requestAnimDict(isPolice and 'anim@scripted@freemode@postertag@collect_can@male@' or 'switch@franklin@cleaning_car')
                            TaskPlayAnim(cache.ped, animDict, isPolice and 'poster_tag_collect_can_var02_male' or '001946_01_gc_fras_v2_ig_5_base', 8.0, -8.0, 3500, 1, 0)
                            PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                            TriggerServerEvent('p_policejob/server_evidence/takeEvidence', data)
                            local evidenceId = data.id
                            DeleteObject(Config.Evidence.currentProps[evidenceId])
                            Config.Evidence.currentProps[evidenceId] = nil
                            RemoveAnimDict(animDict)
                        end,
                        canInteract = function()
                            local playerJob = Core.GetPlayerJob()
                            if Config.Jobs[playerJob.name] then
                                return true
                            end

                            return false
                        end
                    },
                    {
                        name = 'p_policejob/clean_evidence_weed_sample',
                        label = locale('clean_evidence'),
                        icon ='fa-solid fa-weed',
                        distance = 2.0,
                        onSelect = function()
                            local isPolice = Config.Jobs[Core.GetPlayerJob()?.name] ~= nil
                            local animDict = lib.requestAnimDict(isPolice and 'anim@scripted@freemode@postertag@collect_can@male@' or 'switch@franklin@cleaning_car')
                            TaskPlayAnim(cache.ped, animDict, isPolice and 'poster_tag_collect_can_var02_male' or '001946_01_gc_fras_v2_ig_5_base', 8.0, -8.0, 3500, 1, 0)
                            PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                            TriggerServerEvent('p_policejob/server_evidence/takeEvidence', data)
                            local evidenceId = data.id
                            DeleteObject(Config.Evidence.currentProps[evidenceId])
                            -- closestEvidence = {}
                            Config.Evidence.currentProps[evidenceId] = nil
                            RemoveAnimDict(animDict)
                        end,
                        canInteract = function()
                            local playerJob = Core.GetPlayerJob()
                            if Config.Jobs[playerJob.name] then
                                return false
                            end

                            return true
                        end
                    },
                })
            end
        end

        local color = Config.Evidence.Evidences['weed_sample']?.color or {10, 200, 10, 200}
        DrawMarker(
            27, data.coords, 
            0.0, 0.0, 0.0, 
            0.0, 0.0, 0.0, 
            0.25, 0.25, 0.25, 
            color[1], color[2], color[3], color[4], 
            false, false
        )
    end
}

local noGlovesData = { -- numbers with no gloves
    [-1] = true, [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true,
    [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true,
    [12] = true, [13] = true, [14] = true, [15] = true, [16] = true,
    [113] = true, [114] = true, [115] = true, [199] = true,
}

Config.Evidence.checkPlayerGloves = function()
    local playerGloves = GetPedDrawableVariation(cache.ped, 3) -- 0 is the index for gloves
    if noGlovesData[playerGloves] then
        return false -- No gloves equipped
    end

    return true -- Gloves are equipped
end

Config.Evidence.Weapons = {
    [joaat('WEAPON_PISTOL')] = {
        name = locale('pistol'),
        ammo = locale('ammo_pistol'),
    },
    [joaat('WEAPON_COMBATPISTOL')] = {
        name = locale('combat_pistol'),
        ammo = locale('ammo_pistol'),
    },
    [joaat('WEAPON_APPISTOL')] = {
        name = locale('ap_pistol'),
        ammo = locale('ammo_pistol'),
    },
    [joaat('WEAPON_MICROSMG')] = {
        name = locale('micro_smg'),
        ammo = locale('ammo_smg'),
    },
    [joaat('WEAPON_SMG')] = {
        name = locale('smg'),
        ammo = locale('ammo_smg'),
    },
    [joaat('WEAPON_ASSAULTRIFLE')] = {
        name = locale('assault_rifle'),
        ammo = locale('ammo_rifle'),
    },
    [joaat('WEAPON_CARBINERIFLE')] = {
        name = locale('carbine_rifle'),
        ammo = locale('ammo_rifle'),
    },
    [joaat('WEAPON_PUMPSHOTGUN')] = {
        name = locale('pump_shotgun'),
        ammo = locale('ammo_shotgun'),
    },
    [joaat('WEAPON_SAWNOFFSHOTGUN')] = {
        name = locale('sawn_off_shotgun'),
        ammo = locale('ammo_shotgun'),
    },
    [joaat('WEAPON_SNIPERRIFLE')] = {
        name = locale('sniper_rifle'),
        ammo = locale('ammo_sniper'),
    },
    [joaat('WEAPON_HEAVYSNIPER')] = {
        name = locale('heavy_sniper'),
        ammo = locale('ammo_sniper'),
    },
}