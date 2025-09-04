Config.Interactions = {
    ['PutMouthTape'] = {
        label = locale('put_mouth_tape'),
        icon = 'fa-solid fa-tape',
        distance = 2,
        items = 'mouthtape',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if lib.progressBar({
                duration = 5000,
                label = locale('putting_mouth_tape'),
                useWhileDead = false,
                canCancel = true,
                disable = {car = true, move = true, combat = true},
                anim = {dict = 'random@train_tracks', clip = 'idle_e',flag = 1},
            }) then
                TriggerServerEvent('p_policejob/server_interactions/toggleMouthTape', {
                    player = targetId,
                    state = true
                })
            end
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then return false end
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or targetState.carriedBy then return false end
            if targetState.isCuffed and not targetState.mouthTaped then return true end
            return false
        end
    },
    ['RemoveMouthTape'] = {
        label = locale('remove_mouth_tape'),
        icon = 'fa-solid fa-tape',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if lib.progressBar({
                duration = 5000,
                label = locale('removing_mouth_tape'),
                useWhileDead = false,
                canCancel = true,
                disable = {car = true, move = true, combat = true},
                anim = {dict = 'random@train_tracks', clip = 'idle_e',flag = 1},
            }) then
                TriggerServerEvent('p_policejob/server_interactions/toggleMouthTape', {
                    player = targetId,
                    state = false
                })
            end
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then return false end
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or targetState.carriedBy then return false end
            if targetState.mouthTaped then return true end
            return false
        end
    },
    ['HardCuffPlayer'] = {
        label = locale('hard_cuff_player'),
        icon = 'fa-solid fa-handcuffs',
        distance = 2,
        items = 'handcuffs',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local isInFront = utils.isInFront(entity)
            TriggerServerEvent('p_policejob:HandCuffs', {
                type = 'cuffs', state = true, player = targetId, front = isInFront,
                isHard = true
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or targetState.carriedBy then
                return false
            end

            local playerJob = Core.GetPlayerJob()
            if not targetState.isCuffed and (Player(targetId).state.isDead or Config.Jobs[playerJob.name] or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3)) then
                return true
            end

            return false
        end
    },
    ['CuffPlayer'] = {
        label = locale('cuff_player'),
        icon = 'fa-solid fa-handcuffs',
        distance = 2,
        items = 'handcuffs',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local isInFront = utils.isInFront(entity)
            TriggerServerEvent('p_policejob:HandCuffs', {
                type = 'cuffs', state = true, player = targetId, front = isInFront
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or targetState.carriedBy then
                return false
            end

            local playerJob = Core.GetPlayerJob()
            if not targetState.isCuffed and (Player(targetId).state.isDead or Config.Jobs[playerJob.name] or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3)) then
                return true
            end

            return false
        end
    },
    ['UnCuffPlayer'] = {
        label = locale('uncuff_player'),
        icon = 'fa-solid fa-handcuffs',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:HandCuffs', {
                type = 'cuffs', state = false, player = targetId
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy then
                return false
            end

            if targetState.isCuffed and targetState.cuffType ~= 'cable_ties' then
                if Config.CuffsKey and Inventory.getItemCount('cuffs_key', tonumber(targetId)) < 1 then
                    return false
                elseif not Config.CuffsKey and Inventory.getItemCount('handcuffs') < 1 then
                    return false
                end

                return true
            end

            return false
        end
    },
    ['LockpickHandcuffs'] = {
        label = locale('open_cuffs'),
        icon = 'fa-solid fa-lock-open',
        distance = 2,
        items = 'lockpick',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:interactions:OpenCuffs', {
                player = targetId
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy then
                return false
            end

            if Player(targetId).state.isCuffed and Player(targetId).state.cuffType ~= 'cable_ties' then
                return true
            end

            return false
        end
    },
    ['PutPlayerHeadBag'] = {
        label = locale('put_player_headbag'),
        icon = 'fa-solid fa-eye-slash',
        distance = 2,
        items = 'headbag',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob/server_interactions/ToggleHeadBag', {
                state = true, player = targetId
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or targetState.hasHeadBag then
                return false
            end

            if targetState.isCuffed or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return true
            end

            return false
        end
    },
    ['TakeOffPlayerHeadBag'] = {
        label = locale('take_off_player_headbag'),
        icon = 'fa-solid fa-eye',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob/server_interactions/ToggleHeadBag', {
                state = false, player = targetId
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy or not targetState.hasHeadBag then
                return false
            end

            return true
        end
    },
    ['ZipPlayer'] = {
        label = locale('zip_player'),
        icon = 'fa-solid fa-handcuffs',
        distance = 2,
        items = 'cable_ties',
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local isInFront = utils.isInFront(entity)
            TriggerServerEvent('p_policejob:HandCuffs', {
                type = 'cable_ties', state = true, player = targetId,
                timer = true, time = 60 * 1000, front = isInFront
            })
            -- if you dont want to auto remove cable_ties after 5 minutes, set timer to false, time is in minutes, 5 minutes default
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy then
                return false
            end

            local playerJob = Core.GetPlayerJob()
            if not Player(targetId).state.isCuffed and (
                IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) or
                playerJob.name == 'police'
            ) then
                return true
            end

            return false
        end
    },
    ['UnZipPlayer'] = {
        label = locale('unzip_player'),
        icon = 'fa-solid fa-handcuffs',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:HandCuffs', {
                type = 'cable_ties', state = false, player = targetId
            })
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy then
                return false
            end

            if Player(targetId).state.isCuffed and Player(targetId).state.cuffType == 'cable_ties' then
                return true
            end

            return false
        end
    },
    ['SearchPlayer'] = {
        label = locale('search_player'),
        icon = 'fa-solid fa-wallet',
        distance = 2,
        onSelect = function(data)
            if lib.progressBar({
                duration = 5500,
                label = locale('searching_player'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true,
                },
                anim = {
                    dict = 'anim@gangops@facility@servers@bodysearch@',
                    clip = 'player_search' 
                },
            }) then
                local entity = type(data) == 'number' and data or data.entity
                local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                if 
                Player(targetId).state.isCuffed or
                IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) or
                Editable.isPlayerDead(targetId) then
                    Inventory.openInventory('player', targetId)
                end
            end
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy then
                return false
            end

            if 
            Player(targetId).state.isCuffed or
            IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) or
            Editable.isPlayerDead(targetId) then
                return true
            end

            return false
        end
    },
    ['StartDragPlayer'] = {
        label = locale('start_drag'),
        icon = 'fa-solid fa-people-pulling',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:DragPlayer', {state = true, player = targetId})
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.isCuffed or Editable.isPlayerDead(targetId) and not Player(targetId).state.draggedBy then
                return true
            end

            return false
        end
    },
    ['StopDragPlayer'] = {
        label = locale('stop_drag'),
        icon = 'fa-solid fa-people-pulling',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:DragPlayer', {state = false, player = targetId})
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy and Player(targetId).state.draggedBy == cache.serverId then
                return true
            end

            return false
        end
    },
    ['OutFromVehicle'] = { -- dont touch this
        label = locale('out_player'),
        icon = 'fa-solid fa-car',
        distance = 2,
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(entity, seat)))
            TriggerServerEvent('p_policejob:OutVehicle', {seat = seat, player = targetId})
        end,
        canInteract = function(entity, seat)
            if exports['p_policejob']:inTrunk() then return false end
            if not NetworkGetEntityIsNetworked(entity) then return false end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(entity, seat)))
            
            if Player(targetId).state.isCuffed or Editable.isPlayerDead(targetId) then
                return true
            end

            return false
        end
    },
    ['PutInVehicle'] = { -- dont touch this
        label = locale('put_player'),
        icon = 'fa-solid fa-car',
        distance = 2,
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:PutInVehicle', {seat = seat, player = targetId})
        end,
        canInteract = function(entity, seat)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.carryingPlayer then
                return false
            end

            local vehicle, coords = lib.getClosestVehicle(GetEntityCoords(cache.ped), 4.0, false)

            if not vehicle or vehicle == 0 or not IsVehicleSeatFree(vehicle, seat) or not NetworkGetEntityIsNetworked(vehicle) then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))

            local targetState = Player(targetId).state
            if targetState.isCuffed or (targetState.draggedBy and targetState.draggedBy == cache.serverId) or Editable.isPlayerDead(targetId) then
                return true
            end

            return false
        end
    },
    ['CheckGunPowder'] = {
        label = locale('check_gun_powder'),
        icon = 'fa-solid fa-gun',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if lib.progressBar({
                duration = 10000,
                label = locale('checking_gun_powder'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true
                },
                anim = {
                    dict = 'random@train_tracks',
                    clip = 'idle_e',
                    flag = 1
                },
            }) then
                TriggerServerEvent('p_policejob:CheckGunPowder', targetId)
            end
        end,
        canInteract = function(entity, seat)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if Player(targetId).state.draggedBy then
                return false
            end

            local playerJob = Core.GetPlayerJob()
            if not Config.Jobs[playerJob.name] then
                return false
            end

            if Player(targetId).state.isCuffed or Editable.isPlayerDead(targetId) or 
            IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return true
            end

            return false
        end
    },
    ['SetPlayerBand'] = {
        label = locale('set_gps_band'),
        icon = 'fa-solid fa-hands-bound',
        groups = Config.Band.Jobs,
        items = 'tracking_band',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            if lib.progressBar({
                duration = 10000,
                label = locale('setting_gps_band'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true
                },
                anim = {
                    dict = 'random@train_tracks',
                    clip = 'idle_e',
                    flag = 1
                },
            }) then
                TriggerServerEvent('p_policejob:SetPlayerBand', {
                    player = targetId,
                    state = true
                })
            end
        end,
        canInteract = function(entity, seat)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy then
                return false
            end

            local playerJob = Core.GetPlayerJob()
            if not Config.Jobs[playerJob.name] then
                return false
            end

            local hasBand = targetState.hasTrackingBand
            if hasBand then
                return false
            end

            if targetState.isCuffed or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return true
            end

            return false
        end
    },
    ['RemovePlayerBand'] = {
        label = locale('remove_gps_band'),
        icon = 'fa-solid fa-hands-bound',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local playerJob = Core.GetPlayerJob()
            local bandJob = Config.Band.Jobs[playerJob.name]
            if bandJob and tonumber(playerJob.grade) >= bandJob then
                if lib.progressBar({
                    duration = 10000,
                    label = locale('removing_gps_band'),
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                        move = true,
                        combat = true
                    },
                    anim = {
                        dict = 'random@train_tracks',
                        clip = 'idle_e',
                        flag = 1
                    },
                }) then
                    TriggerServerEvent('p_policejob:SetPlayerBand', {
                        player = targetId,
                        state = false
                    })
                end
            else
                TriggerServerEvent('p_policejob:BandAlert', targetId)
                local game = lib.skillCheck(
                    {
                        {areaSize = 30, speedMultiplier = 1.5},
                    },
                    {'1', '2', '3', '4'}
                )

                if game then
                    if lib.progressBar({
                        duration = 10000,
                        label = locale('removing_gps_band'),
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true
                        },
                        anim = {
                            dict = 'random@train_tracks',
                            clip = 'idle_e',
                            flag = 1
                        },
                    }) then
                        TriggerServerEvent('p_policejob:SetPlayerBand', {
                            player = targetId,
                            state = false
                        })
                    end
                end
            end
        end,
        canInteract = function(entity, seat)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy then
                return false
            end

            local hasBand = targetState.hasTrackingBand
            if hasBand then
                return true
            end

            return false
        end
    },
    ['PutPlayerInTrunk'] = {
        label = locale('put_player_in_trunk'),
        icon = 'fa-solid fa-car',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob/server_trunks/PutPlayerInTrunk', targetId)
        end,
        canInteract = function(entity)
            if exports['p_policejob']:inTrunk() then return false end
            local localState = LocalPlayer.state
            if localState.draggingPlayer or localState.carryingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local stateBag = Player(targetId).state
            if stateBag.isCuffed or Editable.isPlayerDead(targetId) then
                local vehicle, _ = lib.getClosestVehicle(GetEntityCoords(cache.ped), 3.5, true)
                if vehicle and vehicle ~= 0 then
                    return true
                end
            end

            return false
        end
    },
    ['SendToJail'] = {
        label = locale('send_to_jail'),
        icon = 'fa-solid fa-hashtag',
        distance = 2,
        groups = Config.Jobs,
        onSelect = function(data)
            local input = lib.inputDialog(locale('send_to_jail'), {
                {type = 'number', label = locale('jail_time'), icon = 'clock', default = 0, min = 0, max = 500, required = false},
                {type = 'number', label = locale('jail_fine'), icon = 'dollar-sign', default = 1, min = 1, required = true},
                {type = 'textarea', label = locale('jail_reason'), icon = 'receipt', required = true}
            })
            if not input then return end
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_policejob:JailPlayer', {
                player = targetId,
                jail = input[1],
                fine = input[2],
                reason = input[3]
            })
        end,
        canInteract = function(entity)
            if not Config.Jail.EnableJail then return false end
            if GetResourceState('piotreq_gpt') ~= 'missing' or exports['p_policejob']:inTrunk() then return false end
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local stateBag = Player(targetId).state
            if stateBag.isCuffed or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return true
            end

            return false
        end
    },
    ['UseBreathalyzer'] = {
        label = locale('use_breathalyzer'),
        icon = 'fa-solid fa-mask-face',
        distance = 2,
        groups = Config.Jobs,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            exports['p_policejob']:useBreathalyzer(targetId)
        end,
        canInteract = function(entity)
            if not Config.Jail.EnableJail then return false end
            if exports['p_policejob']:inTrunk() then return false end
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local stateBag = Player(targetId).state
            if stateBag.isCuffed or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return true
            end

            return false
        end
    }
}

