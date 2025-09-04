Config.Impound = {}

--@param Config.Impound.AllowedJobs: {[jobName]: grade}
Config.Impound.AllowedJobs = Config.Jobs -- same as Config.Jobs, you can modify this to restrict impounding to certain jobs

--@param Config.Impound.Time: number [how long it will take to impound a vehicle in seconds]
Config.Impound.Time = 20

Config.Impound.Locations = {
    -- UNIQUE NAME [Vehicle will be only available at location selected by officer]
    ['Los_Santos'] = {
        label = 'Los Santos Impound Lot', -- label for the impound lot
        ped = {
            model = 's_m_y_cop_01', -- model of the ped that will be spawned at the impound lot [https://forge.plebmasters.de/peds]
            anim = {dict = 'amb@world_human_cop_idles@male@base', anim = 'base', flag = 1}, -- animation dictionary and name [https://forge.plebmasters.de/animations]
        },
        coords = vector4(409.2483, -1622.8567, 29.2919, 227.7229), -- coords of target and ped
    }
}