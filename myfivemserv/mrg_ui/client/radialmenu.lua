lib.addRadialItem({
    {
        id = 'animations',
        label = 'Animacje',
        icon = 'fa-solid fa-person-walking',
        onSelect = function()
            TriggerEvent("mrg_animations:openMenu")
        end
    },
    {
        id = 'character',
        label = 'Postać',
        icon = 'fa-person',
        menu = "character"
    },
})
jobradials = {
    ["ambulance"] = {
        piotreq = true,
        icon = "fa-solid fa-user-doctor"
    },
    ["police"] = {
        piotreq = true,
        icon = "fa-solid fa-user-shield"
    },
    ["mechanic"] = {
        piotreq = true,
        icon = "fa-solid fa-screwdriver"
    },
    ["lsfd"] = {
        piotreq = true,
        icon = "fa-solid fa-fire"
    },
    ["doj"] = {
        piotreq = false,
        icon = "fa-solid fa-scroll"
    }
}

for k, v in pairs(AssignedRadios) do
    options = {
        {
            label = "Wyłącz radio",
            icon = 'walkie-talkie',
            onSelect = function()
                exports['pma-voice']:setRadioChannel(0)
            end
        }
    }
    for id, radioid in pairs(v) do
        table.insert(options, {
            id = "radio-"..k.."-"..Radios[radioid].channel,
            label = "[#"..Radios[radioid].channel.."] - "..Radios[radioid].name,
            icon = 'walkie-talkie',
            onSelect = function()
                exports['pma-voice']:setRadioChannel(tonumber(Radios[radioid].channel))
            end
        })
    end
    lib.registerRadial({
        id = 'job-'..k.."-radio",
        items = options
    })
end

lib.registerRadial({
    id = 'job-ambulance',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gmt']:OpenGMT()
            end
        },
        {
            id = "badge",
            label = "Legitymacja",
            icon = "fa-solid fa-medal",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', "ems")
            end
        },
        {
            id = "radio",
            label = "Radio",
            icon = 'walkie-talkie',
            iconWidth = 25,
            iconHeight = 25,
            menu = 'job-ambulance-radio'
        }
    }
})

lib.registerRadial({
    id = 'job-ambulance-off',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gmt']:OpenGMT()
            end
        }
    }
})

lib.registerRadial({
    id = 'job-doj',
    items = {
        {
            id = "badge",
            label = "Legitymacja",
            icon = "fa-solid fa-medal",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', "doj")
            end
        },
        {
            id = "radio",
            label = "Radio",
            icon = 'walkie-talkie',
            iconWidth = 25,
            iconHeight = 25,
            menu = 'job-doj-radio'
        },
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['p_dojmdt']:openTablet(false)
            end
        }
    }
})


lib.registerRadial({
    id = 'job-lsfd',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gmt']:OpenGMT()
            end
        },
        {
            id = "badge",
            label = "Odznaka",
            icon = "fa-solid fa-medal",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', "lsfd")
            end
        },
        {
            id = "objects",
            label = "Obiekty",
            icon = "road-barrier",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['p_policejob']:ObjectMenu()
            end
        },
        {
            id = "signs",
            label = "Ruch Drogowy",
            icon = "fa-solid fa-traffic-light",
            iconWidth = 25,
            iconHeight = 25,
            menu = "job-lsfd-traffic"
        },
        {
            id = "radio",
            label = "Radio",
            icon = 'walkie-talkie',
            iconWidth = 25,
            iconHeight = 25,
            menu = 'job-lsfd-radio'
        }
    }
})

lib.registerRadial({
    id = 'job-lsfd-traffic',
    items = {
        {
            id = "STOP",
            label = "STOP",
            icon = "fa-solid fa-circle-stop",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                ExecuteCommand('trafficsign 1')
            end
        },
        {
            id = "traffic_control",
            label = "Kierowanie ruchem",
            icon = "fa-solid fa-hand",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                ExecuteCommand('traffic 1')
            end
        },
    }
})

lib.registerRadial({
    id = 'job-lsfd-off',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gmt']:OpenGMT()
            end
        }
    }
})

