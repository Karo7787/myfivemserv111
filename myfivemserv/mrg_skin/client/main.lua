ShopSkin = {}
local ActiveMenu = {}
local playerCam = nil

local WEAR_CLOTHES = {
    head = true,
    body = true,
    bottom = true,
    all = true,
}

local dataClothes = {
    head = {
        animations = {
            on = {
                dict = "mp_masks@standard_car@ds@",
                anim = "put_on_mask",
                move = 51,
                duration = 600
            },
            off = {
                dict = "missheist_agency2ahelmet",
                anim = "take_off_helmet_stand",
                move = 51,
                duration = 1200
            }
        },
        components = {
            male = {
                {1, 0}
            },
            female = {
                {1, 0}
            }
        },
        props = {
            male = {
                {0, -1}
            },
            female = {}
        }
    },
    body = {
        animations = {
            on = {
                dict = "clothingtie",
                anim = "try_tie_negative_a",
                move = 51,
                duration = 1200
            },
            off = {
                dict = "clothingtie",
                anim = "try_tie_negative_a",
                move = 51,
                duration = 1200
            }
        },
        components = {
            male = {
                {11, 252},
                {3, 15},
                {8, 15},
                {10, 0},
                {5, 0}
            },
            female = {
                {11, 15},
                {8, 14},
                {3, 15},
                {10, 0},
                {5, 0}
            }
        },
        props = {
            male = {},
            female = {}
        }
    },
    bottom = {
        animations = {
            on = {
                dict = "re@construction",
                anim = "out_of_breath",
                move = 51,
                duration = 1300
            },
            off = {
                dict = "re@construction",
                anim = "out_of_breath",
                move = 51,
                duration = 1300
            }
        },
        components = {
            male = {
                {4, 61},
                {6, 34}
            },
            female = {
                {4, 15},
                {6, 35}
            }
        },
        props = {
            male = {},
            female = {}
        }
    }
}



local function wearClothes(typeClothes)
    local dataClothes = dataClothes[typeClothes]
    local animationsOn = dataClothes.animations.on
    local components = dataClothes.components[ShopSkin["model"] == "mp_m_freemode_01" and "male" or "female"]
    local props = dataClothes.props[ShopSkin["model"] == "mp_m_freemode_01" and "male" or "female"]
    local appliedComponents = copy(ShopSkin["components"])
    local appliedProps = copy(ShopSkin["props"])

    RequestAnimDict(animationsOn.dict)
    while not HasAnimDictLoaded(animationsOn.dict) do
        Wait(0)
    end

    for i = 1, #components do
        local componentId = components[i][1]
        SetPedComponentVariation(playerPed, componentId, appliedComponents[tostring(componentId)]["drawable"], appliedComponents[tostring(componentId)]["variation"], 2)
    end
    for i = 1, #props do
        local propId = props[i][1]
        SetPedPropIndex(playerPed, propId, appliedProps[tostring(propId)]["drawable"], appliedProps[tostring(propId)]["variation"], 2)
    end

    TaskPlayAnim(playerPed, animationsOn.dict, animationsOn.anim, 3.0, 3.0, animationsOn.duration, animationsOn.move, 0, false, false, false)
end

local function removeClothes(typeClothes)
    local dataClothes = dataClothes[typeClothes]
    local animationsOff = dataClothes.animations.off
    local components = dataClothes.components[ShopSkin["model"] == "mp_m_freemode_01" and "male" or "female"]
    local props = dataClothes.props[ShopSkin["model"] == "mp_m_freemode_01" and "male" or "female"]

    RequestAnimDict(animationsOff.dict)
    while not HasAnimDictLoaded(animationsOff.dict) do
        Wait(0)
    end

    for i = 1, #components do
        local component = components[i]
        SetPedComponentVariation(playerPed, component[1], component[2], 0, 2)
    end

    for i = 1, #props do
        ClearPedProp(playerPed, props[i][1])
    end

    TaskPlayAnim(playerPed, animationsOff.dict, animationsOff.anim, 3.0, 3.0, animationsOff.duration, animationsOff.move, 0, false, false, false)
