ESX = exports.es_extended:getSharedObject()
AvailableWeatherTypes = {}
ESX.TriggerServerCallback("tr-admin:getWeatherTypes", function (data)
    AvailableWeatherTypes = data
end)
lib.locale()
IsNoClipping = false
ShowBlips = false
ShowNames = false
toggle_godmode = false
EntityViewEnabled     = false
EntityFreeAim         = false
EntityPedView         = false
EntityObjectView      = false
EntityVehicleView     = false
EntityViewDistance    = 10
showCoords = false
local Cageobj = nil;
function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end


RegisterNetEvent("tr-admin:killPlayer", function ()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("tr-admin:healPlayer", function ()
    exports.wasabi_ambulance:clearPlayerInjury(true)
end)

local function round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end


local function OpenManagePlayer()
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.open"] then
            local options = {}
            if permissions["admin.revive"] then
                table.insert(options, { label = locale("adminmenu.player.revive"), icon="fa-bandage", args = {
                    action = "revive"
                } })
            end
            if permissions["admin.heal"] then
                table.insert(options, { label = locale("adminmenu.player.heal"), icon="fa-bandage", args = {
                    action = "heal"
                } })
            end
            if permissions["admin.kill"] then
                table.insert(options, { label = locale("adminmenu.player.kill"), icon="fa-skull", args = {
                    action = "kill"
                } })
            end
            if permissions["admin.giveitem"] then
                table.insert(options, { label = locale("adminmenu.player.giveitem"), icon = "fa-hand-holding", args = {
                    action = "giveitem"
                } })
            end
            if permissions["admin.noclip"] then
                table.insert(options, { label = locale("adminmenu.player.noclip"), checked = IsNoClipping, args = {
                    action = "toggle_noclip"
                } })
            end
            if permissions["admin.godmode"] then
                table.insert(options, { label = locale("adminmenu.player.godmode"), checked = toggle_godmode, args = {
                    action = "toggle_godmode"
                } })
            end
            if permissions["admin.show.names"] then
                table.insert(options, { label = locale("adminmenu.player.show.names"), checked = ShowNames, args = {
                    action = "toggle_names"
                } })
            end
            if permissions["admin.show.blips"] then
                table.insert(options, { label = locale("adminmenu.player.show.blips"), checked = ShowBlips, args = {
                    action = "toggle_blips"
                } })
            end
            if #options == 0 then
                table.insert(options, { label = locale("adminmenu.no_options") })
            end
            lib.registerMenu({
                id = "tr-admin:playermenu",
                position = "bottom-right",
                title = locale("adminmenu.manage_player"),
                options = options,
                onClose = function (keyPressed)
                    ExecuteCommand("-adminmenu")
                end,
                onCheck = function (selected, scrollIndex, args, checked)
                    if args.action == "toggle_noclip" then
                        ToggleNoClip(not IsNoClipping)
                    end
                    if args.action == "toggle_names" then
                        ShowNames = not ShowNames
                    end
                    if args.action == "toggle_godmode" then
                        toggle_godmode = not toggle_godmode
                        SetPlayerInvincible(PlayerId(), toggle_godmode)
                    end
                    if args.action == "toggle_blips" then
                        ShowBlips = not ShowBlips
                    end
                end
            }, function (selected, scrollIndex, args, checked)
                if args.action == "heal" then
                    ESX.TriggerServerCallback('tr-admin:HealPlayer', function(completed, err)
                        if completed then
                            lib.notify({
                                title = locale("adminmenu.players.heal"),
                                description = locale("adminmenu.players.heal_notify.success"),
                                type = 'success'
                            })
                        else 
                            lib.notify({
                                title = locale("adminmenu.players.heal"),
                                description = locale("adminmenu.players.heal_notify.error", err),
                                type = 'error'
                            })
                        end
                    end, GetPlayerServerId(PlayerId()))
                elseif args.action == "kill" then
                    ESX.TriggerServerCallback('tr-admin:killPlayer', function(completed, err)
                        if completed then
                            lib.notify({
                                title = locale("adminmenu.players.kill"),
                                description = locale("adminmenu.players.kill_notify.success"),
                                type = 'success'
                            })
                        else 
                            lib.notify({
                                title = locale("adminmenu.players.kill"),
                                description = locale("adminmenu.players.kill_notify.error", err),
                                type = 'error'
                            })
                        end
                    end, GetPlayerServerId(PlayerId()))
                elseif args.action == "revive" then
                    ESX.TriggerServerCallback('tr-admin:RevivePlayer', function(completed, err)
                        if completed then
                            lib.notify({
                                title = locale("adminmenu.players.revive"),
                                description = locale("adminmenu.players.revive_notify.success"),
                                type = 'success'
                            })
                        else 
                            lib.notify({
                                title = locale("adminmenu.players.revive"),
                                description = locale("adminmenu.players.revive_notify.error", err),
                                type = 'error'
                            })
                        end
                    end, GetPlayerServerId(PlayerId()))
                elseif args.action == "giveitem" then
                    local input = lib.inputDialog(locale("adminmenu.players.giveitem"), {
                        {type = 'input', label = locale("adminmenu.players.item"), required = true},
                        {type = 'number', label = locale("adminmenu.players.count"), required = true, icon = 'hashtag'},
                        {type = 'input', label = locale("adminmenu.players.metadata"), required = false},
                    })                  
                    if input == nil then OpenManagePlayer() return end
                    ESX.TriggerServerCallback("tr-admin:giveItemPlayer", function (completed, err)
                        if completed then
                            lib.notify({
                                title = locale("adminmenu.players.giveitem"),
                                description = locale("adminmenu.players.giveitem_notify.success"),
                                type = 'success'
                            })
                        else 
                            lib.notify({
                                title = locale("adminmenu.players.giveitem"),
                                description = locale("adminmenu.players.giveitem_notify.error", err),
                                type = 'error'
                            })
                        end
                    end, GetPlayerServerId(PlayerId()), input[1], input[2], input[3])
                    lib.showMenu("tr-admin:playermenu")                
                end
            end)
            lib.showMenu("tr-admin:playermenu")
        end
    end, {"admin.open", "admin.noclip", "admin.godmode", "admin.giveitem", "admin.revive", "admin.show.names", "admin.show.blips", "admin.invisible", "admin.kill", "admin.heal"})
