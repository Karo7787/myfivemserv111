PrevPos = nil
time = 1800
Citizen.CreateThread(function()
    print(GetNumberOfPedDrawableVariations(PlayerPedId(), 6))
end)
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
		if playerPed then
            if not LocalPlayer.state.InSkin then
                local CurrentPos = GetEntityCoords(playerPed, true)
                if CurrentPos == PrevPos then
                    if time > 0 then
                        if time == 60 then
                            TriggerEvent("chat:addMessage", {
                                templateId = "message",
                                multiline = true,
                                args = {"255, 61, 61", icon and icon or "fa-solid fa-bed", "ANTI AFK", "Za 1 minute zostaniesz wyrzucony za afk, wpisz /play aby zrestartować timer", ""},
                            })
                        elseif time == 30 then
                            TriggerEvent("chat:addMessage", {
                                templateId = "message",
                                multiline = true,
                                args = {"255, 61, 61", icon and icon or "fa-solid fa-bed", "ANTI AFK", "Za "..time.." sekund zostaniesz wyrzucony za afk, wpisz /play aby zrestartować timer", ""},
                            })
                        elseif time <= 10 then
                            TriggerEvent("chat:addMessage", {
                                templateId = "message",
                                multiline = true,
                                args = {"255, 61, 61", icon and icon or "fa-solid fa-bed", "ANTI AFK", "Za "..time.." sekund zostaniesz wyrzucony za afk, wpisz /play aby zrestartować timer", ""},
                            })
                        end
                        time = time - 1
                    else
                        TriggerServerEvent("tr-antiafk:afk")
                        time = 1800
                    end
                else
                    time = 1800
                end
                PrevPos = CurrentPos
            end
        end
    end
end)



RegisterCommand("play", function()
    time = 1800
    TriggerEvent("chat:addMessage", {
        templateId = "message",
        multiline = true,
        args = {"77, 255, 154", icon and icon or "fa-solid fa-bed", "ANTI AFK", "Zrestartowano Timer", ""},
    })
end)