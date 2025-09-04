Language = "pl"
Framework = "esx"

if GetResourceState("es_extended") ~= "missing" then
    Framework = "esx"
end

if GetResourceState("qb-core") ~= "missing" then
    Framework = "qb"
end

MaxItemInInventory = 10

Config = {}

Config.DevMode = false

Config.Sound = {
    PlaySoundOnSuccessfulDelivery = true,
    Lib = "HUD_MINI_GAME_SOUNDSET",
    Name = "MEDAL_UP"
}

Config.NewspaperHitboxSize = 2.5
Config.DeliveryZoneOutlineColor = { r = 255, g = 255, b = 255, alpha = 255 }

Config.RestrictWorkOnlyToVehicles = false
Config.AllowedVehicleModels = {
    [`bmx`] = true,
    [`cruiser`] = true,
    [`fixter`] = true,
    [`scorcher`] = true,
    [`tribike`] = true,
    [`tribike2`] = true,
    [`tribike3`] = true,
}

Config.PickUpPeds = {
    Model = `csb_reporter`,
    Coords = vector4(-598.25, -929.82, 23.87, 92.12), -- 4th param is heading
    Blip = { -- you can remove blip section if you do not want blips on your map
        Scale = 0.8,
        Sprite = 409,
        Color = 3,
        Text = _L("pickupNewspapers")
    },
    TargetsInteractRange = 2.0, -- This is if you are using ox_target, qtarget, qb-target
    StandaloneInteractRange = 1.5,
    StandaloneControls = {
        StartJob = {
            disabled = false,
            key = 38 -- E You can find indexes for keys here: https://mmleczek.com/tools/controls/
        },
        GetMoney = {
            disabled = false,
            key = 47 -- G You can find indexes for keys here: https://mmleczek.com/tools/controls/
        },
    }
}

