lib.locale(Config.Language or 'en')

Citizen.CreateThread(function()
    for name, data in pairs(Config.stations) do
        local point = lib.points.new({
            coords = data.coords,
            distance = data.distance or 5,
        })

        function point:onEnter()
            lib.showTextUI('[E] - '..locale('open_menu'))
        end
         
        function point:onExit()
            lib.hideTextUI()
        end
         
        function point:nearby()
            if cache.vehicle and self.currentDistance < 2.5 and IsControlJustReleased(0, 38) then
                lib.hideTextUI()
                exports['p_tuningmenu']:OpenTuningMenu(false)

                -- USE THIS CODE IF YOU WANT TO OPEN TUNING MENU WITH PAYMENT OPTION FOR MECHANIC JOB ONLY
                -- if ESX.PlayerData.job.name == 'mechanic' then
                --     exports['p_tuningmenu']:OpenTuningMenu(false)
                -- else
                --     exports['p_tuningmenu']:OpenTuningMenu(true)
                -- end
            end
        end
    end
end)