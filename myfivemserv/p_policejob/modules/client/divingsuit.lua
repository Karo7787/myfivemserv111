local activeSuit = false
local suitData = {
    objects = {}
}

local function CreateSuitProps()
    local playerPed = cache.ped
    local maskModel = lib.requestModel('p_d_scuba_mask_s')
    local tankModel = lib.requestModel('p_s_scuba_tank_s')

    suitData.objects[1] = CreateObject(tankModel, 1.0, 1.0, 1.0, false, false, false)
    SetEntityCollision(suitData.objects[1], false, false)
    SetEntityCompletelyDisableCollision(suitData.objects[1], true, true)
    AttachEntityToEntity(suitData.objects[1], playerPed, GetPedBoneIndex(playerPed, 24818), -0.29, -0.23, -0.02, -3.94, -88.7, 180.0, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tankModel)

    suitData.objects[2] = CreateObject(maskModel, 1.0, 1.0, 1.0, false, false, false)
    SetEntityCollision(suitData.objects[2], false, false)
    SetEntityCompletelyDisableCollision(suitData.objects[2], true, true)
    AttachEntityToEntity(suitData.objects[2], playerPed, GetPedBoneIndex(playerPed, 12844), 0.0, 0.01, 0.0, -0.13, -448.17, 194.23, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(maskModel)
end

lib.callback.register('p_policejob/client_divingsuit/UseSuit', function()
    if activeSuit then
        return false
    end

    activeSuit = true
    if lib.progressBar({
        duration = 5000,
        label = locale('using_diving_suit'),
        useWhileDead = false,
        canCancel = true,
        allowSwimming = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d'
        },
    }) then
        activeSuit = true
        local playerPed = cache.ped
        CreateSuitProps()
        SetEnableScuba(playerPed, true)
        SetPedMaxTimeUnderwater(playerPed, 50.0)
        SetTimeout(2000, function()
            ClearPedTasks(playerPed)
        end)
        Citizen.CreateThread(function()
            while activeSuit do
                Citizen.Wait(500)
                if activeSuit and (not DoesEntityExist(suitData.objects[1]) or not DoesEntityExist(suitData.objects[2])) then
                    for i = 1, #suitData.objects do
                        if DoesEntityExist(suitData.objects[i]) then
                            DeleteEntity(suitData.objects[i])
                        end
                    end

                    CreateSuitProps()
                end
            end
        end)
        return true
    else
        activeSuit = false
    end

    return false
end)

lib.callback.register('p_policejob/client_divingsuit/UseClothes', function()
    if not activeSuit then
        return false
    end

    if lib.progressBar({
        duration = 5000,
        label = locale('taking_off_diving_suit'),
        useWhileDead = false,
        canCancel = true,
        allowSwimming = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d'
        },
    }) then
        local playerPed = cache.ped
        for i = 1, #suitData.objects, 1 do
            DetachEntity(suitData.objects[i], true)
            DeleteEntity(suitData.objects[i])
        end
        suitData.objects = {}
        SetEnableScuba(playerPed, false)
        SetPedMaxTimeUnderwater(playerPed, 1.0)
        activeSuit = false
        SetTimeout(1000, function()
            ClearPedTasks(playerPed)
        end)
        return true
    end

    return false
end)