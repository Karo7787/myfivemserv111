Config.Damages = {}

Config.Damages.Actions = {}

Config.Damages.Weapons = {
    [`WEAPON_UNARMED`] = { locale("been_beaten"), locale("beaten") },
    [`WEAPON_KNIFE`] = { locale("been_stabbed"), locale("stabbed") },
    [`WEAPON_NIGHTSTICK`] = { locale("been_hit", locale("nightstick")), locale("beaten") },
    [`WEAPON_HAMMER`] = { locale("been_struck", locale("hammer")), locale("stabbed") },
    [`WEAPON_BAT`] = { locale("been_hit", locale("bat")), locale("beaten") },
    [`WEAPON_GOLFCLUB`] = { locale("been_whacked", locale("golfclub")), locale("beaten") },
    [`WEAPON_CROWBAR`] = { locale("been_struck", locale("crowbar")), locale("stabbed") },
    [`WEAPON_PISTOL`] = { locale("been_shot", locale("pistol")), locale("shot") },
    [`WEAPON_COMBATPISTOL`] = { locale("been_shot", locale("combatpistol")), locale("shot") },
    [`WEAPON_APPISTOL`] = { locale("been_shot", locale("appistol")), locale("shot") },
    [`WEAPON_PISTOL50`] = { locale("been_shot", locale("pistol50")), locale("shot") },
    [`WEAPON_MICROSMG`] = { locale("been_shot", locale("microsmg")), locale("shot") },
    [`WEAPON_SMG`] = { locale("been_shot", locale("smg")), locale("shot") },
    [`WEAPON_ASSAULTSMG`] = { locale("been_shot", locale("assaultsmg")), locale("shot") },
    [`WEAPON_ASSAULTRIFLE`] = { locale("been_shot", locale("assaultrifle")), locale("shot") },
    [`WEAPON_CARBINERIFLE`] = { locale("been_shot", locale("carbinerifle")), locale("shot") },
    [`WEAPON_ADVANCEDRIFLE`] = { locale("been_shot", locale("advancedrifle")), locale("shot") },
    [`WEAPON_MG`] = { locale("been_shot", locale("mg")), locale("shot") },
    [`WEAPON_COMBATMG`] = { locale("been_shot", locale("combatmg")), locale("shot") },
    [`WEAPON_PUMPSHOTGUN`] = { locale("been_shot", locale("pumpshotgun")), locale("shot") },
    [`WEAPON_SAWNOFFSHOTGUN`] = { locale("been_shot", locale("sawnoffshotgun")), locale("shot") },
    [`WEAPON_ASSAULTSHOTGUN`] = { locale("been_shot", locale("assaultshotgun")), locale("shot") },
    [`WEAPON_BULLPUPSHOTGUN`] = { locale("been_shot", locale("bullpupshotgun")), locale("shot") },
    [`WEAPON_SNIPERRIFLE`] = { locale("been_shot", locale("sniperrifle")), locale("shot") },
    [`WEAPON_HEAVYSNIPER`] = { locale("been_shot", locale("heavysniper")), locale("shot") },
    [`WEAPON_REMOTESNIPER`] = { locale("been_shot", locale("remotesniper")), locale("shot") },
    [`WEAPON_GRENADELAUNCHER`] = { locale("been_hit", locale("grenadelauncher")), locale("beaten") },
    [`WEAPON_GRENADE`] = { locale("been_blown_up", locale("grenade")), locale("burn") },
    [`WEAPON_STICKYBOMB`] = { locale("been_blown_up", locale("stickybomb")), locale("burn") },
    [`WEAPON_MOLOTOV`] = { locale("been_set_on_fire", locale("molotov")), locale("burn") },
    [`WEAPON_RPG`] = { locale("been_hit", locale("rpg")), locale("beaten") },
    [`WEAPON_MINIGUN`] = { locale("been_shot", locale("minigun")), locale("shot") },
    [`WEAPON_GRENADELAUNCHER_SMOKE`] = { locale("been_hit", locale("grenadelauncher_smoke")), locale("beaten") },
    [`WEAPON_RAYPISTOL`] = { locale("been_shot", locale("raypistol")), locale("shot") },
    [`WEAPON_RAYCARBINE`] = { locale("been_shot", locale("raycarbine")), locale("shot") },
    [`WEAPON_RAYMINIGUN`] = { locale("been_shot", locale("rayminigun")), locale("shot") },
    [`WEAPON_RAYSHOTGUN`] = { locale("been_shot", locale("rayshotgun")), locale("shot") },
    [`WEAPON_RAYASSAULTRIFLE`] = { locale("been_shot", locale("rayassaultrifle")), locale("shot") },
    [-842959696] = { locale("been_fallen_to_death"), locale("beaten") },
}

Config.Damages.Bones = {
    ["0"] = { 
        id = "hip", 
        label = locale('hipbone'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'torso'
    },
    ["10706"] = { 
        id = "rclavicle", 
        label = locale('right_clavicle'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_arm' -- for ui
    },
    ["64729"] = { 
        id = "lclavicle", 
        label = locale('left_clavicle'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_arm' -- for ui
    },
    ["14201"] = { 
        id = "lfoot", 
        label = locale('left_foot'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_leg' -- for ui
    },
    ["18905"] = { 
        id = "lhand", 
        label = locale('left_hand'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_arm' -- for ui
    },
    ["24816"] = { 
        id = "lbdy", 
        label = locale('lower_chest'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'torso' -- for ui
    },
    ["24817"] = { 
        id = "ubdy", 
        label = locale('upper_chest'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'torso' -- for ui
    },
    ["24818"] = { 
        id = "shoulder", 
        label = locale('shoulder'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_arm' -- for ui
    },
    ["28252"] = { 
        id = "rforearm", 
        label = locale('rforearm'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_arm' -- for ui
    },
    ["36864"] = {
        id = "rleg",
        label = locale('right_leg'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_leg' -- for ui
    },                           
    ["39317"] = { 
        id = "neck", 
        label = locale('neck'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'head' -- for ui
    },
    ["40269"] = { 
        id = "ruparm", 
        label = locale('ruparm'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_arm' -- for ui
    },
    ["45509"] = { 
        id = "luparm", 
        label = locale('luparm'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_arm' -- for ui
    },
    ["51826"] = { 
        id = "rthigh", 
        label = locale('rthigh'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_leg' -- for ui
    },
    ["52301"] = { 
        id = "rfoot", 
        label = locale('right_foot'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_leg' -- for ui
    },
    ["57005"] = { 
        id = "rhand", 
        label = locale('right_hand'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'right_arm' -- for ui
    },
    ["57597"] = { 
        id = "lumbar", 
        label = locale('lumbar'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'torso' -- for ui
    },
    ["58271"] = { 
        id = "lthigh", 
        label = locale('lthigh'), 
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_leg' -- for ui
    },
    ["61163"] = { 
        id = "lforearm", 
        label = locale('lforearm'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_arm' -- for ui
    },
    ["63931"] = { 
        id = "lleg", 
        label = locale('left_leg'),
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'left_leg' -- for ui
    },
    ["31086"] = { 
        id = "head", 
        label = locale('head'), 
        onDamage = 'head', -- Config.Damages.Actions['head']
        actionTime = 5000, -- action will be active for 5 seconds after hit
        values = {
            ['default'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['10'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['20'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['30'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['40'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['50'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['60'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['70'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['80'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['90'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
            ['100'] = {
                label = locale('bruise'),
                items = {['ice_bag'] = 1, ['bandage'] = 1}
            },
        },
        part = 'head' -- for ui
    },          
}

exports("GetDamages", function()
    return Config.Damages.Bones
end)