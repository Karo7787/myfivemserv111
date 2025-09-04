-- Businesses
ConfigBusiness = {}

ConfigBusiness.DefaultMargin = 20 -- price margin in percent (percentage of price business will receive on tattoo purchase)
ConfigBusiness.MinMargin = 0 -- minimal price margin that business owner can set in percents
ConfigBusiness.MaxMargin = 100 -- maximal price margin that business owner can set in percents

-- Tattooing Minigame
ConfigBusiness.MinigameDifficulty = 1.0 -- Multiplier of tattooing minigame difficulty, default = 1.0
ConfigBusiness.MinigameConfirmTimeout = 10000 -- Time in ms for employee to confirm start of tattooing, default = 10000 (10sec)
ConfigBusiness.TutorialReadTimeFirst = 4000 -- Time in ms for employee to read minigame tutorial before it starts for first time since logging in to server, default = 4000 (4s)
ConfigBusiness.TutorialReadTime = 500 -- Same as `TutorialReadTimeFirst`, but for all but first minigame plays, default = 500 (0.5s)

-- If true, grades defined for the specific business here in config will be added to ESX `job_grades` table.
-- For settings of the grades, check the documentation.
ConfigBusiness.AutoInsertJobGrades = true

-- Settings for ESX bossmenu
ConfigBusiness.DefaultESXMenuOptions = {
    withdraw = true,
    deposit = true,
    wash = false,
    employees = true,
    grades = true,
}

ConfigBusiness.Businesses = {
    basic_job = {
        enabled = false,
        businessName = "tattooshop",
        owner = "",
        bossMenu = {
            pos   = vector3(1862.2, 3748.2, 33),
            size  = vector3(1, 1, 1),
            color = {r=255, g=255, b=255, a=255},
            markerLabel = '💼'
        },
        job = {
            enabled = false,
            label= "Tattoo shop",
            employeeMarkerLabel = "🖌",
            customerAnim = {
                sitting = {
                    pos = vector4(1864.0, 3746.6, 33.2, 0),
                    animName = 'ig_5_p3_base',
                    animDict = 'timetable@ron@ig_5_p3',
                },
            },
            employeeAnim = {
                idle = {
                    pos = vector3(1863.34, 3746.0, 33),
                    animName = '_idle_a',
                    animDict = 'random@shop_tattoo',
                },
                tattoo = {
                    animName = 'machinic_loop_mechandplayer',
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                },
            },
            grades = {
                {
                    name = 'novice',
                },
                {
                    name = 'artist',
                },
                {
                    name = 'boss',
                    isBoss = true,
                },
            },
        },
    }
}
