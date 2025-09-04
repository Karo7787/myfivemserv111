PlayerSkin = {}
playerPed = PlayerPedId()
lib.onCache("ped", function(value) playerPed = value end)
Decorations = {
	{
		{`mpbeach_overlays`,`FM_Hair_Fuzz`},
		{`multiplayer_overlays`,`FM_M_Hair_001_a`},
		{`multiplayer_overlays`,`FM_M_Hair_001_b`},
		{`multiplayer_overlays`,`FM_M_Hair_001_c`},
		{`multiplayer_overlays`,`FM_M_Hair_001_d`},
		{`multiplayer_overlays`,`FM_M_Hair_001_e`},
		{`multiplayer_overlays`,`FM_M_Hair_003_a`},
		{`multiplayer_overlays`,`FM_M_Hair_003_b`},
		{`multiplayer_overlays`,`FM_M_Hair_003_c`},
		{`multiplayer_overlays`,`FM_M_Hair_003_d`},
		{`multiplayer_overlays`,`FM_M_Hair_003_e`},
		{`multiplayer_overlays`,`FM_M_Hair_006_a`},
		{`multiplayer_overlays`,`FM_M_Hair_006_b`},
		{`multiplayer_overlays`,`FM_M_Hair_006_c`},
		{`multiplayer_overlays`,`FM_M_Hair_006_d`},
		{`multiplayer_overlays`,`FM_M_Hair_006_e`},
		{`multiplayer_overlays`,`FM_M_Hair_008_a`},
		{`multiplayer_overlays`,`FM_M_Hair_008_b`},
		{`multiplayer_overlays`,`FM_M_Hair_008_c`},
		{`multiplayer_overlays`,`FM_M_Hair_008_d`},
		{`multiplayer_overlays`,`FM_M_Hair_008_e`},
		{`multiplayer_overlays`,`FM_M_Hair_long_a`},
		{`multiplayer_overlays`,`FM_M_Hair_long_b`},
		{`multiplayer_overlays`,`FM_M_Hair_long_c`},
		{`multiplayer_overlays`,`FM_M_Hair_long_d`},
		{`multiplayer_overlays`,`FM_M_Hair_long_e`},
		{`multiplayer_overlays`,`NG_M_Hair_001`},
		{`multiplayer_overlays`,`NG_M_Hair_002`},
		{`multiplayer_overlays`,`NG_M_Hair_003`},
		{`multiplayer_overlays`,`NG_M_Hair_004`},
		{`multiplayer_overlays`,`NG_M_Hair_005`},
		{`multiplayer_overlays`,`NG_M_Hair_006`},
		{`multiplayer_overlays`,`NG_M_Hair_007`},
		{`multiplayer_overlays`,`NG_M_Hair_008`},
		{`multiplayer_overlays`,`NG_M_Hair_009`},
		{`multiplayer_overlays`,`NG_M_Hair_010`},
		{`multiplayer_overlays`,`NG_M_Hair_011`},
		{`multiplayer_overlays`,`NG_M_Hair_012`},
		{`multiplayer_overlays`,`NG_M_Hair_013`},
		{`multiplayer_overlays`,`NG_M_Hair_014`},
		{`multiplayer_overlays`,`NG_M_Hair_015`},
		{`multiplayer_overlays`,`NGBea_M_Hair_000`},
		{`multiplayer_overlays`,`NGBea_M_Hair_001`},
		{`multiplayer_overlays`,`NGBus_M_Hair_000`},
		{`multiplayer_overlays`,`NGBus_M_Hair_001`},
		{`multiplayer_overlays`,`NGHip_M_Hair_000`},
		{`multiplayer_overlays`,`NGHip_M_Hair_001`},
		{`multiplayer_overlays`,`NGInd_M_Hair_000`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_000_a`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_000_b`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_000_c`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_000_d`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_000_e`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_001_a`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_001_b`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_001_c`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_001_d`},
		{`mphipster_overlays`,`FM_Hip_M_Hair_001_e`},
		{`mphipster_overlays`,`FM_Disc_M_Hair_001_a`},
		{`mphipster_overlays`,`FM_Disc_M_Hair_001_b`},
		{`mphipster_overlays`,`FM_Disc_M_Hair_001_c`},
		{`mphipster_overlays`,`FM_Disc_M_Hair_001_d`},
		{`mphipster_overlays`,`FM_Disc_M_Hair_001_e`},
		{`mpbiker_overlays`,`MP_Biker_Hair_000_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_001_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_002_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_003_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_004_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_005_M`},
		{`mpbiker_overlays`,`MP_Biker_Hair_006_M`},
		{`mpgunrunning_overlays`,`MP_Gunrunning_Hair_M_000_M`},
		{`mpgunrunning_overlays`,`MP_Gunrunning_Hair_M_001_M`},
		{`mplowrider_overlays`,`LR_M_Hair_000`},
		{`mplowrider_overlays`,`LR_M_Hair_001`},
		{`mplowrider_overlays`,`LR_M_Hair_002`},
		{`mplowrider_overlays`,`LR_M_Hair_003`},
		{`mplowrider2_overlays`,`LR_M_Hair_004`},
		{`mplowrider2_overlays`,`LR_M_Hair_005`},
		{`mplowrider2_overlays`,`LR_M_Hair_006`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_000_a`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_000_b`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_000_c`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_000_d`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_000_e`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_001_a`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_001_b`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_001_c`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_001_d`},
		{`mpbusiness_overlays`,`FM_Bus_M_Hair_001_e`}
	},
	{
		{`mpbeach_overlays`,`FM_Hair_Fuzz`},
		{`multiplayer_overlays`,`FM_F_Hair_003_a`},
		{`multiplayer_overlays`,`FM_F_Hair_003_b`},
		{`multiplayer_overlays`,`FM_F_Hair_003_c`},
		{`multiplayer_overlays`,`FM_F_Hair_003_d`},
		{`multiplayer_overlays`,`FM_F_Hair_003_e`},
		{`multiplayer_overlays`,`FM_F_Hair_005_a`},
		{`multiplayer_overlays`,`FM_F_Hair_005_b`},
		{`multiplayer_overlays`,`FM_F_Hair_005_c`},
		{`multiplayer_overlays`,`FM_F_Hair_005_d`},
		{`multiplayer_overlays`,`FM_F_Hair_005_e`},
		{`multiplayer_overlays`,`FM_F_Hair_006_a`},
		{`multiplayer_overlays`,`FM_F_Hair_006_b`},
		{`multiplayer_overlays`,`FM_F_Hair_006_c`},
		{`multiplayer_overlays`,`FM_F_Hair_006_d`},
		{`multiplayer_overlays`,`FM_F_Hair_006_e`},
		{`multiplayer_overlays`,`FM_F_Hair_013_a`},
		{`multiplayer_overlays`,`FM_F_Hair_013_b`},
		{`multiplayer_overlays`,`FM_F_Hair_013_c`},
		{`multiplayer_overlays`,`FM_F_Hair_013_d`},
		{`multiplayer_overlays`,`FM_F_Hair_013_e`},
		{`multiplayer_overlays`,`FM_F_Hair_014_a`},
		{`multiplayer_overlays`,`FM_F_Hair_014_b`},
		{`multiplayer_overlays`,`FM_F_Hair_014_c`},
		{`multiplayer_overlays`,`FM_F_Hair_014_d`},
		{`multiplayer_overlays`,`FM_F_Hair_014_e`},
		{`multiplayer_overlays`,`FM_F_Hair_long_a`},
		{`multiplayer_overlays`,`FM_F_Hair_long_b`},
		{`multiplayer_overlays`,`FM_F_Hair_long_c`},
		{`multiplayer_overlays`,`FM_F_Hair_long_d`},
		{`multiplayer_overlays`,`FM_F_Hair_long_e`},
		{`multiplayer_overlays`,`NG_F_Hair_001`},
		{`multiplayer_overlays`,`NG_F_Hair_002`},
		{`multiplayer_overlays`,`NG_F_Hair_003`},
		{`multiplayer_overlays`,`NG_F_Hair_004`},
		{`multiplayer_overlays`,`NG_F_Hair_005`},
		{`multiplayer_overlays`,`NG_F_Hair_006`},
		{`multiplayer_overlays`,`NG_F_Hair_007`},
		{`multiplayer_overlays`,`NG_F_Hair_008`},
		{`multiplayer_overlays`,`NG_F_Hair_009`},
		{`multiplayer_overlays`,`NG_F_Hair_010`},
		{`multiplayer_overlays`,`NG_F_Hair_011`},
		{`multiplayer_overlays`,`NG_F_Hair_012`},
		{`multiplayer_overlays`,`NG_F_Hair_013`},
		{`multiplayer_overlays`,`NG_F_Hair_014`},
		{`multiplayer_overlays`,`NG_F_Hair_015`},
		{`multiplayer_overlays`,`NGBea_F_Hair_000`},
		{`multiplayer_overlays`,`NGBea_F_Hair_001`},
		{`multiplayer_overlays`,`NGBus_F_Hair_000`},
		{`multiplayer_overlays`,`NGBus_F_Hair_001`},
		{`multiplayer_overlays`,`NGHip_F_Hair_000`},
		{`multiplayer_overlays`,`NGHip_F_Hair_001`},
		{`multiplayer_overlays`,`NGInd_F_Hair_000`},
		{`mphipster_overlays`,`FM_Hip_F_Hair_000_a`},
		{`mphipster_overlays`,`FM_Hip_F_Hair_000_b`},
		{`mphipster_overlays`,`FM_Hip_F_Hair_000_c`},
		{`mphipster_overlays`,`FM_Hip_F_Hair_000_d`},
		{`mphipster_overlays`,`FM_Hip_F_Hair_000_e`},
		{`mphipster_overlays`,`FM_F_Hair_017_a`},
		{`mphipster_overlays`,`FM_F_Hair_017_b`},
		{`mphipster_overlays`,`FM_F_Hair_017_c`},
		{`mphipster_overlays`,`FM_F_Hair_017_d`},
		{`mphipster_overlays`,`FM_F_Hair_017_e`},
		{`mphipster_overlays`,`FM_F_Hair_020_a`},
		{`mphipster_overlays`,`FM_F_Hair_020_b`},
		{`mphipster_overlays`,`FM_F_Hair_020_c`},
		{`mphipster_overlays`,`FM_F_Hair_020_d`},
		{`mphipster_overlays`,`FM_F_Hair_020_e`}
	}
}

