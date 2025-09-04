myESX = exports.es_extended:getSharedObject();
function isPlayerJobMatching(tattooJobs, playerJob)
    if not playerJob or not playerJob.name then
        dbg.info('isPlayerJobMatching: playerJob not passed!')
        return false
    end

    for _, tattooJob in pairs(tattooJobs) do
        if not tattooJob.name then
            dbg.error('isPlayerJobMatching: Missing job name in tattoo permissions config!')
            break
        end

        if tattooJob.name == playerJob.name then
            if playerJob.grade == nil and tattooJob.grade == nil then
                return true
            end
            
            if tattooJob.grade == nil then
                return true
            end

            if playerJob.grade ~= nil and playerJob.grade >= tattooJob.grade then
                return true
            end
        end
    end
end

function canPlayerSeeShop(shopPermittedJobs)
    if not shopPermittedJobs then return true end

    local playerJob
    local maxAttempts = 10
    local attempts = 0
    local waitTime = 100

    while not ESX or not ESX.GetPlayerData do
        attempts = attempts + 1

        if attempts > maxAttempts then
            dbg.critical("canPlayerSeeShop: Could not get framework object, contact support please.")                    
            dbg.critical('Cannot load player data!')
            return false
        end

        Wait(waitTime)
    end

    playerJob = PlayerData?.job

    if not playerJob then return true end

    return isPlayerJobMatching(shopPermittedJobs, playerJob)
end


-- If you need to do something extra after rcore_tattoos resets the player's tattoos
-- you can put it here and it will be executed after each tattoo reset (after buy, preview, remove..)

-- If you don't have any idea what to put here, ignore it
-- Could be used for example if someone gets their hair fades from other script deleted by our tattoo reset
-- because hair fades are considered to be tattoos in GTA. You could simply reapply the hair fades here somehow. 
function resetPedDecorationsExtra()
    return
end

-- This commands is for debugging when business bossmenu marker isn't working correctly
if Config.Debug then
    RegisterCommand("rcore_tattoos_reload_markers", function(source, args, rawCommand)
        TriggerEvent(triggerName('reloadBusinessMarkers'))
    end, false)
end


------------------------------
-- Menu open/closing events

-- If you don't have any idea what to put here, ignore it
-- Use on your own risk, use these functions only if you are experienced,
-- support is not provided with these extra functions
------------------------------
function applyNakedOutfit(gender)
    local Skin = Config.NakedPartsIds[gender]
    if not Skin then
        print("Niepoprawna płeć: " .. tostring(gender))
        return
    end

    -- Komponenty (ubrania)
    exports["mrg_skin"]:setPlayerComponent(3, "drawable", Skin.tshirt_1, true) -- T-shirt
    exports["mrg_skin"]:setPlayerComponent(3, "variation", Skin.tshirt_2, true)

    exports["mrg_skin"]:setPlayerComponent(11, "drawable", Skin.torso_1, true) -- Torso
    exports["mrg_skin"]:setPlayerComponent(11, "variation", Skin.torso_2, true)

    exports["mrg_skin"]:setPlayerComponent(4, "drawable", Skin.pants_1, true) -- Spodnie
    exports["mrg_skin"]:setPlayerComponent(4, "variation", Skin.pants_2, true)

    exports["mrg_skin"]:setPlayerComponent(6, "drawable", Skin.shoes_1, true) -- Buty
    exports["mrg_skin"]:setPlayerComponent(6, "variation", Skin.shoes_2, true)

    exports["mrg_skin"]:setPlayerComponent(10, "drawable", Skin.decals_1, true) -- Tatuaże/dekale
    exports["mrg_skin"]:setPlayerComponent(10, "variation", Skin.decals_2, true)

    exports["mrg_skin"]:setPlayerComponent(1, "drawable", Skin.mask_1, true) -- Maska
    exports["mrg_skin"]:setPlayerComponent(9, "drawable", Skin.bproof_1, true) -- Kamizelka
    exports["mrg_skin"]:setPlayerComponent(9, "variation", Skin.bproof_2, true)

    exports["mrg_skin"]:setPlayerComponent(7, "drawable", Skin.chain_1, true) -- Łańcuch
    exports["mrg_skin"]:setPlayerComponent(7, "variation", Skin.chain_2, true)

    exports["mrg_skin"]:setPlayerComponent(5, "drawable", Skin.bags_1, true) -- Plecak
    exports["mrg_skin"]:setPlayerComponent(5, "variation", Skin.bags_2, true)

    exports["mrg_skin"]:setPlayerComponent(3, "drawable", Skin.arms, true) -- Ręce

    -- Propsy (np. kask, okulary, uszy)
    exports["mrg_skin"]:setPlayerProp(0, "drawable", Skin.helmet_1, true) -- Kask
    exports["mrg_skin"]:setPlayerProp(0, "variation", Skin.helmet_2, true)

    exports["mrg_skin"]:setPlayerProp(1, "drawable", Skin.glasses_1, true) -- Okulary
    exports["mrg_skin"]:setPlayerProp(1, "variation", Skin.glasses_2, true)

    exports["mrg_skin"]:setPlayerProp(2, "drawable", Skin.ears_1, true) -- Uszy
    exports["mrg_skin"]:setPlayerProp(2, "variation", Skin.ears_2, true)
end
-- This function is called before tattoo shop menu is opened
function beforeMenuOpen(pos, onlyPreview)
    local playerSex = myESX.GetPlayerData().sex
    local sex = nil
    if playerSex == 'm' or playerSex == 0 then
        sex = 'male'
    else
        sex = 'female'
    end
    applyNakedOutfit(sex)
    exports["mrg_ui"]:HideHelpNotification()
end

-- This function is called after tattoo shop menu is closed
function afterMenuClose()
    ExecuteCommand('fixskin')
end
