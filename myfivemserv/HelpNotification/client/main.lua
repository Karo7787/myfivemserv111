local Messages = {
	Update = GetGameTimer(),
	Display = false,
	Txt = ''
}

local LastMessages = GetGameTimer()

local Keys = {
	['INPUT_CONTEXT'] = 'E',
	['INPUT_VEH_EXIT'] = 'F',
	['INPUT_VEH_ACCELERATE'] = 'W',
	['INPUT_VEH_DUCK'] = 'X',
	['INPUT_PICKUP'] = 'E',
	['INPUT_VEH_HEADLIGHT'] = 'H',
	['INPUT_THROW_GRENADE'] = 'G',
	['INPUT_MOVE_LEFT_ONLY'] = 'A',
	['INPUT_MOVE_RIGHT_ONLY'] = 'D',
	['INPUT_MOVE_UP_ONLY'] = 'W',
	['INPUT_MOVE_DOWN_ONLY'] = 'S',
	['INPUT_DETONATE'] = 'G',
	['INPUT_VEH_MOVE_LEFT_ONLY'] = 'A',
	['INPUT_VEH_MOVE_RIGHT_ONLY'] = 'D',
	['INPUT_VEH_PREV_RADIO_TRACK'] = '-',
	['INPUT_SPRINT'] = 'LEFT SHIFT',
	['INPUT_FRONTEND_RIGHT'] = '⮫',
	['INPUT_FRONTEND_LEFT'] = '⮪',
	['INPUT_CELLPHONE_RIGHT'] = '⮫',
	['INPUT_REPLAY_ADVANCE'] = '⮫',
	['INPUT_CELLPHONE_LEFT'] = '⮪',
	['INPUT_REPLAY_BACK'] = '⮪',
	['INPUT_CELLPHONE_UP'] = '⮬',
	['INPUT_CELLPHONE_DOWN'] = '⮯',
	['INPUT_FRONTEND_ACCEPT'] = 'ENTER',
	['INPUT_FRONTEND_RDOWN'] = 'ENTER',
	['INPUT_JUMP'] = 'SPACJA',
}

function FormatAllKeysInString(str)
	for keyName, keyValue in pairs(Keys) do
		str = string.gsub(str, "~"..keyName.."~", "<span class='button'>" .. keyValue .. "</span>")
	end
	-- ❌ Usuwanie kolorów i formatowania ~x~text
	str = string.gsub(str, "~[^h]~", "") -- np. ~r~Czerwony
	str = string.gsub(str, "~h~", "")    -- pogrubiony tekst

	-- ❌ Usuwanie ~s~
	str = string.gsub(str, "~s~", "")

	-- 🔁 Zamiana nowej linii
	str = string.gsub(str, "~n~", "<br>")
	str = string.gsub(str, "\n", "<br>")
	return str
end

CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if Messages.Display ~= nil and Messages.Display == true then					
			if LastMessages <= GetGameTimer() then				
				exports["mrg_ui"]:HideHelpNotification()

				Messages = {
					Update = GetGameTimer(),
					Display = false,
					Txt = ''
				}
				
			end
		else
			Citizen.Wait(250)
		end
	end
end)

RegisterNetEvent('HelpNotification:Show')
AddEventHandler('HelpNotification:Show', function(text)
	if text ~= nil then
		ShowHelpNotification(text)
	end
end)

ShowHelpNotification = function(msg)
	LastMessages = GetGameTimer() + 200
	
	if not Messages.Display then
		Messages.Display = true
		
		exports["mrg_ui"]:ShowHelpNotification(FormatAllKeysInString(msg))

		
		Messages.Txt = msg
	else
		if Messages.Update <= GetGameTimer() then
			Messages.Update = GetGameTimer() + 200
			
			if Messages.Txt ~= msg then	
				Messages.Txt = msg
				
				exports["mrg_ui"]:HideHelpNotification()
			end
		end
	end
end

RegisterNUICallback('CanHelpNotification', function(data)	
	if data.display ~= nil then
		Messages.Display = false
	end
end)