end

local function OpenManageServer()
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.open"] and permissions["admin.manage.server"] then
            local options = {}
            ESX.TriggerServerCallback("tr-admin:getvSync", function(froze, weather, weatherfroze, blackout)
                if permissions["admin.announcement"] then
                    table.insert(options, { label = locale("adminmenu.server.announcement"), icon="fa-bullhorn", args = {
                        action = "announcement"
                    } })
                end
                if permissions["admin.time.change"] then
                    table.insert(options, { label = locale("adminmenu.server.time"), icon="fa-clock", args = {
                        action = "time"
                    } })
                end
                if permissions["admin.time.froze"] then
                    table.insert(options, { label = locale("adminmenu.server.time_froze"), checked = froze, args = {
                        action = "time_froze"
                    } })
                end
                if permissions["admin.weather.change"] then
                    table.insert(options, { label = locale("adminmenu.server.weather"), values = AvailableWeatherTypes, defaultIndex=indexOf(AvailableWeatherTypes, weather), args = {
                        action = "weather"
                    } })
                end
                if permissions["admin.weather.froze"] then
                    table.insert(options, { label = locale("adminmenu.server.weather_froze"), checked=not weatherfroze, args = {
                        action = "weather_froze"
                    } })
                end
                if permissions["admin.blackout.change"] then
                    table.insert(options, { label = locale("adminmenu.server.blackout"), checked=blackout, args = {
                        action = "blackout"
                    } })
                end
                if #options == 0 then
                    table.insert(options, { label = locale("adminmenu.no_options") })
                end
                lib.registerMenu({
                    id = "tr-admin:servermenu",
                    position = "bottom-right",
                    title = locale("adminmenu.manage.title"),
                    options = options,
                    onClose = function (keyPressed)
                        ExecuteCommand("-adminmenu")
                    end,
                    onCheck = function (selected, scrollIndex, args, checked)
                        if args.action == "blackout" then
                            ESX.TriggerServerCallback("tr-admin:ToggleBlackout", function (completed, err)
                                if completed then
                                    if err then
                                        lib.notify({
                                            title = locale("adminmenu.server.blackout"),
                                            description = locale("adminmenu.manage.blackout.on"),
                                            type = 'success'
                                        })
                                    else
                                        lib.notify({
                                            title = locale("adminmenu.server.blackout"),
                                            description = locale("adminmenu.manage.blackout.off"),
                                            type = 'success'
                                        })
                                    end
                                else 
                                    lib.notify({
                                        title = locale("adminmenu.server.blackout"),
                                        description = locale("adminmenu.players.open_select_notify.error", err),
                                        type = 'error'
                                    })
                                end
                            end) 
                        elseif args.action == "weather_froze" then
                            ESX.TriggerServerCallback("tr-admin:ToggleFrozeWeather", function (completed, err)
                                if completed then
                                    if err then
                                        lib.notify({
                                            title = locale("adminmenu.server.weather_froze"),
                                            description = locale("adminmenu.manage.weather.unfrozen"),
                                            type = 'success'
                                        })
                                    else
                                        lib.notify({
                                            title = locale("adminmenu.server.weather_froze"),
                                            description = locale("adminmenu.manage.weather.frozen"),
                                            type = 'success'
                                        })
                                    end
                                else 
                                    lib.notify({
                                        title = locale("adminmenu.server.weather_froze"),
                                        description = locale("adminmenu.players.open_select_notify.error", err),
                                        type = 'error'
                                    })
                                end
                            end) 
                        elseif args.action == "time_froze" then
                            ESX.TriggerServerCallback("tr-admin:ToggleFrozeTime", function (completed, err)
                                if completed then
                                    if not err then
                                        lib.notify({
                                            title = locale("adminmenu.server.time_froze"),
                                            description = locale("adminmenu.manage.time.unfrozen"),
                                            type = 'success'
                                        })
                                    else
                                        lib.notify({
                                            title = locale("adminmenu.server.time_froze"),
                                            description = locale("adminmenu.manage.time.frozen"),
                                            type = 'success'
                                        })
                                    end
                                else 
                                    lib.notify({
                                        title = locale("adminmenu.server.time_froze"),
                                        description = locale("adminmenu.players.open_select_notify.error", err),
                                        type = 'error'
                                    })
                                end
                            end)
                        end
                    end
                }, function (selected, scrollIndex, args, checked)
                    if args.action == "time" then
                        local input = lib.inputDialog(locale("adminmenu.server.announcement"), {
                            {type = 'number', label = locale("adminmenu.manage.time.hours"), min=0, max=24, default=0, required = true},
                            {type = 'number', label = locale("adminmenu.manage.time.minutes"), min=0, max=60, default=0, required = true},
                        });
                        if input == nil then OpenManageServer() return end
                        Wait(1000)
                        ESX.TriggerServerCallback("tr-admin:setTime", function (completed, err)
                            if completed then
                                lib.notify({
                                    title = locale("adminmenu.server.time"),
                                    description = locale("adminmenu.manage.time.success"),
                                    type = 'success'
                                })
                            else 
                                lib.notify({
                                    title = locale("adminmenu.server.time"),
                                    description = locale("adminmenu.players.open_select_notify.error", err),
                                    type = 'error'
                                })
                            end
                            OpenManageServer();
                        end, input[1], input[2])
                    elseif args.action == "announcement" then
                        local input = lib.inputDialog(locale("adminmenu.server.announcement"), {
                            {type = 'input', label = locale("adminmenu.manage.announcement.text"), required = true},
                        });
                        local reason;
                        if input == nil then OpenManageServer() return end
                        Citizen.Wait(1000)
                        ESX.TriggerServerCallback("tr-admin:sendAnnouncement", function (completed, err)
                            if completed then
                                lib.notify({
                                    title = locale("adminmenu.server.announcement"),
                                    description = locale("adminmenu.manage.announcement.success"),
                                    type = 'success'
                                })
                            else 
                                lib.notify({
                                    title = locale("adminmenu.server.announcement"),
                                    description = locale("adminmenu.players.open_select_notify.error", err),
                                    type = 'error'
                                })
                            end
                            OpenManageServer();
                        end, input[1])
                    elseif args.action == "weather" then
                        ESX.TriggerServerCallback("tr-admin:setWeather", function (completed, err)
                            if completed then
                                lib.notify({
                                    title = locale("adminmenu.server.weather"),
                                    description = locale("adminmenu.manage.weather.success"),
                                    type = 'success'
                                })
                            else 
                                lib.notify({
                                    title = locale("adminmenu.server.weather"),
                                    description = locale("adminmenu.players.open_select_notify.error", err),
                                    type = 'error'
                                })
                            end
                            OpenManageServer();
                        end, AvailableWeatherTypes[scrollIndex]);
                    else
                        lib.showMenu("tr-admin:servermenu")
                    end
                end)
                lib.showMenu("tr-admin:servermenu")
            end)
        end
    end, {"admin.open", "admin.manage.server", "admin.announcement", "admin.time.change", "admin.time.froze", "admin.weather.change", "admin.weather.froze", "admin.blackout.change"})
