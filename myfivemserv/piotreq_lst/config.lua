Config = {}

Config.Language = 'pl' -- pl / en
Config.Framework = 'ESX' -- ESX / QB / QBOX
Config.SSN = Config.Framework == 'ESX' and 'id' or 'cid' -- column name ssn in users db

Config.RadioChannels = {
    ["1"] = 'LSC'
}

Config.Jobs = {
    ['mechanic'] = {
        image = 'img/mechanic.png',
        mainColor = '#d3eb46',
        mainColorHover = '#ddea4e',
        bgColor = '#171811'
    }
}

Config.MechanicLicenses = {
    ['flatbed'] = {label = 'Flatbed License', access = {['mechanic'] = 0}},
}

Config.Shop = {
    ['mechanic'] = {
        {
            itemName = 'parts_default',
            label = 'Default Parts',
            price = 50
        },
        {
            itemName = 'parts_vip',
            label = 'VIP Parts',
            price = 150
        },
        {
            itemName = 'flatbed_remote',
            label = 'Pilot',
            price = 150
        },
        {
            itemName = 'rug',
            label = 'Ręcznik',
            price = 50
        },
        {
            itemName = 'tire',
            label = 'Opona',
            price = 250
        },
        {
            itemName = 'engine_oil',
            label = 'Olej silnikowy',
            price = 250
        },
        {
            itemName = 'gear_oil',
            label = 'Olej skrzyni biegów',
            price = 250
        },
        {
            itemName = 'brake_system',
            label = 'Układ hamulcowy',
            price = 250
        },
        {
            itemName = 'fixkit',
            label = 'Zestaw Naprawczy',
            price = 350
        },

    }
}

Config.DeliveryTime = 10 -- time in minutes
Config.DeliveryStahes = {
    ['mechanic'] = 'mechanic_stash_1' -- stash name for mechanic job
}

Config.Vehicles = {
    ['msc_komoda'] = { label = 'Komoda', price = 500, type = 'car'},
    ['msc_caracara'] = { label = 'Caracara', price = 2500, type = 'car'}
}

Config.Access = {
    ['mechanic'] = { -- for job police
        ['0'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['1'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['2'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['3'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['4'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['5'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['6'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['7'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['8'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = false
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = false, ['reset_time_all'] = false, ['update'] = false, ['fire'] = false, ['add_note'] = false, ['delete_note'] = false,
                ['break'] = false, ['add_license'] = false, ['delete_license'] = false, ['change_badge'] = false, ['reset_time_employee'] = false,
                ['set_photo'] = false
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['9'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = false, ['impound'] = true, ['manage'] = false
            },
            ['orders'] = {
                ['order'] = true
            }
        },
        ['10'] = {
            ['home'] = {
                ['last_customers'] = true, ['last_repairs'] = true, ['most_active_employees'] = true,
                ['duty_time'] = true, ['last_active'] = true
            },
            ['announcements'] = {
                ['create'] = true, ['delete'] = true
            },
            ['repairs'] = {
                ['create_repair'] = true
            },
            ['employees'] = {
                ['add'] = true, ['reset_time_all'] = true, ['update'] = true, ['fire'] = true, ['add_note'] = true, ['delete_note'] = true,
                ['break'] = true, ['add_license'] = true, ['delete_license'] = true, ['change_badge'] = true, ['reset_time_employee'] = true,
                ['set_photo'] = true
            },
            ['garage'] = {
                ['buy'] = true, ['impound'] = true, ['manage'] = true
            },
            ['orders'] = {
                ['order'] = true
            }
        },

    }
}