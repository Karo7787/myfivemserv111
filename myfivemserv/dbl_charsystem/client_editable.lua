RegisterNUICallback("MulticharacterReady", function(data, cb)
    -- exports["mrg_loadingscreen"]:close()
    cb("ok")
end)

RegisterNUICallback("disablepeds", function()
    TriggerEvent("mrg_skin:characters:hidepeds")
end)