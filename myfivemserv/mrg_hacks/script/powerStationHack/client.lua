local activeTasks = 0

RegisterNUICallback('powerStationHack/taskCancel', function(data, cb)
    closeGui()
    activeTasks = 2
end)

RegisterNUICallback('powerStationHack/taskEnd', function(data, cb)
    closeNormalGui()
    activeTasks = 3
end)
  

function OpenGui()
    guiEnabled = true
    SetNuiFocus(guiEnabled, true)
    SendScriptMessage("powerStationHack", {
        action = "start"
    })
end

function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
end

function closeNormalGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled, false)
end
  
function startHack()
    Wait(100)
    local playerPed = PlayerPedId()
    if taskInProcess then
        return 0
    end
    taskInProcess = true
    OpenGui()
    
    activeTasks = 1
    while activeTasks == 1 do
        Citizen.Wait(1)
    end

    if activeTasks == 2 then
        closeGui()
        taskInProcess = false
        return 0
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
end

exports("powerStationHack_startHack", startHack)
