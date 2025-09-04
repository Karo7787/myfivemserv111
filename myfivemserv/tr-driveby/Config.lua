Config = {
    RefreshRate = 0.1, -- seconds
    SpeedUnit = "kmh", -- kmh/mph
    MaxSpeed = 120,
    DriverAllowed = true,
    WeaponBlackList = {
        [GetHashKey("WEAPON_MICROSMG")] = true
    },
    AllowedTypes = {
        ["automobile"] = true, -- cars
        ["bike"] = true, -- bikes
        ["boat"] = false, -- boats
        ["heli"] = false, -- helicopters
        ["plane"] = false, -- planes
        ["submarine"] = false -- submarines
    }
}