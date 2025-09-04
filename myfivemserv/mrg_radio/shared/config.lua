Config = {
    ItemCheckLoop = true,
    RadioItem = "radio",
    VoiceSystem = "pma-voice", -- pma-voice, saltychat
    FastSwitchJobs = {
        ["police"] = true,
        ["ambulance"] = true,
        ["lsfd"] = true,
        ["mechanik"] = true,
        ["doj"] = true
    },
    RestrictedChannels = exports["mrg_ui"]:GetWhiteListedJobsForRadios(),
    MaxFrequency = 1000
}
