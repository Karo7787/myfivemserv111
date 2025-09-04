function openBossMenu(grades, businessName, businessId)
    dbg.info("Opening boss menu. `%s, %s`", businessName, businessId)
    society = businessName or 'unemployed'
    grades = grades or {'boss'}

    if isBoss(society, grades) or isBusinessOwner(businessId) then
        openSocietyMenu(businessName, businessId)
        EmployeeData.isInBossMenu = true
    end
end

function closeBossMenu()
    dbg.info("Closing boss menu")
    if Config.Framework == Frameworks.ESX or Config.Framework == Frameworks.ESX_LIMIT then
        ESX.UI.Menu.CloseAll()
    elseif Config.Framework == Frameworks.QBCORE then
        xpcall(function() 
            exports[Config.Events['qb-core']]:closeMenu()
        end,
        function()
            exports['qb-menu']:closeMenu()
        end)
    end

    CloseAllTattooMenu()
end