local MinimalHeadOverLays = {
    "blemishes",
    "beard",
    "eyebrows",
    "ageing",
    "makeUp",
    "blush",
    "complexion",
    "sunDamage",
    "lipstick",
    "moleAndFreckles",
    "chestHair",
    "bodyBlemishes",
}

local MinimalHeadFeatures = {
    {
        name = "nose",
        ids = {
            "width",
            "peakSize",
            "peakHigh",
            "peakLowering",
            "boneTwist",
            "boneHigh"
        }
    },
    {
        name = "eyes",
        ids = {
            "opening",
            "eyeBrownHigh",
            "eyeBrownForward"
        }
    },
    {
        name = "chin",
        ids = {
            "boneLenght",
            "boneSize",
            "hole",
            "boneLowering"
        }
    },
    {
        name = "cheeks",
        ids = {
            "boneHigh",
            "boneWidth",
            "width"
        }
    },
    {
        name = "neck"
    },
    {
        name = "lips"
    },
    {
        name = "jaw",
        ids = {
            "boneBackSize",
            "boneWidth"
        }
    }
}
local FaceFeaturesMap = {
    [0]  = "nose.width",
    [1]  = "nose.peakHigh",
    [2]  = "nose.peakSize",
    [3]  = "nose.boneHigh",
    [4]  = "nose.peakLowering",
    [5]  = "nose.boneTwist",
    [6]  = "eyes.eyeBrownHigh",
    [7]  = "eyes.eyeBrownForward",
    [8]  = "cheeks.boneHigh",
    [9]  = "cheeks.boneWidth",
    [10] = "cheeks.width",
    [11] = "eyes.opening",
    [12] = "lips",
    [13] = "jaw.boneWidth",
    [14] = "jaw.boneBackSize",
    [15] = "chin.boneLenght",
    [16] = "chin.boneSize",
    [17] = "chin.hole",
    [18] = "chin.boneLowering",
    [19] = "neck"
}

