Config.Interactions = {
    ['PlayerOnBed'] = {
        label = locale('put_on_bed'),
        icon = 'fa-solid fa-bed',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_ambulancejob:server:PlayerOnBed', {
                targetId = targetId
            })
        end,
        canInteract = function(entity)
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local stateBag = Player(targetId).state
            if not stateBag.isDead or stateBag.playerOnBed then
                return false
            end
            
            local bed = utils.getClosestBed()
            if bed then
                return true
            end

            return false
        end
    },
    ['TakePlayerFromBed'] = {
        label = locale('take_player_from_bed'),
        icon = 'fa-solid fa-bed',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_ambulancejob:server:TakePlayerFromBed', {
                targetId = targetId
            })
        end,
        canInteract = function(entity)
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local stateBag = Player(targetId).state
            if stateBag.playerOnBed then
                return true
            end

            return false
        end
    },
    ['CheckDamages'] = {
        label = locale('check_damages'),
        icon = 'fa-solid fa-bandage',
        distance = 2,
        groups = Config.Jobs,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            initDamagesMenu(targetId, Player(targetId).state)
        end
    },
    ['StartDragPlayer'] = {
        label = locale('drag'),
        icon = 'fa-solid fa-people-pulling',
        distance = 2,
        onSelect = function(data)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_ambulancejob:server:DragPlayer', {state = true, player = targetId})
        end,
        canInteract = function(entity)
            if GetResourceState('p_policejob') ~= 'missing' then
                return false
            end

            if LocalPlayer.state.draggingPlayer then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.isCuffed or targetState.isDead and not targetState.draggedBy then
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
            TriggerServerEvent('p_ambulancejob:server:DragPlayer', {state = false, player = targetId})
        end,
        canInteract = function(entity)
            if GetResourceState('p_policejob') ~= 'missing' then
                return false
            end

            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy and targetState.draggedBy == cache.serverId then
                return true
            end

            return false
        end
    },
    ['OutFromVehicle'] = {
        label = locale('out_vehicle'),
        icon = 'fa-solid fa-car',
        distance = 2,
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(entity, seat)))
            TriggerServerEvent('p_ambulancejob:server:OutVehicle', {seat = seat, player = targetId})
        end,
        canInteract = function(entity, seat)
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(entity, seat)))
            local targetState = Player(targetId).state

            if targetState.isCuffed or targetState.isDead then
                return true
            end

            return false
        end
    },
    ['PutInVehicle'] = { -- dont touch this
        label = locale('put_in_vehicle'),
        icon = 'fa-solid fa-car',
        distance = 2,
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_ambulancejob:server:PutInVehicle', {seat = seat, player = targetId})
        end,
        canInteract = function(entity, seat)
            if LocalPlayer.state.draggingPlayer then
                return false
            end

            local vehicle, coords = lib.getClosestVehicle(GetEntityCoords(cache.ped), 4.0, false)

            if not vehicle or vehicle == 0 or not IsVehicleSeatFree(vehicle, seat) then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy then
                return false
            end

            if targetState.isDead then
                return true
            end

            return false
        end
    },
    ['StartDragDeadPlayer'] = {
        label = locale('drag_dead_player'),
        icon = 'fa-solid fa-skull',
        distance = 2,
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent('p_ambulancejob:server:dragDeadPlayer', {
                state = true, player = targetId
            })
        end,
        canInteract = function(entity, seat)
            if LocalPlayer.state.draggingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.draggedBy then
                return false
            end

            if targetState.isDead then
                return true
            end

            return false
        end
    },
    ['UseAdrenalinePlayer'] = {
        label = locale('use_adrenaline_player'),
        icon = 'fa-solid fa-syringe',
        distance = 2,
        items = 'adrenaline',
        onSelect = function(data, seat)
            local entity = type(data) == 'number' and data or data.entity
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local syringeProp = playAdrenaline(13000)
            if not syringeProp then return end
            if lib.progressBar({
                duration = 15000,
                label = locale('using_adrenaline'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true
                },
            }) then
                TriggerServerEvent('p_ambulancejob:server:useAdrenalinePlayer', {
                    targetId = targetId,
                    health = 100 -- health after revive
                })
            end
            ClearPedTasks(cache.ped)
            DeleteEntity(syringeProp)
        end,
        canInteract = function(entity, seat)
            if LocalPlayer.state.draggingPlayer then
                return false
            end
            
            local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local targetState = Player(targetId).state
            if targetState.isDead and targetState.deathStage == 1 then
                return true
            end

            return false
        end
    }
}

Config.DisableDragKeys = {
    24, 257, 25, 263, 45, 22, 44, 37, 23, 21, 288, 289, 170, 75,
    167, 73, 199, 59, 71, 72, 47, 264, 257, 140, 141, 142, 143
}

Config.OnStartPlayerDrag = function(serverId, playerPed)
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

Config.OnStopPlayerDrag = function(serverId, playerPed)
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