lib.registerRadial({
    id = 'job-police-traffic',
    items = {
        {
            id = "STOP",
            label = "STOP",
            icon = "fa-solid fa-circle-stop",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                ExecuteCommand('trafficsign 1')
            end
        },
        {
            id = "traffic_control",
            label = "Kierowanie ruchem",
            icon = "fa-solid fa-hand",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                ExecuteCommand('traffic 1')
            end
        },
    }
})

lib.registerRadial({
    id = 'job-police',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gpt']:OpenGPT()
            end
        },
        {
            id = "objects",
            label = "Obiekty",
            icon = "road-barrier",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['p_policejob']:ObjectMenu()
            end
        },
        {
            id = "badge",
            label = "Odznaka",
            icon = "fa-solid fa-id-badge",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', 'lspd')
            end
        },
        {
            id = "radio",
            label = "Radio",
            icon = 'walkie-talkie',
            iconWidth = 25,
            iconHeight = 25,
            menu = 'job-police-radio'
        },
        {
            id = "signs",
            label = "Ruch Drogowy",
            icon = "fa-solid fa-traffic-light",
            iconWidth = 25,
            iconHeight = 25,
            menu = "job-police-traffic"
        },
    }
})

lib.registerRadial({
    id = 'job-police-off',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_gpt']:OpenGPT()
            end
        }
    }
})
lib.registerRadial({
    id = 'job-mechanic',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_lst']:OpenLST()
            end
        },
        {
            id = "badge",
            label = "Legitymacja",
            icon = "fa-solid fa-medal",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', 'mechanic')
            end
        },
        {
            id = "radio",
            label = "Radio",
            icon = 'walkie-talkie',
            iconWidth = 25,
            iconHeight = 25,
            menu = 'job-mechanic-radio'
        },
    }
})

lib.registerRadial({
    id = 'job-mechanic-off',
    items = {
        {
            id = "mdt",
            label = "Tablet",
            icon = "fa-tablet-screen-button",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['piotreq_lst']:OpenLST()
            end
        }
    }
})


RegisterNetEvent('piotreq_jobcore:UpdateDuty')
AddEventHandler('piotreq_jobcore:UpdateDuty', function(data)
    if not jobradials[ESX.PlayerData.job.name] and not jobradials[ESX.PlayerData.job.name].piotreq then
        return
    end
    job = ESX.PlayerData.job

    if data.status == 1 then
        lib.removeRadialItem('job-'..job.name)
        lib.addRadialItem({
            id = 'job-'..job.name,
            icon = jobradials[job.name].icon or "fa-solid fa-suitcase",
            iconWidth = 35,
            iconHeight = 35,
            label = job.label,
            menu = "job-"..job.name
        }) 
    else
        lib.removeRadialItem('job-'..job.name)
        lib.addRadialItem({
            id = 'job-'..job.name,
            icon = jobradials[job.name].icon or "fa-solid fa-suitcase",
            iconWidth = 35,
            iconHeight = 35,
            label = job.label,
            menu = "job-"..job.name.."-off"
        }) 
    end
end)

PlayerJob = ""


Citizen.CreateThread(function()
    while PlayerJob == "" do
        if ESX.IsPlayerLoaded() then
            local job = ESX.GetPlayerData().job
            PlayerJob = job.name
            if jobradials[job.name] then
                menu = "job-"..job.name
                if jobradials[job.name].piotreq then
                    TriggerServerEvent('piotreq_jobcore:SwitchDuty', {duty = 0})
                    menu = "job-"..job.name.."-off"
                end
                lib.addRadialItem({
                    id = 'job-'..job.name,
                    icon = jobradials[job.name].icon or "fa-solid fa-suitcase",
                    iconWidth = 35,
                    iconHeight = 35,
                    label = job.label,
                    menu = menu
                }) 
            end
            ReloadInventory()
            ReloadJobsMenu()
        end
        Citizen.Wait(100)
    end
end)

AddEventHandler("wasabi_multijob:deleteJob", function()
    ReloadJobsMenu()
end)

