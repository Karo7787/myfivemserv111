local utils = {}
local config = require 'config.client'
local serverConfig = require 'config.server'

--- @param source integer
--- @param message string
--- @param type string
function utils.notify(source, message, type)
    lib.notify(source, { 
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

local function getAmount(item)
    return item.amount or (item.min and item.max and math.random(item.min, item.max)) or 1
end

--- @param items table
--- @param minLoot number
--- @param maxLoot number
function utils.generateLoot(items, minLoot, maxLoot)
    if not items or #items == 0 then
        lib.print.error('Invalid loot configuration: no items provided')
        return {}
    end

    local loot = {}
    local lootAmount = 0
    local attempts = 0
    local maxAttempts = 100

    while lootAmount < minLoot and attempts < maxAttempts do
        for i = 1, #items do
            if lootAmount >= maxLoot then
                break
            end

            local item = items[i]
            local chance = math.random(100)

            if chance <= item.chance then
                local amount = getAmount(item)

                if amount and amount > 0 then
                    if not loot[item.name] then
                        lootAmount = lootAmount + 1
                        loot[item.name] = {
                            amount = amount,
                            metadata = item.metadata or nil
                        }
                    else
                        loot[item.name].amount = math.min(loot[item.name].amount + amount, item.max)
                    end

                    if lootAmount >= maxLoot then
                        break
                    end
                end
            end
        end
        attempts = attempts + 1
    end

    if lootAmount < minLoot then
        return utils.generateLoot(items, minLoot, maxLoot)
    end

    return loot
end

--- @param source integer
--- @param location vector3
--- @param maxDistance number
function utils.checkDistance(source, location, maxDistance)
    if not (type(location) == 'vector3' or type(location) == 'vector4') then
        return false
    end

    local locationCoords = vec3(location.x, location.y, location.z)
    local ped = GetPlayerPed(source)
    local playerPos = GetEntityCoords(ped)

    local distance = #(playerPos - locationCoords)
    return distance < maxDistance
end


---@param source integer
function utils.getPlayerLevel(source)
    local skillName = serverConfig.skills.skillName

    if serverConfig.skills.system == 'evolent_skills' then
        return exports.evolent_skills:getSkillLevel(source, skillName)
    elseif serverConfig.skills.system == 'flight-skills' then
        return exports['flight-skills']:getLevel(source, skillName)
    elseif serverConfig.skills.system == 'cw-rep' then
        return exports['cw-rep']:fetchSkills(source).name
    elseif serverConfig.skills.system == 'pickle_xp' then
        return exports.pickle_xp:GetPlayerLevel(source, skillName)
    end
end

---@param source integer
---@param amount number
function utils.addXp(source, amount)
    local skillName = serverConfig.skills.skillName

    if serverConfig.skills.system == 'evolent_skills' then
        return exports.evolent_skills:addXp(source, skillName, amount)
    elseif serverConfig.skills.system == 'flight-skills' then
        return exports['flight-skills']:addXP(source, skillName, amount)
    elseif serverConfig.skills.system == 'cw-rep' then
        return exports['cw-rep']:updateSkill(source, skillName, amount)
    elseif serverConfig.skills.system == 'pickle_xp' then
        return exports.pickle_xp:AddPlayerXP(source, skillName, amount)
    end
end

---@param source integer
function utils.getGroup(source)
    if serverConfig.groups.system == 'slrn_groups' then
        return exports.slrn_groups:GetGroupByMembers(source)
    elseif serverConfig.groups.system == 'yseries' then
        return exports.yseries:FindGroupByMember(source)
    end
end

---@param source integer
---@param group table
function utils.isGroupLeader(source, group)
    if serverConfig.groups.system == 'slrn_groups' then
        return exports.slrn_groups:isGroupLeader(source, group)
    elseif serverConfig.groups.system == 'yseries' then
        return exports.yseries:IsGroupLeader(group, source)
    end
end

function utils.triggerGroupEvent(group, event, args)
    if serverConfig.groups.system == 'slrn_groups' then
        return exports.slrn_groups:triggerGroupEvent(event, group, args)
    elseif serverConfig.groups.system == 'yseries' then
        return exports.yseries:SendGroupEvent(group, event, args)
    end
end

---@param group string
---@param header string
---@param message string
function utils.notifyGroup(group, header, message)
    if serverConfig.groups.system == 'slrn_groups' then
        return exports.slrn_groups:pNotifyGroup(group, header, message)
    elseif serverConfig.groups.system == 'yseries' then
        return exports.yseries:NotifyGroup(group, message, 3000)
    end
end

---@param group number
function utils.getGroupSize(group)
    if serverConfig.groups.system == 'slrn_groups' then
        return exports.slrn_groups:getGroupSize(group)
    elseif serverConfig.groups.system == 'yseries' then
        return exports.yseries:GetGroupMembersCount(group)
    end
end

function utils.handleExploit(source)
    -- If this is triggered, 99% of the time the player is cheating or doing something weird. Take precautions and investigate the player.
    DropPlayer(source, locale('exploit.exploiting_server'))
    utils.logPlayer(source, { locale('exploit.exploiting_server') })
end

---@param houseType 'ipl' | 'shell'
---@param houseTier number
---@param houseLevel number
function utils.houseBrokenInto(houseType, houseTier, houseLevel)

end

---@param houseType 'ipl' | 'shell'
---@param houseTier number
---@param houseLevel number
function utils.houseExited(houseType, houseTier, houseLevel)

end

---@param houseType 'ipl' | 'shell'
---@param houseTier number
---@param houseLevel number
function utils.furnitureSearched(houseType, houseTier, houseLevel)
    
end

--- @param source integer
--- @param data table
function utils.logPlayer(source, data)
    if not serverConfig.logging.enabled then return end

    if serverConfig.logging.system == 'ox_lib' then
        lib.logger(source, 'House Robbery', data.message)
    elseif serverConfig.logging.system == 'discord' then
        local playerName = GetPlayerName(source)
        local identifiers = GetPlayerIdentifiers(source)
    
        local playerIdentifiers = {}
    
        for _, id in pairs(identifiers) do
            if id:find('discord:') then
                playerIdentifiers.discord = id:gsub('discord:', '')
            elseif id:find('steam:') then
                playerIdentifiers.steam = id:gsub('steam:', '')
            elseif id:find('license:') then
                playerIdentifiers.license = id:gsub('license:', '')
            elseif id:find('license2:') then
                playerIdentifiers.license2 = id:gsub('license2:', '')
            elseif id:find('xbl:') then
                playerIdentifiers.xbox = id:gsub('xbox:', '')
            elseif id:find('live:') then
                playerIdentifiers.live = id:gsub('live:', '')
            elseif id:find('ip:') then
                playerIdentifiers.ip = id:gsub('ip:', '')
            elseif id:find('fivem:') then
                playerIdentifiers.ip = id:gsub('fivem:', '')
            end
        end
    
        local logMessage = ('%s\n\n**Player Identifiers:**\n' ..
            'Player: %s\n' ..
            'FiveM: %s\n' ..
            'Discord: %s\n' ..
            'Steam: %s\n' ..
            'License: %s\n' ..
            'License2: %s\n' ..
            'Xbox: %s\n' ..
            'Live: %s\n' ..
            'IP: %s'):format(
            data.message, 
            playerName,
            playerIdentifiers.fivem or 'Unknown',
            playerIdentifiers.discord or 'Unknown',
            playerIdentifiers.steam or 'Unknown',
            playerIdentifiers.license or 'Unknown',
            playerIdentifiers.license2 or 'Unknown',
            playerIdentifiers.xbl or 'Unknown',
            playerIdentifiers.live or 'Unknown',
            playerIdentifiers.ip or 'Unknown'
        )
    
        local payload = {
            username = serverConfig.logging.name,
            avatar_url = serverConfig.logging.image,
            embeds = {}
        }
    
        if data.title then
            if data.title:find("^Włamanie do mebli") then
                TriggerEvent("sfctab:server:quests:progress", source, "gohouse", 1)
                TriggerEvent("sfctab:server:quests:progress", source, "gohouse2", 1)
            end
            table.insert(payload.embeds, {
                color = data.color,
                title = ('**%s**'):format(data.title),
                description = logMessage,
                footer = {
                    text = os.date('%a %b %d, %I:%M%p'),
                    icon_url = serverConfig.logging.image
                }
            })
        end
    
        if #payload.embeds == 0 then
            payload.embeds = nil
        end

        PerformHttpRequest(serverConfig.logging.webhookUrl, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
    end
end

return utils
