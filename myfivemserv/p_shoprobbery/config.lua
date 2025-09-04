Config = {}

Config.Language = 'pl' -- en / pl
Config.Framework = 'ESX' -- ESX / QB
Config.Debug = false
Config.InFrontRestrict = false -- set to true if you want restrict to player be in front of cash register
Config.FrontTolerance = 0.3 -- 0.3 distance to front coords is max

Config.PoliceJobs = {
    ['police'] = true
}

Config.PoliceAlert = function(playerId)
    if not exports.mrg_achivements:CheckIsUnlocked(playerId, "shoprobbery") then
        exports.mrg_achivements:UnlockAchivements(playerId, "shoprobbery", 1)
    end
    if not exports.mrg_achivements:CheckIsUnlocked(playerId, "shoprobbery2") then
        exports.mrg_achivements:UnlockAchivements(playerId, "shoprobbery2", 1)
    end
    if not exports.mrg_achivements:CheckIsUnlocked(playerId, "shoprobbery3") then
        exports.mrg_achivements:UnlockAchivements(playerId, "shoprobbery3", 1)
    end
    if GetResourceState('piotreq_gpt') == 'started' then
        exports['piotreq_gpt']:SendAlert(playerId, {
            title = 'Napad na sklep',
            code = '10-90',
            icon = 'fa-solid fa-mask',
            info = {
               {icon = 'fa-solid fa-road', isStreet = true},
            },
            blip = {
               scale = 1.25,
               sprite = 161,
               category = 3,
               color = 1,
               hidden = false,
               priority = 4,
               short = true,
               alpha = 200,
               name = "Napad na sklep"
            },
            type = 'normal',
            maxOfficers = 5,
            time = 2,
            notifyTime = 8000,
        })
    end
end

Config.CashRegister = {
    minigame = function()
        return exports["np_minigames"]:Lockpick("Lockpick", 4, 30) and 1 or 0
    end,
    models = {'prop_till_03', 'prop_till_01_dam', 'prop_till_01', 'prop_till_02', 'p_till_01_s'},
    policeCount = 2, -- required cops count
    cooldown = {
        all = 10 -- cooldown for all 5 minutes
    },
    reward = {
        moneyForPoint = 1000, -- money for 1 bag
        maxMoney = 1000,
    },
    openAnim = {
        dict = 'oddjobs@shop_robbery@rob_till',
        clip = 'loop',
        flag = 1
    },
    progress = function()
        local progressBar = lib.progressBar({
            duration = 5000,
            label = 'Okardanie kasetki...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true
            },
            anim = {
                dict = 'oddjobs@shop_robbery@rob_till',
                clip = 'loop',
                flag = 1
            }
        })

        return progressBar
    end
}

Config.Safe = {
    cooldown = 30, -- 1 minute
    policeCount = 3, -- needed police count to start
    minigame = function(randomCode, gameTime, coords)
        return exports["np_minigames"]:PinCracker(3, 20) and 1 or 0
    end,
    points = {
        [1] = {
            coords = vector4(24.7153, -1341.5815, 26.3848, 89.8009),
            codeLength = 10,
            gameTime = 25000,
            reward = {min = 2500, max = 5000},
            items = {
                ['klucze_do_magazynu'] = 1.0 -- script will remove 10% from item durability, set to 1 if you want to remove item
            },
        },
        [2] = {
            coords = vector4(1125.96, -982.53, 45.42, 94.03),
            codeLength = 10,
            gameTime = 25000,
            reward = {min = 2500, max = 5000},
            items = {
                ['klucze_do_magazynu'] = 1.0 -- script will remove 10% from item durability, set to 1 if you want to remove item
            },
        },
        [3] = {
            coords = vector4(373.81, 331.97, 100.45, 74.51),
            codeLength = 10,
            gameTime = 25000,
            reward = {min = 2500, max = 5000},
            items = {
                ['klucze_do_magazynu'] = 1.0 -- script will remove 10% from item durability, set to 1 if you want to remove item
            },
        },
        [4] = {
            coords = vector4(-1218.54, -915.82, 11.33, -169.34),
            codeLength = 10,
            gameTime = 25000,
            reward = {min = 2500, max = 5000},
            items = {
                ['klucze_do_magazynu'] = 1.0 -- script will remove 10% from item durability, set to 1 if you want to remove item
            },
        }

    }
}