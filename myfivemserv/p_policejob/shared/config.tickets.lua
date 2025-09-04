Config.Tickets = {}

--@param enable: boolean [true to enable the ticket system, false to disable it]
Config.Tickets.Enabled = false

--@param jobName: grade [minimum grade required to create a ticket]
Config.Tickets.AllowedJobs = {
    ['police'] = 0,
    ['sheriff'] = 0
}

--@param officerId: number [the ID of the officer who issued the ticket]
--@param targetId: number [the ID of the player who received the ticket]
--@param fineAmount: number [the amount of the fine]
Config.Tickets.OnPlayerFined = function(officerId, targetId, fineAmount)
    -- You can implement any custom logic here when a player is fined.
end

Config.Tickets.Violations = {
    ['police'] = {
        {value = 'speeding', label = locale('speeding')},
        {value = 'reckless_driving', label = locale('reckless_driving')},
        {value = 'running_red_light', label = locale('running_red_light')},
        {value = 'illegal_parking', label = locale('illegal_parking')},
        {value = 'expired_registration', label = locale('expired_registration')},
        {value = 'no_insurance', label = locale('no_insurance')},
        {value = 'no_license', label = locale('no_license')},
        {value = 'driving_without_license', label = locale('driving_without_license')},
        {value = 'driving_under_influence', label = locale('driving_under_influence')},
        {value = 'vehicle_theft', label = locale('vehicle_theft')},
        {value = 'hit_and_run', label = locale('hit_and_run')},
        {value = 'driving_without_seatbelt', label = locale('driving_without_seatbelt')},
        {value = 'other', label = locale('other_violation')}
    },
    ['sheriff'] = {
        {value = 'speeding', label = locale('speeding')},
        {value = 'reckless_driving', label = locale('reckless_driving')},
        {value = 'running_red_light', label = locale('running_red_light')},
        {value = 'illegal_parking', label = locale('illegal_parking')},
        {value = 'expired_registration', label = locale('expired_registration')},
        {value = 'no_insurance', label = locale('no_insurance')},
        {value = 'no_license', label = locale('no_license')},
        {value = 'driving_without_license', label = locale('driving_without_license')},
        {value = 'driving_under_influence', label = locale('driving_under_influence')},
        {value = 'vehicle_theft', label = locale('vehicle_theft')},
        {value = 'hit_and_run', label = locale('hit_and_run')},
        {value = 'driving_without_seatbelt', label = locale('driving_without_seatbelt')},
        {value = 'other', label = locale('other_violation')}
    }
}