local utils = {}

--- @param message string
--- @param type string
function utils.notify(message, type)
    lib.notify({ 
        description = message, 
        type = type 
    })
end

function utils.thermiteMinigame()
    return exports["np_minigames"]:Terminal(4, 2, 10, 30, 4)

end

function utils.laptopMinigame()
    local success = exports.bl_ui:PathFind(1, {
        numberOfNodes = 10,
        duration = 10000,
    })

    return success
end


return utils