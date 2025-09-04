Config.Megaphone = {}

--@param enabled: boolean [true/false]
Config.Megaphone.Enabled = true -- set to false to disable megaphone feature

--@param forceRange: number
Config.Megaphone.forceRange = 50.0 -- proximity range

--@param enableSubmix: boolean
Config.Megaphone.enableSubmix = true -- submix for megaphone?

--@param allowedJobs: table / false
Config.Megaphone.allowedJobs = { -- set to false to allow everyone
    ['police'] = true
}