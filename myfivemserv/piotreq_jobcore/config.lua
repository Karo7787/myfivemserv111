Config = {}

Config.Framework = 'ESX' -- ESX / QB / QBOX / ND (Bridge)
Config.Language = 'pl' -- en / pl

Config.Jobs = { -- jobs with duty timers
    ['police'] = true,
    ['lsfd'] = true,
    ['ambulance'] = true,
    ['mechanic'] = true,
    ['sheriff'] = false,
    ['bean'] = false,
    ['papa'] = false,
    ['burgershot'] = false
}

Config.Payout = {
    ped = {
        model = 'ig_barry',
        anim = {},
    },
    coords = vector4(242.6529, 226.6949, 106.2873, 165.5818),
    radius = 0.25,
    drawSprite = true,
    debug = false,
    label = 'Wez Wyplate',
    icon = 'fa-solid fa-dollar-sign'
}

Config.Society = {
    state = true, -- it will took money from society account
    percent = 100, -- if player has 1000$ payout, it will remove 100% of payout from society account
    needMoney = true, -- check if account has enough money, else it will just remove money without checking
}

Config.Payouts = {
    ['police'] = {
        ["0"] = 700, ["1"] = 1000, ["2"] = 1200,
        ["3"] = 1400, ["4"] = 1600, ["5"] = 1800,
        ["6"] = 2000, ["7"] = 2200, ["8"] = 2400,
        ["9"] = 2600, ["10"] = 2800, ["11"] = 3000,
        ["12"] = 3200, ["13"] = 3250, ["14"] = 3250,
    },
    ['ambulance'] = {
        ["0"] = 1000, ["1"] = 1500, ["2"] = 1700,
        ["3"] = 2000, ["4"] = 2200, ["5"] = 2500,
        ["6"] = 2700, ["7"] = 2900, ["8"] = 3100,
        ["9"] = 3300, ["10"] = 3500,
    },
    ['lsfd'] = {
        ["0"] = 700, ["1"] = 1000, ["2"] = 1200,
        ["3"] = 1400, ["4"] = 1600, ["5"] = 1800,
        ["6"] = 2000, ["7"] = 2200, ["8"] = 2400,
        ["9"] = 2600, ["10"] = 2800, ["11"] = 3000,
        ["12"] = 3200, ["13"] = 3250
    },
    ['mechanic'] = {
        ["0"] = 1000, ["1"] = 1000, ["2"] = 1000,
        ["3"] = 1200, ["4"] = 1500, ["5"] = 1700,
        ["6"] = 2200, ["7"] = 3000, ["8"] = 3100,
        ["9"] = 3200, ["10"] = 3500,
    },
}

-- piotreq_jobcore:TakePayout, you can use this server event if you want to set multiple points