Config.CuffsAsItem = true -- set to true if you want to use handcuffs as item (target will be available too)
Config.CuffsKey = false -- set to true if you want to use key to uncuff player [you will receive key item after cuffing player]
Config.CuffItemCheck = function(entity, playerId)
    local localState = LocalPlayer.state
    if localState.draggingPlayer or localState.carryingPlayer then
        return false
    end

    local targetState = Player(playerId).state
    if targetState.draggedBy or targetState.carriedBy then
        return false
    end

    if Player(playerId).state.isCuffed then
        return 'uncuff'
    else
        local playerJob = Core.GetPlayerJob()
        if Player(playerId).state.isDead or Config.Jobs[playerJob.name] or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
            return 'cuff'
        end
    end

    return false
end


Config.Cuffs = {
    usableItem = true, -- set to true if you want to use handcuffs as item (target will be available too)
    cuffKeys = false, -- set to true if you want to use key to uncuff player [you will receive key item after cuffing player]
    cuffModels = {
        ['cuffs'] = {
            model = 'p_cs_cuffs_02_s',
            coords = {
                ['front'] = vector3(-0.058, 0.00, 0.090),
                ['rear'] = vector3(-0.055, 0.06, 0.04)
            },
            rotation = {
                ['front'] = vector3(290.0, 95.0, 120.0),
                ['rear'] = vector3(265.0, 155.0, 80.0)
            }
        },
        ['cable_ties'] = {
            model = 'police_zip_tie_positioned',
            coords = {
                ['front'] = vector3(-0.04, 0.02, 0.09),
                ['rear'] = vector3(-0.03, 0.05, 0.04)
            },
            rotation = {
                ['front'] = vector3(82.6, -102.44, -5.2),
                ['rear'] = vector3(-4.5, -203.21, 74.0)
            }
        },
    },
    cuffItemCheck = function(entity, playerId)
        local localState = LocalPlayer.state
        if localState.draggingPlayer or localState.carryingPlayer then
            return false
        end

        local targetState = Player(playerId).state
        if targetState.draggedBy or targetState.carriedBy then
            return false
        end

        if targetState.isCuffed then
            return 'uncuff'
        else
            local playerJob = Core.GetPlayerJob()
            if targetState.isDead or Config.Jobs[playerJob.name] or IsEntityPlayingAnim(entity, "random@mugging3", "handsup_standing_base", 3) then
                return 'cuff'
            end
        end

        return false
    end,
}

