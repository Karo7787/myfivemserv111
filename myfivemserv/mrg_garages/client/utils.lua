local utils = {}
local Config = lib.require('config')

Citizen.CreateThread(function()
    Wait(1)
    for id, data in pairs(Config.Garages) do
      data.hideblip = data.hideblip or false
      if not data.hideblip then
        local blip = AddBlipForCoord(data.coords)
        SetBlipSprite (blip, Config.GarageSprites[data.type or "car"])
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.6)
        SetBlipColour (blip, Config.GarageBlipColor)
        SetBlipAsShortRange(blip, true)		
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("<font size= '13'>"..Config.GarageNames[data.type or "car"].."</font>" )
        EndTextCommandSetBlipName(blip)
        Config.Garages[id].blip = blip
      end
      local box = lib.zones.box({
        coords = data.coords,
        size = data.size,
        rotation = data.rotation or 0.0,
        debug = Config.Debug,
        onEnter = function(self)
          utils.garageId = id
        end,
        onExit = function(self)
          utils.garageId = nil
          utils.SendReactMessage('Hide', {})
        end
      })
      Config.Garages[id].zone = box
    end

    for id, data in pairs(Config.Impounds) do
      local blip2 = AddBlipForCoord(data.coords)
      SetBlipSprite (blip2, 466)
      SetBlipDisplay(blip2, 4)
      SetBlipScale  (blip2, 1.0)
      SetBlipColour (blip2, Config.ImpoundBlipColor)
      SetBlipAsShortRange(blip2, true)		
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("<font  size= '11'>Odholownik Pojazdów</font>" )
      EndTextCommandSetBlipName(blip2)
      modelHash = GetHashKey('a_m_m_ktown_01')
      RequestModel(modelHash)
      while not HasModelLoaded(modelHash) do
        Wait(1)
      end
      local npc = CreatePed(1, 'a_m_m_ktown_01', data.coords.x, data.coords.y, data.coords.z - 1, data.coords.w, false, false)
      FreezeEntityPosition(npc, true)
      SetBlockingOfNonTemporaryEvents(npc, true)
      SetEntityHealth(npc, 9999999999999)
      SetEntityCanBeDamaged(npc, false)
  
      exports['qtarget']:AddTargetEntity(npc, {
        options = {
          {
            label = 'Odholuj pojazd',
            icon = 'fas fa-car',
            action = function()
              OpenGarages()
            end
          }
        },
        distance = 2
      })
      local box = lib.zones.box({
        coords = data.coords,
        size = data.size,
        rotation = data.rotation or 0.0,
        debug = Config.Debug,
        onEnter = function(self)
          utils.inImpound = true
        end,
        onExit = function(self)
          utils.inImpound = false
        end
      })
    end
end)

AddGarage = function(id, data)
  if Config.Garages[id] then
    return false, "garage exits"
  end
  data.hideblip = data.hideblip or false
  Config.Garages[id] = data
  if not data.hideblip then
    local blip = AddBlipForCoord(data.coords)
    SetBlipSprite (blip, Config.GarageSprites[data.type or "car"])
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, Config.GarageBlipColor)
    SetBlipAsShortRange(blip, true)		
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("<font size= '13'>"..Config.GarageNames[data.type or "car"].."</font>" )
    EndTextCommandSetBlipName(blip)
    
    Config.Garages[id].blip = blip
  end
  local box = lib.zones.box({
    coords = data.coords,
    size = data.size,
    rotation = data.rotation or 0.0,
    debug = Config.Debug,
    onEnter = function(self)
      utils.garageId = id
    end,
    onExit = function(self)
      utils.garageId = nil
      utils.SendReactMessage('Hide', {})
    end
  })
  Config.Garages[id].zone = box

	return true, data
end

exports("AddGarage", AddGarage)

RemoveGarage = function(id)
  if Config.Garages[id] then
    RemoveBlip(Config.Garages[id].blip)
    Config.Garages[id].zone:remove()
    Config.Garages[id] = nil
    return true
  end
	return false, "garage not found"
end

exports("RemoveGarage", RemoveGarage)

inGarageZone = function()
	return utils.garageId ~= nil
end

exports("inGarageZone", inGarageZone)


utils.getFreeSpawnPoint = function(garageId)
   local garageData = Config.Garages[garageId]
   if not garageId or not garageData then
      return
   end

   local coords = GetEntityCoords(cache.ped)
   local closestSpawn, closestDist = nil, nil
   for i = 1, #garageData.points do
      local point = garageData.points[i]
      local dist = #(vector3(coords.xyz) - vector3(point.xyz))
      if closestDist then
        if dist < closestDist and ESX.Game.IsSpawnPointClear(vector3(point.xyz), 1.5) then
          closestDist = dist
          closestSpawn = i
        end
      else
        if ESX.Game.IsSpawnPointClear(vector3(point.xyz), 1.5) then
          closestDist = dist
          closestSpawn = i
        end
      end
   end

   return closestSpawn
end

utils.SendReactMessage = function(action, data)
    SendNUIMessage({
       action = action,
       data = data
    })
end

utils.toggleNuiFrame = function(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    DisableFire = shouldShow
    SetNuiFocusKeepInput(shouldShow)
    utils.SendReactMessage('setVisible', shouldShow)
end

return utils