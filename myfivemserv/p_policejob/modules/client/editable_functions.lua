Editable = {
    --@param text: string
    --@param type: string [inform, error, success]
    showNotify = function(text, type)
        lib.notify({
            title = 'Police',
            description = text,
            type = type or 'inform'
        })
    end,

    --@param data: table
    --@param data.duration: number [duration in milliseconds]
    --@param data.label: string [label for the progress bar]
    --@param data.disable: table [car: boolean, move: boolean, combat: boolean, mouse: boolean]
    --@param data.anim: table [dict: string, clip: string, flag: number]
    progressBar = function(data)
        return lib.progressBar({
            duration = data.duration or 5000,
            label = data.label or '',
            useWhileDead = false,
            canCancel = true,
            disable = data.disable or {car = true, move = true, combat = true},
            anim = data.anim or nil
        })
    end,

    --@param playerId: number [existing player server id]
    isPlayerDead = function(playerId)
        local stateBag = Player(playerId).state
        return stateBag.isDead or stateBag.dead
    end,

    GetPlayerPrivateClothes = function()
        return lib.callback.await('p_policejob/server/getPlayerPrivateClothes', false)
    end,

    GetPlayerSkin = function()
        if GetResourceState('skinchanger') == 'started' then
            local skin = nil
            TriggerEvent('skinchanger:getSkin', function(skinData)
                skin = skinData
            end)
            while skin == nil do Citizen.Wait(100) end

            return skin
        elseif GetResourceState('qb-clothing') == 'started' then
            return lib.callback.await('p_policejob/server/getPlayerSkin', false)
        elseif GetResourceState('illenium-appearance') == 'started' then
            return exports['illenium-appearance']:getPedAppearance(cache.ped)
        elseif GetResourceState('rcore_clothing') == 'started' then
            return exports['rcore_clothing']:getPlayerSkin(false)
        elseif GetResourceState('crm-appearance') == 'started' then
            return exports['crm-appearance']:crm_get_ped_clothing(cache.ped)
        elseif GetResourceState('bl_appearance') == 'started' then
            return exports['bl_appearance']:GetDrawables(cache.ped)
        elseif GetResourceState('0r-clothing') == 'started' then
            return exports['qb-clothing']:GetSkinData()
        end
    end,

    playClothesAnim = function()
        local animDict = lib.requestAnimDict('clothingtie')
        TaskPlayAnim(cache.ped, animDict, 'try_tie_negative_a', 2.0, 2.0, 2000, 49, 0, false, false, false)
        RemoveAnimDict(animDict)
        Citizen.Wait(1000)
    end,

    convertSkin = function(skin)
        if GetResourceState('skinchanger') == 'started' then
            return skin
        elseif GetResourceState('qb-clothing') == 'started' then
            return {
                ["hat"] = { item = skin.helmet_1 or 0, texture = skin.helmet_2 or 0 },
                ["mask"] = { item = skin.mask_1 or 0, texture = skin.mask_2 or 0 },
                ["glass"] = { item = skin.glasses_1 or 0, texture = skin.glasses_2 or 0 },
                ["ear"] = { item = skin.ears_1 or 0, texture = skin.ears_2 or 0 },
                ["t-shirt"] = { item = skin.tshirt_1 or 0, texture = skin.tshirt_2 or 0 },
                ["torso2"] = { item = skin.torso_1 or 0, texture = skin.torso_2 or 0 },
                ["decals"] = { item = skin.decals_1 or 0, texture = skin.decals_2 or 0 },
                ["arms"] = { item = skin.arms or 0, texture = 0 },
                ["pants"] = { item = skin.pants_1 or 0, texture = skin.pants_2 or 0 },
                ["shoes"] = { item = skin.shoes_1 or 0, texture = skin.shoes_2 or 0 },
                ["bag"] = { item = skin.bags_1 or 0, texture = skin.bags_2 or 0 },
                ["vest"] = { item = skin.bproof_1 or 0, texture = skin.bproof_2 or 0 },
                ["accessory"] = { item = skin.chain_1 or 0, texture = skin.chain_2 or 0 },
                ["watch"] = { item = skin.watches_1 or 0, texture = skin.watches_2 or 0 },
                ["bracelet"] = { item = skin.bracelets_1 or 0, texture = skin.bracelets_2 or 0 }
            }
        elseif GetResourceState('illenium-appearance') == 'started' then
            return {
                components = {
                    {component_id = 1, drawable = skin.mask_1 or 0, texture = skin.mask_2 or 0},      -- Mask
                    {component_id = 3, drawable = skin.arms or 0, texture = skin.arms_2 or 0},    -- Arms
                    {component_id = 4, drawable = skin.pants_1 or 0, texture = skin.pants_2 or 0},    -- Pants
                    {component_id = 5, drawable = skin.bags_1 or 0, texture = skin.bags_2 or 0},      -- Bag
                    {component_id = 6, drawable = skin.shoes_1 or 0, texture = skin.shoes_2 or 0},    -- Shoes
                    {component_id = 7, drawable = skin.chain_1 or 0, texture = skin.chain_2 or 0}, -- Accessories
                    {component_id = 8, drawable = skin.tshirt_1 or 0, texture = skin.tshirt_2 or 0},  -- Undershirt
                    {component_id = 9, drawable = skin.bproof_1 or 0, texture = skin.bproof_2 or 0},    -- Body Armor
                    {component_id = 10, drawable = skin.decals_1 or 0, texture = skin.decals_2 or 0}, -- Decals
                    {component_id = 11, drawable = skin.torso_1 or 0, texture = skin.torso_2 or 0},   -- Top
                },
                props = {
                    {prop_id = 0, drawable = skin.helmet_1 or -1, texture = skin.helmet_2 or 0},      -- Helmet/Hat
                    {prop_id = 1, drawable = skin.glasses_1 or -1, texture = skin.glasses_2 or 0},    -- Glasses
                    {prop_id = 2, drawable = skin.ears_1 or -1, texture = skin.ears_2 or 0},          -- Ears
                    {prop_id = 6, drawable = skin.watches_1 or -1, texture = skin.watches_2 or 0},    -- Watches
                    {prop_id = 7, drawable = skin.bracelets_1 or -1, texture = skin.bracelets_2 or 0} -- Bracelets
                }
            }
        elseif GetResourceState('rcore_clothing') == 'started' then
            return skin
        elseif GetResourceState('crm-appearance') == 'started' then
            return skin
        elseif GetResourceState('bl_appearance') == 'started' then
            return skin
        elseif GetResourceState('0r-clothing') == 'started' then
            return {
                ["hat"] = { item = skin.helmet_1 or 0, texture = skin.helmet_2 or 0 },
                ["mask"] = { item = skin.mask_1 or 0, texture = skin.mask_2 or 0 },
                ["glass"] = { item = skin.glasses_1 or 0, texture = skin.glasses_2 or 0 },
                ["ear"] = { item = skin.ears_1 or 0, texture = skin.ears_2 or 0 },
                ["t-shirt"] = { item = skin.tshirt_1 or 0, texture = skin.tshirt_2 or 0 },
                ["torso2"] = { item = skin.torso_1 or 0, texture = skin.torso_2 or 0 },
                ["decals"] = { item = skin.decals_1 or 0, texture = skin.decals_2 or 0 },
                ["arms"] = { item = skin.arms or 0, texture = 0 },
                ["pants"] = { item = skin.pants_1 or 0, texture = skin.pants_2 or 0 },
                ["shoes"] = { item = skin.shoes_1 or 0, texture = skin.shoes_2 or 0 },
                ["bag"] = { item = skin.bags_1 or 0, texture = skin.bags_2 or 0 },
                ["vest"] = { item = skin.bproof_1 or 0, texture = skin.bproof_2 or 0 },
                ["accessory"] = { item = skin.chain_1 or 0, texture = skin.chain_2 or 0 },
                ["watch"] = { item = skin.watches_1 or 0, texture = skin.watches_2 or 0 },
                ["bracelet"] = { item = skin.bracelets_1 or 0, texture = skin.bracelets_2 or 0 }
            }
        end
    end,

    --@param clothes: table
    setClothes = function(clothes)
        if type(clothes) == 'string' then
            clothes = json.decode(clothes)
        end

        ClearPedBloodDamage(cache.ped)
        ResetPedVisibleDamage(cache.ped)
        ClearPedLastWeaponDamage(cache.ped)
        if GetResourceState('skinchanger') == 'started' then
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerEvent('skinchanger:loadClothes', skin, clothes)
            end)
        elseif GetResourceState('qb-clothing') == 'started' then
            TriggerEvent('qb-clothing:client:loadOutfit', {outfitData = clothes})
        elseif GetResourceState('illenium-appearance') == 'started' then
            exports['illenium-appearance']:setPedComponents(cache.ped, clothes.components)
            exports['illenium-appearance']:setPedProps(cache.ped, clothes.props)
        elseif GetResourceState('rcore_clothing') == 'started' then
            exports['rcore_clothing']:setPlayerSkin(clothes)
        elseif GetResourceState('crm-appearance') == 'started' then
            exports['crm-appearance']:crm_set_ped_clothing(cache.ped, clothes)
        elseif GetResourceState('bl_appearance') == 'started' then
            exports['bl_appearance']:SetPedClothes(cache.ped, clothes)
        elseif GetResourceState('0r-clothing') == 'started' then
            TriggerEvent('qb-clothing:client:loadOutfit', {outfitData = clothes})
        end
    end,

    --@param title: string
    --@param text: string
    showHelpNotify = function(title, text)
        if GetResourceState('p_hints') == 'started' then
            exports['p_hints']:showHintUI({
                title = title,
                text = text,
            })
        else
            lib.showTextUI(text or title)
        end
    end,

    hideHelpNotify = function()
        if GetResourceState('p_hints') == 'started' then
            exports['p_hints']:hideHintUI()
        else
            lib.hideTextUI()
        end
    end,
    
    -- COMPATIBILITY WITH OUR POLICE MDT
    CheckDuty = function()
        return GetResourceState('piotreq_gpt') ~= 'missing' and exports['piotreq_jobcore']:GetDutyData() or {status = 1}
    end,

    -- HAND CUFF MINIGAME TO ESCAPE, IF YOU DONT WANT SET RETURN FALSE INSIDE FUNCTION
    CuffGame = function() 
        local game = lib.skillCheck(
            {
                {areaSize = 30, speedMultiplier = 1.5},
            },
            {'1', '2'}
        )
        return game
    end,

    GetWeaponSerial = function()
        if GetResourceState('ox_inventory') == 'started' then
            return exports.ox_inventory:getCurrentWeapon()?.metadata?.serial or nil
        elseif GetResourceState('qs-inventory') == 'started' then
            return exports['qs-inventory']:GetCurrentWeapon()?.info?.serial or nil
        end
    end
}