local utils = {}
local serverConfig = require 'config.server'

--- @param message string
--- @param type string
function utils.notify(message, type)
    lib.notify({ 
        position = 'top',
        title = 'House Robbery',
        description = message, 
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        type = type 
    })
end

---@param houseTier number
function utils.furnitureMinigame(houseTier)
    local difficulty

    difficulty = {'easy'}

    local success = lib.skillCheck(difficulty, {'1', '2', '3', '4'})
    return success
end

---@param shellTier number
function utils.shellMinigame(shellTier)
    local difficulty

    if shellTier == 1 then
        difficulty = {'easy', 'easy', 'easy', 'easy', 'easy', 'easy'}
    elseif shellTier == 2 then
        difficulty = {'easy', 'easy', 'medium', 'easy', 'medium'}
    elseif shellTier == 3 then
        difficulty = {'easy', 'medium', 'medium', 'medium', 'medium'}
    end

    local success = lib.skillCheck(difficulty, {'1', '2', '3', '4'})
    if success then
        TriggerServerEvent("esx_basicneeds:TakeFoodItem", serverConfig.startPed.item.name)
        if not exports['mrg_achivements']:CheckIsUnlocked('mieszkania') then
            TriggerServerEvent("mrg_achivements:UnlockAchivements", "mieszkania", 1)
        end
        if not exports['mrg_achivements']:CheckIsUnlocked('mieszkania-2') then
            TriggerServerEvent("mrg_achivements:UnlockAchivements", "mieszkania-2", 1)
        end
    end
    return success
end

---@param iplTier number
function utils.iplMinigame(iplTier)
    local difficulty

    if iplTier == 1 then
        difficulty = {'easy', 'easy', 'easy', 'easy', 'easy', 'easy'}
    elseif iplTier == 2 then
        difficulty = {'easy', 'easy', 'medium', 'easy', 'medium'}
    elseif iplTier == 3 then
        difficulty = {'easy', 'medium', 'medium', 'medium', 'medium'}
    end

    local success = lib.skillCheck(difficulty, {'1', '2', '3', '4'})
    if success then
        TriggerServerEvent("esx_basicneeds:TakeFoodItem", serverConfig.startPed.item.name)
        if not exports['mrg_achivements']:CheckIsUnlocked('mieszkania') then
            TriggerServerEvent("mrg_achivements:UnlockAchivements", "mieszkania", 1)
        end
        if not exports['mrg_achivements']:CheckIsUnlocked('mieszkania-2') then
            TriggerServerEvent("mrg_achivements:UnlockAchivements", "mieszkania-2", 1)
        end
    end
    return success
end

function utils.progressBar(config, onComplete, onCancel)
    if lib.progressCircle({
        duration = config.duration,
        label = config.label,
        position = config.position,
        useWhileDead = config.useWhileDead,
        canCancel = config.canCancel,
        disable = config.disable or {},
        anim = config.anim or {},
        prop = config.prop or {},
    }) then
        if onComplete then
            onComplete()
        end
    else
        if onCancel then
            onCancel()
        end
    end
end

function utils.playSound(entity, sound)
    while not RequestScriptAudioBank('audiodirectory/peak_houserobbery', false) do 
        Wait(0)  
    end
        
    local soundId = GetSoundId()
    PlaySoundFromEntity(soundId, sound, entity, 'peak_houserobbery', true)
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank('audiodirectory/peak_houserobbery')
end

function utils.getPlayerLevel()
    local skillName = serverConfig.skills.skillName

    if serverConfig.skills.system == 'evolent_skills' then
        return exports.evolent_skills:getSkillLevel(skillName)
    elseif serverConfig.skills.system == 'flight-skills' then
        return exports['flight-skills']:getLevel(skillName)
    elseif serverConfig.skills.system == 'cw-rep' then
        return exports['cw-rep']:getCurrentLevel(skillName)
    elseif serverConfig.skills.system == 'pickle_xp' then
        return exports.pickle_xp:GetLevel(skillName)
    end
end

return utils