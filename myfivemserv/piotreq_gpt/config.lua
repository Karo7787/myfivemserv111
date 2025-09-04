Config = {}

Config.Debug = false -- debug prints
Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.Language = 'pl' -- pl / en
Config.Target = 'ox_target' -- ox_target / qb-target

Config.UseEvidence = true -- enable evidence system [searching by blood, fingerprint, etc.]
Config.EvidenceColumns = {
    ['blood'] = 'blood', -- column from players table in database to search / fetch
    ['fingerprint'] = 'finger', -- column from players table in database to search / fetch
    ['nationality'] = 'nationality' -- column from players table in database to search / fetch
}

Config.TrimPlate = function(plate)
    return (string.gsub(plate, "^%s*(.-)%s*$", "%1"))
end

Config.SSN = 'id' -- database column for unique character id

Config.RadioChannels = exports["mrg_ui"]:GetRadios()

Config.Jobs = {
    ['police'] = {
        image = 'img/lspd.png',
        mainColor = '#48569a',
        mainColorHover = '#5160ab',
        bgColor = '#111318'
    }
}

Config.Units = {
    'ADAM', 'MERRY', 'EAGLE', 'BOY', 'TASK', 'EDWARD' -- for creating patrols (in dropdown menu)
}

Config.Vehicles = {
    ['police'] = {
        ['nkrhinehart'] = { label = 'Rhinehart', price = 1000, type = 'car' },
        ['pbgjv'] = { label = 'Gountlet', price = 2500, type = 'car' },
        ['pdvjv'] = { label = 'Vigero', price = 2500, type = 'car' },
        ['pbgjv'] = { label = 'Grolwer', price = 2500, type = 'car' },
        ['ppgjv'] = { label = 'Gountlet', price = 2500, type = 'car' },
        ['pvccjv'] = { label = 'Caracara', price = 2500, type = 'car' },
        ['nktorrence'] = { label = 'Torrence', price = 250, type = 'car' },
        ['stxhpd'] = { label = 'Buffalo STX', price = 2500, type = 'car' },
        ['sphijv'] = { label = 'Insurgent', price = 2500, type = 'car' },
        ['spvdjv'] = { label = 'Dominator', price = 2500, type = 'car' },
        ['nkcavalcade3'] = { label = 'Cavalcade', price = 2500, type = 'car' },
        ['nkkomoda'] = { label = 'Komoda', price = 2500, type = 'car' },
        ['nktailgaters'] = { label = 'Tailgaters', price = 2500, type = 'car' },
        ['nksadler'] = { label = 'Sadler', price = 2500, type = 'car' },
        ['nkvstr'] = { label = 'VSTR', price = 2500, type = 'car' },
        ['nkaleutian'] = { label = 'Aleutian', price = 2500, type = 'car' },
        ['nkscout'] = { label = 'Scout', price = 250, type = 'car' },
        ['nkstx'] = { label = 'Sheriff STX', price = 2500, type = 'car' },
        ['nkcaracara2'] = { label = 'Sheriff Caracara', price = 2500, type = 'car' },
        ['nkstanier'] = { label = 'Stainer', price = 1, type = 'car' },
        ['nkfugitive'] = { label = 'Fugitive', price = 2500, type = 'car' },

    }
}

Config.DangerCodes = {
    [1] = { -- first danger code is default
        name = 'green',
        label = 'Zielony',
        color = '#47FF70'
    },
    [2] = {
        name = 'orange',
        label = 'Pomarańczowy',
        color = 'orange'
    },
    [3] = {
        name = 'red',
        label = 'Czerwony',
        color = 'red'
    },
    [4] = {
        name = 'black',
        label = 'Czarny',
        color = '#484848'
    },
}

Config.SecondOwner = 'co_owner' -- name of column in owned_vehicles or nil

