Config.RadioList = {}

Config.RadioList.Enabled = true -- set to false to disable

Config.RadioList.ToggleKey = 'G' -- KEY TO TOGGLE RADIO LIST [TO DISABLE SET TO FALSE]

Config.RadioList.RestrictedJobs = false

Config.RadioList.ChangePageKeys = {
    ['left'] = 'LEFT', -- left arrow
    ['right'] = 'RIGHT', -- right arrow
}

Config.RadioList.ChannelNames = exports["mrg_ui"]:GetRadios()

Config.RadioList.TalkingDelay = 0 -- ms [anti spam for radio]

Config.RadioAnimations = {
    {
        label = 'Na ramieniu',
        animDict = 'random@arrests',
        animClip = 'generic_radio_chatter',
        animFlag = 50,
        isDefault = true -- default animation [you can set other]
    },
    {
        label = 'Slow talk',
        animDict = 'amb@code_human_police_investigate@idle_a',
        animClip = 'idle_b',
        animFlag = 50,
    },
    {
        label = 'Na klatce piersiowej',
        animDict = 'anim@cop_mic_pose_002',
        animClip = 'chest_mic',
        animFlag = 50,
    },
    {
        label = 'W dłoni',
        animDict = 'cellphone@',
        animClip = 'cellphone_text_read_base',
        animFlag = 50,
    },
    {
        label = 'Przy twarzy',
        animDict = 'anim@radio_left',
        animClip = 'radio_left_clip',
        animFlag = 50,
        prop = {
            model = 'prop_cs_hand_radio',
            bone = 60309,
            coords = vector3(0.075, 0.047, 0.011),
            rotation = vector3(-97.9442, 3.7058, -23.2367),
        }
    },
    {
        label = 'Przy twarzy 2',
        animDict = 'anim@male@holding_radio',
        animClip = 'holding_radio_clip',
        animFlag = 50,
        prop = {
            model = 'prop_cs_hand_radio',
            bone = 6286,
            coords = vector3(0.08, 0.03, -0.01),
            rotation = vector3(-59.99, 15.54, -52.55),
        }
    },
}

-- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/ [KEYS HERE]