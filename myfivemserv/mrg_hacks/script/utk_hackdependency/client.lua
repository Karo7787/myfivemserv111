RegisterNetEvent("utk_hack:playSound")
AddEventHandler("utk_hack:playSound", function(name)
    SendScriptMessage("utk_hackdependency", {
        transactionType = name
    })
end)