end

local handsup = false

local function showHands()
    if handsup then
		handsup = false
		ClearPedTasks(playerPed)
	else							
		handsup = true
        lib.requestAnimDict('anim@move_hostages@male')
		TaskPlayAnim(playerPed, "anim@move_hostages@male", "male_idle", 8.0, 8.0, 1.0, 50, 0, 0, 0, 0)
	end
end

Citizen.CreateThread(function()
    SetModel('mp_m_freemode_01')
    SendNUIMessage({
        action = 'changeLanguage',
        data = {
            locale = TRANSLATIONS[Config.Language]
        }
    })
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(100)
    end
    LoadSkin()
end)

local function getMenu(menu)

    Citizen.Wait(500)
    SendNUIMessage({
        action = 'changeLanguage',
        data = {
            locale = TRANSLATIONS[Config.Language]
        } 
    })
    local skinoptions = {}
    for k, menucategory in pairs(Config.Menus[menu]) do
        local category = {
            option = {
                menucategory.optionName,
                optionIcon = menucategory.optionIcon
            },
            sideOptions = {}
        }
        for k2, menusubcategory in pairs(menucategory.subcategories) do
            local subcategory = {
                sideOptionName = menusubcategory.subcategory,
                sideOptionItems = {}
            }
            for k3, menuoption in pairs(menusubcategory.options) do
                local menuoption_data = Config.Options[menuoption]

                local option = {
                    SOI_name = menuoption_data.name,
                    SOI_type = menuoption_data.type or nil,
                    SOI_opt = type(menuoption_data.options) == "function" and menuoption_data.options() or {}
                }
                local removenumber = 0
                if ShopSkin["model"] == "mp_m_freemode_01" or ShopSkin["model"] == "mp_f_freemode_01" then
                    removenumber = 1
                end
                if type(menuoption_data.options) == "table" then
                    for k4, menuoptions in pairs(menuoption_data.options) do
                        table.insert(option.SOI_opt, {
                            SOI_opt_name = menuoptions.name,
                            SOI_opt_sourcename = k..":"..k2..":"..k3..":"..k4..":"..menu,
                            SOI_opt_trigger = 'change',
                            SOI_opt_currentNumber = menuoptions.current(),
                            SOI_opt_minNumber =  menuoptions.min and menuoptions.min() or nil,
                            SOI_opt_maxNumber = menuoptions.max()-removenumber
                        })
                    end
                end
                table.insert(subcategory.sideOptionItems, option)
            end
            table.insert(category.sideOptions, subcategory)
        end
        table.insert(skinoptions, category)
    end
    ActiveMenu = {
        skinType = menu,
        options = skinoptions
    }
    SendNUIMessage({
        action = 'setSkinData',
        data = ActiveMenu
    })
end
function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

  
function openShop(shop)
    LocalPlayer.state:set('InSkin', true, true)
    playerPed = PlayerPedId()
    setPlayerHair(PlayerSkin.head.hair, true)
    ShopSkin = copy(PlayerSkin)
    if shop == nil or not shop then
        shop = 'skin'
    end

    Citizen.Wait(500)

    if shop ~= 'skin' then
        ESX.ShowNotification(_L('5SECONDS_TO_OPEN'))

        Citizen.Wait(5000)
    end
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local gameplayCam = camCoords or GetGameplayCamCoord()
    local playerCoords = GetEntityCoords(playerPed)
    SetCamCoord(cam, gameplayCam.x, gameplayCam.y, playerCoords.z)
    RenderScriptCams(true, false, 0, 0, 0)
    local heading = camHeading or GetGameplayCamRot(2).z

    SetEntityHeading(playerPed, (heading + 180 % 360))
    FreezeEntityPosition(playerPed, true)

    baseCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.08, 0.0, 0.0)
    PointCamAtCoord(cam, baseCoords.x, baseCoords.y, baseCoords.z)
    targetHeading = GetEntityHeading(playerPed)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
    SetNuiFocus(true, true)

    getMenu(shop)
    EnsureLerpThread()
