Fire = function()
    local self = {}
    self.moduleName = "fire"
    self.Started = false
    self.active = {}
    self.removed = {}
    self.ShowFire = true
    self.FireTargetEnabled = false

    self.Translate = function(key)
        return locale('server.modules.'..self.moduleName.."."..key)
    end

    self.IsLookingAt = function(particleCoords, thresholdAngle)
        local playerPed = PlayerPedId()
        local camRot = GetGameplayCamRot(2)
        local camCoords = GetGameplayCamCoord()
        local function rotationToDirection(rot)
            local z = math.rad(rot.z)
            local x = math.rad(rot.x)
            local num = math.abs(math.cos(x))
    
            return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
        end

        local direction = rotationToDirection(camRot)
        local toParticle = vector3(particleCoords.x - camCoords.x, particleCoords.y - camCoords.y, particleCoords.z - camCoords.z)
        local toParticleNormalized = toParticle / #(toParticle)
    
        -- Get dot product between camera direction and direction to particle
        local dot = direction.x * toParticleNormalized.x + direction.y * toParticleNormalized.y + direction.z * toParticleNormalized.z
    
        -- Calculate angle in degrees
        local angle = math.deg(math.acos(dot))
    
        -- Compare with threshold
        return angle < thresholdAngle

    end
    self.Init = function()
        self.LoadAssets()
        self.ParticleLoop()
        self.SCBALoop()
        self.RegisterEvents()
        self.RegisterCommands()
        self.Started = true
        if GetResourceKvpString("ShowFire") == "true" then
            self.ShowFire = true
        elseif GetResourceKvpString("ShowFire") == "false" then
            self.ShowFire = false
        end
        exports("EnableFireTarget", self.EnableFireTarget)
        exports("DisableFireTarget", self.DisableFireTarget)
        exports("IsFireTargetActive", self.IsFireTargetActive)
    end
    self.LoadAssets = function()
        LoadFxAsset("scr_agencyheistb")
        LoadFxAsset("scr_trevor3")
    end

    self.IsFireTargetActive = function()
        return self.FireTargetEnabled
    end
    
    self.DisableFireTarget = function()
        self.FireTargetEnabled = false
    end
    self.EnableFireTarget = function(damagePerTick, attackFunction)
        if self.FireTargetEnabled then return end
        self.FireTargetEnabled = true
    
        CreateThread(function()
            local spriteDict, sprite = "darts", "dart_reticules"
            local damage = 0
            RequestStreamedTextureDict(spriteDict, false)
            local TOLERANCE = 0.6
    
            while self.FireTargetEnabled do
                local camCoords = GetGameplayCamCoord()
                local camRot = GetGameplayCamRot(2)
    
                local function RotationToDirection(rot)
                    local z = math.rad(rot.z)
                    local x = math.rad(rot.x)
                    local num = math.abs(math.cos(x))
                    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                end
    
                local direction = RotationToDirection(camRot)
                local rayOrigin = camCoords
    
                local closestFireIndex = nil
                local closestflameIndex = nil
                local closestDist = math.huge
                local closestCoords = nil
    
                -- Find closest fire particle along crosshair
                for fireIndex, v in pairs(self.active) do
                    for flameIndex, _v in pairs(v.particles) do
                        local flameCoords = v.flameCoords[flameIndex]
                        if flameCoords then
                            local toFlame = flameCoords - rayOrigin
                            local projLength = direction.x * toFlame.x + direction.y * toFlame.y + direction.z * toFlame.z
                            if projLength > 0 and projLength < 100.0 then
                                local closestPoint = rayOrigin + direction * projLength
                                local distToRay = #(closestPoint - flameCoords)
    
                                if distToRay < TOLERANCE then
                                    local distFromCam = #(rayOrigin - flameCoords)
                                    if distFromCam < closestDist then
                                        closestDist = distFromCam
                                        closestFireIndex = fireIndex
                                        closestflameIndex = flameIndex
                                        closestCoords = flameCoords
                                    end
                                end
                            end
                        end
                    end
                end
    
                -- Run raycast if we found a target
                local hasClearSight = false
                
                if closestCoords then
                    local hit, hitCoords, entityHit
    
                    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
                        rayOrigin.x, rayOrigin.y, rayOrigin.z,
                        closestCoords.x, closestCoords.y, closestCoords.z,
                        -1, -- detect all types
                        PlayerPedId(), 0
                    )
    
                    local result, didHit, _, _, _ = GetShapeTestResult(rayHandle)
                    hasClearSight = didHit == 0 -- no hit means clear LOS
                end
    
                -- Draw sprite based on visibility and attack condition
                if closestCoords and closestFireIndex and closestflameIndex and hasClearSight and attackFunction(closestFireIndex, closestDist) then
                    DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 0, 0, 255)
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if IsControlPressed(0, 70) or IsDisabledControlPressed(1, 24) then
                        if damage < Config.Fire.damageUpdate then
                            damage = damage + damagePerTick
                        elseif damage > 0 then
                            print("[DEBUG] Sending data", 'mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
                            TriggerServerEvent('mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
                            damage = 0
                        end
                    end
                else
                    DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 255, 255, 255)
                end
    
                Wait(0)
            end
        end)
    end
    self.SCBALoop = function()
        CreateThread(function()
            local lastCough = 0
            while true do
                local ped = PlayerPedId()
                local pcoords = GetEntityCoords(ped)
                local now = GetGameTimer()
                local shouldCough = false
                for fireIndex, v in pairs(self.active) do
                    if #(v.particles) ~= 0 then
                        for flameIndex, _v in pairs(v.particles) do
                            local flamePos = v.flameCoords[flameIndex]
                            if flamePos then
                                local dist = #(pcoords - vector3(flamePos.x, flamePos.y, flamePos.z))
                                if dist < 5 and not LocalPlayer.state.SCBAActive then
                                    shouldCough = true
                                    break
                                end
                            end
                        end
                        if shouldCough then break end
                    end
                end
                if shouldCough and (now - lastCough > 10000) then
                    lastCough = now
                    ESX.Streaming.RequestAnimDict("timetable@gardener@smoking_joint", function()
                        TaskPlayAnim(ped, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
                        Wait(1000)
                        SendNUIMessage({
                            PayloadType = "PlayTone",
                            Payload     = {"scba_cough", 0.25}
                        })
                        Wait(2000)
                        TriggerEvent("esx_status:remove", "thirst", 150000)
                        ClearPedTasks(ped)
                    end)
                end
                Wait(1000)
            end
        end)
        
    end

    self.ParticleLoop = function()
        local maxRenderDistance = 100.0
        local maxParticlesCount = 20
        local smokeDict = "scr_agencyheistb"
        local flameDict = "scr_trevor3"
    
        RequestNamedPtfxAsset(smokeDict)
        while not HasNamedPtfxAssetLoaded(smokeDict) do Wait(0) end
    
        RequestNamedPtfxAsset(flameDict)
        while not HasNamedPtfxAssetLoaded(flameDict) do Wait(0) end
    
        Citizen.CreateThread(function()
            while true do
                local s = 10
                local pedCoords = GetEntityCoords(PlayerPedId())
                local flameList = {}
    
                for fireIndex, v in pairs(self.active) do
                    for flameIndex, coords in pairs(v.flameCoords) do
                        local dist = #(coords - pedCoords)
                        table.insert(flameList, {
                            fireIndex = fireIndex,
                            flameIndex = flameIndex,
                            coords = coords,
                            dist = dist
                        })
                    end
                end
    
                table.sort(flameList, function(a, b)
                    return a.dist < b.dist
                end)
    
                for i, flame in ipairs(flameList) do
                    if self.active[flame.fireIndex] then
                        local v = self.active[flame.fireIndex]
                        local coords = flame.coords
                        local dist = flame.dist
                        local flameIndex = flame.flameIndex
    
                        Wait(5)
                        while syncInProgress do Wait(5) end
                        syncInProgress = true
    
                        if not self.ShowFire or dist > maxRenderDistance then
                            if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
                                StopParticleFxLooped(v.particles[flameIndex], 0)
                                v.particles[flameIndex] = nil
                            end
                            if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
                                StopParticleFxLooped(v.flameParticles[flameIndex], 0)
                                v.flameParticles[flameIndex] = nil
                            end
    
                            if v.flames and v.flames[flameIndex] and DoesEntityExist(v.flames[flameIndex]) then
                                RemoveScriptFire(v.flames[flameIndex])
                                v.flames[flameIndex] = nil
                            end
    
                        else
                            local maxHealth = 100
                            local health = v.flameHealth[flameIndex] or maxHealth
                            local maxScale = 0.5
                            local minScale = 0.15
                            local targetScale = math.max((health / maxHealth) * maxScale, minScale)                            
                            if not v.currentScale then v.currentScale = {} end
                            if not v.currentScale[flameIndex] then v.currentScale[flameIndex] = targetScale end
                            
                            v.currentScale[flameIndex] = v.currentScale[flameIndex] + (targetScale - v.currentScale[flameIndex]) * 0.1
                            local scale = v.currentScale[flameIndex]
                            
    
                            if not v.baseCoords then v.baseCoords = {} end
                            if not v.baseCoords[flameIndex] then
                                v.baseCoords[flameIndex] = coords
                            end
                            local baseCoords = v.baseCoords[flameIndex]
                            local dropAmount = (maxHealth - health) / maxHealth * 0.6
    
                            local z_fire = baseCoords.z - 0.8
                            local z_plume = baseCoords.z - dropAmount
    
                            if not v.flames then v.flames = {} end
    
                            if GetNumberOfFiresInRange(baseCoords.x, baseCoords.y, z_fire, 0.3) == 0 or not v.flames[flameIndex] then
                                v.flames[flameIndex] = StartScriptFire(baseCoords.x, baseCoords.y, z_fire, 0, false)
                                v.flameCoords[flameIndex] = vector3(baseCoords.x, baseCoords.y, z_fire)
                            end

    
                            if i <= maxParticlesCount then
                                if not v.particles[flameIndex] or not DoesParticleFxLoopedExist(v.particles[flameIndex]) then
                                    SetPtfxAssetNextCall(smokeDict)
                                    v.particles[flameIndex] = StartParticleFxLoopedAtCoord(
                                        "scr_env_agency3b_smoke",
                                        baseCoords.x, baseCoords.y, baseCoords.z + 1.0,
                                        0.0, 0.0, 0.0,
                                        scale,
                                        false, false, false, false
                                    )
                                else
                                    SetParticleFxLoopedScale(v.particles[flameIndex], scale)
                                end
    
                                if not v.flameParticles[flameIndex] or not DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
                                    SetPtfxAssetNextCall(flameDict)
                                    v.flameParticles[flameIndex] = StartParticleFxLoopedAtCoord(
                                        "scr_trev3_trailer_plume",
                                        baseCoords.x, baseCoords.y, z_plume,
                                        0.0, 0.0, 0.0,
                                        scale,
                                        false, false, false, false
                                    )
                                else
                                    SetParticleFxLoopedScale(v.flameParticles[flameIndex], scale)
                                end
                            else
                                if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
                                    StopParticleFxLooped(v.particles[flameIndex], 0)
                                    v.particles[flameIndex] = nil
                                end
                                if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
                                    StopParticleFxLooped(v.flameParticles[flameIndex], 0)
                                    v.flameParticles[flameIndex] = nil
                                end
                            end
                        end
    
                        syncInProgress = false
                    end
                end
    
                Wait(s)
            end
        end)
    end
    
    self.CreateFlame = function(fireIndex, flameIndex, object)
        if not self.removed[fireIndex] then
            if self.active[fireIndex] == nil then
                self.active[fireIndex] = {
                    flameCoords = {},
                    flames = {},
                    particles = {},
                    flameParticles = {},
                    flameHealth = {}
                }
            end
            self.active[fireIndex].flameCoords[flameIndex] = object.c
            self.active[fireIndex].flameHealth[flameIndex] = object.health
        end
    end

    self.RemoveFlame = function(fireIndex, flameIndex)
        if not (fireIndex and flameIndex and self.active[fireIndex]) then
            return
        end
    
        local fireData = self.active[fireIndex]
        local coords = fireData.flameCoords[flameIndex]
        if not coords then return end
    
        -- usuń ogień
        local tries = 0
        while GetNumberOfFiresInRange(coords.x, coords.y, coords.z, 0.3) > 0 and tries < 20 do
            tries = tries + 1
            StopFireInRange(coords.x, coords.y, coords.z, 0.3 * tries)
            Wait(10)
        end
        fireData.flames[flameIndex] = nil
    
        if fireData.particles[flameIndex] and DoesParticleFxLoopedExist(fireData.particles[flameIndex]) then
            StopParticleFxLooped(fireData.particles[flameIndex], 0)
            fireData.particles[flameIndex] = nil
        end
    
        if fireData.flameParticles[flameIndex] and DoesParticleFxLoopedExist(fireData.flameParticles[flameIndex]) then
            StopParticleFxLooped(fireData.flameParticles[flameIndex], 0)
            fireData.flameParticles[flameIndex] = nil
        end
    
        if fireData.flameCoords then
            fireData.flameCoords[flameIndex] = nil
        end
        if fireData.flameHealth then
            fireData.flameHealth[flameIndex] = nil
        end
        if fireData.baseCoords then
            fireData.baseCoords[flameIndex] = nil
        end
        if fireData.currentScale then
            fireData.currentScale[flameIndex] = nil
        end
    
    
        local hasRemaining = false
        for _, c in pairs(fireData.flameCoords) do
            if c ~= nil then
                hasRemaining = true
                break
            end
        end
        if not hasRemaining then
            self.active[fireIndex] = nil
            self.removed[fireIndex] = true
        end
    end    

    self.Remove = function(fireIndex, callback)
        if not (self.active[fireIndex] and self.active[fireIndex].particles) then
            return
        end
    
        for k, v in pairs(self.active[fireIndex].flameCoords) do
            self.RemoveFlame(fireIndex, k)
            Wait(200)
        end
    
        Citizen.SetTimeout(
            200,
            function()
                if self.active[fireIndex] and next(self.active[fireIndex].flames) ~= nil then
                    self.Remove(fireIndex)
                elseif callback then
                    callback(fireIndex)
                end
            end
        )
    end

    self.RemoveAll = function(callback)
        for k, v in pairs(self.active) do
            self.Remove(k)
            Wait(20)
        end
    
        self.active = {}
        self.removed = {}
        
        if callback then
            callback()
        end
    end

    self.RemoveAllFires = function()
        while syncInProgress do
            Wait(10)
        end
        syncInProgress = true
        self.RemoveAll(
            function()
                syncInProgress = false
            end
        )
    end

    self.ERemoveFlame = function(fireIndex, flameIndex)
        while syncInProgress do
			Wait(10)
		end
		syncInProgress = true
		self.RemoveFlame(fireIndex, flameIndex)
		syncInProgress = false
    end

    self.ECreateFlame = function(fireIndex, flameIndex, object)
        while syncInProgress do
			Wait(10)
		end
		syncInProgress = true
		self.CreateFlame(fireIndex, flameIndex, object)
		syncInProgress = false
    end

    self.ERemoveFire = function(fireIndex)
        while syncInProgress do
			Wait(10)
		end
		syncInProgress = true
		self.Remove(fireIndex)
		syncInProgress = false
    end

    self.SynchronizeFlames = function(fires)
        syncInProgress = true
        local coords = GetEntityCoords(PlayerPedId())
        StopFireInRange(coords.x, coords.y, coords.z, 100)
        RemoveParticleFxInRange(coords.x, coords.y, coords.z, 100)
		self.RemoveAll(
			function()
				for k, v in pairs(fires) do
					for _k, _v in ipairs(v) do
						self.CreateFlame(k, _k, _v)
					end
				end
				syncInProgress = false
			end
		)
    end

    self.RegisterEvents = function()
        RegisterNetEvent("mrg_firefighter:modules:fires:remove:fire", function(fireIndex)
            self.ERemoveFire(fireIndex)
        end)
        RegisterNetEvent("mrg_firefighter:modules:fires:remove:flame", function(fireIndex, flameIndex)
            self.ERemoveFlame(fireIndex, flameIndex)
        end)
        RegisterNetEvent("mrg_firefighter:modules:fires:remove:all", function(fireIndex, flameIndex)
            self.RemoveAllFires()
        end)
        RegisterNetEvent("mrg_firefighter:modules:fires:create:flame", function(fireIndex, flameIndex, object)
            self.ECreateFlame(fireIndex, flameIndex, object)
        end)
        RegisterNetEvent("mrg_firefighter:modules:fires:synchronize", function(fires)
            self.SynchronizeFlames(fires)
        end)
        RegisterNetEvent("mrg_firefighter:modules:fires:synchronize:flame", function(fireIndex, flameIndex, flamedata)
            self.active[fireIndex].flameHealth[flameIndex] = flamedata.health
        end)
        RegisterNetEvent("esx:playerLoaded", function(fires)
            TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
        end)
    end
    self.ExtinguisherCheck = function() 
        local ped = PlayerPedId()
        local found, hash = GetCurrentPedWeapon(ped, 1)
        if found and hash == Config.Fire.damages.extinguisher.hash then 
            self.EnableFireTarget(Config.Fire.damages.extinguisher.damage, function(index, dist)
                local ped = PlayerPedId()
                if dist < Config.Fire.damages.extinguisher.range then return true end 
            end)
            CreateThread(function() 
                while self.FireTargetEnabled do 
                    local ped = PlayerPedId()
                    local found, hash = GetCurrentPedWeapon(ped, 1)
                    if (not found or hash ~= Config.Fire.damages.extinguisher.hash) then
                        self.DisableFireTarget()
                        break
                    end
                    Wait(0)
                end
            end)
            return true
        end
    end
    self.TruckCheck = function() 
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if DoesEntityExist(vehicle) then
            local model = GetEntityArchetypeName(vehicle)
            if Config.Fire.damages.truck[model] then
                self.EnableFireTarget(Config.Fire.damages.truck[model].damage, function(index, dist)
                    return dist < Config.Fire.damages.truck[model].range
                end)
                CreateThread(function() 
                    while self.FireTargetEnabled do 
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        local found = false
                        local driving = (DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped)
                        if driving then
                            local model = GetEntityArchetypeName(vehicle)
                            if Config.Fire.damages.truck[model] then
                                found = true
                            end
                        end
                        if (not found or not driving) then
                            self.DisableFireTarget()
                            break
                        end
                        Wait(0)
                    end
                end)
                return true
            end
        end
    end
    self.RegisterCommands = function()
        RegisterCommand("request", function()
            TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
        end)
        RegisterCommand("togglefires", function()
            self.ShowFire = not self.ShowFire
            SetResourceKvp("ShowFire", tostring(self.ShowFire))
        end)
        RegisterCommand('registerscenario', function(source, args, rawCommand)
            local coords = nil
            local desc = args[1]

            local x = tonumber(args[2])
            local y = tonumber(args[3])
            local z = tonumber(args[4])

            if x and y and z then
                coords = vector3(x, y, z)
            end

            TriggerServerEvent('mrg_firefighter:modules:fires:register:scenario', coords or GetEntityCoords(PlayerPedId()), desc)
        end, false)
        
        RegisterCommand('addflame', function(source, args, rawCommand)
                local scenarioID = tonumber(args[1])
                local spread = tonumber(args[2])
                local chance = tonumber(args[3])

                local coords = nil

                local x = tonumber(args[4])
                local y = tonumber(args[5])
                local z = tonumber(args[6])

                if x and y and z then
                    coords = vector3(x, y, z)
                end

                if scenarioID and spread and chance then
                    TriggerServerEvent('mrg_firefighter:modules:fires:add:flame', scenarioID, coords or GetEntityCoords(PlayerPedId()), spread, chance)
                end
        end, false)

        Citizen.CreateThread(function()
            while true do
                Wait(1000)
                if not self.FireTargetEnabled then 
                    if self.ExtinguisherCheck() then
                    elseif self.TruckCheck() then
                    end
                end
            end
        end)
    end

    return self
end

-- Fire = function()
--     local self = {}
--     self.moduleName = "fire"
--     self.Started = false
--     self.active = {}
--     self.removed = {}
--     self.ShowFire = true
--     self.FireTargetEnabled = false

--     self.Translate = function(key)
--         return locale('server.modules.'..self.moduleName.."."..key)
--     end

--     self.IsLookingAt = function(particleCoords, thresholdAngle)
--         local playerPed = PlayerPedId()
--         local camRot = GetGameplayCamRot(2)
--         local camCoords = GetGameplayCamCoord()
--         local function rotationToDirection(rot)
--             local z = math.rad(rot.z)
--             local x = math.rad(rot.x)
--             local num = math.abs(math.cos(x))
    
--             return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
--         end

--         local direction = rotationToDirection(camRot)
--         local toParticle = vector3(particleCoords.x - camCoords.x, particleCoords.y - camCoords.y, particleCoords.z - camCoords.z)
--         local toParticleNormalized = toParticle / #(toParticle)
    
--         -- Get dot product between camera direction and direction to particle
--         local dot = direction.x * toParticleNormalized.x + direction.y * toParticleNormalized.y + direction.z * toParticleNormalized.z
    
--         -- Calculate angle in degrees
--         local angle = math.deg(math.acos(dot))
    
--         -- Compare with threshold
--         return angle < thresholdAngle

--     end
--     self.Init = function()
--         self.LoadAssets()
--         -- self.ParticleLoop()
--         self.ParticleLoop2()
--         self.SCBALoop()
--         self.RegisterEvents()
--         self.RegisterCommands()
--         self.Started = true
--         if GetResourceKvpString("ShowFire") == "true" then
--             self.ShowFire = true
--         elseif GetResourceKvpString("ShowFire") == "false" then
--             self.ShowFire = false
--         end
--         exports("EnableFireTarget", self.EnableFireTarget)
--         exports("DisableFireTarget", self.DisableFireTarget)
--         exports("IsFireTargetActive", self.IsFireTargetActive)
--     end
--     self.LoadAssets = function()
--         LoadFxAsset("scr_agencyheistb")
--         LoadFxAsset("scr_trevor3")
--     end

--     self.IsFireTargetActive = function()
--         return self.FireTargetEnabled
--     end
    
--     self.DisableFireTarget = function()
--         self.FireTargetEnabled = false
--     end
--     self.EnableFireTarget = function(damagePerTick, attackFunction)
--         if self.FireTargetEnabled then return end
--         self.FireTargetEnabled = true
    
--         CreateThread(function()
--             local spriteDict, sprite = "darts", "dart_reticules"
--             local damage = 0
--             RequestStreamedTextureDict(spriteDict, false)
--             local TOLERANCE = 0.6
    
--             while self.FireTargetEnabled do
--                 local camCoords = GetGameplayCamCoord()
--                 local camRot = GetGameplayCamRot(2)
    
--                 local function RotationToDirection(rot)
--                     local z = math.rad(rot.z)
--                     local x = math.rad(rot.x)
--                     local num = math.abs(math.cos(x))
--                     return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
--                 end
    
--                 local direction = RotationToDirection(camRot)
--                 local rayOrigin = camCoords
    
--                 local closestFireIndex = nil
--                 local closestflameIndex = nil
--                 local closestDist = math.huge
--                 local closestCoords = nil
    
--                 -- Find closest fire particle along crosshair
--                 for fireIndex, v in pairs(self.active) do
--                     for flameIndex, _v in pairs(v.particles) do
--                         local flameCoords = v.flameCoords[flameIndex]
--                         if flameCoords then
--                             local toFlame = flameCoords - rayOrigin
--                             local projLength = direction.x * toFlame.x + direction.y * toFlame.y + direction.z * toFlame.z
--                             if projLength > 0 and projLength < 100.0 then
--                                 local closestPoint = rayOrigin + direction * projLength
--                                 local distToRay = #(closestPoint - flameCoords)
    
--                                 if distToRay < TOLERANCE then
--                                     local distFromCam = #(rayOrigin - flameCoords)
--                                     if distFromCam < closestDist then
--                                         closestDist = distFromCam
--                                         closestFireIndex = fireIndex
--                                         closestflameIndex = flameIndex
--                                         closestCoords = flameCoords
--                                     end
--                                 end
--                             end
--                         end
--                     end
--                 end
    
--                 -- Run raycast if we found a target
--                 local hasClearSight = false
                
--                 if closestCoords then
--                     local hit, hitCoords, entityHit
    
--                     local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
--                         rayOrigin.x, rayOrigin.y, rayOrigin.z,
--                         closestCoords.x, closestCoords.y, closestCoords.z,
--                         -1, -- detect all types
--                         PlayerPedId(), 0
--                     )
    
--                     local result, didHit, _, _, _ = GetShapeTestResult(rayHandle)
--                     hasClearSight = didHit == 0 -- no hit means clear LOS
--                 end
    
--                 -- Draw sprite based on visibility and attack condition
--                 if closestCoords and closestFireIndex and closestflameIndex and hasClearSight and attackFunction(closestFireIndex, closestDist) then
--                     DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 0, 0, 255)
--                     local vehicle = GetVehiclePedIsIn(ped, false)
--                     if IsControlPressed(0, 70) or IsDisabledControlPressed(1, 24) then
--                         if damage < Config.Fire.damageUpdate then
--                             damage = damage + damagePerTick
--                         elseif damage > 0 then
--                             print("[DEBUG] Sending data", 'mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
--                             TriggerServerEvent('mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
--                             damage = 0
--                         end
--                     end
--                 else
--                     DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 255, 255, 255)
--                 end
    
--                 Wait(0)
--             end
--         end)
--     end
--     self.SCBALoop = function()
--         CreateThread(function()
--             local lastCough = 0
--             while true do
--                 local ped = PlayerPedId()
--                 local pcoords = GetEntityCoords(ped)
--                 local now = GetGameTimer()
--                 local shouldCough = false
--                 for fireIndex, v in pairs(self.active) do
--                     if #(v.particles) ~= 0 then
--                         for flameIndex, _v in pairs(v.particles) do
--                             local flamePos = v.flameCoords[flameIndex]
--                             if flamePos then
--                                 local dist = #(pcoords - vector3(flamePos.x, flamePos.y, flamePos.z))
--                                 if dist < 5 and not LocalPlayer.state.SCBAActive then
--                                     shouldCough = true
--                                     break
--                                 end
--                             end
--                         end
--                         if shouldCough then break end
--                     end
--                 end
--                 if shouldCough and (now - lastCough > 10000) then
--                     lastCough = now
--                     ESX.Streaming.RequestAnimDict("timetable@gardener@smoking_joint", function()
--                         TaskPlayAnim(ped, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
--                         Wait(1000)
--                         SendNUIMessage({
--                             PayloadType = "PlayTone",
--                             Payload     = {"scba_cough", 0.25}
--                         })
--                         Wait(2000)
--                         TriggerEvent("esx_status:remove", "thirst", 150000)
--                         ClearPedTasks(ped)
--                     end)
--                 end
--                 Wait(1000)
--             end
--         end)
        
--     end
--     self.ParticleLoop = function()
--         Citizen.CreateThread(function()
--             while true do
--                 local s = 1500
--                 for fireIndex, v in pairs(self.active) do
--                     if #(v.particles) ~= 0 then
--                         for flameIndex, _v in pairs(v.particles) do
--                             if v.flameCoords[flameIndex] ~= nil then
--                                 local isFirePresent = GetNumberOfFiresInRange(
--                                     v.flameCoords[flameIndex].x,
--                                     v.flameCoords[flameIndex].y,
--                                     v.flameCoords[flameIndex].z,
--                                     0.05
--                                 )
--                                 if isFirePresent == 0 then
--                                     self.active[fireIndex].flames[flameIndex] = StartScriptFire(v.flameCoords[flameIndex].x, v.flameCoords[flameIndex].y, v.flameCoords[flameIndex].z, 0, false)
--                                 end
--                             end
--                         end
--                     end
--                 end

--                 Wait(s)
--             end
--         end)
--     end
--     self.RefreshFlameParticles = function(fireIndex, flameIndex)
--         if self.ShowFire then
--             local fireData = self.active[fireIndex]
--             if not fireData then return end
--             local coords = fireData.flameCoords[flameIndex]
--             if not coords then return end
        
--             -- Remove old particles if they exist
--             if fireData.particles[flameIndex] and fireData.particles[flameIndex] ~= 0 then
--                 StopParticleFxLooped(fireData.particles[flameIndex], false)
--                 RemoveParticleFx(fireData.particles[flameIndex], true)
--                 fireData.particles[flameIndex] = nil
--             end
--             if fireData.flameParticles[flameIndex] and fireData.flameParticles[flameIndex] ~= 0 then
--                 StopParticleFxLooped(fireData.flameParticles[flameIndex], false)
--                 RemoveParticleFx(fireData.flameParticles[flameIndex], true)
--                 fireData.flameParticles[flameIndex] = nil
--             end
        
--             local maxHealth = 100
--             local health = self.active[fireIndex].flameHealth[flameIndex] or maxHealth
--             local maxScale = 0.6
            
--             local scale = (health / maxHealth) * maxScale
            
--             -- For plume Z: start at coords.z for full health, then lower based on missing health
--             local maxOffset = 0.8 -- Full height offset when health is 100
--             local offsetPlume = (health / maxHealth) * maxOffset
--             local adjustedZ = coords.z + offsetPlume

--             SetPtfxAssetNextCall("scr_agencyheistb")
            
--             self.active[fireIndex].particles[flameIndex] = StartParticleFxLoopedAtCoord(
--                 "scr_env_agency3b_smoke",
--                 self.active[fireIndex].flameCoords[flameIndex].x,
--                 self.active[fireIndex].flameCoords[flameIndex].y,
--                 self.active[fireIndex].flameCoords[flameIndex].z + 1.0,
--                 0.0,
--                 0.0,
--                 0.0,
--                 scale,
--                 false,
--                 false,
--                 false,
--                 false
--             )
        
--             SetPtfxAssetNextCall("scr_trevor3")
        
--             self.active[fireIndex].flameParticles[flameIndex] = StartParticleFxLoopedAtCoord(
--                 "scr_trev3_trailer_plume",
--                 self.active[fireIndex].flameCoords[flameIndex].x,
--                 self.active[fireIndex].flameCoords[flameIndex].y,
--                 adjustedZ,
--                 0.0,
--                 0.0,
--                 0.0,
--                 scale,
--                 false,
--                 false,
--                 false,
--                 false
--             )
--         end
--     end
--     self.ParticleLoop2 = function()
--         local maxRenderDistance = 100.0
--         local maxParticlesCount = 20
--         local smokeDict = "scr_agencyheistb"
--         local flameDict = "scr_trevor3"
    
--         RequestNamedPtfxAsset(smokeDict)
--         while not HasNamedPtfxAssetLoaded(smokeDict) do Wait(0) end
    
--         RequestNamedPtfxAsset(flameDict)
--         while not HasNamedPtfxAssetLoaded(flameDict) do Wait(0) end
    
--         Citizen.CreateThread(function()
--             while true do
--                 local s = 10
--                 local pedCoords = GetEntityCoords(PlayerPedId())
--                 local flameList = {}
    
--                 -- Krok 1: zbierz wszystkie płomienie z dystansem
--                 for fireIndex, v in pairs(self.active) do
--                     for flameIndex, coords in pairs(v.flameCoords) do
--                         local dist = #(coords - pedCoords)
--                         table.insert(flameList, {
--                             fireIndex = fireIndex,
--                             flameIndex = flameIndex,
--                             coords = coords,
--                             dist = dist
--                         })
--                     end
--                 end
    
--                 table.sort(flameList, function(a, b)
--                     return a.dist < b.dist
--                 end)
    
--                 -- Krok 3: iteracja po posortowanej liście
--                 for i, flame in ipairs(flameList) do
--                     if self.active[flame.fireIndex] then
--                         local v = self.active[flame.fireIndex]
--                         local coords = flame.coords
--                         local dist = flame.dist
--                         local flameIndex = flame.flameIndex
        
--                         Wait(5)
--                         while syncInProgress do Wait(5) end
--                         syncInProgress = true
        
--                         if not self.ShowFire or dist > maxRenderDistance then
--                             -- usuń particles
--                             if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
--                                 StopParticleFxLooped(v.particles[flameIndex], 0)
--                                 v.particles[flameIndex] = nil
--                             end
--                             if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
--                                 StopParticleFxLooped(v.flameParticles[flameIndex], 0)
--                                 v.flameParticles[flameIndex] = nil
--                             end
        
--                             -- usuń ogień
--                             local fireCount = GetNumberOfFiresInRange(coords.x, coords.y, coords.z, 0.05)
--                             if fireCount > 0 then
--                                 RemoveScriptFire(v.flames[flameIndex] or 0)
--                             end
--                             v.flames[flameIndex] = nil
        
--                         else
--                             local maxHealth = 100
--                             local health = v.flameHealth[flameIndex] or maxHealth
--                             local maxScale = 0.5
--                             local minScale = 0.15
--                             local scale = math.max((health / maxHealth) * maxScale, minScale)
        
--                             if not v.baseCoords then v.baseCoords = {} end
--                             if not v.baseCoords[flameIndex] then
--                                 v.baseCoords[flameIndex] = coords
--                             end
        
--                             local baseCoords = v.baseCoords[flameIndex]
--                             local dropAmount = (maxHealth - health) / maxHealth * 0.6
        
--                             local z_fire = baseCoords.z - 0.8
--                             local z_plume = baseCoords.z - dropAmount
        
--                             -- ogień (spawn zawsze, jeśli blisko)
--                             local isFirePresent = GetNumberOfFiresInRange(baseCoords.x, baseCoords.y, z_fire, 0.05)
--                             if isFirePresent == 0 then
--                                 v.flames[flameIndex] = StartScriptFire(baseCoords.x, baseCoords.y, z_fire, 0, false)
--                                 v.flameCoords[flameIndex] = vector3(baseCoords.x, baseCoords.y, z_fire)
--                                 Wait(10)
--                             end
        
--                             -- dym + duży płomień tylko dla pierwszych 20
--                             if i <= maxParticlesCount then
--                                 if not v.particles[flameIndex] or not DoesParticleFxLoopedExist(v.particles[flameIndex]) then
--                                     SetPtfxAssetNextCall(smokeDict)
--                                     v.particles[flameIndex] = StartParticleFxLoopedAtCoord(
--                                         "scr_env_agency3b_smoke",
--                                         baseCoords.x, baseCoords.y, baseCoords.z + 1.0,
--                                         0.0, 0.0, 0.0,
--                                         scale,
--                                         false, false, false, false
--                                     )
--                                 end
        
--                                 if not v.flameParticles[flameIndex] or not DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
--                                     SetPtfxAssetNextCall(flameDict)
--                                     v.flameParticles[flameIndex] = StartParticleFxLoopedAtCoord(
--                                         "scr_trev3_trailer_plume",
--                                         baseCoords.x, baseCoords.y, z_plume,
--                                         0.0, 0.0, 0.0,
--                                         scale,
--                                         false, false, false, false
--                                     )
--                                 end
--                             else
--                                 -- usuń dym i duży płomień dla dalszych
--                                 if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
--                                     StopParticleFxLooped(v.particles[flameIndex], 0)
--                                     v.particles[flameIndex] = nil
--                                 end
--                                 if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
--                                     StopParticleFxLooped(v.flameParticles[flameIndex], 0)
--                                     v.flameParticles[flameIndex] = nil
--                                 end
--                             end
--                         end
--                     end
    
--                     syncInProgress = false
--                 end
    
--                 Wait(s)
--             end
--         end)
--     end    
    
    
    
--     self.CreateFlame = function(fireIndex, flameIndex, object)
--         if not self.removed[fireIndex] then
--             if self.active[fireIndex] == nil then
--                 self.active[fireIndex] = {
--                     flameCoords = {},
--                     flames = {},
--                     particles = {},
--                     flameParticles = {},
--                     flameHealth = {}
--                 }
--             end
--             self.active[fireIndex].flameCoords[flameIndex] = object.c
--             self.active[fireIndex].flameHealth[flameIndex] = object.health
--         end
--     end

    
--     self.RemoveFlame = function(fireIndex, flameIndex)
--         if not (fireIndex and flameIndex and self.active[fireIndex]) then
--             return
--         end
    
--         local fireData = self.active[fireIndex]
--         local coords = fireData.flameCoords[flameIndex]

--         Wait(10)
--         local deletetries = 0
--         -- usuń ogień
--         while GetNumberOfFiresInRange(
--             coords.x,
--             coords.y,
--             coords.z,
--             0.1
--         ) > 0 and deletetries < 20 do
--             deletetries = deletetries+1 
--             print("Fire Exists")
--             StopFireInRange(coords.x, coords.y, coords.z, 0.1 * deletetries)
--             Wait(10)
--         end
--         deletetries = 0
--         fireData.flames[flameIndex] = nil
--         Wait(10)
--         while DoesParticleFxLoopedExist(fireData.particles[flameIndex]) and deletetries < 20 do
--             deletetries = deletetries+1 
--             print("Particles Exists")
--             StopParticleFxLooped(fireData.particles[flameIndex])
--             RemoveParticleFxInRange(coords.x, coords.y, coords.z, 0.15* deletetries)
--             Wait(1)
--         end
--         deletetries = 0
--         fireData.particles[flameIndex] = nil
--         Wait(10)
--         while DoesParticleFxLoopedExist(fireData.flameParticles[flameIndex]) and deletetries < 20 do
--             deletetries = deletetries+1 
--             print("Flame Particles Exists")
--             StopParticleFxLooped(fireData.flameParticles[flameIndex])
--             RemoveParticleFxInRange(coords.x, coords.y, coords.z, 0.15* deletetries)
--             Wait(10)
--         end
--         deletetries = 0
--         fireData.flameParticles[flameIndex] = nil
    
--         -- usuń zapisane koordy
--         fireData.flameCoords[flameIndex] = nil
--         print("Deleted", flameIndex)
--         self.active[fireIndex] = nil
--         self.removed[fireIndex] = true
--     end     

--     self.Remove = function(fireIndex, callback)
--         if not (self.active[fireIndex] and self.active[fireIndex].particles) then
--             return
--         end
    
--         for k, v in pairs(self.active[fireIndex].flameCoords) do
--             self.RemoveFlame(fireIndex, k)
--             Wait(200)
--         end
    
--         Citizen.SetTimeout(
--             200,
--             function()
--                 if self.active[fireIndex] and next(self.active[fireIndex].flames) ~= nil then
--                     self.Remove(fireIndex)
--                 elseif callback then
--                     callback(fireIndex)
--                 end
--             end
--         )
--     end

--     self.RemoveAll = function(callback)
--         for k, v in pairs(self.active) do
--             self.Remove(k)
--             Wait(20)
--         end
    
--         self.active = {}
--         self.removed = {}
        
--         if callback then
--             callback()
--         end
--     end

--     self.RemoveAllFires = function()
--         while syncInProgress do
--             Wait(10)
--         end
--         syncInProgress = true
--         self.RemoveAll(
--             function()
--                 syncInProgress = false
--             end
--         )
--     end

--     self.ERemoveFlame = function(fireIndex, flameIndex)
--         while syncInProgress do
-- 			Wait(10)
-- 		end
-- 		syncInProgress = true
-- 		self.RemoveFlame(fireIndex, flameIndex)
-- 		syncInProgress = false
--     end

--     self.ECreateFlame = function(fireIndex, flameIndex, object)
--         while syncInProgress do
-- 			Wait(10)
-- 		end
-- 		syncInProgress = true
-- 		self.CreateFlame(fireIndex, flameIndex, object)
-- 		syncInProgress = false
--     end

--     self.ERemoveFire = function(fireIndex)
--         while syncInProgress do
-- 			Wait(10)
-- 		end
-- 		syncInProgress = true
-- 		self.Remove(fireIndex)
-- 		syncInProgress = false
--     end

--     self.SynchronizeFlames = function(fires)
--         syncInProgress = true
--         local coords = GetEntityCoords(PlayerPedId())
--         StopFireInRange(coords.x, coords.y, coords.z, 100)
--         RemoveParticleFxInRange(coords.x, coords.y, coords.z, 100)
-- 		self.RemoveAll(
-- 			function()
-- 				for k, v in pairs(fires) do
-- 					for _k, _v in ipairs(v) do
-- 						self.CreateFlame(k, _k, _v)
-- 					end
-- 				end
-- 				syncInProgress = false
-- 			end
-- 		)
--     end

--     self.RegisterEvents = function()
--         RegisterNetEvent("mrg_firefighter:modules:fires:remove:fire", function(fireIndex)
--             self.ERemoveFire(fireIndex)
--         end)
--         RegisterNetEvent("mrg_firefighter:modules:fires:remove:flame", function(fireIndex, flameIndex)
--             self.ERemoveFlame(fireIndex, flameIndex)
--         end)
--         RegisterNetEvent("mrg_firefighter:modules:fires:remove:all", function(fireIndex, flameIndex)
--             self.RemoveAllFires()
--         end)
--         RegisterNetEvent("mrg_firefighter:modules:fires:create:flame", function(fireIndex, flameIndex, object)
--             self.ECreateFlame(fireIndex, flameIndex, object)
--         end)
--         RegisterNetEvent("mrg_firefighter:modules:fires:synchronize", function(fires)
--             self.SynchronizeFlames(fires)
--         end)
--         RegisterNetEvent("mrg_firefighter:modules:fires:synchronize:flame", function(fireIndex, flameIndex, flamedata)
--             self.active[fireIndex].flameHealth[flameIndex] = flamedata.health
--             self.RefreshFlameParticles(fireIndex, flameIndex)
--         end)
--         RegisterNetEvent("esx:playerLoaded", function(fires)
--             TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
--         end)
--     end
--     self.ExtinguisherCheck = function() 
--         local ped = PlayerPedId()
--         local found, hash = GetCurrentPedWeapon(ped, 1)
--         if found and hash == Config.Fire.damages.extinguisher.hash then 
--             self.EnableFireTarget(Config.Fire.damages.extinguisher.damage, function(index, dist)
--                 local ped = PlayerPedId()
--                 if dist < Config.Fire.damages.extinguisher.range then return true end 
--             end)
--             CreateThread(function() 
--                 while self.FireTargetEnabled do 
--                     local ped = PlayerPedId()
--                     local found, hash = GetCurrentPedWeapon(ped, 1)
--                     if (not found or hash ~= Config.Fire.damages.extinguisher.hash) then
--                         self.DisableFireTarget()
--                         break
--                     end
--                     Wait(0)
--                 end
--             end)
--             return true
--         end
--     end
--     self.TruckCheck = function() 
--         local ped = PlayerPedId()
--         local vehicle = GetVehiclePedIsIn(ped, false)
--         if DoesEntityExist(vehicle) then
--             local model = GetEntityArchetypeName(vehicle)
--             if Config.Fire.damages.truck[model] then
--                 self.EnableFireTarget(Config.Fire.damages.truck[model].damage, function(index, dist)
--                     return dist < Config.Fire.damages.truck[model].range
--                 end)
--                 CreateThread(function() 
--                     while self.FireTargetEnabled do 
--                         local ped = PlayerPedId()
--                         local vehicle = GetVehiclePedIsIn(ped, false)
--                         local found = false
--                         local driving = (DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped)
--                         if driving then
--                             local model = GetEntityArchetypeName(vehicle)
--                             if Config.Fire.damages.truck[model] then
--                                 found = true
--                             end
--                         end
--                         if (not found or not driving) then
--                             self.DisableFireTarget()
--                             break
--                         end
--                         Wait(0)
--                     end
--                 end)
--                 return true
--             end
--         end
--     end
--     self.RegisterCommands = function()
--         RegisterCommand("request", function()
--             TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
--         end)
--         RegisterCommand("togglefires", function()
--             self.ShowFire = not self.ShowFire
--             SetResourceKvp("ShowFire", tostring(self.ShowFire))
--         end)
--         RegisterCommand('registerscenario', function(source, args, rawCommand)
--             local coords = nil
--             local desc = args[1]

--             local x = tonumber(args[2])
--             local y = tonumber(args[3])
--             local z = tonumber(args[4])

--             if x and y and z then
--                 coords = vector3(x, y, z)
--             end

--             TriggerServerEvent('mrg_firefighter:modules:fires:register:scenario', coords or GetEntityCoords(PlayerPedId()), desc)
--         end, false)
        
--         RegisterCommand('addflame', function(source, args, rawCommand)
--                 local scenarioID = tonumber(args[1])
--                 local spread = tonumber(args[2])
--                 local chance = tonumber(args[3])

--                 local coords = nil

--                 local x = tonumber(args[4])
--                 local y = tonumber(args[5])
--                 local z = tonumber(args[6])

--                 if x and y and z then
--                     coords = vector3(x, y, z)
--                 end

--                 if scenarioID and spread and chance then
--                     TriggerServerEvent('mrg_firefighter:modules:fires:add:flame', scenarioID, coords or GetEntityCoords(PlayerPedId()), spread, chance)
--                 end
--         end, false)

--         Citizen.CreateThread(function()
--             while true do
--                 Wait(1000)
--                 if not self.FireTargetEnabled then 
--                     if self.ExtinguisherCheck() then
--                     elseif self.TruckCheck() then
--                     end
--                 end
--             end
--         end)
--     end

--     return self
-- end

-- -- Fire = function()
-- --     local self = {}
-- --     self.moduleName = "fire"
-- --     self.Started = false
-- --     self.active = {}
-- --     self.removed = {}
-- --     self.ShowFire = true
-- --     self.FireTargetEnabled = false

-- --     self.Translate = function(key)
-- --         return locale('server.modules.'..self.moduleName.."."..key)
-- --     end

-- --     self.IsLookingAt = function(particleCoords, thresholdAngle)
-- --         local playerPed = PlayerPedId()
-- --         local camRot = GetGameplayCamRot(2)
-- --         local camCoords = GetGameplayCamCoord()
-- --         local function rotationToDirection(rot)
-- --             local z = math.rad(rot.z)
-- --             local x = math.rad(rot.x)
-- --             local num = math.abs(math.cos(x))
    
-- --             return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
-- --         end

-- --         local direction = rotationToDirection(camRot)
-- --         local toParticle = vector3(particleCoords.x - camCoords.x, particleCoords.y - camCoords.y, particleCoords.z - camCoords.z)
-- --         local toParticleNormalized = toParticle / #(toParticle)
    
-- --         -- Get dot product between camera direction and direction to particle
-- --         local dot = direction.x * toParticleNormalized.x + direction.y * toParticleNormalized.y + direction.z * toParticleNormalized.z
    
-- --         -- Calculate angle in degrees
-- --         local angle = math.deg(math.acos(dot))
    
-- --         -- Compare with threshold
-- --         return angle < thresholdAngle

-- --     end
-- --     self.Init = function()
-- --         self.LoadAssets()
-- --         self.ParticleLoop()
-- --         self.ParticleLoop2()
-- --         self.SCBALoop()
-- --         self.RegisterEvents()
-- --         self.RegisterCommands()
-- --         self.Started = true
-- --         if GetResourceKvpString("ShowFire") == "true" then
-- --             self.ShowFire = true
-- --         elseif GetResourceKvpString("ShowFire") == "false" then
-- --             self.ShowFire = false
-- --         end
-- --         exports("EnableFireTarget", self.EnableFireTarget)
-- --         exports("DisableFireTarget", self.DisableFireTarget)
-- --         exports("IsFireTargetActive", self.IsFireTargetActive)
-- --     end
-- --     self.LoadAssets = function()
-- --         LoadFxAsset("scr_agencyheistb")
-- --         LoadFxAsset("scr_trevor3")
-- --     end

-- --     self.IsFireTargetActive = function()
-- --         return self.FireTargetEnabled
-- --     end
    
-- --     self.DisableFireTarget = function()
-- --         self.FireTargetEnabled = false
-- --     end
-- --     self.EnableFireTarget = function(damagePerTick, attackFunction)
-- --         if self.FireTargetEnabled then return end
-- --         self.FireTargetEnabled = true
    
-- --         CreateThread(function()
-- --             local spriteDict, sprite = "darts", "dart_reticules"
-- --             local damage = 0
-- --             RequestStreamedTextureDict(spriteDict, false)
-- --             local TOLERANCE = 0.6
    
-- --             while self.FireTargetEnabled do
-- --                 local camCoords = GetGameplayCamCoord()
-- --                 local camRot = GetGameplayCamRot(2)
    
-- --                 local function RotationToDirection(rot)
-- --                     local z = math.rad(rot.z)
-- --                     local x = math.rad(rot.x)
-- --                     local num = math.abs(math.cos(x))
-- --                     return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
-- --                 end
    
-- --                 local direction = RotationToDirection(camRot)
-- --                 local rayOrigin = camCoords
    
-- --                 local closestFireIndex = nil
-- --                 local closestflameIndex = nil
-- --                 local closestDist = math.huge
-- --                 local closestCoords = nil
    
-- --                 -- Find closest fire particle along crosshair
-- --                 for fireIndex, v in pairs(self.active) do
-- --                     for flameIndex, _v in pairs(v.particles) do
-- --                         local flameCoords = v.flameCoords[flameIndex]
-- --                         if flameCoords then
-- --                             local toFlame = flameCoords - rayOrigin
-- --                             local projLength = direction.x * toFlame.x + direction.y * toFlame.y + direction.z * toFlame.z
-- --                             if projLength > 0 and projLength < 100.0 then
-- --                                 local closestPoint = rayOrigin + direction * projLength
-- --                                 local distToRay = #(closestPoint - flameCoords)
    
-- --                                 if distToRay < TOLERANCE then
-- --                                     local distFromCam = #(rayOrigin - flameCoords)
-- --                                     if distFromCam < closestDist then
-- --                                         closestDist = distFromCam
-- --                                         closestFireIndex = fireIndex
-- --                                         closestflameIndex = flameIndex
-- --                                         closestCoords = flameCoords
-- --                                     end
-- --                                 end
-- --                             end
-- --                         end
-- --                     end
-- --                 end
    
-- --                 -- Run raycast if we found a target
-- --                 local hasClearSight = false
                
-- --                 if closestCoords then
-- --                     local hit, hitCoords, entityHit
    
-- --                     local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
-- --                         rayOrigin.x, rayOrigin.y, rayOrigin.z,
-- --                         closestCoords.x, closestCoords.y, closestCoords.z,
-- --                         -1, -- detect all types
-- --                         PlayerPedId(), 0
-- --                     )
    
-- --                     local result, didHit, _, _, _ = GetShapeTestResult(rayHandle)
-- --                     hasClearSight = didHit == 0 -- no hit means clear LOS
-- --                 end
    
-- --                 -- Draw sprite based on visibility and attack condition
-- --                 if closestCoords and closestFireIndex and closestflameIndex and hasClearSight and attackFunction(closestFireIndex, closestDist) then
-- --                     DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 0, 0, 255)
-- --                     local vehicle = GetVehiclePedIsIn(ped, false)
-- --                     if IsControlPressed(0, 70) or IsDisabledControlPressed(1, 24) then
-- --                         if damage < Config.Fire.damageUpdate then
-- --                             damage = damage + damagePerTick
-- --                         elseif damage > 0 then
-- --                             print("[DEBUG] Sending data", 'mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
-- --                             TriggerServerEvent('mrg_firefighter:modules:fires:attack', closestFireIndex, closestflameIndex, damage)
-- --                             damage = 0
-- --                         end
-- --                     end
-- --                 else
-- --                     DrawSprite(spriteDict, sprite, 0.5, 0.5, 0.015, 0.025, 180.0, 255, 255, 255, 255)
-- --                 end
    
-- --                 Wait(0)
-- --             end
-- --         end)
-- --     end
-- --     self.SCBALoop = function()
-- --         CreateThread(function()
-- --             local lastCough = 0
-- --             while true do
-- --                 local ped = PlayerPedId()
-- --                 local pcoords = GetEntityCoords(ped)
-- --                 local now = GetGameTimer()
-- --                 local shouldCough = false
-- --                 for fireIndex, v in pairs(self.active) do
-- --                     if #(v.particles) ~= 0 then
-- --                         for flameIndex, _v in pairs(v.particles) do
-- --                             local flamePos = v.flameCoords[flameIndex]
-- --                             if flamePos then
-- --                                 local dist = #(pcoords - vector3(flamePos.x, flamePos.y, flamePos.z))
-- --                                 if dist < 5 and not LocalPlayer.state.SCBAActive then
-- --                                     shouldCough = true
-- --                                     break
-- --                                 end
-- --                             end
-- --                         end
-- --                         if shouldCough then break end
-- --                     end
-- --                 end
-- --                 if shouldCough and (now - lastCough > 10000) then
-- --                     lastCough = now
-- --                     ESX.Streaming.RequestAnimDict("timetable@gardener@smoking_joint", function()
-- --                         TaskPlayAnim(ped, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
-- --                         Wait(1000)
-- --                         SendNUIMessage({
-- --                             PayloadType = "PlayTone",
-- --                             Payload     = {"scba_cough", 0.25}
-- --                         })
-- --                         Wait(2000)
-- --                         TriggerEvent("esx_status:remove", "thirst", 150000)
-- --                         ClearPedTasks(ped)
-- --                     end)
-- --                 end
-- --                 Wait(1000)
-- --             end
-- --         end)
        
-- --     end
-- --     self.ParticleLoop = function()
-- --         Citizen.CreateThread(function()
-- --             while true do
-- --                 local s = 1500
-- --                 for fireIndex, v in pairs(self.active) do
-- --                     if #(v.particles) ~= 0 then
-- --                         for flameIndex, _v in pairs(v.particles) do
-- --                             if v.flameCoords[flameIndex] ~= nil then
-- --                                 local isFirePresent = GetNumberOfFiresInRange(
-- --                                     v.flameCoords[flameIndex].x,
-- --                                     v.flameCoords[flameIndex].y,
-- --                                     v.flameCoords[flameIndex].z,
-- --                                     0.05
-- --                                 )
-- --                                 if isFirePresent == 0 then
-- --                                     self.active[fireIndex].flames[flameIndex] = StartScriptFire(v.flameCoords[flameIndex].x, v.flameCoords[flameIndex].y, v.flameCoords[flameIndex].z, 0, false)
-- --                                 end
-- --                             end
-- --                         end
-- --                     end
-- --                 end

-- --                 Wait(s)
-- --             end
-- --         end)
-- --     end
-- --     self.RefreshFlameParticles = function(fireIndex, flameIndex)
-- --         if self.ShowFire then
-- --             local fireData = self.active[fireIndex]
-- --             if not fireData then return end
-- --             local coords = fireData.flameCoords[flameIndex]
-- --             if not coords then return end
        
-- --             -- Remove old particles if they exist
-- --             if fireData.particles[flameIndex] and fireData.particles[flameIndex] ~= 0 then
-- --                 StopParticleFxLooped(fireData.particles[flameIndex], false)
-- --                 RemoveParticleFx(fireData.particles[flameIndex], true)
-- --                 fireData.particles[flameIndex] = nil
-- --             end
-- --             if fireData.flameParticles[flameIndex] and fireData.flameParticles[flameIndex] ~= 0 then
-- --                 StopParticleFxLooped(fireData.flameParticles[flameIndex], false)
-- --                 RemoveParticleFx(fireData.flameParticles[flameIndex], true)
-- --                 fireData.flameParticles[flameIndex] = nil
-- --             end
        
-- --             local maxHealth = 100
-- --             local health = self.active[fireIndex].flameHealth[flameIndex] or maxHealth
-- --             local maxScale = 0.6
            
-- --             local scale = (health / maxHealth) * maxScale
            
-- --             -- For plume Z: start at coords.z for full health, then lower based on missing health
-- --             local maxOffset = 0.8 -- Full height offset when health is 100
-- --             local offsetPlume = (health / maxHealth) * maxOffset
-- --             local adjustedZ = coords.z + offsetPlume

-- --             SetPtfxAssetNextCall("scr_agencyheistb")
            
-- --             self.active[fireIndex].particles[flameIndex] = StartParticleFxLoopedAtCoord(
-- --                 "scr_env_agency3b_smoke",
-- --                 self.active[fireIndex].flameCoords[flameIndex].x,
-- --                 self.active[fireIndex].flameCoords[flameIndex].y,
-- --                 self.active[fireIndex].flameCoords[flameIndex].z + 1.0,
-- --                 0.0,
-- --                 0.0,
-- --                 0.0,
-- --                 scale,
-- --                 false,
-- --                 false,
-- --                 false,
-- --                 false
-- --             )
        
-- --             SetPtfxAssetNextCall("scr_trevor3")
        
-- --             self.active[fireIndex].flameParticles[flameIndex] = StartParticleFxLoopedAtCoord(
-- --                 "scr_trev3_trailer_plume",
-- --                 self.active[fireIndex].flameCoords[flameIndex].x,
-- --                 self.active[fireIndex].flameCoords[flameIndex].y,
-- --                 adjustedZ,
-- --                 0.0,
-- --                 0.0,
-- --                 0.0,
-- --                 scale,
-- --                 false,
-- --                 false,
-- --                 false,
-- --                 false
-- --             )
-- --         end
-- --     end
-- --     self.ParticleLoop2 = function()
-- --         local maxRenderDistance = 100.0
-- --         local maxParticlesCount = 20
-- --         local smokeDict = "scr_agencyheistb"
-- --         local flameDict = "scr_trevor3"
    
-- --         RequestNamedPtfxAsset(smokeDict)
-- --         while not HasNamedPtfxAssetLoaded(smokeDict) do Wait(0) end
    
-- --         RequestNamedPtfxAsset(flameDict)
-- --         while not HasNamedPtfxAssetLoaded(flameDict) do Wait(0) end
    
-- --         Citizen.CreateThread(function()
-- --             while true do
-- --                 local s = 10
-- --                 local pedCoords = GetEntityCoords(PlayerPedId())
-- --                 local flameList = {}
    
-- --                 -- Krok 1: zbierz wszystkie płomienie z dystansem
-- --                 for fireIndex, v in pairs(self.active) do
-- --                     for flameIndex, coords in pairs(v.flameCoords) do
-- --                         local dist = #(coords - pedCoords)
-- --                         table.insert(flameList, {
-- --                             fireIndex = fireIndex,
-- --                             flameIndex = flameIndex,
-- --                             coords = coords,
-- --                             dist = dist
-- --                         })
-- --                     end
-- --                 end
    
-- --                 table.sort(flameList, function(a, b)
-- --                     return a.dist < b.dist
-- --                 end)
    
-- --                 -- Krok 3: iteracja po posortowanej liście
-- --                 for i, flame in ipairs(flameList) do
-- --                     if self.active[flame.fireIndex] then
-- --                         local v = self.active[flame.fireIndex]
-- --                         local coords = flame.coords
-- --                         local dist = flame.dist
-- --                         local flameIndex = flame.flameIndex
        
-- --                         Wait(5)
-- --                         while syncInProgress do Wait(5) end
-- --                         syncInProgress = true
        
-- --                         if not self.ShowFire or dist > maxRenderDistance then
-- --                             -- usuń particles
-- --                             if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
-- --                                 StopParticleFxLooped(v.particles[flameIndex], 0)
-- --                                 v.particles[flameIndex] = nil
-- --                             end
-- --                             if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
-- --                                 StopParticleFxLooped(v.flameParticles[flameIndex], 0)
-- --                                 v.flameParticles[flameIndex] = nil
-- --                             end
        
-- --                             -- usuń ogień
-- --                             local fireCount = GetNumberOfFiresInRange(coords.x, coords.y, coords.z, 0.05)
-- --                             if fireCount > 0 then
-- --                                 RemoveScriptFire(v.flames[flameIndex] or 0)
-- --                             end
-- --                             v.flames[flameIndex] = nil
        
-- --                         else
-- --                             local maxHealth = 100
-- --                             local health = v.flameHealth[flameIndex] or maxHealth
-- --                             local maxScale = 0.5
-- --                             local minScale = 0.15
-- --                             local scale = math.max((health / maxHealth) * maxScale, minScale)
        
-- --                             if not v.baseCoords then v.baseCoords = {} end
-- --                             if not v.baseCoords[flameIndex] then
-- --                                 v.baseCoords[flameIndex] = coords
-- --                             end
        
-- --                             local baseCoords = v.baseCoords[flameIndex]
-- --                             local dropAmount = (maxHealth - health) / maxHealth * 0.6
        
-- --                             local z_fire = baseCoords.z - 0.8
-- --                             local z_plume = baseCoords.z - dropAmount
        
-- --                             -- ogień (spawn zawsze, jeśli blisko)
-- --                             local isFirePresent = GetNumberOfFiresInRange(baseCoords.x, baseCoords.y, z_fire, 0.05)
-- --                             if isFirePresent == 0 then
-- --                                 v.flames[flameIndex] = StartScriptFire(baseCoords.x, baseCoords.y, z_fire, 0, false)
-- --                                 v.flameCoords[flameIndex] = vector3(baseCoords.x, baseCoords.y, z_fire)
-- --                                 Wait(10)
-- --                             end
        
-- --                             -- dym + duży płomień tylko dla pierwszych 20
-- --                             if i <= maxParticlesCount then
-- --                                 if not v.particles[flameIndex] or not DoesParticleFxLoopedExist(v.particles[flameIndex]) then
-- --                                     SetPtfxAssetNextCall(smokeDict)
-- --                                     v.particles[flameIndex] = StartParticleFxLoopedAtCoord(
-- --                                         "scr_env_agency3b_smoke",
-- --                                         baseCoords.x, baseCoords.y, baseCoords.z + 1.0,
-- --                                         0.0, 0.0, 0.0,
-- --                                         scale,
-- --                                         false, false, false, false
-- --                                     )
-- --                                 end
        
-- --                                 if not v.flameParticles[flameIndex] or not DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
-- --                                     SetPtfxAssetNextCall(flameDict)
-- --                                     v.flameParticles[flameIndex] = StartParticleFxLoopedAtCoord(
-- --                                         "scr_trev3_trailer_plume",
-- --                                         baseCoords.x, baseCoords.y, z_plume,
-- --                                         0.0, 0.0, 0.0,
-- --                                         scale,
-- --                                         false, false, false, false
-- --                                     )
-- --                                 end
-- --                             else
-- --                                 -- usuń dym i duży płomień dla dalszych
-- --                                 if v.particles[flameIndex] and DoesParticleFxLoopedExist(v.particles[flameIndex]) then
-- --                                     StopParticleFxLooped(v.particles[flameIndex], 0)
-- --                                     v.particles[flameIndex] = nil
-- --                                 end
-- --                                 if v.flameParticles[flameIndex] and DoesParticleFxLoopedExist(v.flameParticles[flameIndex]) then
-- --                                     StopParticleFxLooped(v.flameParticles[flameIndex], 0)
-- --                                     v.flameParticles[flameIndex] = nil
-- --                                 end
-- --                             end
-- --                         end
-- --                     end
    
-- --                     syncInProgress = false
-- --                 end
    
-- --                 Wait(s)
-- --             end
-- --         end)
-- --     end    
    
    
    
-- --     self.CreateFlame = function(fireIndex, flameIndex, object)
-- --         if not self.removed[fireIndex] then
-- --             if self.active[fireIndex] == nil then
-- --                 self.active[fireIndex] = {
-- --                     flameCoords = {},
-- --                     flames = {},
-- --                     particles = {},
-- --                     flameParticles = {},
-- --                     flameHealth = {}
-- --                 }
-- --             end
-- --             self.active[fireIndex].flameCoords[flameIndex] = object.c
-- --             self.active[fireIndex].flameHealth[flameIndex] = object.health
-- --         end
-- --     end

-- --     self.RemoveFlame = function(fireIndex, flameIndex)
-- --         if not (fireIndex and flameIndex and self.active[fireIndex]) then
-- --             return
-- --         end
    
-- --         local fireData = self.active[fireIndex]
-- --         local coords = fireData.flameCoords[flameIndex]
    
-- --         -- 🔥 helper do usuwania ognia z retry
-- --         local function tryRemoveFire(fireHandle, tries)
-- --             if tries <= 0 then return end
-- --             local fireCount = coords and GetNumberOfFiresInRange(coords.x, coords.y, coords.z, 0.2) or 0
-- --             if fireHandle and fireCount > 0 then
-- --                 RemoveScriptFire(fireHandle)
-- --                 Citizen.SetTimeout(500, function()
-- --                     tryRemoveFire(fireHandle, tries - 1)
-- --                 end)
-- --             end
-- --         end
    
-- --         -- ✨ helper do usuwania particle z retry
-- --         local function tryRemoveParticle(particleHandle, tries)
-- --             if tries <= 0 then return end
-- --             if particleHandle and DoesParticleFxLoopedExist(particleHandle) then
-- --                 StopParticleFxLooped(particleHandle, false)
-- --                 RemoveParticleFx(particleHandle, true)
-- --                 Citizen.SetTimeout(500, function()
-- --                     tryRemoveParticle(particleHandle, tries - 1)
-- --                 end)
-- --             end
-- --         end
    
-- --         -- usuń ogień
-- --         if fireData.flames[flameIndex] and fireData.flames[flameIndex] > -1 then
-- --             tryRemoveFire(fireData.flames[flameIndex], 15) -- max 15 prób
-- --             fireData.flames[flameIndex] = nil
-- --         end
    
-- --         -- usuń particles
-- --         if fireData.particles[flameIndex] and fireData.particles[flameIndex] ~= 0 then
-- --             tryRemoveParticle(fireData.particles[flameIndex], 15)
-- --             fireData.particles[flameIndex] = nil
-- --         end
    
-- --         -- usuń flameParticles
-- --         if fireData.flameParticles[flameIndex] and fireData.flameParticles[flameIndex] ~= 0 then
-- --             tryRemoveParticle(fireData.flameParticles[flameIndex], 15)
-- --             fireData.flameParticles[flameIndex] = nil
-- --         end
    
-- --         -- usuń zapisane koordy
-- --         fireData.flameCoords[flameIndex] = nil
    
-- --         -- sprawdź po chwili czy w tym indeksie coś jeszcze zostało
-- --         Citizen.SetTimeout(8000, function()
-- --             local fireCount = coords and GetNumberOfFiresInRange(coords.x, coords.y, coords.z, 1.0) or 0
-- --             if fireCount == 0
-- --             and (not next(fireData.flames))
-- --             and (not next(fireData.particles))
-- --             and (not next(fireData.flameParticles)) then
-- --                 self.active[fireIndex] = nil
-- --                 self.removed[fireIndex] = true
-- --             end
-- --         end)
-- --     end    

-- --     self.Remove = function(fireIndex, callback)
-- --         if not (self.active[fireIndex] and self.active[fireIndex].particles) then
-- --             return
-- --         end
    
-- --         for k, v in pairs(self.active[fireIndex].flameCoords) do
-- --             self.RemoveFlame(fireIndex, k)
-- --             Wait(20)
-- --         end
    
-- --         Citizen.SetTimeout(
-- --             200,
-- --             function()
-- --                 if self.active[fireIndex] and next(self.active[fireIndex].flames) ~= nil then
-- --                     self.Remove(fireIndex)
-- --                 elseif callback then
-- --                     callback(fireIndex)
-- --                 end
-- --             end
-- --         )
-- --     end

-- --     self.RemoveAll = function(callback)
-- --         for k, v in pairs(self.active) do
-- --             self.Remove(k)
-- --             Wait(20)
-- --         end
    
-- --         self.active = {}
-- --         self.removed = {}
        
-- --         if callback then
-- --             callback()
-- --         end
-- --     end

-- --     self.RemoveAllFires = function()
-- --         while syncInProgress do
-- --             Wait(10)
-- --         end
-- --         syncInProgress = true
-- --         self.RemoveAll(
-- --             function()
-- --                 syncInProgress = false
-- --             end
-- --         )
-- --     end

-- --     self.ERemoveFlame = function(fireIndex, flameIndex)
-- --         while syncInProgress do
-- -- 			Wait(10)
-- -- 		end
-- -- 		syncInProgress = true
-- -- 		self.RemoveFlame(fireIndex, flameIndex)
-- -- 		syncInProgress = false
-- --     end

-- --     self.ECreateFlame = function(fireIndex, flameIndex, object)
-- --         while syncInProgress do
-- -- 			Wait(10)
-- -- 		end
-- -- 		syncInProgress = true
-- -- 		self.CreateFlame(fireIndex, flameIndex, object)
-- -- 		syncInProgress = false
-- --     end

-- --     self.ERemoveFire = function(fireIndex)
-- --         while syncInProgress do
-- -- 			Wait(10)
-- -- 		end
-- -- 		syncInProgress = true
-- -- 		self.Remove(fireIndex)
-- -- 		syncInProgress = false
-- --     end

-- --     self.SynchronizeFlames = function(fires)
-- --         syncInProgress = true
-- -- 		self.RemoveAll(
-- -- 			function()
-- -- 				for k, v in pairs(fires) do
-- -- 					for _k, _v in ipairs(v) do
-- -- 						self.CreateFlame(k, _k, _v)
-- -- 					end
-- -- 				end
-- -- 				syncInProgress = false
-- -- 			end
-- -- 		)
-- --     end

-- --     self.RegisterEvents = function()
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:remove:fire", function(fireIndex)
-- --             self.ERemoveFire(fireIndex)
-- --         end)
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:remove:flame", function(fireIndex, flameIndex)
-- --             self.ERemoveFlame(fireIndex, flameIndex)
-- --         end)
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:remove:all", function(fireIndex, flameIndex)
-- --             self.RemoveAllFires()
-- --         end)
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:create:flame", function(fireIndex, flameIndex, object)
-- --             self.ECreateFlame(fireIndex, flameIndex, object)
-- --         end)
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:synchronize", function(fires)
-- --             self.SynchronizeFlames(fires)
-- --         end)
-- --         RegisterNetEvent("mrg_firefighter:modules:fires:synchronize:flame", function(fireIndex, flameIndex, flamedata)
-- --             self.active[fireIndex].flameHealth[flameIndex] = flamedata.health
-- --             self.RefreshFlameParticles(fireIndex, flameIndex)
-- --         end)
-- --         RegisterNetEvent("esx:playerLoaded", function(fires)
-- --             TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
-- --         end)
-- --     end
-- --     self.ExtinguisherCheck = function() 
-- --         local ped = PlayerPedId()
-- --         local found, hash = GetCurrentPedWeapon(ped, 1)
-- --         if found and hash == Config.Fire.damages.extinguisher.hash then 
-- --             self.EnableFireTarget(Config.Fire.damages.extinguisher.damage, function(index, dist)
-- --                 local ped = PlayerPedId()
-- --                 if dist < Config.Fire.damages.extinguisher.range then return true end 
-- --             end)
-- --             CreateThread(function() 
-- --                 while self.FireTargetEnabled do 
-- --                     local ped = PlayerPedId()
-- --                     local found, hash = GetCurrentPedWeapon(ped, 1)
-- --                     if (not found or hash ~= Config.Fire.damages.extinguisher.hash) then
-- --                         self.DisableFireTarget()
-- --                         break
-- --                     end
-- --                     Wait(0)
-- --                 end
-- --             end)
-- --             return true
-- --         end
-- --     end
-- --     self.TruckCheck = function() 
-- --         local ped = PlayerPedId()
-- --         local vehicle = GetVehiclePedIsIn(ped, false)
-- --         if DoesEntityExist(vehicle) then
-- --             local model = GetEntityArchetypeName(vehicle)
-- --             if Config.Fire.damages.truck[model] then
-- --                 self.EnableFireTarget(Config.Fire.damages.truck[model].damage, function(index, dist)
-- --                     return dist < Config.Fire.damages.truck[model].range
-- --                 end)
-- --                 CreateThread(function() 
-- --                     while self.FireTargetEnabled do 
-- --                         local ped = PlayerPedId()
-- --                         local vehicle = GetVehiclePedIsIn(ped, false)
-- --                         local found = false
-- --                         local driving = (DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped)
-- --                         if driving then
-- --                             local model = GetEntityArchetypeName(vehicle)
-- --                             if Config.Fire.damages.truck[model] then
-- --                                 found = true
-- --                             end
-- --                         end
-- --                         if (not found or not driving) then
-- --                             self.DisableFireTarget()
-- --                             break
-- --                         end
-- --                         Wait(0)
-- --                     end
-- --                 end)
-- --                 return true
-- --             end
-- --         end
-- --     end
-- --     self.RegisterCommands = function()
-- --         RegisterCommand("request", function()
-- --             TriggerServerEvent("mrg_firefighter:modules:fires:synchronize:request")
-- --         end)
-- --         RegisterCommand("togglefires", function()
-- --             self.ShowFire = not self.ShowFire
-- --             SetResourceKvp("ShowFire", tostring(self.ShowFire))
-- --         end)
-- --         RegisterCommand('registerscenario', function(source, args, rawCommand)
-- --             local coords = nil
-- --             local desc = args[1]

-- --             local x = tonumber(args[2])
-- --             local y = tonumber(args[3])
-- --             local z = tonumber(args[4])

-- --             if x and y and z then
-- --                 coords = vector3(x, y, z)
-- --             end

-- --             TriggerServerEvent('mrg_firefighter:modules:fires:register:scenario', coords or GetEntityCoords(PlayerPedId()), desc)
-- --         end, false)
        
-- --         RegisterCommand('addflame', function(source, args, rawCommand)
-- --                 local scenarioID = tonumber(args[1])
-- --                 local spread = tonumber(args[2])
-- --                 local chance = tonumber(args[3])

-- --                 local coords = nil

-- --                 local x = tonumber(args[4])
-- --                 local y = tonumber(args[5])
-- --                 local z = tonumber(args[6])

-- --                 if x and y and z then
-- --                     coords = vector3(x, y, z)
-- --                 end

-- --                 if scenarioID and spread and chance then
-- --                     TriggerServerEvent('mrg_firefighter:modules:fires:add:flame', scenarioID, coords or GetEntityCoords(PlayerPedId()), spread, chance)
-- --                 end
-- --         end, false)

-- --         Citizen.CreateThread(function()
-- --             while true do
-- --                 Wait(1000)
-- --                 if not self.FireTargetEnabled then 
-- --                     if self.ExtinguisherCheck() then
-- --                     elseif self.TruckCheck() then
-- --                     end
-- --                 end
-- --             end
-- --         end)
-- --     end

-- --     return self
-- -- end