playerIsForced = false

RegisterNetEvent("tr-admin:PlayerIsForced", function(data)
    playerIsForced = data
end)


function Animations()
    local self = {}

    self.Entities = {}
    self.AnimationsFavorites = {}
    self.AnimationsBinds = {}

    self.SyncedPlayer = nil
    self.AnimationPositioningPed = nil
    self.AnimationPositioningCoords = nil
    self.Group = nil

    self.AnimationPositioning = false
    
    self.EnterKeyword = function(cb)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
            title = "Wprowadź keyword animacji"
        }, function(data, menu)
            local value = data.value
            if value then
                local found = false
                for i = 1, #(Config.Animations) do
                    local items = Config.Animations[i].items
                    for j = 1, #(items) do
                        local item = items[j]
                        if value == item.keyword then
                            found = item
                            break
                        end
                    end
                    if found then
                        break
                    end
                end

                if not found then
                    ESX.ShowNotification("Podana animacja nie istnieje!")
                else
                    menu.close()
                    cb(found)
                end
            end
        end, function(data, menu)
            menu.close()
            cb()
        end)
    end

    -- MAIN
    self.OpenAnimationsMain = function()
        ESX.UI.Menu.CloseAll()

        local elements = {}


        if self.Group == nil or self.Group.host == true then
            elements[#elements + 1] = {label = "⭐ Ulubione", action = "favorite"}
            elements[#elements + 1] = {label = "⌨ Bindowanie", action = "binding"}
            elements[#elements + 1] = {label = "👯‍♀️Grupa Taneczna", action = "group"}
            elements[#elements + 1] = {label = "❌ PRZERWIJ", action = "cancel"}
            elements[#elements + 1] = {label = "Animacje Radia", action = "radio"}
            elements[#elements + 1] = {label = " "}

            for i = 1, #(Config.Animations) do
                local group = Config.Animations[i]
                if not group.hide then
                    elements[#elements + 1] = {label = group.label, value = group.name, items = #group.items > 0}
                end
            end
        else
            elements[#elements + 1] = {label = "Animacje Radia", action = "radio"}
            elements[#elements + 1] = {label = "👯‍♀️Grupa Taneczna", action = "group"}
            elements[#elements + 1] = {label = " "}
            elements[#elements + 1] = {label = "❌Nie możesz samodzielnie używać animacji❌"}
        end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_menu", {
            title    = "Animacje",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            if data.current.action == "favorite" then
                self.OpenAnimationsFavorites()
            elseif data.current.action == "binding" then
                self.OpenAnimationsBinds()
            elseif data.current.action == "cancel" then
                self.ClearTasks()
            elseif data.current.action == "radio" then
                ExecuteCommand("radioanim")
                menu.close()
            elseif data.current.action == "group" then
                self.OpenAnimationGroup()
            elseif data.current.value == "shared" then
                if self.Group == nil then
                    self.OpenAnimationsSynced()
                else
                    ESX.ShowNotification("Podczas tańeczenia w grupie nie można używać tej kategori")
                end
            elseif data.current.items then
                if self.Group and (data.current.value == "facial" or data.current.value == "movements" or data.current.value == "porn") then
                    ESX.ShowNotification("Podczas tańeczenia w grupie nie można używać tej kategori")
                else
                    self.OpenAnimationsItems(data.current.value, false)
                end
            else
                if self.Group and (data.current.value == "objects" or data.current.value == "sytuacyjne" or data.current.value == "praca" or data.current.value == "pozycje") then
                    ESX.ShowNotification("Podczas tańeczenia w grupie nie można używać tej kategori")
                else
                    self.OpenAnimationsCategory(data.current.value)
                end
            end
        end, function(data, menu)
            menu.close()
        end)
    end
    self.OpenAnimationGroup = function()
        ESX.UI.Menu.CloseAll()

        local elements = {}
        if self.Group == nil then
            elements[#elements + 1] = {label = "Grupa: ".. " <span style='color:rgb(255, 82, 232)'>Brak</span>"}
            elements[#elements + 1] = {label = ""}
            elements[#elements + 1] = {label = "Utwórz grupę", action = "create"}
            elements[#elements + 1] = {label = "Dołącz do grupy", action = "join"}
        else
            elements[#elements + 1] = {label = "Grupa: ".. " <span style='color: rgb(255, 82, 232)'>"..self.Group.name.."</span>"}
            elements[#elements + 1] = {label = "Kod Zaproszenia: ".. " <span style='color: rgb(255, 82, 232)'>"..self.Group.id.."</span>"}
            elements[#elements + 1] = {label = ""}
            if self.Group.host == false then
                elements[#elements + 1] = {label = "Opuść grupę", action = "leave"}
                elements[#elements + 1] = {label = "Zaproś do grupy", action = "invite"}
                elements[#elements + 1] = {label = "--- Użytkownicy ---"}
            else
                elements[#elements + 1] = {label = "Usuń grupę", action = "delete"}
                elements[#elements + 1] = {label = "Zaproś do grupy", action = "invite"}
                elements[#elements + 1] = {label = "--- Użytkownicy (Wyrzucenie) ---"}
            end
            for k, v in pairs(self.Group.members) do
                local action = "Oczekiwanie"
                if v.action == "playing" then
                    action = "Odtwarzanie animacji"
                end
                elements[#elements + 1] = {label = "["..v.id.."] "..v.name..(v.host and " [HOST]" or "").. " - "..action, action="kick", value=""..v.id}
            end
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_group_menu", {
            title    = "👯‍♀️Grupa Taneczna",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            if data.current.action == "leave" then
                ESX.TriggerServerCallback('mrg_animations:group:leave', function(data, reason)
                    if data then
                        self.Group = nil
                        ESX.ShowNotification("Wyszedłeś z grupy")
                        Wait(100)
                        self.OpenAnimationGroup()
                    else
                        ESX.ShowNotification("Wystąpił błąd z wyjściem z grupy")
                    end
                end, value)
            elseif data.current.action == "kick" then
                local value = data.current.value
                if value then
                    ESX.TriggerServerCallback('mrg_animations:group:kick', function(data, reason)
                        if data then
                            local member = self.Group.members[value]
                            self.Group.members[value] = nil
                            ESX.ShowNotification("Użytkownik "..member.name.." został wrzucony")
                            Wait(100)
                            self.OpenAnimationGroup()
                        else
                            ESX.ShowNotification("Wystąpił błąd z wrzucaniem użytkownika z grupy  ("..reason..")")
                        end
                    end, value)
                else
                    self.OpenAnimationGroup()
                end
            elseif data.current.action == "invite" then
                local player = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
                if #player > 0 then
                    local elements = {}
                    for k, v in pairs(player) do
                        elements[#elements + 1] = {label = "ID: "..GetPlayerServerId(v), id = GetPlayerServerId(v)}
                    end
                    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_group_invite_menu", {
                        title    = "👯‍♀️Zaproszenie do grupy",
                        align    = "bottom-right",
                        elements = elements
                    }, function(data, menu)
                        print(data.current.id)
                        if data.current.id then
                            TriggerServerEvent("mrg_animations:group:inviteuser", data.current.id)
                        else
                            ESX.ShowNotification("~r~Brak obywateli w pobliżu")
                        end
                    end, function(data, menu)
                        menu.close()
                        self.OpenAnimationsMain()
                    end)
                else
                    ESX.ShowNotification("Brak obywateli w pobliżu")
                end
            elseif data.current.action == "join" then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
                    title = "Wprowadź Kod Zaproszenia grupy"
                }, function(data, menu)
                    local value = data.value
                    if value then
                        menu.close()
                        TriggerServerEvent("mrg_animations:group:joinviaCode", value)
                        Wait(100)
                        self.OpenAnimationGroup()
                    end
                end)
            elseif data.current.action == "create" then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
                    title = "Wprowadź nazwę grupy"
                }, function(data, menu)
                    local value = data.value
                    if value then
                        menu.close()
                        ESX.ShowNotification("Tworzenie grupy")
                        ESX.TriggerServerCallback('mrg_animations:group:create', function(data)
                            if data ~= nil then
                                self.Group = {
                                    id = data.id,
                                    name = data.name,
                                    host = true,
                                    members = data.members
                                }
                                ESX.ShowNotification("Utworzono Grupę")
                                Wait(100)
                                self.OpenAnimationGroup()
                            else
                                ESX.ShowNotification("Wystąpił błąd z tworzeniem grupy")
                            end
                        end, value)
                    end
                end)
            elseif data.current.action == "delete" then
                ESX.ShowNotification("Usuwanie grupy")
                if self.Group.host then
                    ESX.TriggerServerCallback('mrg_animations:group:delete', function(success)
                        if success then
                            self.Group = nil
                            ESX.ShowNotification("Usunięto Grupę")
                            Wait(100)
                            self.OpenAnimationGroup()
                        else
                            ESX.ShowNotification("Wystąpił błąd z usuwaniem grupy")
                        end
                    end, self.Group.id)
                else
                    ESX.ShowNotification("Nie jesteś właścicielem grupy")
                end
            else
                self.OpenAnimationsGroup()
            end
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsMain()
        end)
    end
    self.OpenAnimationsCategory = function(category)
        ESX.UI.Menu.CloseAll()

        local elements = {}

        for i = 1, #(Config.Animations) do
            local group = Config.Animations[i]
            if group.hide and group.attachTo == category then
                elements[#elements + 1] = {label = group.label, value = group.name, items = #group.items > 0}
            end
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_menu", {
            title    = "Animacje",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            if data.current.items then
                self.OpenAnimationsItems(data.current.value, false)
            else
                self.OpenAnimationsCategory(data.current.value)
            end
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsMain()
        end)
    end

    self.OpenAnimationsItems = function(category, isAttached)
        ESX.UI.Menu.CloseAll()

        local title, elements = nil, {}
        for i = 1, #(Config.Animations) do
            local group = Config.Animations[i]
            if group.name == category then
                title = group.label

                local items = group.items
                for j = 1, #(items) do
                    local item = items[j]
                    elements[#elements + 1] = {
                        label = (item.keyword and item.label .. " <span style='color: rgb(255, 82, 232)'>/e " .. item.keyword .. "</span>" or item.label),
                        keyword = item.keyword
                    }
                end
                break
            end
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_sub_menu", {
            title    = title,
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            for i = 1, #(Config.Animations) do
                local group = Config.Animations[i]
                if group.name == category then
                    local items = group.items
                    for j = 1, #(items) do
                        local item = items[j]
                        if item.keyword == data.current.keyword then
                            item.positioning = group.positioning
                            self.PlayAnimation(item)
                            break
                        end
                    end
                end
            end
        end, function(data, menu)
            menu.close()
            if isAttached then
                self.OpenAnimationsCategory(isAttached)
            else
                self.OpenAnimationsMain()
            end
        end)
    end

    self.OpenAnimationsSynced = function()
        ESX.UI.Menu.CloseAll()

        local elements = {}
        for i = 1, #(Config.Shared) do
            local item = Config.Shared[i]
            elements[#elements + 1] = {
                label = (item.keyword and item.label .. " <span style='color: rgb(255, 82, 232)'>/e " .. item.keyword .. "</span>" or item.label),
                keyword = item.keyword
            }
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "animations_sub_menu", {
            title    = "👭 Wspólne Animacje",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= nil then
                if Player(GetPlayerServerId(closestPlayer)).state.InGroup ~= nil then
                    ESX.ShowNotification('Gracz jest w grupie tanecznej i nie jest wstanie teraz wykonywać innych animacji')
                    return
                end
                ESX.ShowNotification('~y~Oczekiwanie na akceptacj� przez obywatela')
                TriggerServerEvent('mrg_animations:requestSynced', GetPlayerServerId(closestPlayer), data.current.keyword)
            end
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsMain()
        end)
    end
    
    -- FAVORITES
    self.OpenAnimationsFavorites = function()
        ESX.UI.Menu.CloseAll()

        local Favorites = self.AnimationsFavorites
        local elements = {}

        if #Favorites > 0 then
            for i = 1, #(Favorites) do
                elements[#elements + 1] = Favorites[i]
            end
            elements[#elements + 1] = {label = " "}
        end
        
        elements[#elements + 1] = {label = "➕ Dodaj", value = "add"}
        elements[#elements + 1] = {label = "➖ Usuń", value = "delete"}

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "favorites_animations", {
            title    = "⭐ Ulubione",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            if data.current.value == "add" then
                menu.close()
                self.EnterKeyword(function(value)
                    if value then
                        local found = false
                        for i = 1, #(Favorites) do
                            if Favorites[i].keyword == value.keyword then
                                found = true
                                break
                            end
                        end
                        if not found then
                            value.label = value.keyword
                            self.AnimationsFavorites[#self.AnimationsFavorites + 1] = value
                            SetResourceKvp("NeedRP-AnimationsFavorites", json.encode(self.AnimationsFavorites))
                        else
                            ESX.ShowNotification("Ta animacja znajduje się w ulubionych!")
                        end
                    end
                    self.OpenAnimationsFavorites()
                end)
            elseif data.current.value == "delete" then
                menu.close()
                self.OpenAnimationsFavoritesDelete()
            else
                self.PlayAnimation(data.current)
            end
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsMain()
        end)
    end

    self.OpenAnimationsFavoritesDelete = function()
        ESX.UI.Menu.CloseAll()

        local Favorites = self.AnimationsFavorites
        local elements = {}

        for i = 1, #(Favorites) do
            elements[#elements + 1] = Favorites[i]
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "delete_favorites_animations", {
            title    = "Usuwanie ulubionych animacji",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            menu.close()
            for i = 1, #(Favorites) do
                if Favorites[i].keyword == data.current.keyword then
                    table.remove(self.AnimationsFavorites, i)
                    break
                end
            end
            self.OpenAnimationsFavoritesDelete()
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsFavorites()
        end)
    end

    -- BINDS
    self.OpenAnimationsBinds = function()
        ESX.UI.Menu.CloseAll()

        local Binds = self.AnimationsBinds
        local elements = {}

        for i = 1, 9 do
            if Binds[i] then
                elements[#elements + 1] = {label = "Klawisz " .. i .. " - " .. Binds[i].keyword, data = Binds[i], key = i, has = true}
            else
                elements[#elements + 1] = {label = "Klawisz " .. i, key = i, has = false}
            end
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "binds_animations", {
            title    = "⌨ Bindowanie",
            align    = "bottom-right",
            elements = elements
        }, function(data, menu)
            if data.current.has then
                self.AnimationsBinds[data.current.key] = nil
                SetResourceKvp("NeedRP-AnimationsBinds", json.encode(self.AnimationsBinds))
                self.OpenAnimationsBinds()
            else
                menu.close()
                self.EnterKeyword(function(value)
                    if value then
                        self.AnimationsBinds[data.current.key] = value
                        SetResourceKvp("NeedRP-AnimationsBinds", json.encode(self.AnimationsBinds))
                    end
                    self.OpenAnimationsBinds()
                end)
            end
        end, function(data, menu)
            menu.close()
            self.OpenAnimationsMain()
        end)
    end

    -- ANIMATIONS
    self.PosAnimation = function(data, AnimationMode, AnimationDuration, props, cb)
        TriggerEvent('skinchanger:getSkin', function(skin)
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())

            if DoesEntityExist(self.AnimationPositioningPed) then
                DeleteEntity(self.AnimationPositioningPed)
            end
            if self.AnimationPositioning then
                self.AnimationPositioning = false
            end
            self.AnimationPositioning = true
            self.AnimationPositioningPed = CreatePed(2, GetEntityModel(PlayerPedId()), coords.x, coords.y, coords.z - 1.0, heading, false)
            TriggerEvent("skinchanger:loadPedSkin", self.AnimationPositioningPed, skin, function()
                FreezeEntityPosition(self.AnimationPositioningPed, true)
                SetEntityCollision(self.AnimationPositioningPed, false, false)
                SetEntityCompletelyDisableCollision(self.AnimationPositioningPed, false, false)
                SetEntityAlpha(self.AnimationPositioningPed, 200, false)
                SetBlockingOfNonTemporaryEvents(self.AnimationPositioningPed, true) 
                SetEntityInvincible(self.AnimationPositioningPed, true)
                FreezeEntityPosition(self.AnimationPositioningPed, true)

                self.TaskPlayAnimation(data, AnimationMode, AnimationDuration, props, self.AnimationPositioningPed)

                while self.AnimationPositioning do
                    DisableControlAction(0, 14, true)
                    DisableControlAction(0, 15, true)
                    DisableControlAction(0, 18, true)
                    DisableControlAction(0, 30,  true)
                    DisableControlAction(0, 31,  true)
                    DisableControlAction(0, 32, true)
                    DisableControlAction(0, 33, true)
                    DisableControlAction(0, 34, true)
                    DisableControlAction(0, 35, true)
                    DisableControlAction(0, 38, true)
                    DisableControlAction(0, 44, true)

                    local xoff = 0.0
                    local yoff = 0.0
                    local zoff = 0.0
                    local heading = GetEntityHeading(self.AnimationPositioningPed)

                    if IsDisabledControlJustReleased(0, 15) then
                        heading = heading + 5
                    end
                    if IsDisabledControlJustReleased(0, 14) then
                        heading = heading - 5
                    end
    
                    if IsDisabledControlPressed(0, 34) then
                        xoff = -0.01;
                    end
                    if IsDisabledControlPressed(0, 35) then
                        xoff = 0.01;
                    end
    
                    if IsDisabledControlPressed(0, 32) then
                        yoff = 0.01;
                    end
                    if IsDisabledControlPressed(0, 33) then
                        yoff = -0.01;
                    end
    
                    if IsDisabledControlPressed(0, 38) then
                        zoff = 0.01;
                    end
                    if IsDisabledControlPressed(0, 44) then
                        zoff = -0.01;
                    end

                    if IsDisabledControlJustPressed(0, 18) then
                        if HasEntityClearLosToEntity(self.AnimationPositioningPed, PlayerPedId(), 2) then
                            self.AnimationPositioningCoords = {
                                x = coords.x,
                                y = coords.y,
                                z = coords.z - 1.0,
                                h = heading
                            }
                            
                            SetEntityCoordsNoOffset(PlayerPedId(), GetEntityCoords(self.AnimationPositioningPed), false, true, true)
                            SetEntityHeading(PlayerPedId(), GetEntityHeading(self.AnimationPositioningPed))
                            
                            for i = 1, #(self.Entities) do
                                DeleteEntity(self.Entities[i].prop)
                            end
                            self.Entities = {}
                            DeleteEntity(self.AnimationPositioningPed)            
                            break
                        else
                            ESX.ShowNotification("Nie możesz ustawić animacji w tym miejscu!")
                        end
                    end

                    local newPos = GetOffsetFromEntityInWorldCoords(self.AnimationPositioningPed, xoff, yoff, zoff)
                    if #(vec3(coords.x, coords.y, coords.z) - vec3(newPos.x, newPos.y, newPos.z)) < 3 then
                        SetEntityCoordsNoOffset(self.AnimationPositioningPed, newPos.x, newPos.y, newPos.z, false, true, true)
                    end
                    SetEntityHeading(self.AnimationPositioningPed, heading)

                    Wait(0)
                end

                cb(self.AnimationPositioning)
                self.AnimationPositioning = false
            end)
        end)
    end

    self.PlayAnimation = function(data)
        if self.AnimationPositioning then
            return
        end
        if LocalPlayer.state.handcuffed then return end
        if LocalPlayer.state.isCuffed then return end
        if LocalPlayer.state.isRopecuffed then return end

        if self.AnimationPositioningCoords then
            return
        end

        if data.type == "walk" then
            self.SetMovementClipset(data.animdict)
            return
        end

        if data.type == "expression" then
            self.SetFacialAnim(data.animdict)
            return
        end

        local AnimationMode = 0
        local AnimationDuration = -1
        local AnimationOptions = data.options

        if IsPedInAnyVehicle(PlayerPedId(), true) then
            AnimationMode = 51
        elseif AnimationOptions then
            if AnimationOptions.moving then
                AnimationMode = 51
            elseif AnimationOptions.loop then
                AnimationMode = 1
            elseif AnimationOptions.stuck then
                AnimationMode = 50
            end
        end

        if AnimationOptions and AnimationOptions.duration then
            AnimationDuration = AnimationOptions.duration
        end

        local StartAnim = function()
            self.TaskPlayAnimation(data, AnimationMode, AnimationDuration, AnimationOptions and AnimationOptions.props)

            Wait(250)

            local PtfxNoProp = false
            if AnimationOptions and AnimationOptions.ptfx then
                local PtfxAsset = AnimationOptions.ptfx.asset
                local PtfxName = AnimationOptions.ptfx.name
                if AnimationOptions.ptfx.noProp then
                    PtfxNoProp = AnimationOptions.ptfx.noProp
                else
                    PtfxNoProp = false
                end
                local Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(AnimationOptions.ptfx.placement)
                local PtfxBone = AnimationOptions.ptfx.bone
                local PtfxColor = AnimationOptions.ptfx.color
                local PtfxInfo = AnimationOptions.ptfx.info
                local PtfxWait = AnimationOptions.ptfx.wait
                local PtfxCanHold = AnimationOptions.ptfx.canHold
                TriggerServerEvent("mrg_animations:syncPtfx", PtfxAsset, PtfxName, vector3(Ptfx1, Ptfx2, Ptfx3), vector3(Ptfx4, Ptfx5, Ptfx6), PtfxBone, PtfxScale, PtfxColor)

                CreateThread(function()
                    if PtfxCanHold then
                        ESX.ShowNotification(PtfxInfo ~= "false" and PtfxInfo or "G")
                        while IsEntityPlayingAnim(PlayerPedId(), data.dict, data.name, 3) do
                            if IsControlPressed(0, 47) then
                                self.StartPtfx()
                                Wait(PtfxWait)
                                while IsControlPressed(0, 47) and IsEntityPlayingAnim(PlayerPedId(), data.dict, data.name, 3) do
                                    Wait(5)
                                end
                                self.StopPtfx()
                            end
                            Wait(0)
                        end
                    else
                        Wait(PtfxWait)
                        self.StartPtfx()
                        self.StopPtfx()
                    end
                end)
            end

            if AnimationOptions and AnimationOptions.ptfx and not PtfxNoProp then
                TriggerServerEvent("mrg_animations:syncPtfxProp", ObjToNet(self.Entities[1].prop))
            end

            CreateThread(function()
                while IsEntityPlayingAnim(PlayerPedId(), data.dict, data.name, 3) do
                    Wait(100)
                end
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityCollision(PlayerPedId(), true, true)
                SetEntityCompletelyDisableCollision(PlayerPedId(), true, true)
                
                local coords = self.AnimationPositioningCoords
                if coords then
                    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
                    SetEntityHeading(PlayerPedId(), coords.h)
                    self.AnimationPositioningCoords = nil
                end
                if self.Group then
                    TriggerServerEvent("mrg_animations:group:EndAnimation")
                end
            end)
        end

        if not self.Group and data.positioning then
            self.PosAnimation(data, AnimationMode, AnimationDuration, AnimationOptions and AnimationOptions.props, function(bool)
                if bool then
                    FreezeEntityPosition(PlayerPedId(), true)
                    StartAnim()
                end
            end)
        else
            if self.Group and self.Group.host then
                ESX.TriggerServerCallback('mrg_animations:group:StartAnimation', function(data)
                    if data then
                        StartAnim()
                    else
                        ESX.ShowNotification("Wystąpił błąd z rozpoczęciem animacji!")
                    end
                end, data.keyword)
            else
                StartAnim()
            end
        end
    end

    self.TaskPlayAnimation = function(data, AnimationMode, AnimationDuration, props, clone)
        if LocalPlayer.state.handcuffed then return end
        if LocalPlayer.state.isCuffed then return end
        if LocalPlayer.state.isRopecuffed then return end
        local ped = clone or PlayerPedId()

        for i = 1, #(self.Entities) do
            DeleteEntity(self.Entities[i].prop)
        end
        self.Entities = {}

        RequestAnimDict(data.dict)
        while not HasAnimDictLoaded(data.dict) do
            Wait(0)
        end

        TaskPlayAnim(ped, data.dict, data.name, 5.0, 5.0, AnimationDuration, AnimationMode, 0, false, false, false)
        RemoveAnimDict(data.dict)

        if props then
            local x, y, z = table.unpack(GetEntityCoords(ped))
            for i = 1, #(props) do
                local obj = props[i]
                local name = obj.name
                local bone = obj.bone
                local off1, off2, off3, rot1, rot2, rot3 = table.unpack(obj.placement)
                if IsModelValid(name) then
                    while not HasModelLoaded(joaat(name)) do
                        RequestModel(joaat(name))
                        Wait(10)
                    end

                    if clone then
                        local prop = CreateObject(joaat(name), x, y, z + 0.2, false, true, true)
                        SetEntityAlpha(prop, 200, false)
                        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
                        table.insert(self.Entities, {prop = prop, animCfg = data})
                        SetModelAsNoLongerNeeded(prop)
                    else
                        local prop = CreateObject(joaat(name), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
                        table.insert(self.Entities, {prop = prop, animCfg = data})
                        SetModelAsNoLongerNeeded(prop)
                    end
                end
            end
        end
        if not exports['mrg_achivements']:CheckIsUnlocked('open-animacja') then
			TriggerServerEvent("mrg_achivements:UnlockAchivements", "open-animacja", 1)
		end
        if not exports['mrg_achivements']:CheckIsUnlocked('open-animacja2') then
			TriggerServerEvent("mrg_achivements:UnlockAchivements", "open-animacja2", 1)
		end
    end

    self.ClearTasks = function()
        if playerIsForced then return end
        ClearPedTasks(PlayerPedId())

        for i = 1, #(self.Entities) do
            DeleteEntity(self.Entities[i].prop)
        end
        self.Entities = {}

        if self.AnimationPositioning then
            self.AnimationPositioning = nil
        end

        if self.AnimationPositioningPed then
            DeleteEntity(self.AnimationPositioningPed)
            self.AnimationPositioningPed = nil
        end

        if self.SyncedPlayer then
            DetachEntity(PlayerPedId(), true, false)
            TriggerServerEvent("mrg_animations:stopSynced", self.SyncedPlayer)
            self.SyncedPlayer = nil
        end

        if LocalPlayer.state.ptfx then
            self.StopPtfx()
        end

        local coords = self.AnimationPositioningCoords
        if coords then
            SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
            SetEntityHeading(PlayerPedId(), coords.h)
            self.AnimationPositioningCoords = nil
        end
        if self.Group and self.Group.host then
            TriggerServerEvent("mrg_animations:group:stopAnimation")
        end
    end

    -- PTFX
    self.StartPtfx = function()
        LocalPlayer.state:set('ptfx', true, true)
    end

    self.StopPtfx = function()
        LocalPlayer.state:set('ptfx', false, true)
    end

    self.PlayerParticles = {}
    AddStateBagChangeHandler('ptfx', nil, function(bagName, key, value, _unused, replicated)
        local plyId = tonumber(bagName:gsub('player:', ''), 10)

        if (self.PlayerParticles[plyId] and value) or (not self.PlayerParticles[plyId] and not value) then return end

        local ply = GetPlayerFromServerId(plyId)
        if ply == 0 then return end

        local plyPed = GetPlayerPed(ply)
        if not DoesEntityExist(plyPed) then return end

        local stateBag = Player(plyId).state
        if value then
            local asset = stateBag.ptfxAsset
            local name = stateBag.ptfxName
            local offset = stateBag.ptfxOffset
            local rot = stateBag.ptfxRot
            local boneIndex = stateBag.ptfxBone and GetPedBoneIndex(plyPed, stateBag.ptfxBone) or GetEntityBoneIndexByName(name, "VFX")
            local scale = stateBag.ptfxScale or 1
            local color = stateBag.ptfxColor
            local propNet = stateBag.ptfxPropNet
            local entityTarget = plyPed
            
            if propNet then
                local propObj = NetToObj(propNet)
                if DoesEntityExist(propObj) then
                    entityTarget = propObj
                end
            end
            
            while not HasNamedPtfxAssetLoaded(asset) do
                RequestNamedPtfxAsset(asset)
                Wait(10)
            end
            UseParticleFxAsset(asset)
            
            self.PlayerParticles[plyId] = StartNetworkedParticleFxLoopedOnEntityBone(name, entityTarget, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneIndex, scale + 0.0, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
            if color then
                if color[1] and type(color[1]) == 'table' then
                    local randomIndex = math.random(1, #color)
                    color = color[randomIndex]
                end
                SetParticleFxLoopedAlpha(self.PlayerParticles[plyId], color.A)
                SetParticleFxLoopedColour(self.PlayerParticles[plyId], color.R / 255, color.G / 255, color.B / 255, false)
            end
        else
            if self.PlayerParticles[plyId] then
                StopParticleFxLooped(self.PlayerParticles[plyId], false)
                RemoveParticleFx(self.PlayerParticles[plyId])
                RemoveNamedPtfxAsset(stateBag.ptfxAsset)
                self.PlayerParticles[plyId] = nil
            end
        end
    end)

    self.SetMovementClipset = function(name)
        RequestAnimSet(name)
        while not HasAnimSetLoaded(name) do
            Citizen.Wait(1)
        end
        SetPedMovementClipset(PlayerPedId(), name, 0.2)
        RemoveAnimSet(name)
        SetResourceKvp("NeedRP-MovementClipset", name)
    end

    self.SetFacialAnim = function(name)
        SetFacialIdleAnimOverride(PlayerPedId(), name, 0)
        SetResourceKvp("NeedRP-FacialAnim", name)
    end

    self.PlaceEntities = function()
        if self.AnimationPositioning then
            return
        end
        if #self.Entities <= 0 then
            return
        end

        local ped = PlayerPedId()
        RequestAnimDict("anim@mp_fireworks")
        while not HasAnimDictLoaded("anim@mp_fireworks") do
            Wait(0)
        end

        TaskPlayAnim(ped, "anim@mp_fireworks", "place_firework_3_box", 5.0, 5.0, 2000, 46, 0, false, false, false)
        RemoveAnimDict("anim@mp_fireworks")

        Wait(2000)

        ped = PlayerPedId()
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, -0.5)
        for i = 1, #(self.Entities) do
            local obj = self.Entities[i]
            DetachEntity(obj.prop, true)
            SetEntityCoords(obj.prop, coords)
            obj.prop = ObjToNet(obj.prop)
            TriggerServerEvent("mrg_animations:CreateEntity", obj)
        end
        self.Entities = {}
        self.ClearTasks()
    end

    return self
end