end

RegisterNetEvent("mrg_skin:menu:open", function(menu)
    openShop(menu)
end)

RegisterNUICallback('change', function(data, cb)
    local data1, data2, data3, data4, data5 = string.match(data.sourcename, "(.*):(.*):(.*):(.*):(.*)")
    Config.Options[Config.Menus[data5][tonumber(data1)].subcategories[tonumber(data2)].options[tonumber(data3)]].options[tonumber(data4)].change(data)
    for k, v in pairs(ActiveMenu.options[tonumber(data1)].sideOptions[tonumber(data2)].sideOptionItems[tonumber(data3)].SOI_opt) do
        ActiveMenu.options[tonumber(data1)].sideOptions[tonumber(data2)].sideOptionItems[tonumber(data3)].SOI_opt[k].SOI_opt_currentNumber = Config.Options[Config.Menus[data5][tonumber(data1)].subcategories[tonumber(data2)].options[tonumber(data3)]].options[k].current()
        local removenumber = 0
        if ShopSkin["model"] == "mp_m_freemode_01" or ShopSkin["model"] == "mp_f_freemode_01" then
            removenumber = 1
        end
        ActiveMenu.options[tonumber(data1)].sideOptions[tonumber(data2)].sideOptionItems[tonumber(data3)].SOI_opt[k].SOI_opt_maxNumber = Config.Options[Config.Menus[data5][tonumber(data1)].subcategories[tonumber(data2)].options[tonumber(data3)]].options[k].max()-removenumber
        if Config.Options[Config.Menus[data5][tonumber(data1)].subcategories[tonumber(data2)].options[tonumber(data3)]].options[k].min then
            ActiveMenu.options[tonumber(data1)].sideOptions[tonumber(data2)].sideOptionItems[tonumber(data3)].SOI_opt[k].SOI_opt_minNumber = Config.Options[Config.Menus[data5][tonumber(data1)].subcategories[tonumber(data2)].options[tonumber(data3)]].options[k].min()
        end
    end
    SendNUIMessage({
        action = 'setSkinData',
        data = ActiveMenu
    })
end)



local targetHeading = 0.0
local currentHeading = 0.0
local currentCamCoords = 0.0
local targetZ = 0.0
local camFov = 40.0
local lerp_thread = false
function EnsureLerpThread()
    if(lerp_thread) then return end
    Citizen.CreateThread(function()
        while LocalPlayer.state.InSkin do
            TaskStandStill(playerPed, 1000)
            Citizen.Wait(10)
        end
    end)
    Citizen.CreateThread(function()
        lerp_thread = true
        currentHeading = GetEntityHeading(playerPed)
        targetHeading = currentHeading
        currentCamCoords = GetCamCoord(cam)
        SetCamFov(cam, camFov)
        targetFov = camFov
        targetZ = currentCamCoords.z
        camZ = currentCamCoords.z
        while LocalPlayer.state.InSkin do
            local _targetHeading = targetHeading
            local _targetZ = targetZ
            local _targetFov = targetFov
            local headingDiff = math.abs(currentHeading - _targetHeading)
            if(headingDiff > 0.3) then
                local lerpValue = Lerp(currentHeading, _targetHeading, headingDiff * GetFrameTime() * 0.5)
                currentHeading = lerpValue
                SetEntityHeading(playerPed, currentHeading%360)
            end
            local zDiff = math.abs(camZ - _targetZ)
            local fovDiff = math.abs(camFov - _targetFov)
            if((zDiff > 0.02 or fovDiff > 0.3)) then
                local newCamZ = Lerp(camZ, _targetZ, zDiff * GetFrameTime() * 5)
                camZ = newCamZ
                local newCamFov = Lerp(camFov, _targetFov, fovDiff * GetFrameTime())
                camFov = newCamFov
                SetCamParams(cam, currentCamCoords.x, currentCamCoords.y, camZ, 0.0, 0.0, 0.0, camFov, 0, 0, 2)
                PointCamAtCoord(cam, baseCoords.x, baseCoords.y, camZ, 1)
            end
            Citizen.Wait(0)
        end
        lerp_thread = false
    end)
