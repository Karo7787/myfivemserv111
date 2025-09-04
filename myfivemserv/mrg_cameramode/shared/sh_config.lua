Shared = {}

--- Camera Mode
Shared.DiscordWebHook = "https://discord.com/api/webhooks/1326964695021654068/Oq6Z42674mteyAkclSJ4OvR41l6okx2NLlShj-VLpbu8IudT4u4bNm0NLQnAFrCUBoNV" 
Shared.Cameramodeheader = 'Tryb Kamery' -- camera mode header text
Shared.MovingX = {Min = -14, Max = 14} -- the maximum and minimum movement horizontaly
Shared.MovingY = {Min = -14, Max = 14} -- the maximum and minimum movement verticaly
Shared.MovingZ = {Min = 0, Max = 8} -- the maximum and minimum movement longitudely ?
Shared.MovingFov = {Min = -12, Max = 40} -- the maximum and minimum FOV
Shared.MaxFilterStrength = 2.6

------ DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING -------
Shared.EndFOV = 20.0
Shared.CameraOffsetStart = vector3(2.20, 2.0, 2.20)
Shared.CameraOffsetEnd = vector3(0.0, 5.0, -0.6)
Shared.CameraTransitionTime = 400
------ DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING -------

--these are all the filters that are used in the camera mode
Shared.Filters = {
    [1] = {
        Name = 'Brak filtra',
        Source = false,
        Color = 'rgb(254,254,254)',
    },
    [2] = {
        Name = 'Czarny i biały',
        Source = 'spectator4',
        Color = 'rgb(0,0,0)',
    },
    [3] = {
        Name = 'Kamera bezpieczeństwa',
        Source = 'CAMERA_secuirity_FUZZ',
        Color = 'rgb(160,80,40)',
    },
    [4] = {
        Name = 'Jasność',
        Source = 'BeastLaunch02',
        Color = 'rgb(240,240,180)',
    },
    [5] = {
        Name = 'Ogniskowanie na środku',
        Source = 'AirRaceBoost01',
        Color = 'rgb(20,224,20)',
    },
    [6] = {
        Name = 'Zielony efekt',
        Source = 'AirRaceBoost02',
        Color = 'rgb(160,224,40)',
    },
    [7] = {
        Name = 'Ostrość',
        Source = 'AmbientPUSH',
        Color = 'rgb(12,12,12)',
    },
    [8] = {
        Name = 'Stary efekt fioletowy',
        Source = 'ArenaEMP',
        Color = 'rgb(140,124,220)',
    },
    [9] = {
        Name = 'Stary efekt jasnoniebieski',
        Source = 'ArenaEMP_Blend',
        Color = 'rgb(42,224,144)',
    },
    [10] = {
        Name = 'Stary efekt brązowy',
        Source = 'BeastIntro01',
        Color = 'rgb(144,64,24)',
    },
    [11] = {
        Name = 'Stary efekt czerwony',
        Source = 'BeastIntro02',
        Color = 'rgb(254,22,22)',
    },
    [12] = {
        Name = 'Plaża zwykła',
        Source = 'ArenaWheelPurple01',
        Color = 'rgb(240,124,220)',
    },
    [13] = {
        Name = 'Plaża wyróżniona',
        Source = 'ArenaWheelPurple02',
        Color = 'rgb(240,24,220)',
    },
    [14] = {
        Name = 'Głębokość',
        Source = 'Bank_HLWD',
        Color = 'rgb(224,22,22)',
    },
    [15] = {
        Name = '420',
        Source = 'Barry1_Stoned',
        Color = 'rgb(44,224,44)',
    },
    [16] = {
        Name = 'Za dużo narkotyków',
        Source = 'BikerFilter',
        Color = 'rgb(122,224,144)',
    },
    [17] = {
        Name = 'Rozmycie w tle',
        Source = 'BarryFadeOut',
        Color = 'rgb(242,224,144)',
    },
    [18] = {
        Name = 'Cień ramki',
        Source = 'BikerForm01',
        Color = 'rgb(4,4,4)',
    },
    [19] = {
        Name = 'Meksykańskie światło filmowe',
        Source = 'Bikers',
        Color = 'rgb(144,82,144)',
    },
    [20] = {
        Name = 'Meksykański film ciemny',
        Source = 'BikersSPLASH',
        Color = 'rgb(144,42,144)',
    },
    [21] = {
        Name = 'Zielony z liniami',
        Source = 'blackNwhite',
        Color = 'rgb(64,224,64)',
    },
    [22] = {
        Name = 'Brudne rozmycie',
        Source = 'BlackOut',
        Color = 'rgb(166,166,166)',
    },
    [23] = {
        Name = 'Różowa gorączka',
        Source = 'BleepYellow02',
        Color = 'rgb(164,44,84)',
    },
    [24] = {
        Name = 'Intensywny rozbłysk',
        Source = 'Bloom',
        Color = 'rgb(222,222,222)',
    },
    [25] = {
        Name = 'Średni rozbłysk',
        Source = 'BloomLight',
        Color = 'rgb(188,188,188)',
    },
    [26] = {
        Name = 'Lekki rozbłysk',
        Source = 'BloomMid',
        Color = 'rgb(144,144,144)',
    },
    [27] = {
        Name = 'Stary telewizor',
        Source = 'Broken_camera_fuzz',
        Color = 'rgb(184,128,42)',
    },
    [28] = {
        Name = 'Gorący niebieski',
        Source = 'BulletTimeDark',
        Color = 'rgb(20,80,244)',
    },
    [29] = {
        Name = 'Gorąca czerwień',
        Source = 'casino_managersoffice',
        Color = 'rgb(244,22,22)',
    },
    [30] = {
        Name = 'Dzień i noc',
        Source = 'casino_mainfloor',
        Color = 'rgb(20,28,84)',
    },
    [31] = {
        Name = 'Stara kamera',
        Source = 'CHOP',
        Color = 'rgb(84,64,42)',
    },
    [32] = {
        Name = 'Światło kinowe',
        Source = 'cinema',
        Color = 'rgb(122,122,144)',
    },
    [33] = {
        Name = 'Intensywne światło kinowe',
        Source = 'cinema_001',
        Color = 'rgb(162,162,184)',
    },
    [34] = {
        Name = 'Czarny i biały rozbłysk',
        Source = 'cops',
        Color = 'rgb(4,4,4)',
    },
    [35] = {
        Name = 'Delikatny fioletowy akcent',
        Source = 'CopsSPLASH',
        Color = 'rgb(162,162,284)',
    },
    [36] = {
        Name = 'Delikatny pomarańczowy akcent',
        Source = 'CrossLine01',
        Color = 'rgb(242,122,24)',
    },
    [37] = {
        Name = 'Czyste tło',
        Source = 'CS1_railwayB_tunnel',
        Color = 'rgb(162,162,284)',
    },
    [38] = {
        Name = 'Usuń wszystkie światła',
        Source = 'downtown_FIB_cascades_opt',
        Color = 'rgb(244,244,82)',
    },
    [39] = {
        Name = 'Czerwony cień',
        Source = 'damage',
        Color = 'rgb(244,24,24)',
    },
    [40] = {
        Name = 'Jasne niebo',
        Source = 'dlc_casino_carpark',
        Color = 'rgb(164,244,244)',
    },
    [41] = {
        Name = 'Żółte akcenty',
        Source = 'DrivingFocusLight',
        Color = 'rgb(244,244,22)',
    },
    [42] = {
        Name = 'Zielone akcenty',
        Source = 'DrivingFocusDark',
        Color = 'rgb(44,244,82)',
    },
    [43] = {
        Name = 'Niebieska kropla',
        Source = 'DRUG_2_drive',
        Color = 'rgb(24,64,242)',
    },
    [44] = {
        Name = 'Fioletowa kropla',
        Source = 'drug_drive_blend02',
        Color = 'rgb(124,24,222)',
    },
    [45] = {
        Name = 'Pod wodą',
        Source = 'Drug_deadman',
        Color = 'rgb(22,184,242)',
    },
    [46] = {
        Name = 'Czysta zieleń',
        Source = 'drug_flying_02',
        Color = 'rgb(44,244,44)',
    },
    [47] = {
        Name = 'Czysty róż',
        Source = 'drug_flying_base',
        Color = 'rgb(224,24,222)',
    },
    [48] = {
        Name = 'Więcej świateł',
        Source = 'eatra_bouncelight_beach',
        Color = 'rgb(244,224,224)',
    },
    [49] = {
        Name = 'Kontrast',
        Source = 'epsilion',
        Color = 'rgb(188,188,188)',
    },
    [50] = {
        Name = 'Kontrast 2',
        Source = 'exile1_plane',
        Color = 'rgb(224,224,224)',
    },
    [51] = {
        Name = 'Jasne światła',
        Source = 'Facebook_NEW',
        Color = 'rgb(222,222,22)',
    },
    [52] = {
        Name = 'Jasne światła 2',
        Source = 'facebook_serveroom',
        Color = 'rgb(222,222,82)',
    },
    [53] = {
        Name = 'Jasne światła 3',
        Source = 'FIB_5',
        Color = 'rgb(222,222,22)',
    },
    [54] = {
        Name = 'Jasne światła 4',
        Source = 'FIB_6',
        Color = 'rgb(222,222,82)',
    },
    [55] = {
        Name = 'Jasne światła 5',
        Source = 'FIB_A',
        Color = 'rgb(222,222,22)',
    },
    [56] = {
        Name = 'Jasne światła 6',
        Source = 'FIB_B',
        Color = 'rgb(222,222,82)',
    },
    [57] = {
        Name = 'Cień z rozmyciem',
        Source = 'fp_vig_blue',
        Color = 'rgb(4,4,4)',
    },
    [58] = {
        Name = 'Zielony cień z rozmyciem',
        Source = 'fp_vig_green',
        Color = 'rgb(44,224,44)',
    },
    [59] = {
        Name = 'Zielony z pasami',
        Source = 'FranklinColorCode',
        Color = 'rgb(24,124,84)',
    },
    [60] = {
        Name = 'Zielony z pasami 2',
        Source = 'FranklinColorCodeBasic',
        Color = 'rgb(24,124,84)',
    },
    [61] = {
        Name = 'Zielony z pasami 3',
        Source = 'FranklinColorCodeBright',
        Color = 'rgb(24,124,84)',
    },
    [62] = {
        Name = 'Zimne kolory',
        Source = 'Glasses_BlackOut',
        Color = 'rgb(64,144,182)',
    },
    [63] = {
        Name = 'Zimne kolory 2',
        Source = 'glasses_brown',
        Color = 'rgb(64,144,182)',
    },
    [64] = {
        Name = 'Niebieski cień',
        Source = 'glasses_Darkblue',
        Color = 'rgb(2,24,222)',
    },
    [65] = {
        Name = 'Zielony cień',
        Source = 'glasses_green',
        Color = 'rgb(22,242,22)',
    },
    [66] = {
        Name = 'Pomarańczowy cień',
        Source = 'glasses_orange',
        Color = 'rgb(244,124,22)',
    },
    [67] = {
        Name = 'Różowy cień',
        Source = 'glasses_pink',
        Color = 'rgb(224,44,182)',
    },
    [68] = {
        Name = 'Fioletowy cień',
        Source = 'glasses_purple',
        Color = 'rgb(124,24,222)',
    },
    [69] = {
        Name = 'Czerwony cień',
        Source = 'glasses_red',
        Color = 'rgb(255,44,44)',
    },
    [70] = {
        Name = 'Pomarańczowy i zielony',
        Source = 'glasses_yellow',
        Color = 'rgb(244,164,12)',
    },
    [71] = {
        Name = 'Mgła',
        Source = 'graveyard_shootout',
        Color = 'rgb(224,224,224)',
    },
    [72] = {
        Name = 'Niewyraźny cień',
        Source = 'helicamfirst',
        Color = 'rgb(4,4,4)',
    },
    [73] = {
        Name = 'Czerwony i niebieski',
        Source = 'Hint_cam',
        Color = 'rgb(244,24,24)',
    },
    [74] = {
        Name = 'Jasnoniebieski',
        Source = 'hud_def_colorgrade',
        Color = 'rgb(24,124,182)',
    },
    [75] = {
        Name = 'Czarny i biały 2',
        Source = 'hud_def_desat_cold_kill',
        Color = 'rgb(4,4,4)',
    },
    [76] = {
        Name = 'Czarny i biały 3',
        Source = 'hud_def_desatcrunch',
        Color = 'rgb(4,4,4)',
    },
    [77] = {
        Name = 'Plaża łagodna',
        Source = 'InchPurple01',
        Color = 'rgb(164,44,222)',
    },
    [78] = {
        Name = 'Biały i jasnoniebieski',
        Source = 'int_Hospital2_DM',
        Color = 'rgb(124,224,222)',
    },
    [79] = {
        Name = 'Niskie czarne i niebieskie',
        Source = 'introblue',
        Color = 'rgb(22,22,222)',
    },
    [80] = {
        Name = 'Fioletowe rozmycie',
        Source = 'Kifflom',
        Color = 'rgb(124,24,222)',
    },
    [81] = {
        Name = 'Zanikanie tła',
        Source = 'michealspliff',
        Color = 'rgb(4,4,4)',
    },
    [82] = {
        Name = 'Pyszny',
        Source = 'MP_Arena_theme_atlantis',
        Color = 'rgb(244,244,244)',
    },
    [83] = {
        Name = 'Żółte niebo',
        Source = 'MP_Arena_theme_evening',
        Color = 'rgb(224,166,22)',
    },
    [84] = {
        Name = 'Reflektor niebieski',
        Source = 'mp_lad_day',
        Color = 'rgb(22,44,222)',
    },
    [85] = {
        Name = 'Reflektor czerwony',
        Source = 'mp_lad_judgment',
        Color = 'rgb(244,22,22)',
    },
    [86] = {
        Name = 'Smog 2',
        Source = 'nervousRON_fog',
        Color = 'rgb(244,244,244)',
    },
    [87] = {
        Name = 'Czarny i biały 4',
        Source = 'NG_blackout',
        Color = 'rgb(4,4,4)',
    },
    [88] = {
        Name = 'Czarny i biały 5',
        Source = 'NG_deathfail_BW_base',
        Color = 'rgb(4,4,4)',
    },
    [89] = {
        Name = 'Gorące kolory',
        Source = 'NG_filmic10',
        Color = 'rgb(222,124,22)',
    },
    [90] = {
        Name = 'Czarny i biały 6',
        Source = 'phone_cam7',
        Color = 'rgb(4,4,4)',
    },
    [91] = {
        Name = 'Ciemna mgła',
        Source = 'SALTONSEA',
        Color = 'rgb(244,244,244)',
    },
    [92] = {
        Name = 'Ciemna mgła 2',
        Source = 'WATER_cove',
        Color = 'rgb(244,244,244)',
    },
    [93] = {
        Name = 'Pod wodą',
        Source = 'underwater_deep',
        Color = 'rgb(42,164,222)',
    },
    [94] = {
        Name = 'Delikatny róż',
        Source = 'TinyPink01',
        Color = 'rgb(224,124,222)',
    },
}
