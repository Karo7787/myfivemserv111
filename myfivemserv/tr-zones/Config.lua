Config = {
    Debug = false,
    Zones = {
        {
            points = {
                vector2(205.59928894042, -1007.814086914),
                vector2(139.98458862304, -983.06079101562),
                vector2(171.51564025878, -887.17987060546),
                vector2(191.33026123046, -865.65966796875),
                vector2(195.73663330078, -851.62512207032),
                vector2(256.02313232422, -874.83526611328)
            },
            action = "client",
            wait = 60000,
            func = function(source, zoneid)
                TriggerEvent("esx_status:remove", "stress", 10000)
            end
        }
    }
}