Config.Carry = {
    useRequest = true, -- if true other player need to accept carry request
    stopCarryKey = 'E', -- set key to stop carry [FOR EXAMPLE 'E']
    onStartCarrying = function(playerId, role)
        if role == 'carrying' then
            lib.showTextUI('[E] - Stop carry')
        end
    end,
    onStopCarrying = function(playerId, role)
        if role == 'carrying' then
            lib.hideTextUI()
        end
    end,
    onRequest = function(playerId)
        local useAlert = false -- SET TO TRUE IF YOU WANT TO USE ALERT DIALOG
        if not useAlert then
            local result = false
            local timer = 0
            Editable.showNotify(locale('player_request_carry', playerId))
            while timer < 500 do
                Citizen.Wait(1)
                timer += 1
                if IsControlJustReleased(0, 38) then
                    result = true
                    break
                end
            end
        
            return result
        else
            local alert = lib.alertDialog({
                header = locale('carry_person_request'),
                content = locale('carry_person_request_info', playerId),
                centered = true,
                cancel = true
            })
            return alert == 'confirm'
        end
    end,
    animation = {
        carried = {
            dict = 'nm',
            clip = 'firemans_carry',
            flag = 33,
            offset = {
                coords = vector3(0.25, -0.05, 0.63),
                rotation = vector3(0.25, 0.0, 180.0)
            }
        },
        carrying = {
            dict = 'missfinale_c2mcs_1',
            clip = 'fin_c2_mcs_1_camman',
            flag = 49
        }
    }
}