RegisterNetEvent('esx:setJob', function(job, lastJob)
    if ESX.IsPlayerLoaded() then
        PlayerJob = job.name
        lib.removeRadialItem('job-'..lastJob.name)
        if jobradials[job.name] then
            menu = "job-"..job.name
            if jobradials[job.name].piotreq then
                TriggerServerEvent('piotreq_jobcore:SwitchDuty', {duty = 0})
                menu = "job-"..job.name.."-off"
            end
            lib.addRadialItem({
                id = 'job-'..job.name,
                icon = jobradials[job.name].icon or "fa-solid fa-suitcase",
                iconWidth = 35,
                iconHeight = 35,
                label = job.label,
                menu = menu
            }) 
        end
    end
    Wait(1000)
    ReloadJobsMenu()
end)


function ReloadJobsMenu()
    ESX.TriggerServerCallback("mrg_ui:radialmenu:GetPlayerJobs", function (jobs)
        elements = {}
        if PlayerJob ~= "unemployed" then
            table.insert(elements,
                {
                    id = "duty",
                    label = "Zakończ pracę",
                    icon = "fa-solid fa-door-open",
                    onSelect = function()
                        TriggerServerEvent("wasabi_multijob:clockOut")
                    end
                }
            )
        end
        for k, v in pairs(jobs) do
            table.insert(elements, {
                    id = 'job-'..v.job,
                    icon = jobradials[v.job] and jobradials[v.job].icon or "fa-solid fa-suitcase",
                    label = v.label,
                    menu = "jobmenu-"..v.job
                })
            lib.registerRadial({
                id = 'jobmenu-'..v.job,
                items = {
                    {
                        id = "duty",
                        label = "Rozpocznij pracę",
                        icon = "fa-solid fa-right-to-bracket",
                        onSelect = function()
                            TriggerEvent("wasabi_multijob:clockIn", {
                                job = v.job,
                                grade = v.grade
                            })
                        end
                    },
                    {
                        id = "duty",
                        label = "Porzuć pracę",
                        icon = "fa-solid fa-trash",
                        onSelect = function()
                            TriggerEvent("wasabi_multijob:deleteJob", {
                                job = v.job,
                                grade = v.grade
                            })
                        end
                    },
                }
            })
        end
        lib.registerRadial({
            id = 'jobmenu',
            items = elements
        })
    end)
    
end
InZones = {}


Citizen.CreateThread(function()
    while true do
        if ESX.IsPlayerLoaded() then
            if GetResourceState("sfjob") == "started" then
                if (exports["sfjob"]:getActiveJob() ~= "unemployed" and Config.sfCompanies[exports["sfjob"]:getActiveJob()]) and not InZones["Company"] then
                    InZones["Company"] = true
                    lib.addRadialItem({
                        id = 'ftablet',
                        icon = 'tablet',
                        label = 'Tablet Firmowy',
                        onSelect = function()
                            TriggerEvent("sfjobtab:tabletopen")
                        end
                    })
                end
                if (exports["sfjob"]:getActiveJob() == "unemployed" or not Config.sfCompanies[exports["sfjob"]:getActiveJob()]) and InZones["Company"] then
                    lib.removeRadialItem('ftablet')
                    InZones["Company"] = false
                end
            else
                lib.removeRadialItem('ftablet')
                InZones["Company"] = false
            end
            if GetResourceState("mrg_garages") == "started" then
                if exports['mrg_garages']:inGarageZone() and not InZones["Garage"] then 
                    InZones["Garage"] = true
                    lib.addRadialItem({
                        id = 'garage',
                        icon = 'warehouse',
                        label = 'Garaż',
                        onSelect = function()
                            exports["mrg_garages"]:OpenGarages()
                        end
                    })
                end
                if InZones["Garage"] and not exports['mrg_garages']:inGarageZone() then
                    lib.removeRadialItem('garage')
                    InZones["Garage"] = false
                end
            else
                lib.removeRadialItem('garage')
                InZones["Garage"] = false
            end
        end
        Wait(100)
    end
end)



AddEventHandler('ox_inventory:updateInventory', function() 
    ReloadInventory()
end)


