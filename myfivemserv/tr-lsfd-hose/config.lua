Config = {}

--If you dont use esx nor use qbus set UseESX to false and UseQBUS to false
--You can then use the identifier whitelist or the role whitelist

--If you use esx enable this
Config.UseESX = true

--If you use qbus enable this
Config.UseQBUS = false

--Required Job To Use The FireHose
Config.JobName = "lsfd"

--Standalone identifier whitelist
--Set UseWhitelist To True To Use The Whitelist
Config.UseWhitelist = false
Config.Identifiers = {
    "license:5ebf5f51ff89e96dade3a6babddd00bb227c3548",
    "license:1123d12313"
}