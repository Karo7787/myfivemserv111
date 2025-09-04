Config = {}

-- █▀ █▀▄ ▄▀▄ █▄ ▄█ ██▀ █   █ ▄▀▄ █▀▄ █▄▀
-- █▀ █▀▄ █▀█ █ ▀ █ █▄▄ ▀▄▀▄▀ ▀▄▀ █▀▄ █ █
local frameworkAutoFind = function()
    if GetResourceState('es_extended') == 'started' then
        return "ESX"
    elseif GetResourceState('qb-core') == 'started' then
        return "QB-Core"
    end
end

Config.Core = frameworkAutoFind()
Config.CoreExport = function()
    if Config.Core == "ESX" then
        return exports['es_extended']:getSharedObject()
    elseif Config.Core == "QB-Core" then
        return exports['qb-core']:GetCoreObject()
    end
end

---@field PlayerLoaded string: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"

---@field PlayerDropped string: ESX: "esx:playerDropped" / QB-Core: "playerDropped"
Config.PlayerDropped = Config.Core == "ESX" and "esx:playerDropped" or "playerDropped"


Config.Notification = function(message, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports["vms_notify"]:Notification("FLIGHT SCHOOL", message, 5000, "#32a852", "fa-solid fa-circle-check")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', 5000)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports["vms_notify"]:Notification("FLIGHT SCHOOL", message, 5000, "#eb4034", "fa fa-exclamation-circle")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', 5000)
        end
    end
end

Config.Interact = {
    Enabled = true,
    Open = function(message)
        exports["mrg_ui"]:ShowHelpNotification(message)
        -- exports['qb-core']:DrawText(message, 'right')
    end,
    Close = function()
        exports["mrg_ui"]:HideHelpNotification()
        -- exports['qb-core']:HideText()
    end,
}


-- █▄ ▄█ ▄▀▄ █ █▄ █   ▄▀▀ ██▀ ▀█▀ ▀█▀ █ █▄ █ ▄▀  ▄▀▀
-- █ ▀ █ █▀█ █ █ ▀█   ▄██ █▄▄  █   █  █ █ ▀█ ▀▄█ ▄██
---@field AccessOnMarker boolean: Do you want to use access to the exam selection menu as E in marker?
Config.AccessOnMarker = false
Config.UseTarget = true
Config.TargetResource = 'ox_target'
Config.Target = function()
    exports[Config.TargetResource]:addBoxZone({
        coords = vec(Config.Zones["menu"].coords.x, Config.Zones["menu"].coords.y, Config.Zones["menu"].coords.z+0.35),
        size = vec(4.0, 4.0, 4.0),
        debug = false,
        useZ = true,
        rotation = 60,
        distance = 9.0,
        options = {
            {
                name = 'flightschoolv2',
                event = 'vms_flightschoolv2:openMenu',
                icon = 'fa-regular fa-file-lines',
                label = "Szkoła Latania"
            }
        }
    })
end


---@field UseVMSCityHall boolean: 
Config.UseVMSCityHall = GetResourceState('vms_cityhall') == 'started'

---@field UseSoundsUI boolean: Do you want to use interaction sounds in the UI?
Config.UseSoundsUI = true

---@field EnableBlur boolean: Do you want to blur the background in the game when you have the UI running?
Config.EnableBlur = true

---@field PossibleChargeByBank boolean: if you set it true, when the player does not have enough cash, it will try to take it from his bank account
Config.PossibleChargeByBank = true

---@field MaxDriveErrors number: How many maximum errors a player can receive for damaging a vehicle, after this number of errors the exam will be aborted
Config.MaxDriveErrors = 8

---@field CheckIsStartAreaIsOccupied boolean: If the maneuvering area is occupied, the practical exam will not start and the player will receive notification about it
Config.CheckIsStartAreaIsOccupied = true

Config.UseJerryCanProp = true
Config.JerryCanObject = joaat('w_am_jerrycan')

Config.TeleportPlayerAfterExam = true
Config.TeleportPlayerAfterFailExam = true

Config.Examiner = {
    Enabled = true, -- Do you want to use a ped as an examiner who sits with the player in the vehicle?
    SpokenCommands = true,
    SpokenLanguage = "EN", -- "EN", "DE", "FR", "ES", "PG"
    PedModel = 'ig_fbisuit_01' -- https://wiki.rage.mp/index.php?title=Peds
}

local licensesResourceAutoFind = function()
    if GetResourceState('Buty-license') == 'started' then
        return "buty-license"
    else
        return "default"
    end
end
--[[
    Supported Licenses script:
    - Buty-license
    - esx_license (default)
    - qb-core metadata (default)
]]
Config.LicensesResource = licensesResourceAutoFind()

---@field AddLicenseItem boolean: Do you use your license as an item on the server
Config.AddLicenseItem = false
Config.LicenseItem = "pilot_license"

Config.MenuIcon = ''
Config.Licenses = {
    Theory = {
        ['HELICOPTER'] = {name = 'theory_helicopter', price = 5000, menuIcon = 'far fa-file-alt', enabled = true},
        ['PLANE'] = {name = 'theory_plane', price = 6500, menuIcon = 'far fa-file-alt', enabled = true},
    },
    Practical = {
        ['HELICOPTER'] = {name = Config.LicensesResource == "buty-license" and 'helicopter' or 'practical_helicopter', price = 15000, menuIcon = 'fas fa-helicopter', enabled = true},
        ['PLANE'] = {name = Config.LicensesResource == "buty-license" and 'plane' or 'practical_plane', price = 35000, menuIcon = 'fas fa-plane', enabled = true},
    }
}