function MinimalToSkin(minimal)
    local skin = {
        ["model"] = "",
        ["components"] = {},
        ["props"] = {},
        ["head"] = {
            ["overlays"] = {},
            ["features"] = {},
            ["blend"] = {},
            ["eyeColor"] = 0
        }
    }
    skin["model"] = minimal[1]
    for componentId, component in pairs(minimal[2].components) do
        if component and componentId ~= 3 then
            skin["components"][""..componentId-1] = {
                drawable = component[1],
                variation = component[2]
            }
        end
    end
    for propId, prop in pairs(minimal[2].props) do
        skin["props"][""..propId-1] = {
            drawable = prop[1],
            variation = prop[2]
        }
    end
    skin["head"]["hair"] = { 
        style = minimal[3].hair[1],
        color = minimal[3].hair[2],
        highlight = minimal[3].hair[3],
        texture = minimal[3].hair[4],
        fade = minimal[3].hair[5]
    }
    for overlayId, overlay in pairs(minimal[3].overlays) do
        skin["head"]["overlays"][MinimalHeadOverLays[overlayId]] = { 
            style = overlay[1],
            color = overlay[2],
            secondColor = overlay[3],
            opacity = overlay[4]
        }
    end
    for _, featureGroup in ipairs(MinimalHeadFeatures) do
        local key = featureGroup.name
        local source = minimal[3].features[key]
    
        if type(source) == "table" and featureGroup.ids then
            skin["head"]["features"][key] = {}
            for i, id in ipairs(featureGroup.ids) do
                skin["head"]["features"][key][id] = source[i] or 0.0
            end
        elseif type(source) == "number" then
            skin["head"]["features"][key] = source
        end
    end
    skin["head"]["blend"] = {
        shapeFirst = minimal[3].blend[1][1],
        shapeSecond = minimal[3].blend[1][2],
        shapeThird = minimal[3].blend[1][3],
        shapeMix = minimal[3].blend[1][4],
    
        skinFirst = minimal[3].blend[2][1],
        skinSecond = minimal[3].blend[2][2],
        skinThird = minimal[3].blend[2][3],
        skinMix = minimal[3].blend[2][4],
    
        thirdMix = minimal[3].blend[3]
    }
    skin["head"]["eyeColor"] = minimal[3].eyeColor
    return skin