end

function Lerp(firstValue, secondValue, factor)
    if(factor > 1.0) then
        factor = 1.0
    end
	return firstValue + (secondValue - firstValue) * factor
end

function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

RegisterNUICallback('cameraChange', function(data, cb)
    if data.rotate ~= 0 then
        targetHeading = targetHeading + data.rotate * 0.2
    end

    if data.move ~= 0 then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local camCoords = currentCamCoords
        local z = targetZ
        if data.move > 0 then
            targetZ = math.min(coords.z + 0.8, targetZ + data.move * 0.002)
        else
            targetZ = math.max(coords.z - 0.8, targetZ + data.move * 0.002)
        end    
    end
end)

RegisterNUICallback('cameraZoom', function(data, cb)
    local ped = PlayerPedId()
    local dist = data.zoom
    local fov = GetCamFov(cam) + dist
    if(fov > 50) then fov = 50 end
    if(fov < 5) then fov = 5 end
    targetFov = fov + 0.01
end)


RegisterNUICallback('change_model', function(data, cb)
    ShopSkin.model = data.value
    setPlayerModel(ShopSkin.model)
    Wait(100)
    getMenu(ActiveMenu.skinType)
end)

RegisterNUICallback('mrg_skin:close', function(data, cb)
    closeSkin()
    LoadSkin()
end)

RegisterNUICallback("mrg_skin:ui:save:player", function()
    PlayerSkin = copy(ShopSkin)
    TriggerServerEvent('mrg_skin:skin:save', SkinToMinimal(PlayerSkin))
    closeSkin()
end)

RegisterNUICallback("mrg_skin:ui:save:wardrobe", function(data, cb)
    local minimal = SkinToMinimal(ShopSkin)
    TriggerServerEvent('mrg_skin:outfits:save', data.value, minimal[1], minimal[2].components, minimal[2].props)
    if not exports['mrg_achivements']:CheckIsUnlocked('zapisanie-fitu') then
        TriggerServerEvent("mrg_achivements:UnlockAchivements", "zapisanie-fitu", 1)
    end
end)
RegisterNUICallback('mrg_skin:ui:save:pay', function(data, cb)
    local success = lib.callback.await('mrg_skin:save:pay', false, data.value)
    if success then
        PlayerSkin = copy(ShopSkin)
        TriggerServerEvent('mrg_skin:skin:save', SkinToMinimal(PlayerSkin))
        if data.value == 'clotheshop' then
            if not exports['mrg_achivements']:CheckIsUnlocked('zakup-w-clotheshop') then
                TriggerServerEvent("mrg_achivements:UnlockAchivements", "zakup-w-clotheshop", 1)
            end
        elseif data.value == "barbershop" then
            if not exports['mrg_achivements']:CheckIsUnlocked('zakup-w-barbershop') then
                TriggerServerEvent("mrg_achivements:UnlockAchivements", "zakup-w-barbershop", 1)
            end
        end
        closeSkin()
    end
end)

function closeSkin()
    LocalPlayer.state:set('InSkin', false, true)
    ActiveMenu = {}
    wearClothes('head')
    wearClothes('bottom')
    wearClothes('body')

    WEAR_CLOTHES = {
        head = true,
        body = true,
        bottom = true,
        all = true,
    }

    ShopSkin = {}
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })

    FreezeEntityPosition(playerPed, false)
    RenderScriptCams(false, false, 0, true, true)
    ClearPedTasks(playerPed)
    DestroyCam(cam)
    SetModel('mp_m_freemode_01')
    ApplySkinToPed()
end