end

local function OpenManagePlayers()
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.open"] and permissions["admin.manage.players"] then
            ESX.TriggerServerCallback("tr-admin:GetPlayers", function(players)
                local options = {}
                table.insert(options, { label = locale("adminmenu.search.title"), icon="fa-user", args = {
                    action = "from_id"
                } })
                local tkeys = {}
                -- populate the table that holds the keys
                for k in pairs(players) do table.insert(tkeys, tonumber(k)) end
                table.sort(tkeys)

                for _, key in pairs(tkeys) do
                    player = players[""..key]
                    local var1, var2 = GetStreetNameAtCoord(player.location.x, player.location.y,
                    player.location.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                    if GetStreetNameFromHashKey(var2) ~= '' then
                        location = GetStreetNameFromHashKey(var1) .. ', ' .. GetStreetNameFromHashKey(var2)
                    else
                        location = GetStreetNameFromHashKey(var1)
                    end
                    table.insert(options, { label = '['..player.playerId..'] '..player.name, description = locale("adminmenu.players.desc", player.firstName, player.lastName, locale("adminmenu.players."..player.sex), location), icon="fa-user", args = {
                        action = "show_player",
                        playerId = player.playerId
                    } })
                end
                lib.registerMenu({
                    id = "tr-admin:playersmenu",
                    position = "bottom-right",
                    title = locale("adminmenu.manage_players"),
                    options = options,
                    onClose = function (keyPressed)
                        ExecuteCommand("-adminmenu")
                    end
                }, function (selected, scrollIndex, args, checked)
                    if args.action == "from_id" then
                        local input = lib.inputDialog(locale("adminmenu.search.title"), {
                            {type = 'number', label = locale("adminmenu.search.playerId"), icon = 'hashtag'},
                        })
                        if input == nil then lib.showMenu("tr-admin:playersmenu") return end
                        if input[1] == "" then lib.showMenu("tr-admin:playersmenu") return end
                        if players[""..input[1]] then
                            player = players[""..input[1]]
                            OpenPlayerMenu(player)
                        else
                            lib.showMenu("tr-admin:playersmenu")
                        end
                    elseif args.action == "show_player" then
                        player = players[""..args.playerId]
                        OpenPlayerMenu(player)
                    else
                        lib.showMenu("tr-admin:playersmenu")
                    end
                end)
                lib.showMenu("tr-admin:playersmenu")
            end)
        end
    end, {"admin.open", "admin.manage.players"})