end

function SkinToMinimal(skin)
    local minimal = {
        skin["model"],
        {
            components = {},
            props = {}
        },
        {
            hair = {},
            overlays = {},
            features = {},
            blend = {},
            eyeColor = 0
        }
    }
    for componentId = 0, 11 do
        if componentId == 2 then
            minimal[2].components[componentId + 1] = nil
        else
            local component = skin["components"][tostring(componentId)]
            if component and component.drawable and component.variation then
                minimal[2].components[componentId + 1] = {
                    component.drawable,
                    component.variation
                }
            else
                minimal[2].components[componentId + 1] = nil
            end
        end
    end

    for propId = 0, 7 do
        local prop = skin["props"][tostring(propId)]
        if prop and prop.drawable and prop.variation then
            minimal[2].props[propId + 1] = {
                prop.drawable,
                prop.variation
            }
        else
            minimal[2].props[propId + 1] = nil
        end
    end

    minimal[3].hair = {
        skin["head"]["hair"].style,
        skin["head"]["hair"].color,
        skin["head"]["hair"].highlight,
        skin["head"]["hair"].texture,
        skin["head"]["hair"].fade
    }

    minimal[3].overlays = {}
    for overlayName, overlay in pairs(skin["head"]["overlays"]) do
        local overlayId = nil
        for id, name in pairs(MinimalHeadOverLays) do
            if name == overlayName then
                overlayId = id
                break
            end
        end
        if overlayId then
            minimal[3].overlays[overlayId] = {
                overlay.style,
                overlay.color,
                overlay.secondColor,
                overlay.opacity
            }
        end
    end

    minimal[3].features = {}
    for _, featureGroup in ipairs(MinimalHeadFeatures) do
        local key = featureGroup.name
        local data = skin["head"]["features"][key]

        if featureGroup.ids then
            minimal[3].features[key] = {}
            for i, id in ipairs(featureGroup.ids) do
                minimal[3].features[key][i] = data and data[id] or 0.0
            end
        else
            minimal[3].features[key] = data or 0.0
        end
    end

    local blend = skin["head"]["blend"]
    minimal[3].blend = {
        {
            blend.shapeFirst,
            blend.shapeSecond,
            blend.shapeThird,
            blend.shapeMix
        },
        {
            blend.skinFirst,
            blend.skinSecond,
            blend.skinThird,
            blend.skinMix
        },
        blend.thirdMix
    }

    minimal[3].eyeColor = skin["head"]["eyeColor"]

    return minimal
end

function ConvertSkin(skin, type)
    if type == "qf_skin" then
        local minimal = {
            skin.model or "mp_m_freemode_01",
            {
                components = {},
                props = {}
            },
            {
                hair = {
                    skin.hair.style or 0,
                    skin.hair.color or 0,
                    skin.hair.highlight or 0,
                    skin.hair.fade or 0,
                    skin.hair.texture or 0
                },
                overlays = {},
                eyeColor = skin.eyeColor or 0,
                blend = {
                    {
                        skin.headBlend.shapeFirst or 0,
                        skin.headBlend.shapeSecond or 0,
                        skin.headBlend.shapeThird or 0,
                        skin.headBlend.shapeMix or 0.0
                    },
                    {
                        skin.headBlend.skinFirst or 0,
                        skin.headBlend.skinSecond or 0,
                        skin.headBlend.skinThird or 0,
                        skin.headBlend.skinMix or 0.0
                    },
                    skin.headBlend.thirdMix or 0.0
                },
                features = {}
            }
        }
    
        -- Mapuj componenty
        for _, comp in pairs(skin.components or {}) do
            minimal[2].components[comp.component_id + 1] = { comp.drawable, comp.texture }
        end
    
        -- Mapuj prop'y
        local propsMap = {}
        for _, prop in pairs(skin.props or {}) do
            propsMap[prop.prop_id] = { prop.drawable, prop.texture }
        end

        local ALL_PROP_IDS = {0,1,2,6,7}
    
        for _, id in ipairs(ALL_PROP_IDS) do
            local key = tostring(id)
            if propsMap[id] then
                minimal[2].props[key+1] = propsMap[id]
            else
                minimal[2].props[key+1] = nil
            end
        end
    
        -- Mapuj overlaye
    
        for _, name in ipairs(MinimalHeadOverLays) do
            local o = skin.headOverlays and skin.headOverlays[name] or { style = 0, color = 0, secondColor = 0, opacity = 0.0 }
            table.insert(minimal[3].overlays, {
                o.style or 0,
                o.color or 0,
                o.secondColor or 0,
                o.opacity or 0.0
            })
        end
    
        -- Mapuj features
        local faceFeatures = skin.faceFeatures or {}
        minimal[3].features = {
            nose = {
                faceFeatures.noseWidth or 0.0,
                faceFeatures.nosePeakSize or 0.0,
                faceFeatures.nosePeakHigh or 0.0,
                faceFeatures.nosePeakLowering or 0.0,
                faceFeatures.noseBoneTwist or 0.0,
                faceFeatures.noseBoneHigh or 0.0
            },
            eyes = {
                faceFeatures.eyesOpening or 0.0,
                faceFeatures.eyeBrownHigh or 0.0,
                faceFeatures.eyeBrownForward or 0.0
            },
            chin = {
                faceFeatures.chinBoneLenght or faceFeatures.chinBoneLength or 0.0,
                faceFeatures.chinBoneSize or 0.0,
                faceFeatures.chinHole or 0.0,
                faceFeatures.chinBoneLowering or 0.0
            },
            cheeks = {
                faceFeatures.cheeksBoneHigh or 0.0,
                faceFeatures.cheeksBoneWidth or 0.0,
                faceFeatures.cheeksWidth or 0.0
            },
            neck = faceFeatures.neckThickness or 0.0,
            lips = faceFeatures.lipsThickness or 0.0,
            jaw = {
                faceFeatures.jawBoneBackSize or 0.0,
                faceFeatures.jawBoneWidth or 0.0
            }
        }
        return minimal     
    end