Config.Questions = {
    ['HELICOPTER'] = {
        QuestionsCount = 6, -- Number of all questions for the draw pool
        QuestionToAnswer = 6, -- Questions the player will have to answer
        NeedAnswersToPass = 4, -- Number of questions a player must answer correctly to pass the theory exam
    },
    ['PLANE'] = {
        QuestionsCount = 6,
        QuestionToAnswer = 6,
        NeedAnswersToPass = 4,
    },
}

Config.Tasks = {
    ['HELICOPTER'] = {
        {label = "Uruchom silnik", id = 1},
        {label = "Wznieś się na wysokość <span>0m</span>/200m", id = 2},
        {label = "Zbierz punkty kontrolne <span>0</span>/3", id = 3},
        {label = "Wykonaj bezpieczne lądowanie", id = 6},
        {label = "Wznieś się na wysokość <span>0m</span>/175m", id = 7},
        {label = "Zbierz punkty kontrolne <span>0</span>/4", id = 8},
        {label = "Wykonaj awaryjne lądowanie", id = 12},
        {label = "Zbierz punkty kontrolne <span>0</span>/10", id = 13},
        {label = "Zwróć helikopter do hangaru", id = 23},
    },
    ['PLANE'] = {
        {label = "Uruchom silnik", id = 1},
        {label = "Wyjdź z hangaru", id = 2},
        {label = "Dotrzyj do punktu", id = 3},
        {label = "Przejdź na pas startowy", id = 4},
        {label = "Wystartuj samolotem", id = 5},
        {label = "Zbierz punkty kontrolne <span>0</span>/10", id = 6},
        {label = "Zaparkuj tyłem w hangarze", id = 16},
        {label = "Sprawdź stan samolotu <span>0</span>%", id = 17},
        {label = "Zatankuj samolot", id = 18},
        {label = "Przejdź na pas startowy", id = 19},
        {label = "Wystartuj samolotem", id = 20},
        {label = "Zbierz punkty kontrolne <span>0</span>/7", id = 21},
        {label = "Zwróć samolot", id = 28},
    }
}

Config.Zones = {
    ["menu"] = {
        menuType = "ox_lib", -- "esx_menu_default" / "esx_context" / "qb-menu" / "ox_lib"
        menuPosition = 'left', -- only for esx_menu_default and esx_context
        coords = vector3(-1155.28, -2715.07, 19.89),
        marker = {
            id = 34, -- https://docs.fivem.net/docs/game-references/markers/
            color = {115, 255, 115, 120}, -- R(ed), G(reen), B(lue), A(lpha)
            scale = vec(0.65, 0.65, 0.65),
            bobUpAndDown = false, -- jumping marker
            rotate = true -- rotating marker
        },
        blip = { -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 359,
            display = 4,
            scale = 1.0,
            color = 43,
            name = "Szkoła Latania"
        }
    },
    ["return_vehicle"] = {
        ['HELICOPTER'] = {
            marker = {
                id = 1, -- https://docs.fivem.net/docs/game-references/markers/
                color = {255, 25, 25, 120}, -- R(ed), G(reen), B(lue), A(lpha)
                scale = vec(7.5, 7.5, 3.5),
                bobUpAndDown = false, -- jumping marker
                rotate = true -- rotating marker
            },
            blip = { -- https://docs.fivem.net/docs/game-references/blips/
                sprite = 467,
                display = 4,
                scale = 1.0,
                color = 2,
                name = "Odstaw Helikopter"
            }
        },
        ['PLANE'] = {
            marker = {
                id = 1, -- https://docs.fivem.net/docs/game-references/markers/
                color = {255, 25, 25, 120}, -- R(ed), G(reen), B(lue), A(lpha)
                scale = vec(10.5, 10.5, 3.5),
                bobUpAndDown = false, -- jumping marker
                rotate = true -- rotating marker
            },
            blip = { -- https://docs.fivem.net/docs/game-references/blips/
                sprite = 467,
                display = 4,
                scale = 1.0,
                color = 2,
                name = "Odstaw Samolot"
            }
        },
    }
}

Config.Practical = {
    ['Vehicles'] = { -- https://docs.fivem.net/docs/game-references/vehicle-models/
        HELICOPTER = 'maverickv',
        PLANE = 'vestra',
    },
    ['Marker'] = { -- https://docs.fivem.net/docs/game-references/markers/
        id = 25, 
        size = vec(0.35, 0.35, 0.35),
        rotate = {0.0, 180.0, 0.0},
        rgba = {255, 255, 0, 140},
        rotataing = false
    },
    ['Checkpoint'] = {
        id = 13,
        id_ground = 48,
        diameter = 20.0,
        diameter_ground = 11.0,
        rgba = {0, 255, 0, 175}
    },
    ['Blip'] = { -- https://docs.fivem.net/docs/game-references/blips/
        sprite = 270,
        display = 4,
        scale = 1.0,
        color = 43,
        name = "Point"
    },
    ['SpawnPoints'] = {
        ['HELICOPTER'] = vector4(-1178.32, -2845.85, 12.95, 329.7),
        ['PLANE'] = vector4(-1650.12, -3139.33, 12.99, 335.32),
    }
}