Config.CitizenLicenses = { -- licenses for citizens
    ['psycholgy'] = {label = 'Badania Psychologiczne', access = {['police'] = 0}},
    ['drive'] = {label = 'Prawo jazdy kat. B', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['drive_truck'] = {label = 'Prawo jazdy kat. C', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['drive_bike'] = {label = 'Prawo jazdy kat. A', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['weapon'] = {label = 'Licencja na broń', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
}

Config.PoliceLicenses = { -- licenses for officers
    ['seu'] = {label = 'Licencja SEU', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['eagle'] = {label = 'Licencja EAGLE', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['dtu'] = {label = 'Licencja DTU', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
    ['SWAT'] = {label = 'Licencja SWAT', access = {['police'] = 0}}, -- license name, label and access [which job and from which grade can add license]
}

Config.AddKeys = function(plate, vehicle, model)
    exports["dbl_carkeys"]:AddKey(plate)
end

Config.RemoveKeys = function(plate, vehicle, model)
    exports["dbl_carkeys"]:RemoveKey(plate)
end

Config.Spawners = {
    ['MissionRow'] = {
        coords = vector4(-1077.47, -826.32, 31.26, 308.97), -- if ped it will be coords of ped and his heading
        radius = 0.75,
        drawSprite = true,
        debug = false,
        ped = { -- optional
            model = 's_m_y_cop_01',
            anim = {}, -- optional, you can add dict, clip and flag
        }, 
        options = {
            {
                type = 'spawn',
                name = 'MissionRow_Spawn_Helicopters',
                label = 'Wyjmij Helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['police'] = 1},
                license = 'eagle', -- license name from gpt_licenses table in db (optional)
                coords = vector4(-1075.35, -813.78, 31.27, 128.04), -- coords to spawn veh
                needDuty = true,
                vehicle = {
                    model = 'polmav', -- spawn name
                    tune = true, -- full tune
                    livery = 0, -- optional livery
                    plate = 'PD%s', -- %s = GPT.Editable.FormatPlate in client
                }
            },
            {
                type = 'hide',
                name = 'MissionRow_Hide_Helicopters',
                label = 'Schowaj helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['police'] = 1},
                license = 'eagle', -- license name from gpt_licenses table in db (optional)
                coords = vector4(-1075.35, -813.78, 31.27, 128.04), -- coords to hide veh
                needDuty = true,
            },
        }
    }
}

Config.LicenseSections = { -- required police license to access sections
    ['cases'] = 'dtu', -- player need "dtu" license to access cases section
    ['evidence'] = 'dtu'
}

Config.ConfiscatePoints = { -- where you can check confiscated vehicles
    ['MissionRow'] = {
        coords = vector3(-1081.72, -823.68, 4.87),
        label = 'Skonfiskowane pojazdy',
        icon = 'fa-solid fa-car',
        drawSprite = true,
        debug = false
    }
}

Config.Access = {
    ['police'] = { -- for job police
        ['0'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = false, ['add_wanted'] = false, ['delete_wanted'] = false, 
                ['add_license'] = false, ['delete_note'] = false, ['delete_license'] = false,
                ['set_photo'] = false
            },
            ['vehicles'] = {
                ['add_note'] = false, ['add_wanted'] = false, 
                ['confiscate'] = false, ['delete_wanted'] = false, ['delete_note'] = false, ['confiscate'] = false
            },
            ['weapons'] = false, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = false, ['jail'] = false, ['custom_jail'] = false, ['custom_fine'] = false
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['1'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['2'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['3'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['4'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['5'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['6'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['7'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['8'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['9'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['10'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['radios'] = true,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = false, ['update'] = false, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            }
        },
        ['11'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = true,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['radios'] = true,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            }
        },
        ['12'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = true,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['radios'] = true,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            }
        },
        ['13'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = true,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['radios'] = true,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            }
        },
        ['14'] = {
            ['home'] = {
                ['last_wanted_citizens'] = true, ['last_wanted_vehicles'] = true, ['most_active_employees'] = false,
                ['change_code'] = true, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = {
                ['add_note'] = true, ['add_wanted'] = true, ['delete_wanted'] = true, 
                ['add_license'] = true, ['delete_note'] = true, ['delete_license'] = true,
                ['set_photo'] = true
            },
            ['vehicles'] = {
                ['add_note'] = true, ['add_wanted'] = true, 
                ['confiscate'] = true, ['delete_wanted'] = true, ['delete_note'] = true, ['confiscate'] = true
            },
            ['weapons'] = true, -- you can set this to false to disable button for this grade a player
            ['evidence'] = false,
            ['radios'] = true,
            ['cases'] = {
                ['create'] = true, ['edit'] = true
            },
            ['judgements'] = {
                ['fine'] = true, ['jail'] = true, ['custom_jail'] = true, ['custom_fine'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            }
        },
    }
    
}