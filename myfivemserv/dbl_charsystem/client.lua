local defaultModel
local cam
local camHeading = 0.0
local camHeight = 0.0
local elements
local creator = false
local peds = {}
local saveCb = nil
local cancelCb = nil

-- AddEventHandler('onResourceStart', function(resourceName)
--     if resourceName == GetCurrentResourceName() then
--         TriggerServerEvent("dbl_character:setup")
--     end
-- end)

local skins = nil

function GetElements()
    local p = promise.new()
    TriggerEvent('skinchanger:getData', function(components, maxVals)
        local _components = {}

		for i = 1, #components do
			local row = components[i]
            local value       = row.value
            local componentId = row.componentId
            if componentId == 0 then
                value = GetPedPropIndex(cache.ped, row.componentId)
            end

			for k, v in pairs(maxVals) do
                if k == row.name then
                    row.max = v
                end
            end

			_components[row.name] = row
		end

        p:resolve(_components)
	end)

    return Citizen.Await(p)
end

local uiLoaded = false
RegisterNUICallback("loaded", function(data, cb)
    uiLoaded = true
end)

CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Wait(0)
	end

    while not uiLoaded do
        Wait(100)
    end

	Wait(2500)

    SendNUIMessage({
        action = "setButtons",
        data = Config.Buttons
    })

    if ESX.PlayerLoaded then
		return 
	end

    TriggerEvent('skinchanger:loadSkin', {sex = 0}, function()
		TriggerEvent('skinchanger:getSkin', function(skin)
			defaultModel = skin
		end)
		
		-- DoScreenFadeOut(0)
		-- ShutdownLoadingScreen()
		-- ShutdownLoadingScreenNui()

        exports["mrg_loading"]:close()
		DoScreenFadeOut(0)
        Wait(5000)
    
		TriggerServerEvent("dbl_character:setup")
	end)
end)

RegisterNetEvent("dbl_character:setup", function(slots, characters)
    local ped = PlayerPedId()
    skins = characters
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, Config.Spawn[1], Config.Spawn[2], Config.Spawn[3])
    SetEntityHeading(ped, Config.Spawn[4])
    SetEntityVisible(ped, false)

    ClearAreaOfPeds(Config.Spawn[1], Config.Spawn[2], Config.Spawn[3], 20.0, true)

    local num = 1
    for i = 2, -2, -2 do
        local coords = GetOffsetFromEntityInWorldCoords(ped, i + 0.0, 0.0, 0.25)
        local newPed = CreatePed(1, "mp_m_freemode_01", coords.x, coords.y, coords.z - 0.9, 0.0, false)
        SetEntityHeading(newPed, Config.Spawn[4] + ((i * 16) + 0.0))
        FreezeEntityPosition(newPed, true)

        -- Jeśli istnieje wygląd postaci, ładujemy go na peda
        if characters[""..num] and characters[""..num].skin then
            TriggerEvent('skinchanger:loadPedSkin', newPed, json.decode(characters[""..num].skin))
        end

        peds[""..num] = newPed
        num = num + 1
    end

    TriggerEvent('skinchanger:getSkin', function(skin)
        defaultModel = skin
    end)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        type = "selector",
        data = {
            limit = slots,
            characters = characters
        }
    })

    DoScreenFadeIn(1000)
    -- DoScreenFadeIn(0)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local camCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.25)
    local camPoint = GetOffsetFromEntityInWorldCoords(ped, -0.05, 0.0, 0.20)
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
    PointCamAtCoord(cam, camPoint.x, camPoint.y, camPoint.z)
    RenderScriptCams(true, false, 0, 0, 0)
end)

RegisterNUICallback("creator", function()
    creator = true

    deleteCam()
    local ped = PlayerPedId()
    SetEntityVisible(ped, true)

    elements = GetElements()

    SendNUIMessage({
        action = "setComponents",
        data = {
            config = Config.Components,
            elements = elements
        }
    })

    createCam(ped)
end)

RegisterNUICallback("select", function(data, cb)
    creator = false

    SetNuiFocus(false, false)
	TriggerServerEvent("dbl_character:select", data.id)
    
    local ped = PlayerPedId()
	FreezeEntityPosition(ped, false)
    SetEntityCollision(ped, true, true)
    SetEntityVisible(ped, true)
    RenderScriptCams(false, false, 0, 0, 0)
    for k, v in pairs(peds) do
        DeleteEntity(v)
    end
    deleteCam()
    Wait(500)
    TriggerEvent("skinchanger:loadSkin", json.decode(skins[""..data.id].skin), nil)
end)

RegisterNUICallback("create", function(data, cb)
    creator = false

    SetNuiFocus(false, false)

    TriggerEvent('skinchanger:getSkin', function(skin)
        data.skin = skin
    end)

	TriggerServerEvent("dbl_character:select", data.id, data)
    
    local ped = PlayerPedId()
	FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true)
    RenderScriptCams(false, false, 0, 0, 0)
    deleteCam()
end)

