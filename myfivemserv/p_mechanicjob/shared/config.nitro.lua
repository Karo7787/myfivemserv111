Config.Nitro = {}

Config.Nitro.SpeedMultiplier = 1.0
Config.Nitro.Decrease = 2.0 -- script will remove 2.0 nitro every second while using
Config.Nitro.TempIncrease = 1.0 -- increase engine temperature for 1.0 while using nitro
Config.Nitro.TempWait = 150 -- every 250ms increase temperature while using nitro
Config.Nitro.MaxTemperature = 140.0 -- from this temperature, engine can blow up
Config.Nitro.BlowChance = 100 -- 50% for blow up engine when reach max temperature
Config.Nitro.AllowedJobs = { -- which jobs can refill nos bottle (set to false if you want to allow everyone)
    ['mechanic'] = 0 -- job name and grade
}