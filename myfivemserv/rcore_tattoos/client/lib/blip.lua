Blips = {}

---@param name string
---@param blip number
---@param coords vector3
---@param options table
---@return number
function createBlip(name, blip, coords, options)
    local x, y, z = table.unpack(coords)

    if options ~= nil and isTable(options) and not table.isEmpty(options) then
        options = table.merge(Config.DefaultBlipOptions, options)
    else
        options = Config.DefaultBlipOptions
    end

    if blip == -1 then
        return
    end

    local ourBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip, blip)
    SetBlipDisplay(ourBlip, options.type)
    SetBlipScale(ourBlip, options.scale)
    SetBlipColour(ourBlip, options.color)
    SetBlipAsShortRange(ourBlip, options.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    Blips[ourBlip] = ourBlip
    return ourBlip
end

function removeBlip(id)
    if DoesBlipExist(Blips[id]) then
        RemoveBlip(Blips[id])
        dbg.debug('Deleted blip %s', id)
    end
end

---@param instance number
---@return nil|number
function getBlip(instance)
    if Blips[instance] ~= nil then
        return Blips[instance]
    end
    return nil
end

---@return table
function getBlips()
    return Blips
end