Config.LockpickCuffs = {
    miniGame = function()
        local game = lib.skillCheck(
            {
                {areaSize = 30, speedMultiplier = 1.5},
                {areaSize = 30, speedMultiplier = 1.6},
                {areaSize = 30, speedMultiplier = 1.6},
                {areaSize = 25, speedMultiplier = 1.5},
                {areaSize = 25, speedMultiplier = 1.7},
            },
            {'1', '2', '3', '4'}
        )
        return game
    end,
    animation = {
        enabled = true,
        dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        clip = 'machinic_loop_mechandplayer',
        flag = 49
    }
}

Config.DisableKeys = {
    ['hardcuff'] = { -- THIS IS ENABLED KEYS WHILE HARD CUFF !!!!!!!!!!!!!!!!!!!!!!!!!
        0, 1, 2, 249
    },
    ['cuff'] = {
        24, 257, 25, 263, 45, 22, 44, 37, 23, 21, 288, 289, 170, 75,
        167, 73, 199, 59, 71, 72, 47, 264, 257, 140, 141, 142, 143
    },
    ['drag'] = {
        24, 257, 25, 263, 45, 22, 44, 37, 23, 21, 288, 289, 170, 75,
        167, 73, 199, 59, 71, 72, 47, 264, 257, 140, 141, 142, 143
    }
}

