Config.GPS = {}

Config.GPS.NeedDuty = true -- true | false (need to be on duty to turn on/off gps?)

Config.GPS.DutyCheck = function()
    if GetResourceState('piotreq_jobcore') == 'started' then
        local dutyData = exports['piotreq_jobcore']:GetDutyData()
        if dutyData.status ~= 1 then
            return false
        end
    end

    return true
end

Config.GPS.ShortRange = true -- only visible closests blips on minimap

Config.GPS.RefreshRate = 2500 -- 2.5s

Config.GPS.Jobs = {
    ['ambulance'] = {
        color = 59,
        lights = 63,
        display = 'EMS',
        types = {
            onFoot = {
                color = 59,
                lights = 1,
                sprite = 1,
                scale = 1.1,
                heading = true
            },
            inVeh = {
                color = 59,
                lights = 1,
                sprite = 56,
                scale = 1.1,
                heading = true
            },
            boat = {
                color = 59,
                lights = 1,
                sprite = 427,
                scale = 1.1,
                heading = true
            },
            plane = {
                color = 59,
                lights = 1,
                sprite = 43,
                scale = 1.1,
                heading = true
            },
            heli = {
                color = 59,
                lights = 1,
                sprite = 43,
                scale = 1.1,
                heading = true
            },
            bike = {
                color = 59,
                lights = 1,
                sprite = 1,
                scale = 1.1,
                heading = true
            },
        }
    },
}