CreateThread(function()
    Wait(500)
    DisplayRadar(false)
    while not ESX.IsPlayerLoaded() do
        Wait(1000)
    end
    HUD.StartNUI()
    HUD.StartTheards()
end)