RegisterNUICallback('take_clothes_off', function(data, cb)
    if data.value == 'handsUp' then
        showHands()
    elseif data.value ~= 'all' then
        if WEAR_CLOTHES[data.value] then
            WEAR_CLOTHES[data.value] = false
            removeClothes(data.value)
        else
            WEAR_CLOTHES[data.value] = true
            wearClothes(data.value)
        end
    else
        if WEAR_CLOTHES['all'] then
            WEAR_CLOTHES['all'] = false
            removeClothes('head')
            removeClothes('bottom')
            removeClothes('body')
        else
            WEAR_CLOTHES['all'] = true
            wearClothes('head')
            wearClothes('bottom')
            wearClothes('body')
        end
    end
end)


CreatorCoords = vector3(-795.12, 331.72, 201.42)
Teleport = vector4(-542.64, -208.41, 37.95, 209.04)
function startCharacter(gender)
    TriggerServerEvent("mrg_skin:buckets:change")
    SetModel(gender == "Male" and 'mp_m_freemode_01' or 'mp_f_freemode_01')
    PlayerSkin = MinimalToSkin(json.decode(Config.StartClothes[gender]))
    TriggerServerEvent('mrg_skin:skin:save', SkinToMinimal(PlayerSkin))
    playerPed = PlayerPedId()
    ApplySkinToPed()
    openShop('skin')
    Citizen.Wait(400)
    while LocalPlayer.state.InSkin do
        Wait(100)
    end
    DoScreenFadeOut(500)
    Wait(550)
    SetEntityCoords(PlayerPedId(), Teleport.x, Teleport.y, Teleport.z)
    SetEntityHeading(PlayerPedId(), Teleport.w)
    Wait(1500)
    DoScreenFadeIn(1000)
    TriggerEvent("mrg_skin:finished")
    TriggerServerEvent("mrg_skin:buckets:reset")
    if not exports['mrg_achivements']:CheckIsUnlocked('create-character') then
        TriggerServerEvent("mrg_achivements:UnlockAchivements", "create-character", 1)
    end
end

local function RegisterChangeOutfitMenu(id, parent, outfits, mType)
    local changeOutfitMenu = {
        id = id,
        title = TRANSLATIONS[Config.Language]['OUTFITS_CHANGE'],
        menu = parent,
        options = {}
    }

    for k, v in pairs(outfits) do
        changeOutfitMenu.options[#changeOutfitMenu.options + 1] = {
            title = v.name,
            description = v.model,
            event = "mrg_skin:outfits:change",
            args = {
                type = mType,
                name = v.name,
                model = v.model,
                components = v.components,
                props = v.props,
                disableSave = mType and true or false
            }
        }
    end
    if #changeOutfitMenu.options > 2 then
        table.sort(changeOutfitMenu.options, function(a, b)
            return a.title < b.title
        end)
    end

    lib.registerContext(changeOutfitMenu)
end 

RegisterNetEvent("mrg_skin:outfits:change", function(data)
    local minimalSkin = SkinToMinimal(PlayerSkin)
    minimalSkin[1] = data.model
    minimalSkin[2] = {
        ["components"] = json.decode(data.components),
        ["props"] = json.decode(data.props),
    }
    PlayerSkin = MinimalToSkin(minimalSkin)
    TriggerServerEvent('mrg_skin:skin:save', minimalSkin)
    ApplySkinToPed()
end)


local function RegisterUpdateOutfitMenu(id, parent, outfits)
    local updateOutfitMenu = {
        id = id,
        title = TRANSLATIONS[Config.Language]['OUTFITS_UPDATE'],
        menu = parent,
        options = {}
    }
    for k, v in pairs(outfits) do
        updateOutfitMenu.options[#updateOutfitMenu.options + 1] = {
            title = v.name,
            description = v.model,
            event = "mrg_skin:outfits:update",
            args = v.id
        }
    end
    if #updateOutfitMenu.options > 0 then
        table.sort(updateOutfitMenu.options, function(a, b)
            return a.title < b.title
        end)
    end
    
    lib.registerContext(updateOutfitMenu)
end


