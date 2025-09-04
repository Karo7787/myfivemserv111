while not Config do Wait(1) end

--@param coords vector3
--@param radius number
--@param jobs table
Config.Printers = {
    ['CityHall_1'] = {
        coords = vector3(70.38, -901.29, 35.15),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },
    ['CityHall_2'] = {
        coords = vector3(-543.8696, -202.8657, 38.2151),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },

    -- FM CITY HALL LS
    -- ['LS_CityHall_1'] = {
    --     coords = vector3(-560.58, -603.95, 35.65),
    --     radius = 0.5,
    --     jobs = {
    --         ['doj'] = 0,
    --     },
    -- },
    -- ['LS_CityHall_2'] = {
    --     coords = vector3(-567.14, -604.0, 35.7),
    --     radius = 0.5,
    --     jobs = {
    --         ['doj'] = 0,
    --     },
    -- },
}