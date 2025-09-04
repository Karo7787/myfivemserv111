function Minigame()
    if not exports['mrg_achivements']:CheckIsUnlocked('obywatele') then
        TriggerServerEvent("mrg_achivements:UnlockAchivements", "obywatele", 1)
    end
    local success = lib.skillCheck({'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w', 'a', 's', 'd'})
    if success then
        TriggerServerEvent("sfctab:quests:progress", "robNpc", 1)
        TriggerServerEvent("sfctab:quests:progress", "robNpc2", 1)
    end
    return success
end

function Dispatch()
    if R.Policenotify == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = R.AlertJobs,
            coords = data.coords,
            title = '10-15 - npcrobbery',
            message = ''..data.sex..' robbing npc at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 59,
                scale = 1.2,
                colour = 39,
                flashes = false,
                text = '911 - npcrobbery',
                time = 5,
                sound = 1,
            }
        })
    elseif R.Policenotify == "ps-dispatch" then
        TriggerServerEvent("r_npcrobbery:piotreq:alert")
    elseif R.Policenotify == "linden_outlawalert" then
        local player = GetEntityCoords(cache.ped)
        local data = { displayCode = "10-15", description = "NPC", isImportant = 1,
        recipientList = R.AlertJobs,
        length = '10000', infoM = 'fa-info-circle', info = "npcrobbery" }
        local dispatchData = { dispatchData = data, caller = 'citizen', coords = player }
        TriggerServerEvent('wf-alerts:svNotify', dispatchData)
    elseif R.Policenotify == "quasar-dispatch" then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = R.AlertJobs,
            callLocation = playerData.coords,
            callCode = { code = 'Npc' },
            message = "A "..playerData.sex.. "Is robbing npc at: ".. playerData.street_1,
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 488,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'npcrobbery',
                time = (20 * 1000),
            }
        })
    elseif R.Policenotify == "core-dispatch" then
        for k, v in pairs(R.AlertJobs) do
            local coords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent("core_dispatch:addMessage", "npcrobbery", coords, v, 5000, 11, 5)
        end
    elseif R.Policenotify == "op-dispatch" then
        for k,v in pairs(R.AlertJobs) do
            local job = v
            local text = "npcrobbery"
            local coords = GetEntityCoords(PlayerPedId())
            local id = GetPlayerServerId(PlayerId())
            local title = "npcrobbery"
            local panic = false
            TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
        end
    else
        print("[NPCROBBERY] Put the police notify system in to the config")
    end
end