lib.registerRadial({
    id = 'rockstar',
    items = {
        {
            label = 'Uruchom nagrywanie',
            icon = "fa-solid fa-film",
            onSelect = function()
                StartRecording(1)
            end
        },
        {
            label = 'Zakończ nagrywanie',
            icon = "fa-solid fa-film",
            onSelect = function()
                StopRecordingAndSaveClip()
            end
        },
        {
            label = 'Usuń klip',
            icon = "fa-solid fa-film",
            onSelect = function()
                StopRecordingAndDiscardClip()
            end
        },
        {
            label = 'Edytor Rockstar',
            icon = "fa-solid fa-film",
            onSelect = function()
                NetworkSessionLeaveSinglePlayer()
                ActivateRockstarEditor()
            end
        }
    }
})

lib.registerRadial({
    id = 'car',
    items = {
        {
            label = 'Radio',
            icon = "fa-solid fa-tachograph-digital",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports["mrg_radiocar"]:OpenRadio()
            end
        },
        {
            label = 'Przebieg',
            icon = "fa-solid fa-gauge-simple-high",
            onSelect = function()
                ESX.ShowNotification("Przebieg pojazdu wynosi: "..exports['p_mechanicjob']:formatMileage(exports['p_mechanicjob']:getMileage(GetVehiclePedIsIn(PlayerPedId(), false))).." KM")
            end
        },
        {
            label = 'Zmień Siedzenie',
            icon = "fa-solid fa-chair",
            iconWidth = 25,
            iconHeight = 25,
            menu = "car-seats"
        },
        {
            label = 'Sterowanie szybami',
            icon = "fa-solid fa-table",
            iconWidth = 25,
            iconHeight = 25,
            menu = "car-windows"
        },  
        {
            label = 'Sterowanie drzwiami',
            icon = "fa-solid fa-door-open",
            iconWidth = 25,
            iconHeight = 25,
            menu = "car-doors"
        },  
    }
})

