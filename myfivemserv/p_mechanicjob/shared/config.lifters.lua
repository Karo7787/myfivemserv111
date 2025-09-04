Config.Lifters = {}

Config.Lifters.Offsets = {
    ['pole'] = {
        [1] = vector3(1.43, -2.88, -0.3),
        [2] = vector3(-1.43, -2.88, -0.3),
        [3] = vector3(-1.43, 2.88, -0.3),
        [4] = vector3(1.43, 2.88, -0.3),
    },
    ['box'] = vector4(1.80, -2.9, 1.35, 0.0)
}

Config.Lifters.Points = {
    [1] = {
        coords = vector4(-321.21, -156.22, 38.01, 250.0),
        maxZ = 40.2,
        minZ = 38.25,
        detachOffset = vector3(0, -6.25, 0.0),
        jobs = {['mechanic'] = 0}
    },
    [2] = {
        coords = vector4(-317.23, -145.29, 38.01, 250.0),
        maxZ = 40.2,
        minZ = 38.25,
        detachOffset = vector3(0, -6.25, 0.0),
        jobs = {['mechanic'] = 0}
    },
    [3] = {
        coords = vector4(-313.38, -134.7, 38.01, 250.0),
        maxZ = 40.2,
        minZ = 38.25,
        detachOffset = vector3(0, -6.25, 0.0),
        jobs = {['mechanic'] = 0}
    },
}