end
local ScareOptions = {
    "spooky",
    "spider",
    "puppet",
    "puppet2",
    "stickman",
    "santa",
    "knock",
    "foxy",
    "sayhello",
    "sayhellonear",
    "sayfindme",
    "sayfindmenear"
}
function OpenPlayerTrollMenu(player)
    permissions = {"admin.trollmenu", "admin.trollmenu.scare", "admin.trollmenu.slap", "admin.trollmenu.explode", "admin.trollmenu.wild", "admin.trollmenu.drug", "admin.trollmenu.drunk", "admin.trollmenu.clown", "admin.trollmenu.ragdoll", "admin.trollmenu.fire", "admin.trollmenu.cage", "admin.trollmenu.crash", "admin.trollmenu.spamcmds"}
    for k, v in pairs(ScareOptions) do
        table.insert(permissions, "admin.trollmenu.scare."..v)
    end
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.trollmenu"] then
            options = {}
            if permissions["admin.trollmenu.slap"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.slap"), args = {
                    action = "slap"
                }})
            end
            if permissions["admin.trollmenu.fire"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.fire"), args = {
                    action = "fire"
                }})
            end
            if permissions["admin.trollmenu.crash"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.crash"), args = {
                    action = "crash"
                }})
            end
            if permissions["admin.trollmenu.spamcmds"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.spamcmds"), args = {
                    action = "spamcmds"
                }})
            end
            if permissions["admin.trollmenu.explode"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.explode"), args = {
                    action = "explode"
                }})
            end
            
            if permissions["admin.trollmenu.ragdoll"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.ragdoll"), args = {
                    action = "ragdoll"
                }})
            end
            if permissions["admin.trollmenu.clown"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.clown"), args = {
                    action = "clown"
                }})
            end
            if permissions["admin.trollmenu.drug"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.drug"), args = {
                    action = "drug"
                }})
            end
            if permissions["admin.trollmenu.wild"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.wild"), args = {
                    action = "wild"
                }})
            end
            if permissions["admin.trollmenu.drunk"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.drunk"), args = {
                    action = "drunk"
                }})
            end
            local PermitedScareOptions = {}
            for k, v in pairs(ScareOptions) do
                
                if permissions["admin.trollmenu.scare."..v] then
                    table.insert(PermitedScareOptions, { label = locale("adminmenu.players.trollmenu_options.scare_options."..v), args = v})
                end
            end
            if #PermitedScareOptions == 0 then
                table.insert(PermitedScareOptions, { label = locale("adminmenu.no_options") })
            end
            if permissions["admin.trollmenu.scare"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.scare"), values = PermitedScareOptions, args = {
                    action = "scare"
                } })
            end
            if permissions["admin.trollmenu.drunk"] then
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.forceleft"), args = {
                    action = "forceleft"
                }})
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.forceright"), args = {
                    action = "forceright"
                }})
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.forceaccelerate"), args = {
                    action = "forceaccelerate"
                }})
                table.insert(options, { label = locale("adminmenu.players.trollmenu_options.forcereverse"), args = {
                    action = "forcereverse"
                }})
            end
            if #options == 0 then
                table.insert(options, { label = locale("adminmenu.no_options") })
            end
            lib.registerMenu({
                id = "tr-admin:trollmenu",
                position = "bottom-right",
                title = '['..player.playerId..'] '..player.name.. " "..locale("adminmenu.players.trollmenu"),
                options = options,
                onClose = function (keyPressed)
                    OpenPlayerMenu(player)
                end
            }, function (selected, scrollIndex, args, checked)
                if args.action == "scare" then
                    args.action = "scare."..PermitedScareOptions[scrollIndex].args
                end                    
                ESX.TriggerServerCallback("tr-admin:trollmenu:execute", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.trollmenu"),
                            description = locale("adminmenu.players.trollmenu_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.trollmenu"),
                            description = locale("adminmenu.players.trollmenu_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId, args.action)
                OpenPlayerTrollMenu(player)
            end)
            lib.showMenu("tr-admin:trollmenu")
        end
    end, permissions)
end
function OpenPlayerMenu(player)
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        options = {
            { label = locale("adminmenu.players.info"), icon = "fa-user", args = {
                action = "char_info"
            }},
        }
        if permissions["admin.revive"] then
            table.insert(options, { label = locale("adminmenu.player.revive"), icon="fa-bandage" , args = {
                action = "revive"
            }})
        end
        if permissions["admin.spectate"] then
            table.insert(options, { label = locale("adminmenu.player.spectate"), icon="fa-binoculars" , args = {
                action = "spectate"
            }})
        end
        if permissions["admin.heal"] then
            table.insert(options, { label = locale("adminmenu.player.heal"), icon="fa-bandage" , args = {
                action = "heal"
            }})
        end
        if permissions["admin.kill"] then
            table.insert(options, { label = locale("adminmenu.player.kill"), icon="fa-skull", args = {
                action = "kill"
            } })
        end
        if permissions["admin.warn"] then
            table.insert(options, { label = locale("adminmenu.players.warn"), icon = "fa-triangle-exclamation", args = {
                action = "warn"
            }})
        end
        if permissions["admin.screenshot"] then
            table.insert(options, { label = locale("adminmenu.players.screenshot"), icon = "fa-camera", args = {
                action = "screenshot"
            }})
        end
        if permissions["admin.ban"] then
            table.insert(options, { label = locale("adminmenu.players.ban"), icon = "fa-hammer", args = {
                action = "ban"
            }})
        end
        if permissions["admin.kick"] then
            table.insert(options, { label = locale("adminmenu.players.kick"), icon = "fa-xmark", args = {
                action = "kick"
            }})
        end
        if permissions["admin.giveitem"] then
            table.insert(options, { label = locale("adminmenu.players.giveitem"), icon = "fa-hand-holding", args = {
                action = "giveitem"
            }})
        end
        if permissions["admin.inventory"] then
            table.insert(options, { label = locale("adminmenu.players.inventory"), icon = "fa-hand-holding", args = {
                action = "inventory"
            }})
        end
        if permissions["admin.trollmenu"] then
            table.insert(options, { label = locale("adminmenu.players.trollmenu"), icon = "fa-face-grin-tongue-wink", args = {
                action = "trollmenu"
            }})
        end
        if permissions["admin.cleareq"] then
            table.insert(options, { label = locale("adminmenu.players.cleareq"), icon = "fa-trash", args = {
                action = "cleareq"
            }})
        end
        if #options == 0 then
            table.insert(options, { label = locale("adminmenu.no_options") })
        end
        lib.registerMenu({
            id = "tr-admin:manageplayermenu",
            position = "bottom-right",
            title = '['..player.playerId..'] '..player.name,
            options = options,
            onClose = function (keyPressed)
                OpenManagePlayers()
            end
        }, function (selected, scrollIndex, args, checked)
            if args.action == "spectate" then
                StartSpectate(player.playerId)
            elseif args.action == "screenshot" then
                ESX.TriggerServerCallback('tr-admin:TookScreenshotOfPlayer', function(completed, data)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.screenshot"),
                            description = locale("adminmenu.players.screenshot_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.kill"),
                            description = locale("adminmenu.players.screenshot_notify.error", data),
                            type = 'error'
                        })
                    end
                end, player.playerId)
            elseif args.action == "trollmenu" then
                OpenPlayerTrollMenu(player)
            elseif args.action == "kill" then
                ESX.TriggerServerCallback('tr-admin:killPlayer', function(completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.kill"),
                            description = locale("adminmenu.players.kill_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.kill"),
                            description = locale("adminmenu.players.kill_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
            elseif args.action == "heal" then
                ESX.TriggerServerCallback('tr-admin:HealPlayer', function(completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.heal"),
                            description = locale("adminmenu.players.heal_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.heal"),
                            description = locale("adminmenu.players.heal_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
                OpenPlayerMenu(player)
            elseif args.action == "inventory" then
                ESX.TriggerServerCallback('tr-admin:requestOpenPlayerInventory', function(completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.inventory"),
                            description = locale("adminmenu.players.inventory_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.inventory"),
                            description = locale("adminmenu.players.inventory_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
            elseif args.action == "revive" then
                ESX.TriggerServerCallback('tr-admin:RevivePlayer', function(completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.revive"),
                            description = locale("adminmenu.players.revive_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.revive"),
                            description = locale("adminmenu.players.revive_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
                OpenPlayerMenu(player)
            elseif args.action == "cleareq" then
                ESX.TriggerServerCallback("tr-admin:clearPlayerInventory", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.cleareq"),
                            description = locale("adminmenu.players.cleareq_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.cleareq"),
                            description = locale("adminmenu.players.cleareq_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
                OpenPlayerMenu(player)
            elseif args.action == "giveitem" then
                local input = lib.inputDialog(locale("adminmenu.players.giveitem"), {
                    {type = 'input', label = locale("adminmenu.players.item"), required = true},
                    {type = 'number', label = locale("adminmenu.players.count"), required = true, icon = 'hashtag'},
                    {type = 'input', label = locale("adminmenu.players.metadata"), required = false},
                })                  
                if input == nil then OpenPlayerMenu(player) return end
                ESX.TriggerServerCallback("tr-admin:giveItemPlayer", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.giveitem"),
                            description = locale("adminmenu.players.giveitem_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.giveitem"),
                            description = locale("adminmenu.players.giveitem_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId, input[1], input[2], input[3])
                OpenPlayerMenu(player)
            elseif args.action == "warn" then
                local input = lib.inputDialog(locale("adminmenu.players.warn"), {
                    {type = 'input', label = locale("adminmenu.players.reason"), required = true},
                });
                local reason;
                if input == nil then OpenPlayerMenu(player) return end
                Citizen.Wait(1000)
                ESX.TriggerServerCallback("tr-admin:WarnPlayer", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.warn"),
                            description = locale("adminmenu.players.player_warned"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.warn"),
                            description = locale("adminmenu.players.crash_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId, input[1])
                Citizen.Wait(1000)
                OpenPlayerMenu(player)
            elseif args.action == "kick" then
                local input = lib.inputDialog(locale("adminmenu.players.kick"), {locale("adminmenu.players.reason")})
                local reason;
                if input == nil then OpenPlayerMenu(player) return end
                if input[1] == "" then reason = locale("adminmenu.players.kick_no_reason") else reason = input[1] end
                Citizen.Wait(1000)
                ESX.TriggerServerCallback("tr-admin:KickPlayer", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.kick"),
                            description = locale("adminmenu.players.player_kicked"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.kick"),
                            description = locale("adminmenu.players.crash_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId, reason)
                Citizen.Wait(1000)
                OpenManagePlayers()
            elseif args.action == "ban" then
                local input = lib.inputDialog(locale("adminmenu.players.ban"), {
                    {type = 'input', label = locale("adminmenu.players.reason"), min = 4, max = 16},
                    {type = 'checkbox', label = locale("adminmenu.players.perm"), icon = 'hashtag'},
                    {type = 'number', label = locale("adminmenu.players.time"), icon = 'hashtag', default=10},
                    {type = 'select', label = locale("adminmenu.players.unit.title"), options={
                        { label=locale("adminmenu.players.unit.hours"), value="hours" },
                        { label=locale("adminmenu.players.unit.days"), value="days" },
                        { label=locale("adminmenu.players.unit.weeks"), value="weeks" },
                        { label=locale("adminmenu.players.unit.months"), value="months" }
                    }, default="hours"},
                  })
                local reason;
                if input == nil then OpenPlayerMenu(player) return end
                if input[1] == "" then reason = locale("adminmenu.players.ban_no_reason") else reason = input[1] end
                local time = input[2] and "permanent" or input[3].." "..input[4]
                Citizen.Wait(1000)
                ESX.TriggerServerCallback("tr-admin:BanPlayer", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.ban"),
                            description = locale("adminmenu.players.player_ban"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.kick"),
                            description = locale("adminmenu.players.crash_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId, reason, time)
                Citizen.Wait(1000)
                OpenManagePlayers()
            elseif args.action == "crash" then
                Citizen.Wait(1000)
                ESX.TriggerServerCallback("tr-admin:crashPlayer", function (completed, err)
                    if completed then
                        lib.notify({
                            title = locale("adminmenu.players.crash_notify.title"),
                            description = locale("adminmenu.players.crash_notify.success"),
                            type = 'success'
                        })
                    else 
                        lib.notify({
                            title = locale("adminmenu.players.crash_notify.title"),
                            description = locale("adminmenu.players.crash_notify.error", err),
                            type = 'error'
                        })
                    end
                end, player.playerId)
                Citizen.Wait(1000)
                OpenManagePlayers()
            elseif args.action == "char_info" then
                local var1, var2 = GetStreetNameAtCoord(player.location.x, player.location.y,
                player.location.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                if GetStreetNameFromHashKey(var2) ~= '' then
                    location = GetStreetNameFromHashKey(var1) .. ', ' .. GetStreetNameFromHashKey(var2)
                else
                    location = GetStreetNameFromHashKey(var1)
                end
                options = {
                    { label = locale("adminmenu.players.char_info.firstname", player.firstName)},
                    { label = locale("adminmenu.players.char_info.lastname", player.lastName)},
                    { label = locale("adminmenu.players.char_info.dob", player.dateofbirth)},
                    { label = locale("adminmenu.players.char_info.gender", locale("adminmenu.players."..player.sex))},
                    { label = locale("adminmenu.players.char_info.height", player.height)},
                    { label = locale("adminmenu.players.char_info.street", location)},
                }
                lib.registerMenu({
                    id = "tr-admin:manageplayercharmenu",
                    position = "bottom-right",
                    title = '['..player.playerId..'] '..player.name,
                    options = options,
                    onClose = function (keyPressed)
                        OpenPlayerMenu(player)
                    end
                }, function (selected, scrollIndex, args, checked)
                    lib.showMenu("tr-admin:manageplayercharmenu")
                end)
                lib.showMenu("tr-admin:manageplayercharmenu")
            else
                OpenPlayerMenu(player)
            end
        end)
        lib.showMenu("tr-admin:manageplayermenu")
    end, {"admin.ban", "admin.kick", "admin.revive", "admin.heal", "admin.inventory", "admin.spectate", "admin.kill", "admin.trollmenu", "admin.cleareq", "admin.warn", "admin.giveitem", "admin.screenshot"})
end

range = {5,10,15,20,25,30,35,40,45,50};

function OpenPlayerDeveloperMenu()
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.developer"] then
            options = {
                { label = locale("adminmenu.developer.entity_view_distanc_title"), 
                values = range,
                defaultIndex = indexOf(range, EntityViewDistance),
                args = {
                    action = "entity_view_distance"
                }},
                { label = locale("adminmenu.developer.entity_view_freeaim_copy"), 
                args = {
                    action = "entity_view_freeaim_copy"
                }},
                { label = locale("adminmenu.developer.entity_view_freeaim"), 
                checked = EntityFreeAim,
                args = {
                    action = "entity_view_freeaim"
                }},
                { label = locale("adminmenu.developer.entity_view_vehicles"), 
                checked = EntityVehicleView,
                args = {
                    action = "entity_view_vehicles"
                }},
                { label = locale("adminmenu.developer.entity_view_peds"), 
                checked = EntityPedView,
                args = {
                    action = "entity_view_ped"
                }},
                { label = locale("adminmenu.developer.entity_view_objects"), 
                checked = EntityObjectView,
                args = {
                    action = "entity_view_object"
                }},
                { label = locale("adminmenu.developer.copycoords"), 
                args = {
                    action = "copycoords"
                }},
                { label = locale("adminmenu.developer.showcoords"), 
                checked = showCoords,
                args = {
                    action = "showcoords"
                }}
            }
            if IsPedInAnyVehicle(PlayerPedId()) then
                table.insert(options, { label = locale("adminmenu.developer.vehiclefulltune"), 
                args = {
                    action = "vehiclefulltune"
                }})
                table.insert(options, { label = locale("adminmenu.developer.vehicletunemenu"), 
                args = {
                    action = "vehicletunemenu"
                }})
            end
            if #options == 0 then
                table.insert(options, { label = locale("adminmenu.no_options") })
            end
            lib.registerMenu({
                id = "tr-admin:devmenu",
                position = "bottom-right",
                title = 'DEV MENU',
                options = options,
                onClose = function (keyPressed)
                    ExecuteCommand("-adminmenu")
                end,
                onCheck = function (selected, scrollIndex, args, checked)
                    if args.action == "entity_view_freeaim" then
                        ToggleEntityFreeView()
                    end
                    if args.action == "entity_view_vehicles" then
                        ToggleEntityVehicleView()
                    end
                    if args.action == "entity_view_object" then
                        ToggleEntityObjectView()
                    end
                    if args.action == "entity_view_ped" then
                        ToggleEntityPedView()
                    end
                    if args.action == "showcoords" then
                        showCoords = not showCoords
                    end
                end
            }, function (selected, scrollIndex, args, checked)
                if args.action == "vehicletunemenu" then
                    exports['p_tuningmenu']:OpenTuningMenu(false)
                    return
                elseif args.action == "vehiclefulltune" then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        SetVehicleModKit(vehicle, 0)
                        for modType = 0, 49, 1 do
                            local bestMod = GetNumVehicleMods(vehicle, modType)-1
                            SetVehicleMod(vehicle, modType, bestMod, false)
                            ToggleVehicleMod(vehicle, 18, true)
                        end
                    end
                elseif args.action == "copycoords" then
                    CopyToClipboard('coords4')
                elseif args.action == "entity_view_freeaim_copy" then
                    CopyToClipboard('freeaimEntity')
                elseif args.action == "entity_view_distance" then
                    SetEntityViewDistance(range[scrollIndex])
                    lib.notify({
                         title= locale("adminmenu.developer.entity_view_distance", range[scrollIndex]),
                         description= locale("adminmenu.developer.entity_view_distance", range[scrollIndex]),
                    })
                end
                OpenPlayerDeveloperMenu()
            end)
            lib.showMenu("tr-admin:devmenu")
        end
    end, {"admin.developer"})
end

deleterange = {50, 100, 150, 200, 250, 300}

function OpenPlayerMiscMenu()
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.open"] then
            options = {
                { label = locale("adminmenu.misc.cleararea.vehicles"), 
                values = deleterange,
                args = {
                    action = "cleararea.vehicles"
                }},
                { label = locale("adminmenu.misc.cleararea.peds"), 
                values = deleterange,
                args = {
                    action = "cleararea.peds"
                }},
            }
            if #options == 0 then
                table.insert(options, { label = locale("adminmenu.no_options") })
            end
            lib.registerMenu({
                id = "tr-admin:miscmenu",
                position = "bottom-right",
                title = 'MISC MENU',
                options = options,
                onClose = function (keyPressed)
                    ExecuteCommand("-adminmenu")
                end,
            }, function (selected, scrollIndex, args, checked)
                if args.action == "cleararea.peds" then
                    local curCoords = GetEntityCoords(PlayerPedId())
                    local radiusToFloat = deleterange[scrollIndex] + 0.0
                    ClearAreaOfPeds(curCoords.x, curCoords.y, curCoords.z, radiusToFloat, false, false, false, false, false)
                elseif args.action == "cleararea.vehicles" then
                    local curCoords = GetEntityCoords(PlayerPedId())
                    local radiusToFloat = deleterange[scrollIndex] + 0.0
                    ClearAreaOfVehicles(curCoords.x, curCoords.y, curCoords.z, radiusToFloat, false, false, false, false, false)
                end
                OpenPlayerMiscMenu()
            end)
            lib.showMenu("tr-admin:miscmenu")
        end
    end, {"admin.open"})
end

RegisterCommand("-adminmenu", function (source, args, raw)
    local _source = source
    ESX.TriggerServerCallback("tr-admin:CheckPlayerPermission", function(permissions)
        if permissions["admin.open"] then
            local options = {
                { label = locale("adminmenu.manage_player"), icon="fa-user", args = {
                    action = "manage_player"
                } },
            }
            if permissions["admin.manage.players"] then
                table.insert(options, { label = locale("adminmenu.manage_players"), icon="fa-users", args = {
                    action = "manage_players"
                } })
            end
            if permissions["admin.manage.server"] then
                table.insert(options, { label = locale("adminmenu.manage_server"), icon="fa-server", args = {
                    action = "manage_server"
                } })
            end
            if permissions["admin.developer"] then
                table.insert(options, { label = locale("adminmenu.developer_options"), icon="fa-database", args = {
                    action = "developer_options"
                } })
            end
            table.insert(options, { label = locale("adminmenu.misc_options"), icon="fa-tablet", args = {
                action = "misc_options"
            } })
            lib.registerMenu({
                id = "tr-admin:openmenu",
                position = "bottom-right",
                title = "Panel Administartora",
                options = options
            }, function (selected, scrollIndex, args, checked)
                if args.action == "manage_player" then
                    OpenManagePlayer()
                end 
                if args.action == "manage_server" then
                    OpenManageServer()
                end
                if args.action == "manage_players" then
                    OpenManagePlayers()
                end
                if args.action == "developer_options" then
                    OpenPlayerDeveloperMenu()
                end
                if args.action == "misc_options" then
                    OpenPlayerMiscMenu()
                end
            end)
            lib.showMenu("tr-admin:openmenu")
        end
    end, {"admin.open", "admin.manage.players", "admin.manage.server", "admin.developer"})
end)



RegisterKeyMapping("-adminmenu", locale("adminmenu.keybind"), "keyboard", "HOME")

RegisterNetEvent("tr-admin:trollmenu:player:slap", function ()
    local forcecount = 0 -- Slap function from OFRP
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped, true) then
        repeat
            ApplyForceToEntity(veh, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false, true)
            forcecount = forcecount + 1
            Citizen.Wait(0)
        until(forcecount > 10)
    else
        SetGravityLevel(3)
        ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
        Wait(100)
        SetPedToRagdoll(ped, 500, 500, 0, false, false, false)
        Wait(10000)
        SetGravityLevel(0)
    end
    forcecount = 0

end)

RegisterNetEvent("tr-admin:trollmenu:player:ragdoll", function ()
    SetPedToRagdoll(PlayerPedId(), 10000, 10000, 0, true, true, false)
end)

RegisterNetEvent("tr-admin:trollmenu:player:explode", function ()
    local coords = GetEntityCoords(PlayerPedId())
    AddExplosion(coords.x, coords.y, coords.z, 0, 100.0, true, false, 1.0)
end)


RegisterNetEvent("tr-admin:trollmenu:player:drug", function()

	local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator3")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
    AnimpostfxPlay("HeistCelebPass", 60000, true)
	SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@VERYDRUNK", true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
	
    Citizen.Wait(60000)

    SetPedIsDrunk(playerPed, false)		
	SetPedMoveRateOverride(playerPed,1.0)
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(playerPed)
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)


end)

RegisterNetEvent("tr-admin:trollmenu:player:clown", function()
	local playerPed = PlayerPedId()
	local pCoords = GetEntityCoords(playerPed)

	RequestModel("speedo2")

	repeat
		Wait(10)
	until HasModelLoaded("speedo2")

	RequestModel("s_m_y_clown_01")

	repeat
		Wait(10)
	until HasModelLoaded("s_m_y_clown_01")

	repeat
		found, SpawnCoords = FindSpawnPointInDirection(pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 100.0)
		Wait(100)
	until found

	local veh = CreateVehicle("speedo2", SpawnCoords, 0, true, false)
	SetVehicleModKit(veh, 0)
	SetVehicleMod(veh, 11, 3, false)
	SetVehicleMod(veh, 12, 3, false)
	SetVehicleMod(veh, 13, 3, false)
	ToggleVehicleMod(veh, 18, true)

	AddRelationshipGroup("CLOWNS")
	AddRelationshipGroup("ASSASINTARGET")
	SetPedRelationshipGroupHash(playerPed, "ASSASINTARGET")
	SetRelationshipBetweenGroups(5, "CLOWNS", "ASSASINTARGET")
	SetRelationshipBetweenGroups(0, "CLOWNS", "CLOWNS")
	local peds = {}
	for i=-1, 4 do
		local ped = CreatePedInsideVehicle(veh,"WHATEVER", "s_m_y_clown_01", i, true, false)
		table.insert(peds, ped)
		GiveWeaponToPed(ped, "weapon_pistol", 999, false, true)
		SetPedRelationshipGroupDefaultHash(ped, "CLOWNS")
		SetPedRelationshipGroupHash(ped, "CLOWNS")
		SetPedCombatAbility(ped, 2)
		SetPedCombatMovement(ped, 3)
		SetPedCombatRange(ped, 2)
		SetPedCombatAttributes(ped, 46, true)
		SetPedCombatAttributes(ped, 2, true)
		SetPedCombatAttributes(ped, 3, false)
		SetPedCombatAttributes(ped, 20, false)
		TaskCombatPed(ped, playerPed, 0, 16)
	end

	local allPedsDead
	repeat 
		Wait(100)
		local alivePeds = {}
		for i, ped in pairs(peds) do
			if not IsPedDeadOrDying(ped, true) then
				table.insert(alivePeds,ped)
			end
		end
		for i, ped in pairs(alivePeds) do
			local pedVeh = GetVehiclePedIsUsing(ped)
			if pedVeh ~= 0 and GetEntityHealth(pedVeh) < 100 then
				ClearPedTasks(ped)
				TaskLeaveVehicle(ped, pedVeh, 4160)
				Wait(5000)
				ClearPedTasks(ped)
				TaskCombatPed(ped, playerPed, 0, 16)
			end
		end
		if #alivePeds == 0 then
			allPedsDead = true
		end
	until (IsPedDeadOrDying(PlayerPedId(), true) or allPedsDead)
	for i, ped in pairs(peds) do
		if not IsPedDeadOrDying(ped, true) then
			ClearPedTasks(ped)
			TaskVehicleDriveWander(ped, veh, 60.0, 524860)
			SetPedAsNoLongerNeeded(ped)
		else
			SetPedAsNoLongerNeeded(ped)
		end
	end
	SetVehicleAsNoLongerNeeded(veh)
	SetModelAsNoLongerNeeded("speedo2")
	SetModelAsNoLongerNeeded("s_m_y_clown_01")
end)

RegisterNetEvent("tr-admin:trollmenu:player:scare.spooky", function ()
    SendNUIMessage({
        action = "show",
        type = "spooky",
        display = true
      })
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.puppet", function ()
    SendNUIMessage({
        action = "show",
        type = "puppet",
        display = true
      })
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.puppet2", function ()
    SendNUIMessage({
        action = "show",
        type = "puppet2",
        display = true
      })
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.santa", function ()
    SendNUIMessage({
        action = "show",
        type = "santa",
        display = true
      })
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.foxy", function ()
    SendNUIMessage({
        action = "show",
        type = "foxy",
        display = true
      })
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.stickman", function ()
    SendNUIMessage({
        action = "show",
        type = "stickman",
        display = true
      })
end)

RegisterNetEvent("tr-admin:trollmenu:player:scare.knock", function ()
    SendNUIMessage({
        action = "show",
        type = "knock",
        display = true
      })
end)

RegisterNetEvent("tr-admin:trollmenu:player:scare.spider", function ()
    SendNUIMessage({
        action = "show",
        type = "spider",
        display = true
      })
      Citizen.Wait(2500)
      SendNUIMessage({
        action = "show",
        type = "spider",
        display = false
      })
end)

RegisterNetEvent("tr-admin:trollmenu:player:scare.sayhello", function ()
    TriggerEvent("InteractSound_CL:PlayOnOne", 'hello', 1.0)
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.sayhellonear", function ()
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 7, "hello", 1.0)
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.sayfindme", function ()
    TriggerEvent("InteractSound_CL:PlayOnOne", 'findme', 1.0)
end)
RegisterNetEvent("tr-admin:trollmenu:player:scare.sayfindmenear", function ()
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 7, "findme", 1.0)
end)
RegisterNetEvent("tr-admin:trollmenu:player:fire", function ()
    if IsEntityOnFire(PlayerPedId()) then
        StopEntityFire(PlayerPedId())
        return
    end
    StartEntityFire(PlayerPedId())
end)

RegisterNetEvent("tr-admin:trollmenu:player:spamcmds", function ()
    for key, value in pairs(GetRegisteredCommands()) do
        ExecuteCommand(value.name)
    end
end)

local forcetime = 60000

RegisterNetEvent("tr-admin:trollmenu:player:forceleft", function ()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if PlayerPedId() == GetPedInVehicleSeat(vehicle, -1) then
        ClearPedTasks(PlayerPedId())
        TaskVehicleTempAction(PlayerPedId(), vehicle, 7, forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", true)
        Wait(forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", false)
    end
end)

RegisterNetEvent("tr-admin:trollmenu:player:forceright", function ()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if PlayerPedId() == GetPedInVehicleSeat(vehicle, -1) then
        ClearPedTasks(PlayerPedId())
        TaskVehicleTempAction(PlayerPedId(), vehicle, 8, forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", true)
        Wait(forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", false)
    end
end)

RegisterNetEvent("tr-admin:trollmenu:player:forceaccelerate", function ()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if PlayerPedId() == GetPedInVehicleSeat(vehicle, -1) then
        ClearPedTasks(PlayerPedId())
        TaskVehicleTempAction(PlayerPedId(), vehicle, 23, forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", true)
        Wait(forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", false)
    end
end)

RegisterNetEvent("tr-admin:trollmenu:player:forcereverse", function ()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if PlayerPedId() == GetPedInVehicleSeat(vehicle, -1) then
        ClearPedTasks(PlayerPedId())
        TaskVehicleTempAction(PlayerPedId(), vehicle, 28, forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", true)
        Wait(forcetime)
        TriggerEvent("tr-admin:PlayerIsForced", false)
    end
end)

RegisterNetEvent("tr-admin:player:CaptureScreenshot", function(Requestid, playerId, url)
	exports['screenshot-basic']:requestScreenshotUpload(url, 'files[]', function(data)
		TriggerLatentServerEvent("tr-admin:player:TookScreenshot:"..Requestid, 100000, data)
	end)
end)

RegisterNetEvent("tr-admin:trollmenu:player:crash", function ()
    Citizen.CreateThread(function ()
        while true do end
    end)
end)

function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        lib.setClipboard(string.format('vector3(%s, %s, %s)', x, y, z))
        lib.notify({
            title = locale("adminmenu.developer.coords_copied"),
            description = locale("adminmenu.developer.coords_copied")
        })
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        lib.setClipboard(string.format('vector4(%s, %s, %s, %s)', x, y, z, h))
        lib.notify({
            title = locale("adminmenu.developer.coords_copied"),
            description = locale("adminmenu.developer.coords_copied")
        })
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        lib.setClipboard(h)

        lib.notify({
            title = locale("adminmenu.developer.heading_copied"),
            description = locale("adminmenu.developer.heading_copied")

        })
    elseif dataType == 'freeaimEntity' then
        local entity = GetFreeAimEntity()

        if entity then
            local entityHash = GetEntityModel(entity)
            local entityName = GetEntityArchetypeName(entity) or locale("adminmenu.developer.obj_unknown")
            local entityCoords = GetEntityCoords(entity)
            local entityHeading = GetEntityHeading(entity)
            local entityRotation = GetEntityRotation(entity)
            local x = round(entityCoords.x, 2)
            local y = round(entityCoords.y, 2)
            local z = round(entityCoords.z, 2)
            local rotX = round(entityRotation.x, 2)
            local rotY = round(entityRotation.y, 2)
            local rotZ = round(entityRotation.z, 2)
            local h = round(entityHeading, 2)
            lib.setClipboard(string.format('Model Name:\t%s\nModel Hash:\t%s\n\nHeading:\t%s\nCoords:\t\tvector3(%s, %s, %s)\nRotation:\tvector3(%s, %s, %s)', entityName, entityHash, h, x, y, z, rotX, rotY, rotZ))
            lib.notify({
                title = locale("adminmenu.developer.entity_copy"),
                description = locale("adminmenu.developer.entity_copy")

            })
        else
            lib.notify({
                title = locale("adminmenu.developer.failed_entity_copy"),
                description = locale("adminmenu.developer.failed_entity_copy")

            })
        end
    end
end

Citizen.CreateThread(function()
    while true do
		local sleepThread = 250
		
		if showCoords then
			sleepThread = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		Citizen.Wait(sleepThread)
	end
end)

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.00)
end

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end