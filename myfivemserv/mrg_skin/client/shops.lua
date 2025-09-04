local function convert(options)
    local distance = options.distance
    options = options.options
    for _, v in pairs(options) do
        v.onSelect = v.action
        v.distance = v.distance or distance
        v.name = v.name or v.label
        v.groups = v.job or v.gang
        v.type = nil
        v.action = nil

        v.job = nil
        v.gang = nil
        v.qtarget = true
    end

    return options
end

function AddTargetEntity(entity, parameters)
    exports["ox_target"]:addLocalEntity(entity, convert(parameters))
end
local function CreatePedAtCoords(pedModel, coords, scenario)
    pedModel = type(pedModel) == "string" and joaat(pedModel) or pedModel
    lib.requestModel(pedModel)
    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z - 0.98, coords.w, false, false)
    TaskStartScenarioInPlace(ped, scenario, true)
    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    return ped
end

local Peds = {}
Citizen.CreateThread(function()
    for k, v in pairs(Config.Shops.Coords) do
        local shoptype = Config.Shops.Types[v.type]
        local parameters = {
            options = {{
                type = "client",
                action = function()
                    openShop(shoptype.openmenu)
                end,
                icon = shoptype.icon,
                label = shoptype.label
            }},
            distance = 2.0,
        }
        if shoptype.accessoutfits then
            table.insert(parameters.options, {
                type = "client",
                action = function()
                    OpenOutfitMenu()
                end,
                icon = shoptype.icon,
                label = _L("OUTFITS")
            })
        end
        if v.blip ~= false then
            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, shoptype.blip.sprite)
            SetBlipColour(blip, shoptype.blip.color)
            SetBlipScale(blip, shoptype.blip.scale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(shoptype.label)
            EndTextCommandSetBlipName(blip)
        end
        Peds[k] = CreatePedAtCoords(shoptype.ped, v.coords, shoptype.scenario)
        AddTargetEntity(Peds[k], parameters)
    end
end)