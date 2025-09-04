Config.Radar = {}

Config.Radar.KeyMapper = 'G' -- Press "G" to toggle Police Radar (SET to "" if you dont want key mapper)

-- SPEED UNIT
Config.Radar.Unit = 'KMH' -- MPH / KMH

--@param [side: string]: [key: string]
Config.Radar.LockKeys = {
    ['front'] = 'J',
    ['rear'] = 'M'
}

--@param [jobName: string]
Config.Radar.RestrictedJobs = {
    ['police'] = true,
    ['sheriff'] = true
}

--@param [vehicleModel: string]d
-- REMEMBER TO USE SYNTAX ` INSTEAD OF '
Config.Radar.RestrictedVehicles = {
    [`pbgjv`] = true,
    [`pdvjv`] = true,
    [`ppgjv`] = true,
    [`pvccjv`] = true,
    [`sphijv`] = true,
    [`spvdjv`] = true,
    [`stxhpd`] = true,
    [`nkaleutian`] = true,
    [`nkcaracara2`] = true,
    [`nkcavalcade3`] = true,
    [`nkfugitive`] = true,
    [`nkkomoda`] = true,
    [`nkmanchez3`] = true,
    [`nkomnisegt`] = true,
    [`nkrhinehart`] = true,
    [`nksadler`] = true,
    [`nkscout`] = true,
    [`nkshinobi`] = true,
    [`nkstanier`] = true,
    [`nkstx`] = true,
    [`nksvolito`] = true,
    [`nktorrence`] = true,
    [`nkvstr`] = true,
    [`nktailgaters`] = true
}

Config.Radar.RestrictedDuty = true -- must be on duty to use

-- POLICE SPEED GUN
Config.HandRadar = {}

--@param [jobName: string]: grade [number]
Config.HandRadar.RestrictedJobs = { -- which jobs can use
    ['police'] = 0,
    ['sheriff'] = 0
}

--@param bool: true/false
Config.HandRadar.RestrictedDuty = true -- must be on duty to use