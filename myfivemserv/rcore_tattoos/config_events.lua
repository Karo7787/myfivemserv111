-- 👉 You can ignore this file if you do not notice any errors regarding ESX/QBCore Events
-- This file is used for servers where default events, like `esx:getSharedObject`,
-- are renamed to for example `framework:getSharedObject`

-- If your server is the case and you encounter errors with events,
-- feel free to edit the names below to match event names of your server

-- ❔ How? If you have for example `esx:getSharedObject` renamed to `framework:getSharedObject`
-- you can change it below like this:
-- ['esx:getSharedObject'] = 'framework:getSharedObject'

-- ❗❗❗ **NEVER** change the first value, only the second after the equals symbol!
Config = Config or {}
Config.Events = {
    -- ESX
    ["es_extended"] = "es_extended", --name of esx script
    ['esx:getSharedObject'] = 'esx:getSharedObject',
    ["esx:playerLoaded"] = "esx:playerLoaded",
    ["esx:setJob"] = "esx:setJob",
    ["esx:playerSpawned"] = "esx:playerSpawned",
    ["esx_society:openBossMenu"] = "esx_society:openBossMenu",
    ["esx_addonaccount:getSharedAccount"] = "esx_addonaccount:getSharedAccount",
    ["esx_society:registerSociety"] = "esx_society:registerSociety",

    -- QBCore
    ["qb-core"] = "qb-core",             -- name of QBCore script
    ["qb-bossmenu"] = "qb-bossmenu",     -- name of qb-bossmenu script
    ["qb-management"] = "qb-management", -- name of qb-management script
    ["qb-banking"] = "qb-banking",       -- name of qb-banking script
    ["QBCore:GetObject"] = "QBCore:GetObject",
    ["QBCore:Client:OnPlayerLoaded"] = "QBCore:Client:OnPlayerLoaded",
    ["QBCore:Client:OnJobUpdate"] = "QBCore:Client:OnJobUpdate",
    ["qb-bossmenu:client:OpenMenu"] = "qb-bossmenu:client:OpenMenu",
    ["qb-bossmenu:client:openMenu"] = "qb-bossmenu:client:openMenu",
    ["qb-bossmenu:server:removeAccountMoney"] = "qb-bossmenu:server:removeAccountMoney",
    ["qb-bossmenu:server:addAccountMoney"] = "qb-bossmenu:server:addAccountMoney",

    -- Other
    ["oxmysql"] = "oxmysql" -- name of oxmysql script
}
