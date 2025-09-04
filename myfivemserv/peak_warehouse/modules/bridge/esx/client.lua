local bridge = {}
local ESX = exports.es_extended:getSharedObject()

function bridge.hasPlayerLoaded()
    return ESX.PlayerLoaded
end

return bridge