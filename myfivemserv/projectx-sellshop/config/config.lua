Config = Config or {}
Loc = {}

-- //////////////////////////////////////////////////
-- ///////////////// Our Discord ////////////////////
-- //////// https://discord.gg/bJNxYDAm5u ///////////
-- //////////////////////////////////////////////////

Config = {
    debug = false, -- Shows polyzones created inside the game
    Lan = 'pl', -- Translation, 'en' 'pl' 'de' 'da' 'fr' 'in' 'am' 'ph' 'no' 'nl' 'ja' 'da' 'ru' 'gr' 'se' 'lt' 'ar' 'bg' 'bs', 'cn', 'cs', 'ee', 'el', 'en', 'es', 'et', 'fa', 'fi', 'ge', 'he', 'hu', 'id', 'is', 'it', 'lv', 'pt', 'pt-br', 'ro', 'rs', 'sl', 'sv', 'th', 'tr', 'vn'
    Framework = 'esx', -- 'qb' 'qbox' 'esx' or "custom" if you put it as "custom", you will need to edit the functions in opensource/client.lua and opensource/server.lua
    ESX = "new", -- (only for ESX users) "new" or "old" chosoe the version of ESX you are using
    Inventory = "ox", -- "ox" or "qs" or "qb" or "origen" or "tgiann" or "esx" or "lj" or "ps", or "custom" if you put it as "custom", you will need to edit the inventory functions in opensource/client.lua and opensource/server.lua
    Notification = "ox", -- "ox" or "qb" or "esx" or "custom" if you put it as "custom", you will need to edit the notification function in opensource/client.lua and opensource/server.lua
    Progressbar = "ox", -- "ox" or "qb" or "custom" if you put it as "custom", you will need to edit the progressbar function in opensource/client.lua
    ProgressbarType = "circle", -- "circle" or "bar" | ONLY USED FOR OX PROGRESSBAR
    Dispatch = {
        Resource = 'custom', -- "ps" "cd" "qs" "origen" "tk" "codem" "rcore" "l2s" "redutzu" "lb" "sonoran" or "outlaw" or "custom", if you put it as "custom", you will need to edit the dispatch function in opensource/client.lua
        -- If you wish to change the text on the dispatch you can do it here:
        Title = 'Podejrzana Sprzedaż',
        Description = 'Ktoś próbuje sprzedać nielegalne rzeczy',
        Code = '10-90',

        Blip = {
            Text = 'Podejrzana Sprzedaż',
            Color = 1,
            Sprite = 187,
            Scale = 0.8
        }
    },

    Interaction = 'ox_target', -- ox_target, qb-target, drawtext, worldinteract (worldinteract requires https://github.com/darktrovx/interact)

    DrawtextButton = 38, -- [E] by default
    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(1.4, 1.4, 2), -- Size of the drawtext zone
    DrawTextRotation = 70.0, -- Rotation of the drawtext zone

    CurrencySymbol = '$', -- Currency Symbol, you can change it to any symbol you want.
    InventoryPath = 'ox_inventory/web/images/', -- Inventory Path, change it to you inventory path for images.
    PoliceJobs = {["police"] = true}, -- Jobs that receive the dispatch and are checked for their count if you want to add more follow this example: PoliceJobs = {["police"] = true, ["fbi"] = true, ["swat"] = true}
    UseXP = false, -- If you want to use XP system, set this to true, otherwise set it to false
    ClientSideXP = false, -- If you want to use the client side XP system, set this to true, otherwise set it to false and it will use the server side XP system

    ProgressbarConfig = {
        Enable = false, -- If you want to use a progress bar, set this to true, otherwise set it to false and it will not use a progress bar
        Duration = 2000, -- Duration of the progress bar in milliseconds
        Text = 'Selling...', -- Text of the progress bar
        Animation = {
            Enable = true, -- If you want to use an animation, set this to true, otherwise set it to false and it will not use an animation
            NPCSync = true, -- If you want to make the npc play the emote aswell set this to true, otherwise set it to false and only the player will do the animation.
            Dict = 'mp_common', -- Animation dict
            Anim = 'givetake1_b', -- Animation name
        }
    },

    Shops = {
        ['pawnshop'] = {
            -- Menu/Target Options
            ["MenuTitle"] = 'Lombard', -- Menu Title. title on the sell menu
            ["TargetIcon"] = 'fas fa-dollar-sign', -- Target Icon, you can use any icon from fontawesome
            ["TargetText"] = 'Sprzedaj', -- Target/TextUI Text
            ["TargetSize"] = 1.5, -- Target Size
            ["TargetDistance"] = 1.0, -- Target Size
            ["OnlyShowItemsInInventory"] = false, -- true = Show only the items that the player has in his inventory, false show all items on this shop

            ["Coords"] = vector4(-1225.37, -1439.5, 3.37, 128.28), -- Coords of the ped or target

            ["Ped"] = {
                Enable = true, -- If you want to use a ped, set this to true, otherwise set it to false and it will use only target/drawtext
                Model = `a_m_m_business_01`,
                ["IdleAnimation"] = {
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (https://forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
                        anim = "idle_a"
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                },
                ["SuccessfulAnimation"] = { -- Player Successful Animation, you can use a scenario or an animation
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'mp_common',
                        anim = 'givetake1_b'
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                    Duration = 2,
                    AdvancedAnimation = false,
                },
                ["PedSuccessfulAnimation"] = { -- Ped/Npc Successful Animation, you can use a scenario or an animation
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'mp_common',
                        anim = 'givetake1_b'
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                },
            },

            ["TimeFrame"] = {
                Enable = false, -- If you want to use a time frame, set this to true, otherwise set it to false and it will be open 24/7
                Time = {open = 9, close = 22}, -- Time frame when the shop is open, if the shop is closed the player will get a notification when interacting.
            },
            
            ["PoliceCount"] = 0, -- Minimum police online to access the shop

            ["Blip"] = {
                Enable = true, -- If you want to use a blip, set this to true
                Text = "Lombard", -- Blip text
                Sprite = 605, -- Blip icon, https://docs.fivem.net/docs/game-references/blips/
                Color = 0 -- Blip color, https://docs.fivem.net/docs/game-references/blips/#blip-colors
            },

            ["Items"] = {
                ['gold'] = { -- The "spawn" name of the item
                    Label = "Sztabka złota", -- The name that will show on the menu
                    Price = 250, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = true, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pendrive", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
                ['gold_pearl'] = { -- The "spawn" name of the item
                    Label = "Złota perła", -- The name that will show on the menu
                    Price = 100, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pendrive", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
                ['pink_pearl'] = { -- The "spawn" name of the item
                    Label = "Różwa perła", -- The name that will show on the menu
                    Price = 100, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pawnshopcoin", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
                ['white_pearl'] = { -- The "spawn" name of the item
                    Label = "Biała perła", -- The name that will show on the menu
                    Price = 100, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pawnshopcoin", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
                ['diamond'] = { -- The "spawn" name of the item
                    Label = 'Diament', -- The name that will show on the menu
                    Price = 300, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pawnshopcoin", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
                ['watch1'] = { -- The "spawn" name of the item
                    Label = 'Zegarek', -- The name that will show on the menu
                    Price = 200, -- The price that the item will be sold for

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can delete this table if you don't want to use it
                        Enable = true, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "pendrive", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },
                },
            },

            ["BulkSale"] = {  -- you can also delete this table if you don't want to use it
                Enable = false, -- Enable or disable bulk sale
                BulkAmount = 10, -- Amount of items that people need to sell
                ExtraCash = 10, -- (%) Percentage of extra cash gained from selling in bulk
            },
        },
        ['suspiciousbuyer'] = {
            -- Menu/Target Options
            ["MenuTitle"] = 'Tajemniczy kupujący', -- Menu Title. title on the sell menu
            ["TargetIcon"] = 'fas fa-mask', -- Target Icon, you can use any icon from fontawesome
            ["TargetText"] = 'Sprzedaj', -- Target/TextUI Text
            ["TargetSize"] = 1.0, -- Target Size
            ["TargetDistance"] = 1.5, -- Target Size
            ["OnlyShowItemsInInventory"] = true, -- true = Show only the items that the player has in his inventory, false show all items on this shop
            ["Coords"] = { -- Coords of the ped or target (Will spawn in one random location from the coords below)
                vec4(1915.52, 3735.22, 31.64, 206.85)
            },

            ["Ped"] = {
                Enable = true, -- If you want to use a ped, set this to true, otherwise set it to false and it will use only target/drawtext
                Model = 'a_m_m_og_boss_01', -- You can use any ped model
                ["IdleAnimation"] = { -- Idle Animation, you can use a scenario or an animation
                    AnimationType = "scenario", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (https://forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'amb@world_human_hang_out_street@female_arms_crossed@idle_a', -- Animation dict
                        anim = 'idle_a' -- Animation name
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                },
                ["SuccessfulAnimation"] = { -- Player Successful Animation, you can use a scenario or an animation
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'mp_common', -- Animation dict
                        anim = 'givetake1_b' -- Animation name
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                    Duration = 2, -- Duration of the animation in seconds
                    AdvancedAnimation = true, -- An advanced animation done by us, done by using an animation for both the dealer and seller, with a prop (Setting this to true, will cancel the ["SuccessfulAnimation"] above) (This animation cannot be edited)
                },
            },

            ["TimeFrame"] = {
                Enable = true, -- If you want to use a time frame, set this to true, otherwise set it to false and it will be open 24/7
                Time = {open = 23, close = 6}, -- Time frame when the shop is open, if the shop is closed the player will get a notification when interacting.
            },

            ["PoliceCount"] = 0, -- Minimum police online to access the shop

            ["Blip"] = {
                Enable = false, -- If you want to use a blip, set this to true
                Text = "Suspicious Buyer", -- Blip text
                Sprite = 465, -- Blip icon, https://docs.fivem.net/docs/game-references/blips/
                Color = 1, -- Blip color, https://docs.fivem.net/docs/game-references/blips/#blip-colors
            },

            ["Items"] = {
                ['gold'] = { -- The "spawn" name of the item
                    Label = "Sztabka złota", -- The name that will show on the menu
                    Price = 400, -- The price that the item will be sold for
                    DispatchChance = 60, -- The % chance than the police will get a dispatch when the player sells this item
                    -- image = 'x_painting.png', -- The image that will show on the menu, if the item's image name is the same as the item's name there is no need to add it

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given
                    ["DirtyMoney"] = {
                        Enable = false, -- If you want to use dirty money, set this to true, otherwise set it to false and it will use cash
                        Item = "black_money", -- The item that will be used as dirty money, if you have MoneyType = "cash" then this will be ignored
                        MetaData = false, -- if true, the price will be used as metadata, for blackmoney (shown as info when hovering over the item in the inventory)
                    },

                    ["ItemReward"] = { -- you can also delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "water_bottle", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },

                    ["Volume"] = { -- you can also delete this table if you don't want to use it
                        Enable = false,
                        AmountUntilDropInPrice = 10, -- Amount of items that players need to sell to drop the price
                        DropInPrice = 10, -- (%) Price that will be dropped
                    },

                    ["Exp"] = 10, -- Amount of XP to give. Set to false to give XP equal to amount sold, or remove this line to give no XP.
                },
                ['diamond'] = { -- The "spawn" name of the item
                    Label = "Diament", -- The name that will show on the menu
                    Price = 500, -- The price that the item will be sold for
                    DispatchChance = 90, -- The % chance than the police will get a dispatch when the player sells this item
                    -- image = 'x_painting.png', -- The image that will show on the menu, if the item's image name is the same as the item's name there is no need to add it

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["ItemReward"] = { -- you can also delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "rarecoin", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },

                    ["Volume"] = { -- you can also delete this table if you don't want to use it
                        Enable = false,
                        AmountUntilDropInPrice = 10, -- Amount of items that players need to sell to drop the price
                        DropInPrice = 10, -- (%) Price that will be dropped
                    },

                    ["Exp"] = 10, -- Amount of XP to give. Set to false to give XP equal to amount sold, or remove this line to give no XP.
                },
                ['watch1'] = {
                    Label = 'Zegarek', -- The name that will show on the menu
                    Price = 350,
                    DispatchChance = 90, -- The % chance than the police will get a dispatch when the player sells this item

                    ["DisableMoney"] = false, -- If you set this to true, only the item specified in ["ItemReward"] will be given

                    ["DirtyMoney"] = { -- you can also delete this table if you don't want to use it
                        Enable = false, -- If you want to use dirty money, set this to true, otherwise set it to false and it will use cash
                        Item = "black_money", -- The item that will be used as dirty money, if you have MoneyType = "cash" then this will be ignored
                        MetaData = false, -- if true, the price will be used as metadata, for blackmoney (shown as info when hovering over the item in the inventory)
                    },

                    ["ItemReward"] = { -- you can also delete this table if you don't want to use it
                        Enable = false, -- If you want to give the player an item as a reward, set this to true, otherwise set it to false and it will only give money
                        Item = "criminalcoin", -- The item that will be given to the player.
                        Amount = 1, -- Amount of the item to give. Set to false to give the amount sold instead.
                    },

                    ["Volume"] = { -- you can also delete this table if you don't want to use it
                        Enable = false,
                        AmountUntilDropInPrice = 10, -- Amount of items that players need to sell to drop the price
                        DropInPrice = 10, -- (%) Price that will be dropped
                    },

                    ["Exp"] = 10, -- Amount of XP to give. Set to false to give XP equal to amount sold, or remove this line to give no XP.
                },
            },
            ["BulkSale"] = { -- you can also delete this table if you don't want to use it
                Enable = false,
                BulkAmount = 10, -- Amount of items that people need to sell
                ExtraCash = 10, -- (%) Percentage of extra cash gained from selling in bulk
            },
        },
        ['jeweler'] = {
            -- Menu/Target Options
            ["MenuTitle"] = 'Tajemniczy kupujący',
            ["TargetIcon"] = 'fas fa-ring',
            ["TargetText"] = 'Sprzedaj biżuterie',
            ["TargetSize"] = 1.5,
            ["TargetDistance"] = 2.5,
            ["OnlyShowItemsInInventory"] = false, 

            ["Coords"] = vector4(-729.34, 188.56, 80.96, 163.37),

            ["Ped"] = {
                Enable = true,
                Model = {'a_f_y_business_01', `a_f_y_business_04`},
                ["IdleAnimation"] = {
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (https://forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
                        anim = "idle_a"
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                },
                ["SuccessfulAnimation"] = { -- Player Successful Animation, you can use a scenario or an animation
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'mp_common',
                        anim = 'givetake1_b'
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                    Duration = 2,
                    AdvancedAnimation = false,
                },
                ["PedSuccessfulAnimation"] = { -- Ped/Npc Successful Animation, you can use a scenario or an animation
                    AnimationType = "animation", -- "animation" or "scenario" or "none"

                    Animation = { -- Animation, you can use a scenario or an animation (forge.plebmasters.de/animations?ped=A_F_Y_Beach_01)
                        dict = 'mp_common',
                        anim = 'givetake1_b'
                    },
                    Scenario = 'WORLD_HUMAN_CLIPBOARD', -- Use this if you want a scenario instead of an animation (https://github.com/DioneB/gtav-scenarios)
                },
            },

            ["TimeFrame"] = {
                Enable = false, -- If you want to use a time frame, set this to true, otherwise set it to false and it will be open 24/7
                Time = {open = 23, close = 6}, -- Time frame when the shop is open, if the shop is closed the player will get a notification when interacting.
            },

            ["PoliceCount"] = 0, -- Minimum police online to access the shop


            ["Blip"] = {
                Enable = false,
                Text = "Jeweler",
                Sprite = 233, -- Blip icon, https://docs.fivem.net/docs/game-references/blips/
                Color = 1, -- Blip color, https://docs.fivem.net/docs/game-references/blips/#blip-colors
            },

            ["Items"] = {
                ['diamond_earring'] = {
                    Label = "Diamond Earrings",
                    Price = 600,
			DispatchChance = 60,
                },
                ['diamond_necklace'] = {
                    Label = "Diamond Necklace",
                    Price = 600,
			DispatchChance = 60,
                },
                ['diamond_ring'] = {
                    Label = "Diamond Ring",
                    Price = 600,
			DispatchChance = 60,
                },
                ['emerald_earring'] = {
                    Label = "Emerald Earrings",
                    Price = 600,
			DispatchChance = 60,
                },
                ['emerald_necklace'] = {
                    Label = "Emerald Necklace",
                    Price = 600,
			DispatchChance = 60,
                },
                ['emerald_ring'] = {
                    Label = "Emerald Ring",
                    Price = 600,
			DispatchChance = 60,
                },
                ['ruby_earring'] = {
                    Label = "Ruby Earrings",
                    Price = 600,
			DispatchChance = 60,
                },
                ['ruby_necklace'] = {
                    Label = "Ruby Necklace",
                    Price = 600,
			DispatchChance = 60,
                },
                ['ruby_ring'] = {
                    Label = "Ruby Ring",
                    Price = 600,
			DispatchChance = 60,
                },
                ['sapphire_earring'] = {
                    Label = "Sapphire Earrings",
                    Price = 600,
			DispatchChance = 60,
                },
                ['sapphire_necklace'] = {
                    Label = "Sapphire Necklace",
                    Price = 600,
			DispatchChance = 60,
                },
                ['sapphire_ring'] = {
                    Label = "Sapphire Ring",
                    Price = 600,
			DispatchChance = 60,
                },
                ['giant_gem'] = {
                    Label = "Gigantyczny Rubin",
                    Price = 8000,
			DispatchChance = 80,
                },
                ['box_of_jewelry'] = {
                    Label = "Skrzynka blyskotek",
                    Price = 3500,
			DispatchChance = 80,
                },
                ['diamond'] = {
                    Label = "Diament",
                    Price = 400,
			DispatchChance = 60,
                },


            },

            ["BulkSale"] = {
                Enable = false,
                BulkAmount = 10, -- Amount of items that people need to sell 
                ExtraCash = 10, -- (%) Percentage of extra cash gained from selling in bulk
            },
        }
    }
}