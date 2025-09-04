Config.Functions = {
    StartFramework = function()
        if GetResourceState("es_extended") ~= "missing" then
            ESX = exports["es_extended"]:getSharedObject()
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore = exports["qb-core"]:GetCoreObject()
        end
    end,

    HasPlayerLoaded = function()
        if ESX then
            return ESX.IsPlayerLoaded()
        elseif QBCore then
            return QBCore.Functions.GetPlayerData()
        end
    end,

    --------------------------------- Server ---------------------------------

    RegisterUsableItem = function(item, func)
        -- func: (source, item) => void
        -- source<number> Its the player id that uses the item
        -- item<string>   The name of the item that is being used

        if GetResourceState("es_extended") ~= "missing" then
            ESX.RegisterUsableItem(item, func)
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore.Functions.CreateUseableItem(item, func)
        end
    end,

    GiveTrollyMoney = function(source, amount)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/AddMoney/
        exports["dbl_logs"]:SendLog(source, "```Z napadu na bank dostał "..amount.."$```", "napad")
        AddMoney(source, "cash", amount)
    end,

    HaveItem = function(source, item)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/HasItem/
        return HaveItem(source, item)
    end,
    
    RemoveItem = function(source, item, amount)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/RemoveItem/
        RemoveItem(source, item, amount)
    end,

    OnShuttersManagement = function(source)
        local bank = GetClosestBankInRadius(source, Config.ShuttersManagement.distance)
        if not bank then 
            TriggerClientAction("ShowNotify", source, Config.Translations["shutters_no_near_bank"])
            return
        end

        TriggerClientAction("ShowNotify", source, Config.Translations["shutters_toggling"])
        
        bank.door_shutters = not bank.door_shutters

        if bank.beingRobbed then
            bank.shuttersBroken = true
        end
    end,

    -- OnShutterHit: (bankId, source, weapon) => integer
    -- bankId<string> The id of the bank
    -- source<number> Its the player id that hit the shutter
    -- weapon<number> Current weapon hash that is being used

    -- Return the number of hits to add to the shutter
    OnShutterHit = function(bankId, source, weapon)
        -- Add your checks here
        return 1
    end,

    -- CanStartRobbery: (source, bankId) => boolean
    -- source<number> Its the player id that tries to start a robbery
    -- bankId<string> The id of the bank

    -- Return true if the player can start the robbery
    CanStartRobbery = function(source, bankId)
        if GlobalState['scoreboard_counter']["police"] < Config.MinCops then
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.showNotification(Config.Translations["robbery_cant_start_notify"])
            return false
        end
        if Cooldown > 0 then
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.showNotification(Config.Translations["robbery_cooldown_notify"])
            return false
        end
        return true
    end,

    StartAlarm = function(bankId)
        if ESX then
            exports['piotreq_gpt']:SendAlert(nil, {
                title = 'Napad na bank',
                code = '10-90',
                coords = Config.Banks[bankId].interior.pos,
                canAnswer = false,
                maxOfficers = 6,
                time = 2,
                blip = {
                    sprite = 434,
                    color = 5,
                    scale = 0.75,
                    alpha = 200,
                    name = 'Napad na bank',
                },
                type = 'risk',
                info = {
                    {icon = 'fa-solid fa-road', isStreet = true},
                },
                notifyTime = 10000,
            })
            Cooldown = 60
        elseif QBCore then
            local players = QBCore.Functions.GetQBPlayers()

            for _, v in pairs(players) do
                if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
                    TriggerClientAction('QBCore:Notify', v.PlayerData.source, Config.Translations["robbery_started_notify"], "primary")
                    TriggerClientAction("SetBlipToBank", v.PlayerData.source, bankId)
                end
            end
        end
    end,

    CanStartVaultHacking = function(source, bankId)
        if Config.VaultHackingItem and Config.VaultHackingItem ~= "" then
            return Config.Functions.HaveItem(source, Config.VaultHackingItem)
        else
            return true
        end
    end,
    RegisterNetEvent('utility_bank:OpenShutters',function(id)
        exports["utility_bank"]:SetBankDoorStatus(id, "shutters", false)
    end),
    -- Used to check validity of what the client is trying to do
    -- CanRaiseIntimidation: (source, bank) => boolean
    -- source<number> Its the player id that tries to raise the intimidation
    -- bank<Bank> The bank datas

    -- Return true if the player can raise the intimidation
    CanRaiseIntimidation = function(source, bank)
        local ped = GetPlayerPed(source)
        local weapon = GetSelectedPedWeapon(ped)

        -- Only allow if its using a weapon
        if weapon == `WEAPON_UNARMED` then
            return false
        end

        -- Only allow if the player is inside the bank
        if not InsideBank(source, bank) then
            return false
        end

        return true
    end,

    --------------------------------- Client ---------------------------------

    -- NeedToRaiseIntimdation: () => boolean, boolean

    -- Return true if need to raise the intimidation
    NeedToRaiseIntimdation = function()
        return IsPedShooting(PlayerPedId())
    end,

    -- Called when the player raises the intimidation
    -- OnRaiseIntimidation: () => void
    OnRaiseIntimidation = function()
        PlayShootPainHostages() -- internal function to play the shooting pain animation
    end,

    -- This function is called every 1 second while the player is inside a bank and if it is not being robbed
    -- NeedToStartRobbery: () => boolean

    -- Return true if need to start the robbery
    NeedToStartRobbery = function()
        return IsPedArmed(PlayerPedId(), 7)
    end,

    -- OnVaultHackingMinigameStarted: (bankId) => boolean 
    -- bankId<string> The id of the bank

    --  Returns true if the hack was completed successfully 
    OnVaultHackingMinigameStarted = function(bankId)
        -- StartHackingMinigame: (lives) => boolean
        -- lives<number> The amount of lives for the minigame
        -- password<string> The password for the minigame (ONLY 8 CHARACTERS)

        -- Returns true if the hack was completed successfully
        local result = exports.sfminigame6:startGame({ timePlay = 30, carSpeed = 0.50, playerSpeed = 0.25, level = 5 })
        if result then
            if not exports['mrg_achivements']:CheckIsUnlocked('bank_heist') then
                TriggerServerEvent("mrg_achivements:UnlockAchivements", "bank_heist", 1)
            end
            if not exports['mrg_achivements']:CheckIsUnlocked('bank_heist2') then
                TriggerServerEvent("mrg_achivements:UnlockAchivements", "bank_heist2", 1)
            end
            TriggerServerEvent("esx_basicneeds:TakeFoodItem", Config.VaultHackingItem)
        end

        return result
    end,

    --[[
        TargetAddModel = function(models, options)
    
        end,
        TargetAddLocalEntity = function(entity, options)
    
        end,
        TargetRemoveLocalEntity = function(entity)
    
        end,
    ]]
}