Config.Paramedic = {}

Config.Paramedic.Beds = {
    ['Alta'] = {
        {
            bedCoords = vector4(93.43, -420.36, 40.25, 338.62),
            pedCoords = vector4(92.11, -420.91, 39.38, 279.2),
        }
    }
}

Config.Paramedic.Paramedics = {
    ['Alta'] = {
        coords = vector3(87.89, -412.95, 39.38),
        distance = 4,
        maxMedics = 2, -- if there is more than 2 medics online, paramedic will be disabled
        prices = {
            ['cash'] = 250,
            ['card'] = 250
        },
        ped = {
            coords = vector4(89.76, -413.45, 39.38, 76.07),
            model = 's_m_m_paramedic_01',
        },
    }
}

Config.Paramedic.OfflineMedic = {
    deathTimer = 300,
    useAdvanced = false, -- true = script will spawn ambulance with driver and take you to hospital, false = normal respawn in hospital
    removeItems = true, -- true = script will remove all items from player
    whitelistedItems = { -- this items will not be removed (set to false to remove all items)
        ['phone'] = true,
        ['money'] = true,
        ['simcard'] = true
    },
    driverModel = 's_m_m_paramedic_01',
    ambulanceModels = {
        ['boat'] = 'predator',
        ['heli'] = 'maverick', -- not available for now
        ['car'] = 'ambulance'
    },
    options = {
        ['Pillbox'] = {
            label = 'Los Santos Medical Center',
            destinations = {
                ['car'] = vector3(340.2643, -556.1202, 28.7369),
                ['boat'] = vector3(340.2643, -556.1202, 28.7369),
                ['heli'] = vector3(352.3582, -588.5287, 74.1656) -- not available for now
            },
            spawnCoords = vector4(99.54, -415.88, 39.38, 70.04)
        }
    }
}