end
function GetPlayerGender()
    ESX.PlayerData = ESX.GetPlayerData()

    if ESX.PlayerData.sex == "f" then
        return "Female"
    end

    return "Male"
end

function GetGender(isNew)
    if isNew then
        return GetPlayerGender()
    end

    local model = GetPedModel(cache.ped)

    if model == "mp_f_freemode_01" then
        return "Female"
    end

    return "Male"
end
function LoadSkin()
    local skin = lib.callback.await('mrg_skin:skin:get')
    if(skin) then
        if skin.components and skin.props then
            skin = ConvertSkin(skin, "qf_skin")
        elseif skin.hair_1 and skin.bags_1 and skin.sex then
            print("Skinchanger skins is not supported")
        end
        PlayerSkin = MinimalToSkin(skin)
        ApplySkinToPed()
    else
        startCharacter(GetGender(true))
    end
end

function ApplySkinToPed(skinData, targetPed, changemodel)
    local ped = targetPed or PlayerPedId()
    local skin = skinData
    local changemodel = changemodel or true
    if not skinData then
        skin = PlayerSkin
    end

    if GetHashKey(skin.model) and GetHashKey(skin.model) ~= GetEntityModel(ped) and changemodel then
        SetModel(skin.model)
        ped = PlayerPedId()
    end
    if skin.components then
        for compIdStr, compData in pairs(skin.components) do
            local compId = tonumber(compIdStr)
            if compId and compData then
                SetPedComponentVariation(ped, compId, compData.drawable or 0, compData.variation or 0, 2)
            end
        end
    end
    if skin.props then
        for propIdStr, propData in pairs(skin.props) do
            local propId = tonumber(propIdStr)
            if propId then
                ClearPedProp(ped, propId)
                if propData and propData.drawable and propData.drawable ~= -1 then
                    SetPedPropIndex(ped, propId, propData.drawable, propData.variation or 0, 2)
                end
            end
        end
    end
    if skin.head and skin.head.blend then
        local blend = skin.head.blend
        SetPedHeadBlendData(ped,
            blend.shapeFirst or 0,
            blend.shapeSecond or 0,
            blend.shapeThird or 0,
            blend.skinFirst or 0,
            blend.skinSecond or 0,
            blend.skinThird or 0,
            (blend.shapeMix or 0) + 0.0,
            (blend.skinMix or 0) + 0.0,
            (blend.thirdMix or 0) + 0.0,
        false)
    end
    if skin.head and skin.head.overlays then
        for k, v in pairs(MinimalHeadOverLays) do
            local overlayData = skin.head.overlays[v]
            if overlayData then
                local colorType = 1
                if v == "blush" or v == "lipstick" or v == "makeUp" then
                    colorType = 2
                end
                SetPedHeadOverlay(ped, k-1, overlayData.style or 0, (overlayData.opacity or 0) + 0.0)
                SetPedHeadOverlayColor(ped, k-1, colorType or 0,
                    tonumber(overlayData.color) or 0,
                    tonumber(overlayData.secondColor) or tonumber(overlayData.color) or 0)
            end
        end
    end
    if skin.head and skin.head.features then
        for featureId, path in pairs(FaceFeaturesMap) do
            local parts = {}
            for part in string.gmatch(path, "[^%.]+") do
                table.insert(parts, part)
            end
            local value = skin.head.features
            for _, key in ipairs(parts) do
                if value == nil then break end
                value = value[key]
            end
            if value ~= nil then
                SetPedFaceFeature(ped, featureId, value + 0.0)
            end
        end
    end
    if skin.head and skin.head.hair then
        local hair = skin.head.hair
        SetPedComponentVariation(ped, 2, hair.style, hair.texture, 0)
        SetPedHairColor(ped, hair.color or 0, hair.highlight or 0)
    end
    if skin.head and skin.head.eyeColor then
        SetPedEyeColor(ped, skin.head.eyeColor)
    end
    Wait(100)
    TriggerEvent("rcore_tattoos:applyOwnedTattoos")