RegisterNetEvent('mrg_skin:outfits:update', function(id)
    local outfits = lib.callback.await("mrg_skin:outfits:get", false)
    local outfitExists = false
    for k, v in pairs(outfits) do
        if v.id == id then
            outfitExists = true
            break
        end
    end
    if not outfitExists then
        ESX.showNotification(_L('OUTFIT_LOADING_ERROR'))
        return
    end
    local minimal = SkinToMinimal(PlayerSkin)
    TriggerServerEvent('mrg_skin:outfits:update', id, minimal[1], minimal[2].components, minimal[2].props)
end)


local function RegisterGenerateOutfitCodeMenu(id, parent, outfits)
    local generateOutfitCodeMenu = {
        id = id,
        title = TRANSLATIONS[Config.Language]['OUTFITS_GENERATE'],
        menu = parent,
        options = {}
    }

    for k, v in pairs(outfits) do
        generateOutfitCodeMenu.options[#generateOutfitCodeMenu.options + 1] = {
            title = v.name,
            description = v.model,
            event = "mrg_skin:outfits:generatecode",
            args = v.id
        }
    end
    
    lib.registerContext(generateOutfitCodeMenu)
end
RegisterNetEvent('mrg_skin:outfits:generatecode', function(id)
    lib.callback("mrg_skin:outfits:generatecode", false, function(code)
        if not code then
            FRAMEWORK.ShowNotification(_L('OUTFIT_LOADING_ERROR'))
            return
        end
        lib.setClipboard(code)
        lib.inputDialog(TRANSLATIONS[Config.Language]['OUTFITS_GENERATE'], {
            {
                type = "input",
                label = TRANSLATIONS[Config.Language]['OUTFITS_CODE'],
                default = code,
                disabled = true
            }
        })
    end, id)
end)


local function RegisterDeleteOutfitMenu(id, parent, outfits)
    local deleteOutfitMenu = {
        id = id,
        title = TRANSLATIONS[Config.Language]['OUTFITS_DELETE'],
        menu = parent,
        options = {}
    }
    if #outfits >= 2 then
        table.sort(outfits, function(a, b)
            return a.name < b.name
        end)
    end

    for k, v in pairs(outfits) do
        deleteOutfitMenu.options[#deleteOutfitMenu.options + 1] = {
            title = TRANSLATIONS[Config.Language]['OUTFITS_DELETE']..': "'..v.name..'"',
            event = 'mrg_skin:outfits:delete',
            args = v.id
        }
    end

    lib.registerContext(deleteOutfitMenu)
end
RegisterNetEvent('mrg_skin:outfits:delete', function(id)
    TriggerServerEvent('mrg_skin:outfits:delete', id)
end)
RegisterNetEvent('mrg_skin:outfits:import', function()
    local response = lib.inputDialog(TRANSLATIONS[Config.Language]['OUTFITS_IMPORT'], {
        {
            type = "input",
            label = TRANSLATIONS[Config.Language]['OUTFITS_IMPORT_NAME'],
            placeholder = TRANSLATIONS[Config.Language]['OUTFITS_IMPORT_PLACEHOLDER'],
            default = TRANSLATIONS[Config.Language]['OUTFITS_IMPORT_DEFAULT'],
            required = true
        },
        {
            type = "input",
            label = TRANSLATIONS[Config.Language]['OUTFITS_CODE'],
            placeholder = "fAaBlCsDzEyFwGyHsIsJiKeL",
            required = true
        }
    })

    if not response then
        return
    end

    local outfitName = response[1]
    local outfitCode = response[2]
    if outfitCode ~= nil then
        Wait(500)
        lib.callback("mrg_skin:outfits:import", false, function(success)
            if success then
                ESX.ShowNotification(_L('OUTFIT_ADDED'))
                if not exports['mrg_achivements']:CheckIsUnlocked('import-fitu') then
                    TriggerServerEvent("mrg_achivements:UnlockAchivements", "import-fitu", 1)
                end
            else
                ESX.ShowNotification(_L('SOMETHING_WRONG'))
            end
        end, outfitName, outfitCode, PlayerSkin.model)
    end 
end)

