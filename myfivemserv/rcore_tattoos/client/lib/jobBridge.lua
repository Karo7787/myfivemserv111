function initJobBridge()
    if Config.Framework == Frameworks.ESX or Config.Framework == Frameworks.ESX_LIMIT then
        -- event for player loaded
        Config.OnPlayerLoaded = Config.Events["esx:playerLoaded"]
        -- event for setjob
        Config.OnJobUpdate = Config.Events["esx:setJob"]

        PlayerData = {}
        ESX = nil

        ESX = getEsxObject()

        CreateThread(function()
            while ESX == nil do
                Wait(10)
            end

            if ESX.IsPlayerLoaded() then
                PlayerData = ESX.GetPlayerData()
            end
        end)

        RegisterNetEvent(Config.OnPlayerLoaded)
        AddEventHandler(Config.OnPlayerLoaded, function(xPlayer)
            PlayerData = xPlayer
        end)

        RegisterNetEvent(Config.OnJobUpdate)
        AddEventHandler(Config.OnJobUpdate, function(job)
            PlayerData.job = job
        end)

        function isAtJob(name)
            return PlayerData.job.name == name
        end
    elseif Config.Framework == Frameworks.QBCORE then
        -- event for player loaded
        Config.OnPlayerLoaded = Config.Events["QBCore:Client:OnPlayerLoaded"]
        -- event for setjob
        Config.OnJobUpdate = Config.Events["QBCore:Client:OnJobUpdate"]

        GetQBCoreObject = function()
            local objectType = 1
            --------------------------
            if objectType == 1 then
                return exports[Config.Events['qb-core']]:GetCoreObject()
            end
            --------------------------
            if objectType == 2 then
                local QBCore = nil
                local breakPoint = 0
                while not QBCore do
                    Wait(100)
                    TriggerEvent(Config.Events["QBCore:GetObject"], function(obj) QBCore = obj end)

                    breakPoint = breakPoint + 1
                    if breakPoint == 25 then
                        print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                        break
                    end
                end

                return QBCore
            end
            --------------------------
            if objectType == 3 then
                return exports[Config.Events['qb-core']]:GetSharedObject()
            end
            --------------------------
        end

        PlayerData = {}
        local QBCore
        function UpdatePlayerDataForQBCore()
            local pData = QBCore.Functions.GetPlayerData()

            local jobName = "none"
            local gradeLevel = nil
            local gradeName = "none"

            if pData.job then
                jobName = pData.job.name or "none"

                if pData.job.grade then
                    gradeLevel = pData.job.grade.level
                    gradeName = pData.job.grade.name
                end
            end
            PlayerData = {
                job = {
                    name = jobName,
                    grade = gradeLevel,
                    grade_name = gradeName,
                }
            }
        end

        CreateThread(function()
            QBCore = GetQBCoreObject()

            if QBCore and QBCore.Functions.GetPlayerData() then
                UpdatePlayerDataForQBCore()
            end
        end)

        -- Will load player job + update markers
        RegisterNetEvent(Config.OnPlayerLoaded, function()
            UpdatePlayerDataForQBCore()
        end)

        -- Will load player job + update markers
        RegisterNetEvent(Config.OnJobUpdate, function()
            UpdatePlayerDataForQBCore()
        end)

        function isAtJob(name)
            return PlayerData.job.name == name
        end

    -- Uncomment and edit the elseif below to use your own framework. Don't forget to add your framework to Frameworks array!

    -- elseif Config.Framework == Frameworks.YOUR_FRAMEWORK_NAME then
    --     -- copy content of ESX part and rewrite to your framework
    -- end

    else -- Default - if Config.Framework doesn't match with any frameworks above
        print('Job-bridge: Wrong option in frameworks! Using job bridge fallback functions!')

        PlayerData = {
            job = {
                name = 'unemployed',
                grade = 0,
                grade_name = 'none',
            }
        }
    end
end

CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsPlayerActive(PlayerId()) then
            initJobBridge()
            break
        end
    end
end)

--Clear ped of any tattoos and apply selected tattoos
RegisterNetEvent(Config.Events["QBCore:Client:OnPlayerLoaded"], function()
    CreateThread(function()
        Wait(5000)
        TriggerServerEvent(triggerName('reload'))
    end)
end)

--If you are using esx_multichar
RegisterNetEvent(Config.Events['esx:playerLoaded'], function()
    TriggerServerEvent(triggerName('reload'))
end)
