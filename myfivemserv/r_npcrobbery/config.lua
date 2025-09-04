R = {}

R.Framework = "ESX" -- Options: ESX, qbcore
R.NewEsx = true -- if you use esx 1.1 version set this to false

R.Target = "ox_target" -- options: ox_target, qb-target
R.Inventory = "ox_inventory" -- Options: ESX, qb-inventory, ox_inventory, quasar
R.Policenotify = "ps-dispatch" -- options cd_dispatch, ps-dispatch, linden_outlawalert, quasar-dispatch, core-dispatch, op-dispatch

-- Logs
R.Enablelogs = true -- set to true if you want to use logs
R.Logtype = "webhook" -- options: webhook or ox_lib

-- customize
R.Cooldowntime = 30 -- in minutes
R.Policeneeded = 0 -- police needed to rob npc
R.PlayerRobChance = 5 -- the chance that npc robs the player
R.PlayerRobTime = 10000 -- time it takes for npc to rob player
R.NpcWeapon = "weapon_pistol" -- weapon for the npc
R.RobbedCurrency = "money" -- the currency that npc steals (Options: "money", "bank", "black_money")
R.RobbedAmount = 80 -- % amount of players RobbedItem count
R.KillChance = 3 -- % 0-100 chance does the npc kill the player (npc will try to kill the player if kills he leaves the scene if does not manage to kill the player he leaves)
R.Npcrobtime = math.random(4000, 6000) -- now long it takes to rob npc
R.NpcRobDistance = 2.5 -- robbery distance (target)

R.AlertJobs = { -- your police jobs
    "police",
    "fib"
}

R.EnableZone = false -- do you want to enable robbery zones (so people can only rob peds inside these zones)
R.Zones = {
    ["grove"] = {
        ZoneDebug = true,
        ZoneThickness = 30,
        Points = {
            vec(-181.3508, -1503.8090, 29.2750),
            vec(-245.3368, -1582.3202, 29.2750),
            vec(-245.5448, -1707.3185, 29.2750),
            vec(-184.4426, -1763.4316, 29.2750),
            vec(-50.0829, -1606.5959, 29.2750),
        }
    },
}

R.Rewards =  {
    {item = "money", min = 150, max = 250, chance = 90},
    {item = "watch1", min = 1, max = 1, chance = 50},
    {item = "laptop", min = 1, max = 2, chance = 95},
    {item = "usb_black", min = 1, max = 2, chance = 50},
}

R.Blacklist = {
    "a_c_rhesus",
    "a_c_boar",
    "a_c_cat_01",
    "a_c_chickenhawk",
    "a_c_chimp",
    "a_c_chop",
    "a_c_cormorant",
    "a_c_cow",
    "a_c_coyote",
    "a_c_crow",
    "a_c_deer",
    "a_c_dolphin",
    "a_c_fish",
    "a_c_hen",
    "a_c_humpback",
    "a_c_husky",
    "a_c_killerwhale",
    "a_c_mtlion",
    "a_c_pig",
    "a_c_pigeon",
    "a_c_poodle",
    "a_c_pug",
    "a_c_rabbit_01",
    "a_c_rat",
    "a_c_retriever",
    "a_c_rottweiler",
    "a_c_seagull",
    "a_c_sharkhammer",
    "a_c_sharktiger",
    "a_c_shepherd",
    "a_c_stingray",
    "a_c_westy",  
}