Config.Zones = {
    {
        coords = vector3(-1055.31, 535.93, 87.72),
        hasBlip = true,
        blipRadius = 185.0,
        blipScale = 0.8,
        blipSprite = 1,
        blipColor = 11,
        blipText = "Vinewood Hills delivery zone",
        revenue = 50, -- Here you set up how much money player gets per one newspaper
        zoneDeliveryPoints = {
            vec4(-884.19,  517.99, 91.4,   105.0),
            vec4(-873.57,  562.66, 95.6,   310.0),
            vec4(-907.5,   545.09, 99.0,   135.0),
            vec4(-904.64,  587.94, 99.9,   330.0),
            vec4(-924.63,  561.52, 98.75,  152.0),
            vec4(-947.74,  567.88, 100.4,  161.0),
            vec4(-974.06,  583.53, 100.84, 170.0),
            vec4(-1022.60, 586.91, 102.1,  182.0),
            vec4(-1107.52, 594.25, 103.4,  30.0),
            vec4(-1125.40, 548.65, 101.2,  195.0),
            vec4(-1146.58, 546.4,  100.4,  190.0),
            vec4(-1167.02, 568.12, 100.7,  9.0),
            vec4(-1193.07, 563.93, 99.25,  5.0),
            vec4(-1155.64, 480.26, 85.05,  5.0),
            vec4(-1174.55, 440.20, 85.7,   266.0),
            vec4(-1122.68, 485.83, 81.1,   350.0),
            vec4(-1094.50, 427.29, 74.65,  85.0),
            vec4(-1215.81, 458.22, 90.8,   185.0),
            vec4(-987.04,  487.44, 81.25,  190.0),
            vec4(-968.5,  436.75,  79.5,   65.0),
        }
    },
    {
        coords = vector3(85.14, -1849.92, 23.85),
        hasBlip = true,
        blipRadius = 140.0,
        blipScale = 0.8,
        blipSprite = 1,
        blipColor = 11,
        blipText = "Grove St delivery zone",
        revenue = 50, -- Here you set up how much money player gets per one newspaper
        zoneDeliveryPoints = {
            vec4(-33.92, -1847.37, 25.1,  50.0),
            vec4(-4.96,  -1871.99, 23.1,  230),
            vec4(23.0,   -1896.98, 21.95, 140.0),
            vec4(56.63,  -1922.66, 20.65, 140.0),
            vec4(76.59,  -1948.38, 20.1,  140.0),
            vec4(114.34, -1961.07, 20.1,  200.0),
            vec4(126.6,  -1929.76, 20.3,  210.0),
            vec4(101.07, -1912.17, 20.36, 335.0),
            vec4(54.16,  -1873.32, 21.4,  315.0),
            vec4(29.67,  -1854.47, 23.0,  315.0),
            vec4(104.33, -1885.07, 22.9,  140.0),
            vec4(127.85, -1896.72, 22.6,  155.0),
            vec4(171.25, -1871.39, 23.35, 245.0),
            vec4(150.09, -1864.92, 23.34, 335.0),
            vec4(130.61, -1853.25, 24.0,  330.0),
            vec4(152.81, -1823.75, 26.8,  230.0),
            vec4(85.64,  -1959.3,  20.0,  230.0),
            vec4(39.18,  -1911.78, 20.9,  50.0),
            vec4(45.94,  -1864.31, 22.23, 315.0),
            vec4(21.054, -1844.51, 23.50, 230.0),
        }
    },
    {
        coords = vector3(984.91, -561.35, 60.0),
        hasBlip = true,
        blipRadius = 150.0,
        blipScale = 0.8,
        blipSprite = 1,
        blipColor = 11,
        blipText = "Mirror Park delivery zone",
        revenue = 60, -- Here you set up how much money player gets per one newspaper
        zoneDeliveryPoints = {
            vec4(979.44,  -716.13, 56.9,  132.0),
            vec4(970.91,  -701.15, 57.4,  172.0),
            vec4(960.29,  -669.71, 57.3,  120.0),
            vec4(943.50,  -653.59, 57.3,  40.0),
            vec4(929.05,  -639.42, 57.1,  140.0),
            vec4(903.15,  -615.67, 57.3,  50.0),
            vec4(886.79,  -608.12, 57.1,  136.0),
            vec4(861.7,   -583.41, 57.11, 0.0),
            vec4(850.58,  -532.58, 56.8,  -5.0),
            vec4(861.85,  -509.29, 56.3,  50.0),
            vec4(906.47,  -489.80, 58.3,  25.0),
            vec4(921.98,  -478.21, 60.0,  25.0),
            vec4(944.02,  -463.54, 60.35, 303.0),
            vec4(967.40,  -451.98, 61.3,  35.0),
            vec4(987.72,  -433.27, 62.8,  35.0),
            vec4(1010.44, -423.34, 63.9,  127.0),
            vec4(1056.26, -448.7, 65.2,   169.0),
            vec4(1051.58, -470.53, 62.85, 80.0),
            vec4(1046.22, -497.90, 63.00, 170.0),
            vec4(1090.01, -484.35, 64.6,  257.0),
        }
    },
    {
        coords = vector3(1306.35, -623.47, 60.0),
        hasBlip = true,
        blipRadius = 130.0,
        blipScale = 0.8,
        blipSprite = 1,
        blipColor = 11,
        blipText = "Mirror Park delivery zone #2",
        revenue = 70, -- Here you set up how much money player gets per one newspaper
        zoneDeliveryPoints = {
            vec4(1241.66, -566.22, 68.5,  45.0),
            vec4(1240.70, -601.60, 68.3,  2.0),
            vec4(1251.02, -621.22, 68.3,  28.0),
            vec4(1265.44, -648.35, 66.8,  210.0),
            vec4(1270.96, -683.35, 64.94, 5.0),
            vec4(1264.98, -702.84, 63.3,  60.0),
            vec4(1229.24, -725.43, 59.7,  6.0),
            vec4(1222.5,  -697.05, 59.7,  12.0),
            vec4(1221.46, -669.05, 62.4,  12.0),
            vec4(1206.89, -620.36, 65.35, 5.0),
            vec4(1203.67, -598.87, 66.9,  2.0),
            vec4(1200.9,  -575.72, 68.0,  46.0),
            vec4(1303.10, -527.64, 70.26, 70.0),
            vec4(1328.14, -535.83, 71.25, 70.0),
            vec4(1348.23, -547.14, 72.81, 68.0),
            vec4(1372.82, -555.64, 73.61, 68.0),
            vec4(1388.64, -569.67, 73.41, 24.0),
            vec4(1385.93, -593.25, 73.41, 233.0),
            vec4(1367.23, -606.23, 73.62, 0.0),
            vec4(1341.72, -597.49, 73.65, 53.0),
        }
    }
}