Config.OnPlayerCuff = function()
    local playerPed = cache.ped
    SetEnableHandcuffs(playerPed, true)
    DisablePlayerFiring(playerPed, true)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
    SetPedCanPlayGestureAnims(playerPed, false)
    LocalPlayer.state.invBusy = true
    LocalPlayer.state.invHotkeys = false
    LocalPlayer.state.canUseWeapons = false
    lib.disableRadial(true)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(true)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(false)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(true)
    end
end

Config.OnPlayerUnCuff = function()
    local playerPed = cache.ped
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    LocalPlayer.state.invBusy = false
    LocalPlayer.state.invHotkeys = true
    LocalPlayer.state.canUseWeapons = true
    lib.disableRadial(false)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(false)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(true)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(false)
    end
end

Config.OnStartPlayerDrag = function()
    LocalPlayer.state.invBusy = true
    LocalPlayer.state.invHotkeys = false
    LocalPlayer.state.canUseWeapons = false
    lib.disableRadial(true)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(true)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(false)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(true)
    end
end

Config.OnStopPlayerDrag = function()
    LocalPlayer.state.invBusy = false
    LocalPlayer.state.invHotkeys = true
    LocalPlayer.state.canUseWeapons = true
    lib.disableRadial(false)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:disableTargeting(false)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AllowTargeting(true)
    end
    if GetResourceState('lb-phone') == 'started' then
        exports["lb-phone"]:ToggleDisabled(false)
    end
end