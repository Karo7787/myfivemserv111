
Citizen.CreateThread(function()
    -- e.g.: for ox_target
    local coords = vec3(-554.66, -185.09, 38.22)
    local size = vec3(1, 1, 1)
    local rotation = 0
    local options = {
        {
            name = "jobcenter",
            onSelect = function ()
                TriggerServerEvent("sfjob:jobCenter")
            end,
            icon = "fas fa-briefcase",
            label = "Urzad Pracy",
        },
        {
            name = "vehicles",
            onSelect = function ()
                TriggerEvent("dbl_jct:vehicleManage")
            end,
            icon = "fas fa-sign-in",
            label = "Zarządzanie pojazdami",
        },
        {
            name = "fish",
            onSelect = function ()
                local result = lib.callback.await("dbl_jct:buyFishLicense", false)
                if result == "error" then
                    SFX.ShowNotification("Wystąpił błąd!")
                elseif result == "money" then
                    SFX.ShowNotification("Nie posiadasz wystarczającej ilości pieniędzy na koncie!")
                elseif result == "license" then
                    SFX.ShowNotification("Posiadasz już licencje rybacką!")
                elseif result == "doj" then
                    SFX.ShowNotification("Jest wystarczająca ilość dojowców na służbie!")
                end
            end,
            canInteract = function()
                return true
            end,
            icon = "fas fa-fish",
            label = "Wyrób licencje rybacką (1000$)",
        }
    }
    createInteraction(coords, size, rotation, options) -- Quickly create interaction for players
    
    -- local coords2 = vec3(262.2, 226.4, 106.28)
    -- local size2 = vec3(1, 1, 1)
    -- local rotation2 = 340
    -- local options2 = {
    --     {
    --         name = "collectpaycheck",
    --         onSelect = function ()
    --             TriggerServerEvent("sfjob:collectPaycheck")
    --             TriggerServerEvent('piotreq_jobcore:TakePayout')
    --         end,
    --         icon = "fas fa-hand-holding-usd",
    --         label = "Odbierz wyplate",
    --     }
    -- }
    -- createInteraction(coords2, size2, rotation2, options2) -- Quickly create interaction for players
end)


local function AddVehicleKey(plate, result)
    local options = {}
    local myPed = PlayerPedId()
	local coords = GetEntityCoords(myPed, true)
    local pid = PlayerId()
    for _, player in ipairs(SFX.Game.GetPlayers()) do
        if pid ~= player then
            local target = GetPlayerPed(player)
            if IsEntityVisible(target) then
                local distance = #(coords - GetEntityCoords(target, true))
                if distance <= 3.0 then
                    local id = GetPlayerServerId(player)
                    table.insert(options, {value = id, label = "Obywatel [" .. id .. "]"})
                end
            end
        end
    end

    local input = lib.inputDialog('Daj klucze [' .. string.upper(plate) .. ']', {
        {type = "select", label = "Wybierz obywatela", options = options}
    })
    if not input or not input[1] then
        return SFX.ShowNotification("Wybierz obywatela!")
    end
    local result = lib.callback.await("dbl_jct:addVehicleSubowner", false, result.id, input[1])
    if result == "success" then
        SFX.ShowNotification("Klucze zostały nadane!")
    elseif result == "error" then
        SFX.ShowNotification("Wystąpił błąd!")
    elseif result == "money" then
        SFX.ShowNotification("Nie posiadasz wystarczającej ilości pieniędzy na koncie!")
    end
end

local function RemoveVehicleKey(plate, result)
    local options = {}

    for i = 1, #(result.subowners) do
        table.insert(options, {value = result.subowners[i].identifier, label = result.subowners[i].label})
    end

    local input = lib.inputDialog('Zabierz klucze [' .. string.upper(plate) .. ']', {
        {type = "select", label = "Wybierz obywatela", options = options}
    })
    if not input or not input[1] then
        return SFX.ShowNotification("Wybierz obywatela!")
    end
    local result = lib.callback.await("dbl_jct:removeVehicleSubowner", false, result.id, input[1])
    if result then
        SFX.ShowNotification("Klucze zostały zabrane!")
    else
        SFX.ShowNotification("Wystąpił błąd!")
    end
end

RegisterNetEvent("dbl_jct:vehicleManage", function()
    local input = lib.inputDialog('Zarządzanie pojazdami', {{type = "input", label = "Wpisz rejestrację pojazdu", placeholder="ABC 1234", required = true}})
    if not input then
        return SFX.ShowNotification("Podaj rejestrację pojazdu!")
    end

    local plate = input[1]

    local result = lib.callback.await("dbl_jct:getVehicleSubowners", false, plate)
    if not result then
        return SFX.ShowNotification("Nie znaleziono pojazdu!")
    end
    local options = {}
    if #result.subowners < result.limit then
        table.insert(options,             {
            title = 'Daj klucze [$3500]',
            onSelect = function()
                AddVehicleKey(plate, result)
            end
        })
    end
    table.insert(options, {
        title = 'Zabierz klucze',
        onSelect = function()
            RemoveVehicleKey(plate, result)
        end
    })
    lib.registerContext({
        id = 'manage_vehicle',
        title = 'Zarządzanie pojazdem [' .. string.upper(plate) .. ']',
        options = options
    })
    lib.showContext('manage_vehicle')
end)