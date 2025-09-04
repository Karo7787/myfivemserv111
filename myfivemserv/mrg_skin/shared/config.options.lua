
Config.Options = {
    ["ped"] = {
        name = TRANSLATIONS[Config.Language]['ped'],
        type = "select",
        options = function()
            local peds = {}
            if (ShopSkin["model"] == 'mp_m_freemode_01' or ShopSkin["model"] == 'mp_f_freemode_01') then
                local isMan = ShopSkin["model"] == 'mp_m_freemode_01' and true or false
                peds = {
                    {
                        SOI_opt_name = 'mp_m_freemode_01',
                        SOI_tattoo_has = isMan
                    },
                    {
                        SOI_opt_name = 'mp_f_freemode_01',
                        SOI_tattoo_has = not isMan
                    }
                }
            else
                peds = {
                    {
                        SOI_opt_name = ShopSkin["model"],
                        SOI_tattoo_has = true,
                    },
                    {
                        SOI_opt_name = 'mp_m_freemode_01',
                        SOI_tattoo_has = ShopSkin["model"] == 'mp_m_freemode_01'
                    },
                    {
                        SOI_opt_name = 'mp_f_freemode_01',
                        SOI_tattoo_has = ShopSkin["model"] == 'mp_f_freemode_01'
                    }
                }
            end
            return peds
        end
    },
    ["face"] = {
        name = TRANSLATIONS[Config.Language]['face'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['face_father'],
                current = function()
                    return ShopSkin["head"]["blend"]["shapeFirst"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["shapeFirst"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['face_mother'],
                current = function()
                    return ShopSkin["head"]["blend"]["shapeSecond"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["shapeSecond"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['face_mix'],
                current = function()
                    return ShopSkin["head"]["blend"]["shapeMix"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["shapeMix"] = data.value / 10
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
        }
    },
    ["skin"] = {
        name = TRANSLATIONS[Config.Language]['skin'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['skin_father'],
                current = function()
                    return ShopSkin["head"]["blend"]["skinFirst"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["skinFirst"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['skin_mother'],
                current = function()
                    return ShopSkin["head"]["blend"]["skinSecond"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["skinSecond"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['skin_mix'],
                current = function()
                    return ShopSkin["head"]["blend"]["skinMix"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["skinMix"] = data.value / 10
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
        }
    },
    ["race"] = {
        name = TRANSLATIONS[Config.Language]['race'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['race_shape'],
                current = function()
                    return ShopSkin["head"]["blend"]["shapeThird"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["shapeThird"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['race_skin'],
                current = function()
                    return ShopSkin["head"]["blend"]["skinThird"]
                end,
                max = function()
                    return 46
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["skinThird"] = data.value
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['race_mix'],
                current = function()
                    return ShopSkin["head"]["blend"]["thirdMix"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["blend"]["thirdMix"] = data.value / 10
                    setPlayerHeadBlend(ShopSkin["head"]["blend"], true)
                end
            },
        }
    },
    ["nose"] = {
        name = TRANSLATIONS[Config.Language]['nose'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['nose_width'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["width"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["width"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['nose_height'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["peakHigh"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["peakHigh"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['nose_size'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["peakSize"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["peakSize"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['nose_bone_height'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["boneHigh"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["boneHigh"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['nose_peak_height'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["peakLowering"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["peakLowering"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['nose_bone_twist'],
                current = function()
                    return ShopSkin["head"]["features"]["nose"]["boneTwist"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["nose"]["boneTwist"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["skin_eyebrows"] = {
        name = TRANSLATIONS[Config.Language]['eyebrows'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_height'],
                current = function()
                    return ShopSkin["head"]["features"]["eyes"]["eyeBrownHigh"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["eyes"]["eyeBrownHigh"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_depth'],
                current = function()
                    return ShopSkin["head"]["features"]["eyes"]["eyeBrownForward"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["eyes"]["eyeBrownForward"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["cheeks"] = {
        name = TRANSLATIONS[Config.Language]['cheeks'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['cheeks_bone_height'],
                current = function()
                    return ShopSkin["head"]["features"]["cheeks"]["boneHigh"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["cheeks"]["boneHigh"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['cheeks_bone_width'],
                current = function()
                    return ShopSkin["head"]["features"]["cheeks"]["boneWidth"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["cheeks"]["boneWidth"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['cheeks_width'],
                current = function()
                    return ShopSkin["head"]["features"]["cheeks"]["width"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["cheeks"]["width"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["jaw"] = {
        name = TRANSLATIONS[Config.Language]['jaw'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['jaw_width'],
                current = function()
                    return ShopSkin["head"]["features"]["jaw"]["boneWidth"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["jaw"]["boneWidth"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['jaw_size'],
                current = function()
                    return ShopSkin["head"]["features"]["jaw"]["boneBackSize"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["jaw"]["boneBackSize"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["skin_chin"] = {
        name = TRANSLATIONS[Config.Language]['chin'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['chin_height'],
                current = function()
                    return ShopSkin["head"]["features"]["chin"]["boneLowering"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["chin"]["boneLowering"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_lenght'],
                current = function()
                    return ShopSkin["head"]["features"]["chin"]["boneLenght"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["chin"]["boneLenght"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_size'],
                current = function()
                    return ShopSkin["head"]["features"]["chin"]["boneSize"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["chin"]["boneSize"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_hole'],
                current = function()
                    return ShopSkin["head"]["features"]["chin"]["hole"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["chin"]["hole"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["blemishes"] = {
        name = TRANSLATIONS[Config.Language]['blemishes'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['blemishes_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blemishes"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blemishes"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['blemishes_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blemishes"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(0) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blemishes"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["wrinkles"] = {
        name = TRANSLATIONS[Config.Language]['wrinkles'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['wrinkles_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["ageing"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["ageing"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['wrinkles_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["ageing"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(3) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["ageing"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["complexion"] = {
        name = TRANSLATIONS[Config.Language]['complexion'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['complexion_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["complexion"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["complexion"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['complexion_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["complexion"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(6) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["complexion"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["burns"] = {
        name = TRANSLATIONS[Config.Language]['burns'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['burns_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["sunDamage"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["sunDamage"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['burns_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["sunDamage"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(7) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["sunDamage"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["freckles"] = {
        name = TRANSLATIONS[Config.Language]['freckles'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['freckles_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["moleAndFreckles"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["moleAndFreckles"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['freckles_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["moleAndFreckles"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(9) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["moleAndFreckles"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["look_accessories"] = {
        name = TRANSLATIONS[Config.Language]['look_accessories'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['look_accessories_eyes_opening'],
                current = function()
                    return ShopSkin["head"]["features"]["eyes"]["opening"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["eyes"]["opening"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['look_accessories_lip_thickness'],
                current = function()
                    return ShopSkin["head"]["features"]["lips"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["lips"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['look_accessories_neck_thickness'],
                current = function()
                    return ShopSkin["head"]["features"]["neck"] * 20
                end,
                max = function()
                    return 21
                end,
                min = function()
                    return -20
                end,
                change = function(data)
                    ShopSkin["head"]["features"]["neck"] = data.value / 20
                    setPlayerFaceFeatures(ShopSkin["head"]["features"], true)
                end
            },
        }
    },
    ["hair"] = {
        name = TRANSLATIONS[Config.Language]['hair'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['hair_style'],
                current = function()
                    return ShopSkin["head"]["hair"]["style"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 2)
                end,
                change = function(data)
                    ShopSkin["head"]["hair"]["style"] = data.value
                    setPlayerHair(ShopSkin["head"]["hair"], true)
                end
            },   
            {
                name = TRANSLATIONS[Config.Language]['hair_variant'],
                current = function()
                    return ShopSkin["head"]["hair"]["texture"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 2, ShopSkin["head"]["hair"]["style"])
                end,
                change = function(data)
                    ShopSkin["head"]["hair"]["texture"] = data.value
                    setPlayerHair(ShopSkin["head"]["hair"], true)
                end
            },   
            {
                name = TRANSLATIONS[Config.Language]['hair_color'],
                current = function()
                    return ShopSkin["head"]["hair"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["hair"]["color"] = data.value
                    setPlayerHair(ShopSkin["head"]["hair"], true)
                end
            },   
            {
                name = TRANSLATIONS[Config.Language]['hair_second_color'],
                current = function()
                    return ShopSkin["head"]["hair"]["highlight"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["hair"]["highlight"] = data.value
                    setPlayerHair(ShopSkin["head"]["hair"], true)
                end
            },   
            {
                name = TRANSLATIONS[Config.Language]['hair_fade'],
                current = function()
                    return ShopSkin["head"]["hair"]["fade"]
                end,
                max = function()
                    return #Decorations[ShopSkin["model"] == "mp_m_freemode_01" and 1 or 2]
                end,
                change = function(data)
                    ShopSkin["head"]["hair"]["fade"] = data.value
                    setPlayerHair(ShopSkin["head"]["hair"], true)
                end
            },
        }
    },
    ["eyebrows"] = {
        name = TRANSLATIONS[Config.Language]['eyebrows'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["eyebrows"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["eyebrows"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["eyebrows"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(2) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["eyebrows"]["style"] = data.value 
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["eyebrows"]["color"]
                end,
                max = function()
                    return 64
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["eyebrows"]["color"] = data.value 
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['eyebrows_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["eyebrows"]["secondColor"]
                end,
                max = function()
                    return 64
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["eyebrows"]["secondColor"] = data.value 
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["eye_color"] = {
        name = TRANSLATIONS[Config.Language]['eye_color'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['eye_color_style'],
                current = function()
                    return ShopSkin["head"]["eyeColor"]
                end,
                max = function()
                    return 31
                end,
                change = function(data)
                    ShopSkin["head"]["eyeColor"] = data.value 
                    setPlayerEyeColor(ShopSkin["head"]["eyeColor"], true)
                end
            },
        }
    },
    ["chin"] = {
        name = TRANSLATIONS[Config.Language]['chin'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['chin_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["beard"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["beard"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["beard"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(1) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["beard"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["beard"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["beard"]["color"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['chin_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["beard"]["secondColor"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["beard"]["secondColor"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["body_hair"] = {
        name = TRANSLATIONS[Config.Language]['body_hair'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['body_hair_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["chestHair"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["chestHair"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['body_hair_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["chestHair"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(10) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["chestHair"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['body_hair_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["chestHair"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["chestHair"]["color"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['body_hair_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["chestHair"]["secondColor"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["chestHair"]["secondColor"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["body_blemishes"] = {
        name = TRANSLATIONS[Config.Language]['body_blemishes'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['body_blemishes_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["bodyBlemishes"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["bodyBlemishes"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['body_blemishes_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["bodyBlemishes"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(11) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["bodyBlemishes"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["general_makeup"] = {
        name = TRANSLATIONS[Config.Language]['general_makeup'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['general_makeup_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["makeUp"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["makeUp"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['general_makeup_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["makeUp"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(4) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["makeUp"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['general_makeup_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["makeUp"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["makeUp"]["color"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['general_makeup_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["makeUp"]["secondColor"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["makeUp"]["secondColor"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["blushes"] = {
        name = TRANSLATIONS[Config.Language]['blush'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['blush_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blush"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blush"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['blush_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blush"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(8) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blush"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['blush_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blush"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blush"]["color"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['blush_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["blush"]["secondColor"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["blush"]["secondColor"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["lipstick"] = {
        name = TRANSLATIONS[Config.Language]['lipstick'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['lipstick_density'],
                current = function()
                    return ShopSkin["head"]["overlays"]["lipstick"]["opacity"] * 10
                end,
                max = function()
                    return 21
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["lipstick"]["opacity"] = data.value / 10
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['lipstick_style'],
                current = function()
                    return ShopSkin["head"]["overlays"]["lipstick"]["style"]
                end,
                max = function()
                    return GetPedHeadOverlayNum(8) - 1
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["lipstick"]["style"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['lipstick_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["lipstick"]["color"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["lipstick"]["color"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['lipstick_second_color'],
                current = function()
                    return ShopSkin["head"]["overlays"]["lipstick"]["secondColor"]
                end,
                max = function()
                    return 63
                end,
                change = function(data)
                    ShopSkin["head"]["overlays"]["lipstick"]["secondColor"] = data.value
                    setPlayerHeadOverlays(ShopSkin["head"]["overlays"], true)
                end
            },
        }
    },
    ["gloves"] = {
        name = TRANSLATIONS[Config.Language]['gloves'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["3"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 3)
                end,
                change = function(data)
                    ShopSkin["components"]["3"]["drawable"] = data.value
                    ShopSkin["components"]["3"]["variation"] = 0
                    setPlayerComponent(3, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["3"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 3, ShopSkin["components"]["3"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["3"]["variation"] = data.value
                    setPlayerComponent(3, "variation", data.value, true)
                end
            },
        }
    },
    ["tshirt"] = {
        name = TRANSLATIONS[Config.Language]['tshirt'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["8"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 8)
                end,
                change = function(data)
                    ShopSkin["components"]["8"]["drawable"] = data.value
                    ShopSkin["components"]["8"]["variation"] = 0
                    setPlayerComponent(8, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["8"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 8, ShopSkin["components"]["8"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["8"]["variation"] = data.value
                    setPlayerComponent(8, "variation", data.value, true)
                end
            },
        }
    },
    ["vest"] = {
        name = TRANSLATIONS[Config.Language]['vest'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["9"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 9)
                end,
                change = function(data)
                    ShopSkin["components"]["9"]["drawable"] = data.value
                    ShopSkin["components"]["9"]["variation"] = 0
                    setPlayerComponent(9, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["9"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 9, ShopSkin["components"]["9"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["9"]["variation"] = data.value
                    setPlayerComponent(9, "variation", data.value, true)
                end
            },
        }
    },
    ["torso"] = {
        name = TRANSLATIONS[Config.Language]['torso'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["11"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 11)
                end,
                change = function(data)
                    ShopSkin["components"]["11"]["drawable"] = data.value
                    ShopSkin["components"]["11"]["variation"] = 0
                    setPlayerComponent(11, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["11"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 11, ShopSkin["components"]["11"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["11"]["variation"] = data.value
                    setPlayerComponent(11, "variation", data.value, true)
                end
            },
        }
    },
    ["pants"] = {
        name = TRANSLATIONS[Config.Language]['pants'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["4"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 4)
                end,
                change = function(data)
                    ShopSkin["components"]["4"]["drawable"] = data.value
                    ShopSkin["components"]["4"]["variation"] = 0
                    setPlayerComponent(4, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["4"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 4, ShopSkin["components"]["4"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["4"]["variation"] = data.value
                    setPlayerComponent(4, "variation", data.value, true)
                end
            },
        }
    },
    ["shoes"] = {
        name = TRANSLATIONS[Config.Language]['shoes'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["6"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 6)
                end,
                change = function(data)
                    ShopSkin["components"]["6"]["drawable"] = data.value
                    ShopSkin["components"]["6"]["variation"] = 0
                    setPlayerComponent(6, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["6"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 6, ShopSkin["components"]["6"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["6"]["variation"] = data.value
                    setPlayerComponent(6, "variation", data.value, true)
                end
            },
        }
    },
    ["bag"] = {
        name = TRANSLATIONS[Config.Language]['bag'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["5"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 5)
                end,
                change = function(data)
                    ShopSkin["components"]["5"]["drawable"] = data.value
                    ShopSkin["components"]["5"]["variation"] = 0
                    setPlayerComponent(5, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["5"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 5, ShopSkin["components"]["5"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["5"]["variation"] = data.value
                    setPlayerComponent(5, "variation", data.value, true)
                end
            },
        }
    },
    ["hat"] = {
        name = TRANSLATIONS[Config.Language]['hat'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["props"]["0"]["drawable"]
                end,
                min = function()
                    return -1
                end,
                max = function()
                    return GetNumberOfPedPropDrawableVariations(playerPed, 0) - 1
                end,
                change = function(data)
                    ShopSkin["props"]["0"]["drawable"] = data.value
                    ShopSkin["props"]["0"]["variation"] = 0
                    setPlayerProp(0, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["props"]["0"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedPropTextureVariations(playerPed, 0, ShopSkin["props"]["0"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["props"]["0"]["variation"] = data.value
                    setPlayerProp(0, "variation", data.value, true)
                end
            },
        }
    },
    ["glasses"] = {
        name = TRANSLATIONS[Config.Language]['glasses'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["props"]["1"]["drawable"]
                end,
                min = function()
                    return -1
                end,
                max = function()
                    return GetNumberOfPedPropDrawableVariations(playerPed, 1) - 1
                end,
                change = function(data)
                    ShopSkin["props"]["1"]["drawable"] = data.value
                    ShopSkin["props"]["1"]["variation"] = 0
                    setPlayerProp(1, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["props"]["1"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedPropTextureVariations(playerPed, 1, ShopSkin["props"]["1"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["props"]["1"]["variation"] = data.value
                    setPlayerProp(1, "variation", data.value, true)
                end
            },
        }
    },
    ["mask"] = {
        name = TRANSLATIONS[Config.Language]['mask'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["1"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 1)
                end,
                change = function(data)
                    ShopSkin["components"]["1"]["drawable"] = data.value
                    ShopSkin["components"]["1"]["variation"] = 0
                    setPlayerComponent(1, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["1"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 1, ShopSkin["components"]["1"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["1"]["variation"] = data.value
                    setPlayerComponent(1, "variation", data.value, true)
                end
            },
        }
    },
    ["chain"] = {
        name = TRANSLATIONS[Config.Language]['chain'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["7"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 7)
                end,
                change = function(data)
                    ShopSkin["components"]["7"]["drawable"] = data.value
                    ShopSkin["components"]["7"]["variation"] = 0
                    setPlayerComponent(7, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["7"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 7, ShopSkin["components"]["7"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["7"]["variation"] = data.value
                    setPlayerComponent(7, "variation", data.value, true)
                end
            },
        }
    },
    ["accessories"] = {
        name = TRANSLATIONS[Config.Language]['accessories'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["components"]["10"]["drawable"]
                end,
                max = function()
                    return GetNumberOfPedDrawableVariations(playerPed, 10)
                end,
                change = function(data)
                    ShopSkin["components"]["10"]["drawable"] = data.value
                    ShopSkin["components"]["10"]["variation"] = 0
                    setPlayerComponent(10, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["components"]["10"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedTextureVariations(playerPed, 10, ShopSkin["components"]["10"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["components"]["10"]["variation"] = data.value
                    setPlayerComponent(10, "variation", data.value, true)
                end
            },
        }
    },
    ["on_the_ears"] = {
        name = TRANSLATIONS[Config.Language]['on_the_ears'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["props"]["2"]["drawable"]
                end,
                min = function()
                    return -1
                end,
                max = function()
                    return GetNumberOfPedPropDrawableVariations(playerPed, 2) - 1
                end,
                change = function(data)
                    ShopSkin["props"]["2"]["drawable"] = data.value
                    ShopSkin["props"]["2"]["variation"] = 0
                    setPlayerProp(2, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["props"]["2"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedPropTextureVariations(playerPed, 2, ShopSkin["props"]["2"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["props"]["2"]["variation"] = data.value
                    setPlayerProp(2, "variation", data.value, true)
                end
            },
        }
    },
    ["watch"] = {
        name = TRANSLATIONS[Config.Language]['watch'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["props"]["6"]["drawable"]
                end,
                min = function()
                    return -1
                end,
                max = function()
                    return GetNumberOfPedPropDrawableVariations(playerPed, 6) - 1
                end,
                change = function(data)
                    ShopSkin["props"]["6"]["drawable"] = data.value
                    ShopSkin["props"]["6"]["variation"] = 0
                    setPlayerProp(6, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["props"]["6"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedPropTextureVariations(playerPed, 6, ShopSkin["props"]["6"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["props"]["6"]["variation"] = data.value
                    setPlayerProp(6, "variation", data.value, true)
                end
            },
        }
    },
    ["bracelet"] = {
        name = TRANSLATIONS[Config.Language]['bracelet'],
        options = {
            {
                name = TRANSLATIONS[Config.Language]['drawable'],
                current = function()
                    return ShopSkin["props"]["7"]["drawable"]
                end,
                min = function()
                    return -1
                end,
                max = function()
                    return GetNumberOfPedPropDrawableVariations(playerPed, 7) - 1
                end,
                change = function(data)
                    ShopSkin["props"]["7"]["drawable"] = data.value
                    ShopSkin["props"]["7"]["variation"] = 0
                    setPlayerProp(7, "drawable", data.value, true)
                end
            },
            {
                name = TRANSLATIONS[Config.Language]['variation'],
                current = function()
                    return ShopSkin["props"]["7"]["variation"]
                end,
                max = function()
                    return GetNumberOfPedPropTextureVariations(playerPed, 7, ShopSkin["props"]["7"]["drawable"])
                end,
                change = function(data)
                    ShopSkin["props"]["7"]["variation"] = data.value
                    setPlayerProp(7, "variation", data.value, true)
                end
            },
        }
    },
}