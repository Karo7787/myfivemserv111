ActiveCallbacks = {}
CallbackId = 0

function TriggerServerCallback(callbackName, ...)
    CallbackId += 1
    local callbackId = CallbackId
    ActiveCallbacks[tostring(callbackId)] = promise.new()
    TriggerServerEvent(("%s:callback_s:%s"):format(GetCurrentResourceName(), callbackName), callbackId, ...)
    return table.unpack(Citizen.Await(ActiveCallbacks[tostring(callbackId)]))
end

RegisterNetEvent(("%s:callback_s:return"):format(GetCurrentResourceName()), function(callbackId, ...)
    if(not ActiveCallbacks[tostring(callbackId)]) then return end
    ActiveCallbacks[tostring(callbackId)]:resolve({...})
    ActiveCallbacks[tostring(callbackId)] = nil
end)

EventHandlers = {}
ClientCallbacks = {}

function RegisterClientCallback(callbackName, cb)
    ClientCallbacks[callbackName] = cb
    if(EventHandlers[callbackName]) then
        print("Overwriting callback: "..callbackName)
        RemoveEventHandler(EventHandlers[callbackName])
    end
    EventHandlers[callbackName] = RegisterNetEvent(("%s:callback_c:%s"):format(GetCurrentResourceName(), callbackName), function(callbackId, ...)
        TriggerServerEvent(("%s:callback_c:return"):format(GetCurrentResourceName()), callbackId, ClientCallbacks[callbackName](...))
    end)
end
