Config.Objects = {}

Config.Objects.NeedDuty = true -- need to be on duty to remove props?
Config.Objects.Type = 'vehicle' -- menu / vehicle [vehicle = only available in vehicle trunk]
Config.Objects.RequireOpenTrunk = true -- need to open trunk to access objects?
Config.Objects.maxObjectsPerUse = 10 -- max objects per use through object menu

-- TODO:
-- Config.Objects.PoliceTape = {
--     tapeModel = 'prop_cordon_tape',
-- }

-- THIS IS FOR VEHICLE TRUNK
Config.Objects.RestrictedVehicles = {}

-- THIS IS FOR OBJECTS MENUd
Config.Objects.Jobs = {
    ['police'] = {
        ['p_ld_stinger_s'] = locale('stinger'),
        ['prop_consign_01a'] = locale('consign'),
        ['prop_roadcone02a'] = locale('roadcone'),
        ['prop_barrier_work05'] = locale('barrier'),
        ['bzzz_police_props_screen_a'] = "Miejsce zbrodni",
        ['bzzz_police_props_number_a'] = "Tabliczka #1",
        ['bzzz_police_props_number_b'] = "Tabliczka #2",
        ['bzzz_police_props_number_c'] = "Tabliczka #3",
        ['bzzz_police_props_number_d'] = "Tabliczka #4",
        ['bzzz_police_props_number_e'] = "Tabliczka #5",
        ['bzzz_police_props_cone_blue_anim'] = locale('roadcone_light'),
        ['reh_prop_reh_outline_01a'] = locale('tape')
    },
    ['lsfd'] = {
        ['prop_consign_01a'] = locale('consign'),
        ['prop_mp_arrow_barrier_01'] = "Barierka z strzałką",
        ['prop_barrier_work06a'] = "Barierka robotnicza (Bez znaku)",
        ['prop_barrier_work06b'] = "Barierka robotnicza (Z znakiem)",
        ['bzzz_police_props_sign_a'] = "Uwaga, wykopy",
        ['bzzz_police_props_sign_b'] = "Uwaga, zwolnij",
        ['bzzz_police_props_roadclosed_a'] = "Barierka Droga zamknięta",
        ['prop_roadcone02a'] = locale('roadcone'),
        ['prop_barrier_work05'] = locale('barrier'),
        ['bzzz_police_props_cone_red_anim'] = locale('roadcone_light')
    }
}

Config.Objects.SpikeStripItem = {
    enabled = false, -- IF YOU WANT SPIKE TRIPS AS ITEM, REMOVE MODEL 'p_ld_stinger_s' FROM CONFIG ABOVE
    jobRestricted = true, -- IS ONLY ALLOWED FOR JOBS?
    allowedJobs = Config.Jobs,
}

Config.Objects.ShowHelpNotify = function()
    if GetResourceState('p_helper') == 'started' then
        exports['p_helper']:showHelper({
            {
                keys = {'X'},
                label = locale('cancel')
            },
            {
                keys = {'<', '>'},
                label = locale('rotate_left_right')
            },
            {
                keys = {'E'},
                label = locale('confirm')
            },
        })
    else
        lib.showTextUI('[X] - '..locale('cancel')..' | [<] [>] - '..locale('rotate_left_right')..'  | [E] - '..locale('confirm')..'')
    end
end

Config.Objects.HideHelpNotify = function()
    if GetResourceState('p_helper') == 'started' then
        exports['p_helper']:hideHelper()
    else
        lib.hideTextUI()
    end
end