ESX = exports.es_extended:getSharedObject();
AllowList = false
local IsWide = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if ESX.IsPlayerLoaded() then
            local res = GetIsWidescreen()
            if not res and not IsWide and not AllowList then
                ESX.TriggerServerCallback('tr-resforce:CheckUser', function(data)
                if data == 0 then
                        startTimer()
                        IsWide = true
                else
                        AllowList = true
                end
                end)
            elseif res and IsWide then
                IsWide = false
            end
        end
    end
end)

function startTimer()
	local timer = 30

	Citizen.CreateThread(function()
		while timer > 0 and IsWide do
			Citizen.Wait(1000)

			if timer > 0 then
                timer = timer - 1
                if timer == 0 then
                    TriggerServerEvent("tr-resforce:KickUser")
                end
			end
		end
	end)


	Citizen.CreateThread(function()
		while IsWide do
			Citizen.Wait(0)
            PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 0)
			draw("~r~WYKRYTO NIEPRAWIDŁOWY FORMAT EKRANU", string.format("ZMIEŃ FORMAT NA ~y~16:9~w~ BĄDŹ WYŻSZY, %s SEKUND DO WYRZUCENIA", timer), 1)
		end
	end)
end

function draw(bigtext, text, time) 
    local scaleform = RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
  
    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString(bigtext)
    PushScaleformMovieMethodParameterString(text)
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()
  
    local timer = GetGameTimer()
    while GetGameTimer() - timer < time * 1000 do
        Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
    end
end