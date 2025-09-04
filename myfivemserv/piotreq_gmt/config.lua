Config = {}

Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.Language = 'pl' -- en / pl
Config.SSN = 'id' -- column name ssn in users db

Config.Debug = false

Config.RadioChannels = exports["mrg_ui"]:GetRadios()

Config.Jobs = {
    ['lsfd'] = {
        image = 'img/lsfd.png',
        mainColor = '#dc9748',
        mainColorHover = '#dcad48',
        bgColor = '#2b221b'
    },
    ['ambulance'] = {
        image = 'img/lspd.png',
        mainColor = '#dc4848',
        mainColorHover = '#ea4e4e',
        bgColor = '#181111'
    }
}

Config.Units = {
    'ADAM', 'MERRY', 'EAGLE', 'SEU' -- for creating patrols
}

Config.Vehicles = {
    ['ambulance'] = { label = 'Karetka', price = 1, type = 'car', access = {'ambulance', 'lsfd'} },
    ['firetruk'] = { label = 'MTL Fire Truck', price = 1, type = 'car', access = {'lsfd'} },   
    ['slrr'] = { label = 'Vapid Ladder Truck', price = 2500, type = 'car', access = {'lsfd'} },   
    ['mmladder'] = { label = 'MTL Ladder Truck', price = 500, type = 'car', access = {'lsfd'} },   
    ['fdl300'] = { label = 'Benfefactor Brush Truck', price = 10000, type = 'car', access = {'lsfd'} },   
    ['bfdsuv'] = { label = 'Declasse Granger 3600LX', price = 2500, type = 'car', access = {'lsfd'} },
    ['nkballer7ems'] = { label = 'Baller EMS', price = 500, type = 'car', access = {'ambulance'} },
    ['nkcaracara2ems'] = { label = 'Caracara EMS', price = 2500, type = 'car', access = {'ambulance'} },
    ['nkstxems'] = { label = 'STX EMS', price = 2500, type = 'car', access = {'ambulance'} }
}

Config.SecondOwner = 'co_owner' -- name of column in owned_vehicles or nil

Config.Documents = {
    ['psycholgy'] = {label = 'Badania Psychologiczne', access = {['ambulance'] = 0}},
}

Config.WorkersLicenses = {
    ['eagle'] = {label = 'Licencja EAGLE', access = {['ambulance'] = 0, ['lsfd'] = 0}},
    ['lsfd_paramedic'] = {label = 'Licencja PARAMEDIC', access = {['lsfd'] = 0}},
}

Config.AddKeys = function(plate)
    print(plate)
    exports["mrg_carkeys"]:AddKey(plate)
end

Config.RemoveKeys = function(plate)
    exports["mrg_carkeys"]:RemoveKey(plate)
end