function OpenOutfitMenu()
    local outfits = lib.callback.await("mrg_skin:outfits:get", false)
    local mainMenuID = "mrg_skin:outfits:main"
    local changeOutfitMenuID = 'mrg_skin:outfits:change'
    local updateOutfitMenuID = 'mrg_skin:outfits:update'
    local deleteOutfitMenuID = 'mrg_skin:outfits:delete'
    local generateOutfitCodeMenuID = 'mrg_skin:outfits:generatecode'
    RegisterChangeOutfitMenu(changeOutfitMenuID, mainMenuID, outfits)
    RegisterUpdateOutfitMenu(updateOutfitMenuID, mainMenuID, outfits)
    RegisterGenerateOutfitCodeMenu(generateOutfitCodeMenuID, mainMenuID, outfits)
    RegisterDeleteOutfitMenu(deleteOutfitMenuID, mainMenuID, outfits)

    lib.registerContext({
        id = mainMenuID,
        title = TRANSLATIONS[Config.Language]['OUTFITS'],
        options = {
            {
                title = TRANSLATIONS[Config.Language]['OUTFITS_CHANGE'],
                description = TRANSLATIONS[Config.Language]['OUTFITS_CHANGE_DESC'],
                menu = changeOutfitMenuID
            },
            {
                title = TRANSLATIONS[Config.Language]['OUTFITS_UPDATE'],
                description = TRANSLATIONS[Config.Language]['OUTFITS_UPDATE_DESC'],
                menu = updateOutfitMenuID
            },
            {
                title = TRANSLATIONS[Config.Language]['OUTFITS_GENERATE'],
                description = TRANSLATIONS[Config.Language]['OUTFITS_GENERATE_DESC'],
                menu = generateOutfitCodeMenuID
            },
            {
                title = TRANSLATIONS[Config.Language]['OUTFITS_DELETE'],
                description = TRANSLATIONS[Config.Language]['OUTFITS_DELETE_DESC'],
                menu = deleteOutfitMenuID
            },
            {
                title = TRANSLATIONS[Config.Language]['OUTFITS_IMPORT'],
                description = TRANSLATIONS[Config.Language]['OUTFITS_IMPORT_DESC'],
                event = 'mrg_skin:outfits:import'
            },
        }
    })

    lib.showContext(mainMenuID)
end

exports("OpenOutfitMenu", OpenOutfitMenu)

RegisterNetEvent("mrg_skin:skin:change", function(changes)
    for k, v in pairs(changes) do
        if v.type == "component" then
            setPlayerComponent(v.id, "drawable", v.drawable)
            setPlayerComponent(v.id, "variation", v.variation)
        else
            setPlayerProp(v.id, "drawable", v.drawable)
            Citizen.Wait(10)
            setPlayerProp(v.id, "variation", v.variation)
        end
    end
    TriggerServerEvent('mrg_skin:skin:save', SkinToMinimal(PlayerSkin))
end)
RegisterNetEvent("mrg_skin:skin:setModel", function(model)
    setPlayerModel(model)
    TriggerServerEvent('mrg_skin:skin:save', SkinToMinimal(PlayerSkin))
    Wait(1000)
    LoadSkin()
end)

RegisterNetEvent("mrg_skin:skin:reloadSkin", function(model)
    SetModel('mp_m_freemode_01')
    Wait(100)
    LoadSkin()
end)

RegisterCommand("wlosy", function()
    if not LocalPlayer.state.InSkin then
        if PlayerSkin.head.hair.style == GetPedDrawableVariation(playerPed, 2) then
            local hair = copy(PlayerSkin.head.hair)
            hair.style = 0
            setPlayerHair(hair, true)
        else
            setPlayerHair(PlayerSkin.head.hair, true)
        end
        TriggerEvent("rcore_tattoos:applyOwnedTattoos")
    end
end)