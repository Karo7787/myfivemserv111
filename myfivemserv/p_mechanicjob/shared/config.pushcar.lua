Config.PushCar = {}

Config.PushCar.MinHealth = 1000.0
Config.PushCar.Keys = {
    ['left'] = 'A',
    ['right'] = 'D'
}

Config.PushCar.OnStart = function()
    LocalPlayer.state.invBusy = true
    LocalPlayer.state.canUseWeapons = false
    LocalPlayer.state.invHotkeys = false
end

Config.PushCar.OnStop = function()
    LocalPlayer.state.invBusy = false
    LocalPlayer.state.canUseWeapons = true
    LocalPlayer.state.invHotkeys = true
end