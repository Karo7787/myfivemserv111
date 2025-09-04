return {
    -- ██████  ███████  █████  ██   ██     ███████  ██████ ██████  ██ ██████  ████████ ███████ 
    -- ██   ██ ██      ██   ██ ██  ██      ██      ██      ██   ██ ██ ██   ██    ██    ██      
    -- ██████  █████   ███████ █████       ███████ ██      ██████  ██ ██████     ██    ███████ 
    -- ██      ██      ██   ██ ██  ██           ██ ██      ██   ██ ██ ██         ██         ██ 
    -- ██      ███████ ██   ██ ██   ██     ███████  ██████ ██   ██ ██ ██         ██    ███████ 

    -- This is the main config file for ipl type houses.

    iplConfig = {
        [1] = { -- Ipl tier
            item = {
                required = true,
                name = 'lockpick',
                amount = 1,
                removeOnFail = {
                    enabled = true,
                    chance = 40 -- 40% chance to lose lockpick on failed attempt
                }
            },
            notifyPoliceOnFail = {
                enabled = true,
                failCount = 2 -- Notify police after 3 failed attempts
            },
            xpAmount = {
                breakIn = { min = 10, max = 15 },
                search = { min = 5, max = 10 }
            },
            alarm = {
                enabled = true, -- Enable alarm and sound bar UI
                instant = {
                    enabled = true, -- Enable alarm instantntly after entering the house (Not recommended, sound bar UI will be disabled)
                    chance = 100,
                },
                sound = true, -- Play alarm sound using native audio
            },
            police = {
                required = true,
                amount = 2
            },
            owner = {
                spawn = true,
                chance = 50,
                sleepChance = 40,
                models = { `a_m_m_tramp_01`, `a_m_m_trampbeac_01`, `a_f_m_tramp_01`, `a_m_o_genstreet_01`, `a_f_o_genstreet_01`, `a_m_m_salton_01`, `a_m_m_salton_02`, `a_m_m_salton_03`, `a_m_m_salton_04`, `a_f_m_salton_01`, `g_m_m_armgoon_01`, `g_m_y_armgoon_02`, `g_m_y_mexgoon_01`, `g_m_m_mexboss_01`, `g_m_y_mexgang_01`, `g_m_y_mexgang_02`, `a_m_o_salton_01`, `a_f_m_skidrow_01`, `a_m_m_skidrow_01`, `a_m_o_tramp_01` },
            },
            pet = {
                spawn = true,
                chance = 50,
                sleepChance = 70,
                models = { `a_c_westy`, `a_c_rottweiler`, `a_c_pug` },
            },
            vehicle = {
                spawn = true,
                chance = 50,
                models = { `blista`, `panto`, `prairie`, `asea`, `emperor`, `regina`, `stalion`, `intruder`, `romero`, `surge`, `dilettante`, `sabre`, `issi2`, `rhapsody`, `futo` }
            }
        },
        [2] = { -- Ipl tier
            item = {
                required = true,
                name = 'lockpick',
                amount = 1,
                removeOnFail = {
                    enabled = true,
                    chance = 30 -- 30% chance to lose lockpick on failed attempt
                }
            },
            notifyPoliceOnFail = {
                enabled = true,
                failCount = 2 -- Notify police after 2 failed attempts
            },
            xpAmount = {
                breakIn = { min = 15, max = 20 },
                search = { min = 10, max = 15 }
            },
            alarm = {
                enabled = true, -- Enable alarm and sound bar UI
                instant = {
                    enabled = true, -- Enable alarm instantntly after entering the house (Not recommended, sound bar UI will be disabled)
                    chance = 100,
                },
                sound = true, -- Play alarm sound using native audio
            },
            police = {
                required = true,
                amount = 3
            },
            owner = {
                spawn = true,
                chance = 50,
                sleepChance = 40,
                models = { `a_m_y_beach_01`, `a_f_y_bevhills_01`, `a_m_y_bevhills_01`, `a_f_y_bevhills_02`, `a_m_y_business_01`, `a_f_y_business_01`, `a_m_y_business_02`, `a_f_y_business_02`, `a_m_m_business_01`, `a_f_m_business_02`, `a_m_y_stlat_01`, `a_m_y_stwhi_01`, `a_f_y_tourist_01`, `a_f_y_tourist_02`, `a_m_y_genstreet_01`, `a_f_y_genhot_01`, `a_f_y_soucent_01`, `a_m_m_hillbilly_01`, `a_f_m_hillbilly_02`, `a_m_m_fatlatin_01` },
            },
            pet = {
                spawn = true,
                chance = 50,
                sleepChance = 70,
                models = { `a_c_westy`, `a_c_rottweiler`, `a_c_pug`, `a_c_retriever` },
            },
            vehicle = {
                spawn = true,
                chance = 50,
                models = { `buffalo`, `dominator`, `sultan`, `fugitive`, `granger`, `jackal`, `bison`, `oracle`, `tailgater`, `zion`, `schafter2`, `penumbra`, `brawler`, `comet2`, `coquette`, `kuruma` },
            }
        },
        [3] = { -- Ipl tier
            item = {
                required = true,
                name = 'lockpick',
                amount = 1,
                removeOnFail = {
                    enabled = true, 
                    chance = 20 -- 20% chance to lose lockpick on failed attempt
                }
            },
            notifyPoliceOnFail = {
                enabled = true,
                failCount = 1 -- Notify police after 1 failed attempt
            },
            xpAmount = {
                breakIn = { min = 25, max = 30 },
                search = { min = 15, max = 20 }
            },
            alarm = {
                enabled = true, -- Enable alarm and sound bar UI
                instant = {
                    enabled = true, -- Enable alarm instantntly after entering the house (Not recommended, sound bar UI will be disabled)
                    chance = 100,
                },
                sound = true, -- Play alarm sound using native audio
            },
            police = {
                required = true,
                amount = 4
            },
            owner = {
                spawn = true,
                chance = 50,
                sleepChance = 30,
                models = { `a_f_y_business_03`, `a_m_y_business_03`, `a_f_y_bevhills_03`, `a_m_y_bevhills_02`, `a_f_y_bevhills_04`, `a_m_y_business_04`, `u_m_m_aldinapoli`, `u_m_m_bankman`, `u_m_m_bikehire_01`, `u_m_m_filmdirector`, `u_f_y_comjane`, `u_f_y_corpse_01`, `u_m_y_cyclist_01`, `u_f_y_hotposh_01`, `u_m_m_jewelsec_01`, `u_m_m_jewelthief`, `u_m_m_markfost`, `u_f_m_miranda`, `u_m_m_promourn_01`, `u_m_m_streetart_01` },
            },
            pet = {
                spawn = true,
                chance = 70,
                sleepChance = 70,
                models = { `a_c_westy`, `a_c_rottweiler`, `a_c_pug`, `a_c_retriever`, `a_c_shepherd`, `a_c_poodle` },
            },
            vehicle = {
                spawn = true,
                chance = 50,
                models = { `adder`, `zentorno`, `t20`, `cognoscenti`, `osiris`, `cheetah`, `entityxf`, `pfister811`, `nero`, `reaper`, `italigtb`, `tempesta`, `turismor`, `xa21`, `vagner`, `pariah`, `visione` },
            }
        }
    },
    
    ipls = {
        integrityWay = {
            tier = 1,
            level = 10,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(-38.10, -576.28, 89.18, 249.87), 
                    vec4(-36.71, -577.14, 84.65, 344.92), 
                    vec4(-40.08, -577.97, 89.18, 338.45) 
                },
                pet = { 
                    vec4(-39.80, -573.30, 88.73, 246.70), 
                    vec4(-25.28, -590.61, 90.12, 321.08), 
                    vec4(-36.38, -576.12, 84.63, 238.64) 
                },
                vehicle = { 
                    vec4(-19.87, -635.01, 35.7242, 249.01),
                    vec4(-21.27, -638.73, 35.72, 249.63)
                },
                house = vec4(-13.9, -583.66, 90.11, 68.19),
                door = vec4(-15.9, -612.43, 35.86, 65.38),
            },
            furniture = {
                { type = 'cabin', coords = vec4(-46.18, -587.18, 88.36, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-36.72, -577.16, 88.44, 00.00), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(-34.77, -585.61, 88.51, 00.00), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(-37.86, -577.98, 83.30, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-39.08, -585.29, 83.61, 00.00), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(-32.88, -575.73, 88.13, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(-45.02, -587.66, 88.66, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_mixer', model = 'v_res_tre_mixer', coords = vec4(-29.74, -587.49, 88.92, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(-30.10, -587.04, 88.72, 00.00), isSearched = false, isBusy = false },
            },
        },
        delPerroHeights = {
            tier = 1,
            level = 7,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(-1463.09, -546.92, 73.7, 45.83), 
                    vec4(-1455.6, -553.64, 72.51, 153.96), 
                    vec4(-1463.97, -545.11, 72.7, 109.77)
                },
                pet = {
                    vec4(-1466.72, -548.08, 73.24, 325.53), 
                    vec4(-1459.03, -531.28, 73.08, 220.95), 
                    vec4(-1469.43, -528.14, 72.44, 217.94)
                },
                vehicle = { 
                    vec4(-1479.47, -513.75, 32.80, 25.18),
                    vec4(-1477.33, -511.74, 32.80, 31.37)
                },
                house = vec4(-1452.87, -537.06, 74.04, 118.79),
                door = vec4(-1477.83, -519.71, 34.74, 213.13),
            },
            furniture = {
                { type = 'cabin', coords = vec4(-1471.82, -535.02, 73.86, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-1467.35, -524.23, 72.92, 00.00), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(-1463.09, -550.03, 73.14, 00.00), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(-1458.08, -550.12, 72.57, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-1454.48, -548.97, 72.57, 00.00), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(-1462.70, -550.44, 73.18, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_vase', model = 'hei_heist_acc_vase_02', coords = vec4(-1461.80, -549.83, 73.19, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(-1473.78, -538.59, 73.393, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_laptop', model = 'prop_laptop_01a', coords = vec4(-1472.55, -526.85, 73.16, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_headphones', model = 'v_res_pcheadset', coords = vec4(-1472.70, -528.29, 73.16, 00.00), isSearched = false, isBusy = false },

            },
        },
        delPerroHeights2 = {
            tier = 1,
            level = 25,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(-1473.45, -533.08, 55.99, 296.93), 
                    vec4(-1472.08, -532.61, 51.46, 18.65), 
                    vec4(-1462.19, -532.07, 50.72, 228.56) 
                },
                pet = { 
                    vec4(-1475.01, -532.41, 55.54, 221.4), 
                    vec4(-1466.52, -537.02, 50.73, 318.51), 
                    vec4(-1466.89, -536.43, 50.73, 28.96) 
                },
                vehicle = { 
                    vec4(-1467.26, -505.1, 31.81, 30.06),
                    vec4(-1469.33, -507.09, 32.80, 33.12) 
                },
                house = vec4(-1453.93, -517.64, 56.93, 124.79),
                door = vec4(-1459.49, -506.22, 32.08, 209.6),
            },
            furniture = {
                { type = 'cabin', coords = vec4(-1458.21, -537.61, 55.34, 318.18), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-1469.42, -545.99, 54.82, 288.42), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(-1459.81, -533.76, 54.53, 333.51), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(-1471.76, -532.12, 54.53, 126.17), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-1469.74, -534.03, 50.72, 210.84), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(-1471.12, -528.64, 54.95, 00.00), isSearched = false, isBusy = false  },
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(-1468.35, -545.37, 55.48, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_mixer', model = 'v_res_tre_mixer', coords = vec4(-1459.68, -532.81, 55.73, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(-30.10, -587.04, 88.72, 00.00), isSearched = false, isBusy = false },
            },
        },
        wildOatsDrive3655 = {
            tier = 3,
            level = 14,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(-165.06, 480.65, 137.72, 186.01),
                    vec4(-163.25, 483.92, 134.56, 193.65), 
                    vec4(-170.12, 497.68, 130.52, 123.69) 
                },
                pet = { 
                    vec4(-168.73, 481.72, 133.88, 7.46), 
                    vec4(-165.2, 483.67, 137.27, 43.93), 
                    vec4(-170.3, 495.41, 137.65, 86.84) 
                },
                vehicle = { 
                    vec4(-188.02, 501.8, 133.97, 89.8),
                    vec4(-191.12, 500.12, 134.54, 22.72)
                },
                house = vec4(-174.39, 497.91, 137.65, 198.38),
                door = vec4(-173.4, 502.83, 137.42, 275.8),
            },
            furniture = {
                { type = 'cabin', coords = vec4(-171.01, 482.51, 136.95, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-166.63, 493.67, 137.47, 00.00), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(-170.84, 481.56, 133.58, 00.00), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(-175.81, 489.72, 129.57, 00.00), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(-165.79, 495.92, 133.45, 00.00), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(-166.36, 482.27, 136.71, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(-171.42, 483.11, 137.27, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_mixer', model = 'v_res_tre_mixer', coords = vec4(-165.42, 497.92, 137.81, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(-168.09, 497.37, 137.61, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_toaster', model = 'prop_toaster_01', coords = vec4(-166.13, 497.91, 137.74, 00.00), isSearched = false, isBusy = false },
            },
        },
        northConkerAvenue2044 = {
            tier = 3,
            level = 65,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(332.0, 425.81, 148.99, 14.7),
                    vec4(332.12, 427.88, 145.57, 211.73),
                    vec4(343.56, 438.04, 141.77, 125.77) 
                },
                pet = { 
                    vec4(330.15, 427.19, 148.99, 309.59), 
                    vec4(330.91, 426.44, 145.57, 78.65), 
                    vec4(341.93, 436.87, 141.77, 55.32) 
                },
                vehicle = { 
                    vec4(352.88, 436.81, 146.03, 297.56),
                    vec4(353.77, 434.71, 147.08, 306.86) 
                },
                house = vec4(342.2, 437.96, 149.38, 114.33),
                door = vec4(346.15, 440.39, 148.08, 115.05),
            },
            furniture = {
                { type = 'cabin', coords = vec4(327.89, 429.93, 145.57, 29.03), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(342.95, 430.65, 149.38, 279.48), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(345.32, 437.11, 141.77, 335.59), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(334.08, 436.51, 141.77, 22.09), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(342.37, 429.05, 145.58, 295.39), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(329.28, 426.03, 148.44, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(328.74, 431.13, 148.99, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_mixer', model = 'v_res_tre_mixer', coords = vec4(344.62, 429.31, 149.54, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(343.37, 431.74, 149.33, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_toaster', model = 'prop_toaster_01', coords = vec4(344.41, 429.99, 149.47, 00.00), isSearched = false, isBusy = false },
            },
        },
        legionSquare = {
            tier = 1,
            level = 25,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(259.11, -995.7, -99.01, 175.04),
                    vec4(261.16, -996.53, -98.57, 102.13),
                    vec4(262.63, -1003.78, -98.27, 88.31)
                },
                pet = { 
                    vec4(259.47, -1003.9, -99.01, 314.56),
                    vec4(261.72, -994.87, -99.01, 187.34),
                    vec4(254.33, -1001.13, -98.93, 280.99) 
                },
                vehicle = { 
                    vec4(323.16, -1002.95, 28.3, 0.11), 
                    vec4(317.8481, -1003.1359, 29.3046, 91.4069)
                },
                house = vec4(266.16, -1007.57, -101.01, 11.03),
                door = vec4(307.67, -1005.6, 29.51, 189.49),
            },
            furniture = {
                { type = 'cabin', coords = vec4(266.24, -999.41, -98.88, 89.63), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(264.1, -994.86, -97.25, 180.81), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(259.8, -1004.4, -99.09, 354.84), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(261.31, -1002.05, -99.29, 174.74), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(255.7, -999.83, -98.63, 180.69), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_tv', model = 'prop_tv_03', coords = vec4(256.73, -995.44, -98.86, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(258.92, -996.42, -99.56, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_toaster', model = 'prop_toaster_01', coords = vec4(266.66, -995.32, -99.03, 00.00), isSearched = false, isBusy = false },
            },
        },
        northConkerAvenue2045 = {
            tier = 3,
            level = 50,
            isRobbed = false,
            coords = {
                owner = { 
                    vec4(374.34, 407.12, 145.53, 336.72), 
                    vec4(374.54, 424.48, 142.1, 169.35), 
                    vec4(372.5, 405.74, 142.11, 216.12)
                },
                pet = { 
                    vec4(372.81, 407.23, 145.53, 59.63), 
                    vec4(371.56, 409.51, 142.1, 214.7), 
                    vec4(377.59, 422.42, 141.01, 270.96) 
                },
                vehicle = { 
                    vec4(369.28, 434.26, 143.57, 264.51),
                    vec4(372.06, 432.84, 144.46, 314.93)
                },
                house = vec4(373.63, 423.74, 145.91, 221.63),
                door = vec4(374.29, 427.45, 145.68, 237.6),
            },
            furniture = {
                { type = 'cabin', coords = vec4(369.38, 408.3, 145.5, 73.22), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(369.17, 407.92, 142.1, 117.82), isSearched = false, isBusy = false },
                { type = 'kitchen', coords = vec4(377.79, 417.39, 145.9, 209.77), isSearched = false, isBusy = false },
                { type = 'chest', coords = vec4(377.27, 407.49, 142.13, 240.72), isSearched = false, isBusy = false },
                { type = 'cabin', coords = vec4(373.57, 425.73, 142.1, 20.03), isSearched = false, isBusy = false },
            },
            propItems = {
                { reward = 'peak_bong', model = 'prop_bong_01', coords = vec4(373.00, 406.14, 144.97, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_pcspeaker', model = 'prop_mp3_dock', coords = vec4(368.78, 409.06, 145.52, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_mixer', model = 'v_res_tre_mixer', coords = vec4(380.47, 419.93, 146.07, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_scales', model = 'v_res_m_kscales', coords = vec4(377.82, 420.56, 145.86, 00.00), isSearched = false, isBusy = false },
                { reward = 'peak_toaster', model = 'prop_toaster_01', coords = vec4(379.82, 420.22, 146.00, 00.00), isSearched = false, isBusy = false },
            },
        },
    }    
}