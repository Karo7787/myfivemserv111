exports("squidcard", function(item, data)
    SendNUIMessage({
        action = "newnumber",
        number = data["metadata"]["message"],
    })
    SendNUIMessage({
        action = "show"
    })
    SetNuiFocus(true, true)
end)


RegisterNUICallback("closeCard",function(data, cb)
    SetNuiFocus(false, false)
end)