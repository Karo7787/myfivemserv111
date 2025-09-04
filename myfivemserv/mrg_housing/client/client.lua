ESX = exports["es_extended"]:getSharedObject();
PlayerData = nil
local loaded = false

local function createProperty(property)
    if not PlayerData then
        PlayerData = ESX.GetPlayerData()
    end
    if not PropertiesTable[property.property_id] then
	    PropertiesTable[property.property_id] = Property:new(property)
    end
end
RegisterNetEvent('mrg_housing:client:addProperty', createProperty)

RegisterNetEvent('mrg_housing:client:hideScreen', function(val)
    if val then
        DoScreenFadeOut(0)
    else
        DoScreenFadeIn(500)
    end
end)

RegisterNetEvent('mrg_housing:client:removeProperty', function (property_id)
	local property = Property.Get(property_id)

	if property then
		property:RemoveProperty(true)
	end

	PropertiesTable[property_id] = nil
end)

-- Citizen.CreateThread(function()
--     TriggerServerEvent("mrg_housing:server:createNewApartment", "Integrity Way")
-- end)

function InitialiseProperties(properties)
    if loaded then return end
    Debug("Initialising properties")
    PlayerData = ESX.GetPlayerData()

    for k, v in pairs(Config.Apartments) do
        ApartmentsTable[k] = Apartment:new(v)
    end

	if not properties then
    	properties = lib.callback.await('mrg_housing:server:requestProperties')
	end
    for k, v in pairs(properties) do
        createProperty(v.propertyData)
    end

    TriggerEvent("mrg_housing:client:initialisedProperties")

    Debug("Initialised properties")
    loaded = true
end
RegisterNetEvent("esx:playerLoaded", function()
    PlayerData = ESX.GetPlayerData()
    InitialiseProperties()
end)

Citizen.CreateThread(function()
    if ESX.IsPlayerLoaded() then
        PlayerData = ESX.GetPlayerData()
        InitialiseProperties()
    end
end)

RegisterNetEvent('mrg_housing:client:initialiseProperties', InitialiseProperties)

if GetResourceState('qbx_properties') == 'started' then
    local data = {}
    for k, v in pairs(Config.Apartments) do
        data[#data +1] = {
            label = v.label,
            description = 'Luxury Apartments!',
            enter = vec3(v.door.x, v.door.y, v.door.z),
            id = k
        }
    end
    TriggerEvent('mrg_housing:setApartments', data)
end

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

AddEventHandler("onResourceStop", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		if Modeler.IsMenuActive then
			Modeler:CloseMenu()
		end

		for k, v in pairs(PropertiesTable) do
			v:RemoveProperty()
		end

        for k, v in pairs(ApartmentsTable) do
            v:RemoveApartment()
        end
	end
end)

exports('GetProperties', function()
    return PropertiesTable
end)

exports('GetProperty', function(property_id)
    return Property.Get(property_id)
end)

exports('GetApartments', function()
    return ApartmentsTable
end)

exports('GetApartment', function(apartment)
    return Apartment.Get(apartment)
end)

exports('GetShells', function()
    return Config.Shells
end)


lib.callback.register('mrg_housing:cb:confirmPurchase', function(amount, street, id)
    return lib.alertDialog({
        header = 'Purchase Confirmation',
        content = 'Are you sure you want to purchase '..street..' ' .. id .. ' for $' .. amount .. '?',
        centered = true,
        cancel = true,
        labels = {
            confirm = "Purchase",
            cancel = "Cancel"
        }
    })
end)

lib.callback.register('mrg_housing:cb:confirmRaid', function(street, id)
    return lib.alertDialog({
        header = 'Nalot',
        content = 'Chcesz wziąć udział w nalocie? '..street..' ' .. id .. '?',
        centered = true,
        cancel = true,
        labels = {
            confirm = "Do ataku!",
            cancel = "Anuluj"
        }
    })
end)

lib.callback.register('mrg_housing:cb:ringDoorbell', function()
    return lib.alertDialog({
        header = 'Zadzwoń dzwonkiem',
        content = 'Nie masz klucza do tej nieruchomości, czy chcesz zadzwonić do drzwi?',
        centered = true,
        cancel = true,
        labels = {
            confirm = "Zadzwoń",
            cancel = "Anuluj"
        }
    })
end)

lib.callback.register('mrg_housing:cb:showcase', function()
    return lib.alertDialog({
        header = 'Prezentacja',
        content = 'Chcesz zaprezentować tę nieruchomość?',
        centered = true,
        cancel = true,
        labels = {
            confirm = "Tak",
            cancel = "Nie"
        }
    })
end)

-- InitialiseProperties()