local seatnumbers = {
    [-1] = "Kierowca",
    [0] = "Pasażer",
    [1] = "Za kierowcą",
    [2] = "Za pasażerem"
}
local windownumbers = {
    [0] = "Przednia Lewa",
    [1] = "Tylnia Lewa",
    [2] = "Przednia Prawa",
    [3] = "Tylnia Prawa"
}
local doorsnumbers = {
    [0] = "Przednie Lewe",
    [1] = "Przednie Prawe",
    [2] = "Tylne Lewe",
    [3] = "Tylne Prawe",
    [4] = "Maska",
    [5] = "Bagażnik"
}
RegisterCommand("seat", function(source, args)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle then
        if IsVehicleSeatFree(vehicle, args[1]-2) then
            SetPedIntoVehicle(PlayerPedId(), vehicle, args[1]-2)
        else
            ESX.ShowNotification("Siedzenie jest zajęte")
        end
    end
end)
RegisterCommand("window", function(source, args)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle then
        if IsVehicleWindowIntact(vehicle, args[1]-1) then
            RollDownWindow(vehicle, args[1]-1)
        else
            RollUpWindow(vehicle, args[1]-1)
        end
    end
end)
RegisterCommand("door", function(source, args)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle then
        if GetVehicleDoorAngleRatio(vehicle, args[1]-1) > 0.1 then
            SetVehicleDoorShut(vehicle, args[1]-1, false)
        else
            SetVehicleDoorOpen(vehicle, args[1]-1)
        end
    end
end)
lib.onCache('vehicle', function(value)
    if value then 
        local seatsbuttons = {}
        local windowbuttons = {}
        local doorbuttons = {}
        for i=1,GetVehicleModelNumberOfSeats(GetEntityModel(value)) do
             table.insert(seatsbuttons, {
                label = seatnumbers[i-2] or "Siedzenie: "..i,
                icon = "fa-solid fa-chair",
                keepOpen = true,
                onSelect = function()
                    if IsVehicleSeatFree(value, i-2) then
                        SetPedIntoVehicle(PlayerPedId(), value, i-2)
                    else
                        ESX.ShowNotification("Siedzenie jest zajęte")
                    end
                end
            })
        end
        for i=3,0,-1 do
            table.insert(windowbuttons, {
                label = windownumbers[i],
                icon = "fa-solid fa-table",
                keepOpen = true,
                onSelect = function()
                    if IsVehicleWindowIntact(value, i) then
                        RollDownWindow(value, i)
                    else
                        RollUpWindow(value, i)
                    end
                end
           })
       end
       for i=0,5 do
            if GetIsDoorValid(value, i) then
                table.insert(doorbuttons, {
                    label = doorsnumbers[i],
                    icon = "fa-solid fa-door-open",
                    keepOpen = true,
                    onSelect = function()
                        if GetVehicleDoorAngleRatio(value, i) > 0.1 then
                            SetVehicleDoorShut(value, i, false)
                        else
                            SetVehicleDoorOpen(value, i)
                        end
                    end
                })
            end
        end
        lib.registerRadial({
            id = 'car-seats',
            items = seatsbuttons
        })
        lib.registerRadial({
            id = 'car-doors',
            items = doorbuttons
        })
        lib.registerRadial({
            id = 'car-windows',
            items = windowbuttons
        })
        lib.addRadialItem({
            {
                id = 'car',
                label = "Pojazd",
                icon = 'car',
                menu = 'car'
            }
        })
    else
        lib.removeRadialItem('car')
    end
end)
ReloadInventory = function()
    local countphone = exports.ox_inventory:Search('count', 'phone')
    if countphone > 0 and not InZones["Phone"] then
        InZones["Phone"] = true
        lib.addRadialItem({
            {
                id = 'phone',
                label = 'Telefon',
                icon = "fa-solid fa-phone",
                iconWidth = 25,
                iconHeight = 25,
                onSelect = function()
                    exports["lb-phone"]:ToggleOpen(true, false)
                end
            },
        })
    end
    if countphone == 0 and InZones["Phone"] then
        InZones["Phone"] = false
        lib.removeRadialItem("phone")
    end
    local CharacterOptions = {
        {
            id = 'rockstar',
            label = 'Edytor Rockstar',
            icon = "fa-solid fa-film",
            iconWidth = 25,
            iconHeight = 25,
            menu = "rockstar"
        },
        {
            id = 'jobs',
            label = 'Zatrudnienia',
            icon = "fa-solid fa-suitcase",
            menu = "jobmenu"
        },
        {
            id = 'achivements',
            label = 'Osiągnięcia',
            icon = "fa-solid fa-award",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                exports['mrg_achivements']:OpenAchivements()
            end
        },
        {
            id = 'stats',
            label = 'Statystyki',
            icon = "fa-solid fa-person-walking",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                ExecuteCommand("+statistics")
            end
        },
        {
            id = 'documents',
            label = 'Dokumenty',
            icon = "fa-id-card",
            iconWidth = 25,
            iconHeight = 25,
            menu = "documents"
        },
    }
    local Documents = {}
    local countid = exports.ox_inventory:Search('count', 'idcard')
    if countid > 0 then
        table.insert(Documents, {
            id = 'idcard',
            label = 'Dowód Osobisty',
            icon = "fa-id-card",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', 'idcard')
            end
        })
    end
    local countid = exports.ox_inventory:Search('count', 'driver')
    if countid > 0 then
        table.insert(Documents, {
            id = 'idcard',
            label = 'Prawo Jazdy',
            icon = "fa-id-card",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent('mrg_documents:document:show', 'driver')
            end
        })
    end
    local countid = exports.ox_inventory:Search('count', 'weapon')
    if countid > 0 then
        table.insert(Documents, {
            id = 'idcard',
            label = 'Licencja na broń',
            icon = "fa-id-card",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerServerEvent("mrg_documents:document:show", 'weapon')
            end
        })
    end
    local tabletid = exports.ox_inventory:Search('count', 'tablet')
    if tabletid > 0 and exports["sfctab"]:getMyGroup() ~= 0 then
        table.insert(CharacterOptions, {
            id = 'org',
            label = 'Tablet Organizacji',
            icon = "fa-tablet",
            iconWidth = 25,
            iconHeight = 25,
            onSelect = function()
                TriggerEvent("sfctab:tabletopen")
            end
        })
    end
    lib.registerRadial({
        id = 'documents',
        items = Documents
    })
    lib.registerRadial({
        id = 'character',
        items = CharacterOptions
    })
end