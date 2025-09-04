local BlipsEnabled = false
local NamesEnabled = false

local playerBlipHandles = {}


CreateThread(function()
    while true do
        Wait(1000)
        if ShowNames then
            NamesEnabled = true
        end
        if ShowBlips then
            BlipsEnabled = true
        end
        if NamesEnabled or BlipsEnabled then
            ESX.TriggerServerCallback("tr-admin:GetPlayersForBlips", function(players)
               if type(players) == "string" then
                if players == "access denied" then
                    lib.notify({
                        title = "Panel Administratora",
                        description = "ACCESS DENIED",
                        type = 'error'
                    })
                end
               else 
                for id, blip in pairs(playerBlipHandles) do
                    playerids = {}
                    for k, v in pairs(players) do
                        table.insert(playerids, v.id)
                    end
                    if not players[id] then
                        RemoveBlip(blip)
                        playerBlipHandles[id] = nil
                    end
                end
                for _, player in pairs(players) do
                    local playeridx = GetPlayerFromServerId(player.id)
                    local ped = GetPlayerPed(playeridx)
                    local blip = GetBlipFromEntity(ped)
                    local name = 'ID: '..player.id..' | ['..player.rank:lower():gsub("^%l", string.upper)..'] '..player.name.. " ("..player.rpname..")"
                    if playeridx ~= -1 then 
                        local Tag = CreateFakeMpGamerTag(ped, name, false, false, "", false)
                        SetMpGamerTagAlpha(Tag, 0, 255) -- Sets "MP_TAG_GAMER_NAME" bar alpha to 100% (not needed just as a fail safe)
                        SetMpGamerTagAlpha(Tag, 2, 255) -- Sets "MP_TAG_HEALTH_ARMOUR" bar alpha to 100%
                        SetMpGamerTagAlpha(Tag, 4, 255) -- Sets "MP_TAG_AUDIO_ICON" bar alpha to 100%
                        SetMpGamerTagAlpha(Tag, 6, 255) -- Sets "MP_TAG_PASSIVE_MODE" bar alpha to 100%
                        SetMpGamerTagHealthBarColour(Tag, 25)  --https://wiki.rage.mp/index.php?title=Fonts_and_Colors
                        if ShowNames then
                            SetMpGamerTagVisibility(Tag, 0, true) -- Activates the player ID Char name and FiveM name
                            SetMpGamerTagVisibility(Tag, 2, true) -- Activates the health (and armor if they have it on) bar below the player names
                            if NetworkIsPlayerTalking(playeridx) then
                                SetMpGamerTagVisibility(Tag, 4, true) -- If player is talking a voice icon will show up on the left side of the name
                            else
                                SetMpGamerTagVisibility(Tag, 4, false)
                            end
                            if GetPlayerInvincible(playeridx) then
                                SetMpGamerTagVisibility(Tag, 6, true) -- If player is in godmode a circle with a line through it will show up
                            else
                                SetMpGamerTagVisibility(Tag, 6, false)
                            end
                        else
                            SetMpGamerTagVisibility(Tag, 0, false)
                            SetMpGamerTagVisibility(Tag, 2, false)
                            SetMpGamerTagVisibility(Tag, 4, false)
                            SetMpGamerTagVisibility(Tag, 6, false)
                            RemoveMpGamerTag(Tag) -- Unloads the tags till you activate it again
                            NamesEnabled = false
                        end
                    end
            
                    -- Blips Logic
                    if ShowBlips then
                        if not DoesBlipExist(playerBlipHandles[player.id]) then
                            blip = AddBlipForCoord(player.location.x, player.location.y, player.location.z)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(' ['..player.rank:lower():gsub("^%l", string.upper)..'] '..'ID: '..player.id..' '..player.name.. " ("..player.rpname..")")
                            EndTextCommandSetBlipName(blip)
                            ShowHeadingIndicatorOnBlip(blip, true)
                            SetBlipSprite(blip, 1)
                            SetBlipScale(blip, 0.8)
                            SetBlipShrink(blip, 1)
                            SetBlipDisplay(blip, 6)

                            playerBlipHandles[player.id] = blip
                        else
                            blip = playerBlipHandles[player.id]
                            SetBlipCoords(blip, player.location.x, player.location.y, player.location.z)
                            local veh = GetVehiclePedIsIn(ped, false)
                            local blipSprite = GetBlipSprite(blip)
                            --Payer Death
                            if not GetEntityHealth(ped) then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)            --Dead icon
                                    ShowHeadingIndicatorOnBlip(blip, false)
                                end
                            --Player in Vehicle
                            elseif veh ~= 0 then
                                local classveh = GetVehicleClass(veh)
                                local modelveh = GetEntityModel(veh)
                                --MotorCycles (8) or Cycles (13)
                                if classveh == 8  or classveh == 13 then
                                    if blipSprite ~= 226 then
                                        SetBlipSprite(blip, 226)        --Motorcycle icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --OffRoad (9)
                                elseif classveh == 9 then
                                    if blipSprite ~= 757 then
                                        SetBlipSprite(blip, 757)        --OffRoad icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Industrial (10)
                                elseif classveh == 10 then
                                    if blipSprite ~= 477 then
                                        SetBlipSprite(blip, 477)        --Truck icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Utility (11)
                                elseif classveh == 11 then
                                    if blipSprite ~= 477 then
                                        SetBlipSprite(blip, 477)        --Truck icon despite finding better one
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Vans (12)
                                elseif classveh == 12 then
                                    if blipSprite ~= 67 then
                                        SetBlipSprite(blip, 67)         --Van icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Boats (14)
                                elseif classveh == 14 then
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(blip, 427)        --Boat icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Helicopters (15)
                                elseif classveh == 15 then
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(blip, 422)        --Moving helicopter icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Planes (16)
                                elseif classveh == 16 then
                                    if modelveh == 'besra' or modelveh == 'hydra' or modelveh == 'lazer' then
                                        if blipSprite ~= 424 then
                                            SetBlipSprite(blip, 424)    --Jet icon
                                            ShowHeadingIndicatorOnBlip(blip, false)
                                        end
                                    elseif blipSprite ~= 423 then
                                        SetBlipSprite(blip, 423)        --Plane icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Service (17)
                                elseif classveh == 17 then
                                    if blipSprite ~= 198 then
                                        SetBlipSprite(blip, 198)        --Taxi icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Emergency (18)
                                elseif classveh == 18 then
                                    if blipSprite ~= 56 then
                                        SetBlipSprite(blip, 56)        --Cop icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Military (19)
                                elseif classveh == 19 then
                                    if modelveh == 'rhino' then
                                        if blipSprite ~= 421 then
                                            SetBlipSprite(blip, 421)    --Tank icon
                                            ShowHeadingIndicatorOnBlip(blip, false)
                                        end
                                    elseif blipSprite ~= 750 then
                                        SetBlipSprite(blip, 750)        --Military truck icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Commercial (20)
                                elseif classveh == 20 then
                                    if blipSprite ~= 477 then
                                        SetBlipSprite(blip, 477)        --Truck icon
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                --Every car (0, 1, 2, 3, 4, 5, 6, 7)
                                else
                                    if modelveh == 'insurgent' or modelveh == 'insurgent2' or modelveh == 'limo2' then
                                        if blipSprite ~= 426 then
                                            SetBlipSprite(blip, 426)    --Armed car icon
                                            ShowHeadingIndicatorOnBlip(blip, false)
                                        end
                                    elseif blipSprite ~= 225 then
                                        SetBlipSprite(blip, 225)        --Car icon
                                        ShowHeadingIndicatorOnBlip(blip, true)
                                    end
                                end
                                -- Show number in case of passangers
                                local passengers = GetVehicleNumberOfPassengers(veh)
                                if passengers then
                                    if not IsVehicleSeatFree(veh, -1) then
                                        passengers = passengers + 1
                                    end
                                    ShowNumberOnBlip(blip, passengers)
                                else
                                    HideNumberOnBlip(blip)
                                end
                            --Player on Foot
                            else
                                HideNumberOnBlip(blip)
                                ShowHeadingIndicatorOnBlip(blip,false)
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                end
                            end
            
                            SetBlipRotation(blip, Ceil(player.location.heading))
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(' ['..player.rank:lower():gsub("^%l", string.upper)..'] '..'ID: '..player.id..' '..player.name.. " ("..player.rpname..")")
                            EndTextCommandSetBlipName(blip)
                            SetBlipScale(blip, 0.85)
            
                            if IsPauseMenuActive() then
                                SetBlipAlpha(blip, 255)
                            else
                                local x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                local x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(playeridx), true))
                                local distance = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(blip, distance)
                            end
                            playerBlipHandles[player.id] = blip
                        end
                    else
                        RemoveBlip(playerBlipHandles[player.id])
                        BlipsEnabled = false
                    end
                end
               end
            end)
        end
    end
end)
