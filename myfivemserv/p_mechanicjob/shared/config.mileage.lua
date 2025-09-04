Config.Mileage = {}

Config.Mileage.Speed = {
    [100000] = 0.8, -- from 50k mileage, max speed of vehicle will be 0.98 (its not 50km km, its value from database which is not formatted)
}

Config.Mileage.Brakes = {
    [100] = 0.65 -- if brakes is 10% or less they will work bad
}