RegisterNetEvent("dbl_character:skin", function(cb1, cb2, menu)
    saveCb = cb1
    cancelCb = cb2

    if not menu then
        menu = "skin"
    end

    if menu == "tattoo" then
        return
    end

    elements = GetElements()

    SendNUIMessage({
        action = "setComponents",
        data = {
            config = Config.Components,
            elements = elements
        }
    })
    
    TriggerEvent('skinchanger:getSkin', function(skin)
        defaultModel = skin
    end)

    createCam(PlayerPedId())
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        type = "creator",
        data = {
            name = Config.Buttons[menu][1].name,
            type = menu
        }
    })
end)

RegisterNUICallback("change", function(data, cb)
    if data.name == "sex" then
        elements = GetElements()

        SendNUIMessage({
            action = "setComponents",
            data = {
                config = Config.Components,
                elements = elements
            }
        })
    end

    TriggerEvent('skinchanger:change', data.name, tonumber(data.value))
    TriggerEvent('skinchanger:getData', function(components, maxVals)
        local val = Config.ResetElement[data.name]
        if val then
            for i = 1, #components do
                local element = components[i]
                if element.name == val then
                    TriggerEvent('skinchanger:change', val, element.min)

                    element.value = element.min
                    element.max = maxVals[element.name]
                
                    cb(element)
                end
            end
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent("dbl_character:change", function(name, value)
    TriggerEvent('skinchanger:change', name, tonumber(value))
end)

RegisterNUICallback("save", function(data, cb)
    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent("esx_skin:save", skin)
    end)
    SetNuiFocus(false, false)
    deleteCam()
    if saveCb then
        saveCb()
    end
end)

RegisterNUICallback("cancel", function(data, cb)
	SetNuiFocus(false, false)
    deleteCam()
    
	TriggerEvent("skinchanger:loadSkin", defaultModel)
    TriggerServerEvent("esx_skin:save", defaultModel)

    if cancelCb then
        cancelCb()
    end
end)

function createCam(ped)
    if cam then
        DestroyCam(cam, true)
    end

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    
    -- Tworzymy nowy ped i kopiujemy wygląd postaci
    local newPed = CreatePed(1, GetEntityModel(ped), coords.x, coords.y, coords.z - 1.0, 0.0, false)
    SetEntityHeading(newPed, heading)
    SetEntityVisible(newPed, false)
    SetBlockingOfNonTemporaryEvents(newPed, true)
    FreezeEntityPosition(newPed, true)

    -- Ładujemy wygląd gracza do peda
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadPedSkin', newPed, skin)
    end)

    peds[1] = newPed

    -- Konfiguracja kamery
    camHeight = 0.25
    local camCoords = GetOffsetFromEntityInWorldCoords(newPed, 1.0, 2.0, (camHeight + 0.25))
    local camPoint = GetOffsetFromEntityInWorldCoords(newPed, 0.60, 0.0, camHeight)
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
    PointCamAtCoord(cam, camPoint.x, camPoint.y, camPoint.z)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
    SetCamFov(cam, 60.0)

    camHeading = heading - 30.0
    SetEntityHeading(ped, camHeading)
end

function deleteCam()
    if cam then
        RenderScriptCams(false, false, 0, 0, 0)
        DestroyCam(cam, true)
    end

    for i = 1, #peds do
        if DoesEntityExist(peds[i]) then
            DeleteEntity(peds[i])
        end
    end
    peds = {}
end

RegisterNUICallback("camRotate", function(data, cb)
    camHeading = camHeading - data.dist * 0.2
    SetEntityHeading(PlayerPedId(), camHeading)
end)

RegisterNUICallback("camHeight", function(data, cb)
    camHeight = camHeight + data.dist * 0.008

    local height1 = 0.7
    if creator then
        height1 = 1.0
    end

    local height2 = -0.85
    if creator then
        height2 = -0.55
    end

    if camHeight >= height1 then
        camHeight = height1
    end
    
    if camHeight <= height2 then
        camHeight = height2
    end

    local camCoords = GetOffsetFromEntityInWorldCoords(peds[1], 1.0, 2.0, (camHeight + 0.25))
    local camPoint = GetOffsetFromEntityInWorldCoords(peds[1], (GetCamFov(cam) / 100), 0.0, camHeight)
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
    PointCamAtCoord(cam, camPoint.x, camPoint.y, camPoint.z)
end)

RegisterNUICallback("camZoom", function(data, cb)
    local zoom = GetCamFov(cam) + data.dist / 2
    if zoom <= 10.0 then
        return
    end
    if zoom >= 70.0 then
        return
    end

    local camCoords = GetOffsetFromEntityInWorldCoords(peds[1], 1.0, 2.0, (camHeight + 0.25))
    local camPoint = GetOffsetFromEntityInWorldCoords(peds[1], (zoom / 100), 0.0, camHeight) -- max 0.65 min -0.85
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
    PointCamAtCoord(cam, camPoint.x, camPoint.y, camPoint.z)
    SetCamFov(cam, zoom)
end)