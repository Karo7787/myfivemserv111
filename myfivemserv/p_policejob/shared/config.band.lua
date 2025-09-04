Config.Band = {}

--@param Enabled: boolean [set to false to disable band functionality]
Config.Band.Enabled = true -- set to false to disable band functionality

--@param jobName: grade [which job name and from which grade can use band]
Config.Band.Jobs = {
    ['police'] = 10,
    -- ['sheriff'] = 0,
}

-- Band blip settings
Config.Band.Blip = {
    scale = 1.2,
    sprite = 1,
    category = 3,
    shrink = true,
    priority = 5,
    height = false,
    color = 6,
    heading = true,
    pulse = false -- set to false to disable pulse blip
}

Config.Band.LoopRate = 1100
Config.Band.UpdateCoordsRate = 900

Config.Band.Prop = {
    model = 'prop_trackingband_01',
    coords = vector3(-0.03, 0.11, 0.01),
    rotation = vector3(-87.96, 0.0, 24.44)
}