end

function SetModel(model)
    if(IsModelInCdimage(GetHashKey(model)) and IsModelValid(GetHashKey(model))) then
        local health = GetEntityHealth(playerPed)
        local modelHash = GetHashKey(model)
        ESX.Streaming.RequestModel(modelHash)
        SetPlayerModel(PlayerId(), modelHash)
        Citizen.Wait(0)
        playerPed = PlayerPedId()
        if(model == 'mp_m_freemode_01' or model == 'mp_f_freemode_01') then
            SetFreemodeDefault()
        else
            SetPedRandomComponentVariation(playerPed, 0)
        end 
        SetEntityHealth(playerPed, health)
    else
        print(string.format("Attempted to change to invalid model: %s", model))
    end
end

function SetFreemodeDefault()
    SetPedHeadBlendData(playerPed, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
    SetPedComponentVariation(playerPed, 11, 0, 11, 0)
    SetPedComponentVariation(playerPed, 8, 0, 1, 0)
    SetPedComponentVariation(playerPed, 6, 1, 2, 0)
    SetPedHeadOverlayColor(playerPed, 1, 1, 0, 0)
    SetPedHeadOverlayColor(playerPed, 2, 1, 0, 0)
    SetPedHeadOverlayColor(playerPed, 4, 2, 0, 0)
    SetPedHeadOverlayColor(playerPed, 5, 2, 0, 0)
    SetPedHeadOverlayColor(playerPed, 8, 2, 0, 0)
    SetPedHeadOverlayColor(playerPed, 10, 1, 0, 0)
    SetPedHeadOverlay(playerPed, 1, 0, 0.0)
    SetPedHairColor(playerPed, 1, 1)
end

function GetSkin()
    return PlayerSkin
end

function GetTempSkin()
    return getPedAppearance(playerPed)
end

function setPlayerComponent(ComponentId, Type, Value, temp)
    local ped = PlayerPedId()
    if not temp then
        -- print("COMPONENT",ComponentId, Type, Value, temp)
        if Type == "drawable" then
            PlayerSkin["components"][""..ComponentId]["variation"] = 0
        end
        PlayerSkin["components"][""..ComponentId][Type] = Value
        SetPedComponentVariation(ped, ComponentId, PlayerSkin["components"][""..ComponentId]["drawable"], PlayerSkin["components"][""..ComponentId]["variation"], 2)
    else
        if Type == "drawable" then
            SetPedComponentVariation(ped, ComponentId, Value, 0, 2)
        else
            SetPedComponentVariation(ped, ComponentId, GetPedDrawableVariation(ped, ComponentId), Value, 2)
        end
    end
end

function setPlayerProp(PropId, Type, Value, temp)
    local ped = PlayerPedId()
    if not temp then
        -- print("PROP",PropId, Type, Value, temp)
        if Type == "drawable" then
            PlayerSkin["props"][""..PropId]["variation"] = 0
        end
        PlayerSkin["props"][""..PropId][Type] = Value
        if PlayerSkin["props"][""..PropId]["drawable"] == -1 then
            ClearPedProp(ped, PropId)
        else
            SetPedPropIndex(ped, PropId, PlayerSkin["props"][""..PropId]["drawable"], PlayerSkin["props"][""..PropId]["variation"], false)
        end
    else
        if Type == "drawable" then
            if Value == -1 then
                ClearPedProp(ped, PropId)
            else
                SetPedPropIndex(ped, PropId, Value, 0, false)
            end
        else
            SetPedPropIndex(ped, PropId, GetPedPropIndex(ped, PropId), Value, false)
        end
    end
end

function setPlayerModel(model, temp)
    local ped = PlayerPedId()
    if not temp then
        PlayerSkin["model"] = model
        SetModel(PlayerSkin["model"])
    else
        SetModel(model)
    end
end

function setPlayerHeadBlend(blend, temp)
    local ped = PlayerPedId()
    if not temp then
        PlayerSkin["head"]["blend"] = blend
        SetPedHeadBlendData(ped,
            blend.shapeFirst or 0,
            blend.shapeSecond or 0,
            blend.shapeThird or 0,
            blend.skinFirst or 0,
            blend.skinSecond or 0,
            blend.skinThird or 0,
            (blend.shapeMix or 0) + 0.0,
            (blend.skinMix or 0) + 0.0,
            (blend.thirdMix or 0) + 0.0,
        false)
    else
        SetPedHeadBlendData(ped,
            blend.shapeFirst or 0,
            blend.shapeSecond or 0,
            blend.shapeThird or 0,
            blend.skinFirst or 0,
            blend.skinSecond or 0,
            blend.skinThird or 0,
            (blend.shapeMix or 0) + 0.0,
            (blend.skinMix or 0) + 0.0,
            (blend.thirdMix or 0) + 0.0,
        false)
    end
end

function setPlayerFaceFeatures(faceFeatures, temp)
    local ped = PlayerPedId()
    if not temp then
        PlayerSkin["head"]["features"] = faceFeatures
        for featureId, path in pairs(FaceFeaturesMap) do
            local parts = {}
            for part in string.gmatch(path, "[^%.]+") do
                table.insert(parts, part)
            end
            local value = PlayerSkin["head"]["features"]
            for _, key in ipairs(parts) do
                if value == nil then break end
                value = value[key]
            end
            if value ~= nil then
                SetPedFaceFeature(ped, featureId, value + 0.0)
            end
        end
    else
        for featureId, path in pairs(FaceFeaturesMap) do
            local parts = {}
            for part in string.gmatch(path, "[^%.]+") do
                table.insert(parts, part)
            end
            local value = faceFeatures
            for _, key in ipairs(parts) do
                if value == nil then break end
                value = value[key]
            end
            if value ~= nil then
                SetPedFaceFeature(ped, featureId, value + 0.0)
            end
        end
    end
end

function setPlayerHeadOverlays(headOverlays, temp)
    local ped = PlayerPedId()
    if not temp then
        PlayerSkin["head"]["overlays"] = headOverlays
        for k, v in pairs(MinimalHeadOverLays) do
            local overlayData = skin.head.overlays[v]
            if overlayData then
                local colorType = 1
                if v == "blush" or v == "lipstick" or v == "makeUp" then
                    colorType = 2
                end
                SetPedHeadOverlay(ped, k-1, overlayData.style or 0, (overlayData.opacity or 0) + 0.0)
                SetPedHeadOverlayColor(ped, k-1, colorType or 0,
                    tonumber(overlayData.color) or 0,
                    tonumber(overlayData.secondColor) or tonumber(overlayData.color) or 0)
            end
        end
    else
        for k, v in pairs(MinimalHeadOverLays) do
            local overlayData = headOverlays[v]
            if overlayData then
                local colorType = 1
                if v == "blush" or v == "lipstick" or v == "makeUp" then
                    colorType = 2
                end
                SetPedHeadOverlay(ped, k-1, overlayData.style or 0, (overlayData.opacity or 0) + 0.0)
                SetPedHeadOverlayColor(ped, k-1, colorType or 0,
                    tonumber(overlayData.color) or 0,
                    tonumber(overlayData.secondColor) or tonumber(overlayData.color) or 0)
            end
        end
    end
end

function setPlayerEyeColor(eyeColor, temp)
    local ped = PlayerPedId()
    if not temp then
        PlayerSkin["head"]["eyeColor"] = eyeColor
        if PlayerSkin["head"] and PlayerSkin["head"]["eyeColor"] then
            SetPedEyeColor(ped, PlayerSkin["head"]["eyeColor"])
        end
    else
        SetPedEyeColor(ped, eyeColor)
    end
end
hairDecorDefault = {'mpbeach_overlays', "FM_hair_fuzz"}

function setPlayerHair(hair, temp)
    local ped = PlayerPedId()
    local pedModel = GetEntityModel(ped)
    if not temp then
        PlayerSkin["head"]["hair"] = hair
        SetPedComponentVariation(ped, 2, PlayerSkin["head"]["hair"].style, PlayerSkin["head"]["hair"].texture, 0)
        SetPedHairColor(ped, PlayerSkin["head"]["hair"].color or 0, PlayerSkin["head"]["hair"].highlight or 0)
        ClearPedDecorations(ped)
        TriggerEvent("rcore_tattoos:applyOwnedTattoos")
    else
        ClearPedDecorations(ped)
        SetPedComponentVariation(ped, 2, hair.style, hair.texture, 0)
        SetPedHairColor(ped, hair.color or 0, hair.highlight or 0)
        local decorationType
        if pedModel == `mp_m_freemode_01` then
            decorationType = "male"
        elseif pedModel == `mp_f_freemode_01` then
            decorationType = "female"
        else
            decorationType = IsPedMale(ped) and "male" or "female"
        end
        local decor = Decorations[decorationType == "male" and 1 or 2][hair["fade"]]
        if decor then
            AddPedDecorationFromHashes(ped, decor[1], decor[2])
        else
            AddPedDecorationFromHashes(ped, hairDecorDefault[1], hairDecorDefault[2])
        end
    end
end 

AddEventHandler("rcore_tattoos:applyOwnedTattoos", function()
    if not LocalPlayer.state.InSkin then
        Wait(2500)
    end
    local ped = PlayerPedId()
    local pedModel = GetEntityModel(ped)
    local decorationType
    if pedModel == `mp_m_freemode_01` then
        decorationType = "male"
    elseif pedModel == `mp_f_freemode_01` then
        decorationType = "female"
    else
        decorationType = IsPedMale(ped) and "male" or "female"
    end
    while not PlayerSkin["head"] do
        Wait(1)
    end
    local decor = Decorations[decorationType == "male" and 1 or 2][PlayerSkin["head"]["hair"]["fade"]]
    if decor then
        AddPedDecorationFromHashes(ped, decor[1], decor[2])
    else
        AddPedDecorationFromHashes(ped, hairDecorDefault[1], hairDecorDefault[2])
    end
end)

local Peds = {}

RegisterNetEvent("skinchanger:loadPedSkin")
AddEventHandler("skinchanger:loadPedSkin", function(targetPed, clothes, cb)
    SetPedMaxHealth(targetPed, 200)
    SetPedDefaultComponentVariation(targetPed)
    local skin = clothes
    if skin.components and skin.props and not skin.head then
        skin = ConvertSkin(skin, "qf_skin")
    elseif skin.hair_1 and skin.bags_1 and skin.sex then
        print("Skinchanger skins is not supported")
    end
    if not skin.head then
        skin = MinimalToSkin(skin)
    end
    if not ESX.IsPlayerLoaded() then
        local coords = GetEntityCoords(targetPed)
        local heading = GetEntityHeading(targetPed)
        DeleteEntity(targetPed)
		lib.requestModel(skin.model, 2000)
        local entity = CreatePed(0, skin.model, coords.x, coords.y, coords.z-1, heading, false, true)
		SetModelAsNoLongerNeeded(skin.model)
		FreezeEntityPosition(entity, true)
		SetEntityInvincible(entity, true)
		SetBlockingOfNonTemporaryEvents(entity, true)
        targetPed = entity
        table.insert(Peds, entity)
    end
    ApplySkinToPed(skin, targetPed, false)
    if type(cb) == "table" then
        cb()
    end
end)

RegisterNetEvent("mrg_skin:characters:hidepeds", function()
    for k, v in pairs(Peds) do
        DeleteEntity(v)
    end
end)

RegisterNetEvent("skinchanger:loadSkin2", function(ped, skin)
    if not skin[1] then skin[1] = "mp_m_freemode_01" end
    ApplySkinToPed(MinimalToSkin(skin), ped, false)
end)

RegisterNetEvent("skinchanger:getSkin", function(cb)
    lib.callback("mrg_skin:skin:get", false, function(appearance)
        if appearance then
            cb(MinimalToSkin(appearance))
        end
    end)
end)

RegisterNetEvent("skinchanger:loadSkin", function(skin, cb)
    if skin.model or skin[1] then
        if skin.components and skin.props then
            skin = ConvertSkin(skin, "qf_skin")
        elseif skin.hair_1 and skin.bags_1 and skin.sex then
            print("Skinchanger skins is not supported")
        end
        ApplySkinToPed(MinimalToSkin(skin), targetPed, false)
        if type(cb) == "function" then
            cb()
        end
    else
        local minimal = json.decode(Config.StartClothes[skin.sex == 0 and "Male" or "Female"])
        ApplySkinToPed(MinimalToSkin(minimal))
    end

	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent("esx_skin:openSaveableMenu", function(onSubmit, onCancel)
    onSubmit()
    Wait(1000)
    startCharacter(GetGender(true))
end)

RegisterCommand("propfix", function()
    ExecuteCommand("fixskin")
end)


local stats = {
    health = 0,
    armour = 0
}

local function BackupPlayerStats()
    stats = {
        health = GetEntityHealth(playerPed),
        armour = GetPedArmour(playerPed)
    }
end

local function RestorePlayerStats()
    if stats then
        SetEntityMaxHealth(playerPed, 200)
        Wait(1000)
        SetEntityHealth(playerPed, stats.health)
        SetPedArmour(playerPed, stats.armour)
        stats = {}
    end
end


local ReloadSkinCooldown = 5000
local reloadSkinTimer = 0
local function InCooldown()
    return (GetGameTimer() - reloadSkinTimer) < ReloadSkinCooldown
end
RegisterCommand("fixskin", function()
    if InCooldown() or cache.vehicle or IsPedFalling(cachePed) then
        return
    end

    reloadSkinTimer = GetGameTimer()
    BackupPlayerStats()
    SetModel('mp_m_freemode_01')
    LoadSkin()
    RestorePlayerStats()
end)
