Config = {}

Config.Debug = false
Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.Language = 'pl' -- en / pl
Config.MechanicMDT = GetResourceState('piotreq_lst') ~= 'missing'

Config.TrimPlate = function(plate)
    return (string.gsub(plate, "^%s*(.-)%s*$", "%1"))
end

Config.Workshops = {
    ['mechanic'] = {
        coords = vector3(-333.62, -139.75, 39.01),
        size = vector3(85.0, 85.0, 60.0),
        rotation = 180.7125,
        blip = {
            label = 'Illegal Customs',
            sprite = 402,
            color = 44,
            scale = 0.9
        }
    }
}
Config.TuningPoints = {
    [1] = vector3(-333.29, -133.02, 38.92),
    [2] = vector3(-339.89, -160.43, 38.6),
    [3] = vector3(-347.93, -158.36, 38.6)
}

Config.Repairs = {
    engineTime = 7500,
    bodyTime = 7500,
    tireTime = 15000,
    oilTime = 7500,
    brakesTime = 7500,
    nitroTime = 15000,
    cleanTime = 5000,
    checkTime = 5000
}

Config.OutfitsAccess = {
    ['mechanic'] = 0
}

Config.Radio = {
    [4] = { -- frequency
        jobs = {['mechanic'] = true},
        label = "MECH"
    },
    [5] = {
        jobs = {['mechanic'] = true},
        label = "MECH"
    },
    [6] = {
        jobs = {['mechanic'] = true},
        label = "MECH"
    },
}

Config.Parts = {
    [0] = { -- for vehicle class Compacts
        engine = { -- for engine
            [{0, 1000}] = { -- engine health 0-100
                [1] = {part = 'parts_default', count = 1} -- need this items to repair
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil', -- item name
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [1] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [2] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [3] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [4] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [5] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [6] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [7] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 2}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [8] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [9] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [12] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [14] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [15] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [16] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [17] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [18] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    },
    [20] = {
        engine = {
            [{0, 1000}] = {
                [1] = {part = 'parts_default', count = 1}
            }
        },
        body = {
            [{0, 1000}] = {
                [1] = {part = 'parts_vip', count = 1}
            }
        },
        engineOil = 'engine_oil',
        gearOil = 'gear_oil',
        brakeSystem = 'brake_system'
    }
}

Config.Blacklist = { -- for flatbed
    [10] = true, -- Industrial
    [13] = true, -- Cycles
    [14] = true, -- Boats
    [15] = true, -- Helicopters
    [16] = true, -- Planes
    [17] = true, -- Service
    [20] = true, -- Commercial
    [21] = true -- Trains
}

Config.Flatbeds = {
    {
        model = "flatbed3",
        Extras = {
            [1] = false 
        },
        Attach = vector2(0.0, 1.0),
        Radius = 3.0,
        Default = {
            Pos = vector3(0.0, -3.8, 0.35),
            Rot = vector3(0.0, 0.0, 0.0)
        },
        Active = {
            Pos = vector3(0.0, -8.20, -0.75),
            Rot = vector3(15.0, 0.0, 0.0)
        }
    }
}