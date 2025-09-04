RegisterNuiCallback("fetchRadioData", function(data, cb)
    local radiodata = lib.callback.await('piotreq_gpt:getRadioData', false)
    cb(radiodata)
end)

RegisterNuiCallback("getNationality", function(data, cb)
    local nationality = lib.callback.await('piotreq_gpt:getNationality', false, data.identifier)
    cb(nationality)
end)