Config.Spawners = {
    ['Pillbox'] = {
        coords = vector4(86.32, -413.04, 84.4, 63.01), -- if ped it will be coords of ped and his heading
        radius = 0.75,
        drawSprite = true,
        debug = false,
        ped = { -- optional
            model = 's_m_m_paramedic_01',
            anim = {}, -- optional, you can add dict, clip and flag
        }, 
        options = {
            {
                type = 'spawn',
                name = 'Pillbox_Spawn_Helicopters',
                label = 'Wyciągnij Helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['ambulance'] = 0},
                license = 'eagle', -- license name from gmt_licenses table in db (optional)
                coords = vector4(94.91, -418.91, 86.07, 65.71), -- coords to spawn veh
                needDuty = false,
                vehicle = {
                    model = 'polmav', -- spawn name
                    tune = true, -- full tune
                    livery = 1, -- optional livery
                    plate = 'EMS%s', -- %s = GMT.Editable.FormatPlate in client
                }
            },
            {
                type = 'hide',
                name = 'Pillbox_Hide_Helicopters',
                label = 'Schowaj Helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['ambulance'] = 0},
                license = 'eagle', -- license name from gmt_licenses table in db (optional)
                coords = vector4(94.91, -418.91, 86.07, 65.71), -- coords to hide veh
                needDuty = false,
            },
        }
    },
    ['VFD_HELI'] = {
        coords = vector4(-1044.26, -1431.64, 9.56, 157.86), -- if ped it will be coords of ped and his heading
        radius = 0.75,
        drawSprite = true,
        debug = false,
        ped = { -- optional
            model = 's_m_y_fireman_01',
            anim = {}, -- optional, you can add dict, clip and flag
        }, 
        options = {
            {
                type = 'spawn',
                name = 'VFD_HELI_Spawn_Helicopters',
                label = 'Wyciągnij Helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['lsfd'] = 0},
                license = 'eagle', -- license name from gmt_licenses table in db (optional)
                coords = vector4(-1039.61, -1439.45, 9.5, 81.75), -- coords to spawn veh
                needDuty = true,
                vehicle = {
                    model = 'fdpolmav', -- spawn name
                    tune = true, -- full tune
                    livery = 2, -- optional livery
                    plate = 'FD%s', -- %s = GMT.Editable.FormatPlate in client
                }
            },
            {
                type = 'hide',
                name = 'VFD_HELI_Hide_Helicopters',
                label = 'Schowaj Helikopter',
                icon = 'fa-solid fa-helicopter',
                distance = 2,
                jobs = {['lsfd'] = 0},
                license = 'eagle', -- license name from gmt_licenses table in db (optional)
                coords = vector4(-1039.61, -1439.45, 9.5, 81.75), -- coords to hide veh
                needDuty = true,
            },
        }
    },
    ['VFD_BOAT'] = {
        coords = vector4(-998.46, -1409.15, 1.6, 152.03), -- if ped it will be coords of ped and his heading
        radius = 0.75,
        drawSprite = true,
        debug = false,
        ped = { -- optional
            model = 's_m_y_fireman_01',
            anim = {}, -- optional, you can add dict, clip and flag
        }, 
        options = {
            {
                type = 'spawn',
                name = 'VFD_BOAT_Spawn_Boat',
                label = 'Wyciągnij Łódź',
                icon = 'fa-solid fa-ship',
                distance = 2,
                jobs = {['lsfd'] = 0},
                coords = vector4(-998.73, -1400.38, 0.47, 19.07), -- coords to spawn veh
                needDuty = true,
                vehicle = {
                    model = 'fireboat', -- spawn name
                    tune = true, -- full tune
                    plate = 'FD%s', -- %s = GMT.Editable.FormatPlate in client
                }
            },
            {
                type = 'hide',
                name = 'VFD_BOAT_Hide_boat',
                label = 'Schowaj Łódź',
                icon = 'fa-solid fa-ship',
                distance = 2,
                jobs = {['lsfd'] = 0},
                coords = vector4(-998.73, -1400.38, 0.47, 19.07), -- coords to hide veh
                needDuty = true,
            },
        }
    }
}

Config.Access = {
    ['ambulance'] = { -- for job ambulance
        ['0'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = false, ['add_allergy'] = false, ['delete_allergy'] = false, 
                ['add_procedure'] = false, ['delete_note'] = false, ['delete_procedure'] = false,
                ['set_photo'] = false
            },
            ['documents'] = {
                ['add_document'] = false, ['delete_document'] = false
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = false, ['delete_wheelchair'] = false
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = false
        },
        ['1'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['2'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['3'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['4'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['5'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['6'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['7'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['8'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
        ['9'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
        ['10'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
    },
    ['lsfd'] = { -- for job lsfd
        ['0'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ["raports"] = true,
            ['citizens'] = { -- medic cards
                ['add_note'] = false, ['add_allergy'] = false, ['delete_allergy'] = false, 
                ['add_procedure'] = false, ['delete_note'] = false, ['delete_procedure'] = false,
                ['set_photo'] = false
            },
            ['documents'] = {
                ['add_document'] = false, ['delete_document'] = false
            },
            ['announcements'] = {
                ['create'] = false, ['delete'] = false
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = false, ['delete_wheelchair'] = false
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = false
        },
        ['1'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['2'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['3'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['4'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['5'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['6'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ["raports"] = true,
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['7'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['8'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['9'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['10'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ["raports"] = true,
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = false, ['manage'] = false
            },
            ['judgements'] = true
        },
        ['11'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ["raports"] = true,
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
        ['12'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ["raports"] = true,
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
        ['13'] = {
            ['home'] = {
                ['last_procedures'] = true, ['last_assigned_wheelchairs'] = true, ['most_active_employees'] = true,
                ['change_code'] = false, ['duty_time'] = true, ['last_active'] = true
            },
            ["raports"] = true,
            ['patrols'] = {
                ['create'] = true, ['join'] = true
            },
            ['citizens'] = { -- medic cards
                ['add_note'] = true, ['add_allergy'] = true, ['delete_allergy'] = true, 
                ['add_procedure'] = true, ['delete_note'] = true, ['delete_procedure'] = true,
                ['set_photo'] = true
            },
            ['documents'] = {
                ['add_document'] = true, ['delete_document'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['wheelchairs'] = {
                ['add_wheelchair'] = true, ['delete_wheelchair'] = true
            },
            ['notepad'] = true,
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['judgements'] = true
        },
    }
}