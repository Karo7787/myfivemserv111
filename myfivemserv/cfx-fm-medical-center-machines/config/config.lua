-- //////////////////////////////////////////////////
-- /////////////// Done By Project X ////////////////
-- ///////////////// Our Discord ////////////////////
-- //////// https://discord.gg/bJNxYDAm5u ///////////
-- //////////////////////////////////////////////////

Config = Config or {}
Loc = {}

Config = {
    debug = false,

    Interaction = "ox_target", -- ox_target, qb-target, drawtext
    DisableElevator = false, -- Disable the elevator if you want to use your own script

    CancelKey = "x", -- Key to cancel the animation (default: x)
    CancelCommand = "cancelmre", -- Key to cancel the animation (default: x)

    -- Drawtext
    Button = "[E] - ", -- For translation only
    DrawtextButton = 38, -- [E] by default
    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(3, 3, 2), -- Size of the drawtext zone
    DrawTextRotation = 90.0, -- Rotation of the drawtext zone

    icon = "fas fa-bed-pulse",
    Labels = {
        ["GoUp"] = "Uzyj windy na dach",
        ["GoDown"] = "Uzwyj windy na parter",
        ["Rad"] = "Uzyj maszyny",
        ["MRE"] = "Uzyj Maszyny",
        ["Surgery"] = "Poloz sie na lozku"
    },

    Distance = 1.0, -- Distance to interact with the object
    Radius = 1.0, -- Radius of the target
}