ESX = exports["es_extended"]:getSharedObject()
playerPed = PlayerPedId()
lib.onCache('ped', function(value) playerPed = value end)
local PlayerLoad = false
local suggestionsRemove = {}

local playerGroup = "user"
Citizen.CreateThread(function()
    Citizen.Wait(1000*5)
    while true do
        if PlayerLoad then 
            ESX.TriggerServerCallback("esx_rpchat:getGroup", function(PlayerGroup)
                playerGroup = PlayerGroup
            end)
        end
        Citizen.Wait(1000*120)
   end
end)

Citizen.CreateThread(function() -- Dev purposes
    if ESX.GetPlayerData() then
        PlayerLoad = true;
		Citizen.Wait(1000*5)
		ESX.TriggerServerCallback("esx_rpchat:getGroup", function(PlayerGroup)
			playerGroup = PlayerGroup
		end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerLoad = true
    Citizen.Wait(1000*5)
    ESX.TriggerServerCallback("esx_rpchat:getGroup", function(PlayerGroup)
        playerGroup = PlayerGroup
    end)
end)
RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group)
    playerGroup = group
end)

local AdminGroups = {
	["admin"] = true,
	["best"] = true,
	["superadmin"] = true,
	["mod"] = true,
	["trialsupport"] = true
}

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local typing = {}

local my_server_id = 0
local blockKeysThread = false
chatOpen = false
isPhoneOpen = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')
--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }
	if author ~= "" then
		table.insert(args, 1, author)
	end
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			color = color,
			multiline = true,
			args = args
		}
	})
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	if #msg <= 0 then
		return;
	end
	print(msg)
end)

AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = message
	})
end)

local SuggestionsToRegister = {}

-- addSuggestion
local addSuggestion = function(name, help, params)
	if not chatLoaded then
		table.insert(SuggestionsToRegister, {
			name = name,
			help = help,
			params = params or nil
		})
	else
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = {
				name = name,
				help = help,
				params = params or nil
			}
		})
	end
end

exports('addSuggestion', addSuggestion)
AddEventHandler('chat:addSuggestion', addSuggestion)

AddEventHandler('chat:addSuggestions', function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		if not chatLoaded then
			table.insert(SuggestionsToRegister, suggestion)
		else
			SendNUIMessage({
				type = 'ON_SUGGESTION_ADD',
				suggestion = suggestion
			})
		end
	end
end)

local removeSuggestion = function(name)
	local find = false
	for i = 1, #(suggestionsRemove) do
		if suggestionsRemove[i] == name then
			find = true
			break
		end
	end
	if not find then
		table.insert(suggestionsRemove, name)
	end
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end

AddEventHandler('chat:removeSuggestion', removeSuggestion)


AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

AddEventHandler('chat:close', function(clearMessage)
	SendNUIMessage({
		type = 'ON_CLOSE',
		clearMessage = false
	})
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	LocalPlayer.state.ChatOpen = false
	SetNuiFocus(false)
	TriggerServerEvent("chat:typing_send", false)
	if not data.canceled then
		local id = PlayerId()

		--deprecated
		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			TriggerEvent("chat:commandTyped", data.message:sub(2))
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message, data.mode)
		end
	end

	cb('ok')
end)


local function refreshCommands()
	if GetRegisteredCommands then
	  local registeredCommands = GetRegisteredCommands()
  
	  local suggestions = {}
  
	  for _, command in ipairs(registeredCommands) do
		  if IsAceAllowed(('command.%s'):format(command.name)) and command.name ~= 'toggleChat' then
			  table.insert(suggestions, {
				  name = '/' .. command.name,
				  help = ''
			  })
		  end
	  end
  
	  TriggerEvent('chat:addSuggestions', suggestions)
  
	  for i = 1, #(suggestionsRemove) do
		removeSuggestion(suggestionsRemove[i])
	  end
	end
  end

local function refreshThemes()
	local themes = {}

	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)

		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
	Wait(500)

	refreshCommands()
	refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
	Wait(500)

	refreshCommands()
	refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
	TriggerServerEvent('chat:init');
	refreshCommands()
	refreshThemes()

	chatLoaded = true
    for k, v in pairs(SuggestionsToRegister) do 
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = v
		})
	end
	cb('ok')
end)

RegisterNetEvent("chat:typing_cl", function(data)
	typing = data
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function getAbsoluteCoords(ped)
  	return GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, 0))
end

local currentString = "."
local i = 0
Citizen.CreateThread(function()

    while true do
		local drawing = false
		Citizen.Wait(0)
		
		i = i + 1
		if i > 1000 then i = 0 end

		if i % 30 == 0 then
			if #currentString == 3 then
				currentString = "."
			else
				currentString = currentString.."."
			end
		end
		
		local coords = GetEntityCoords(playerPed)

		for v, k in pairs(typing) do
			if v == my_server_id then
				local player = GetPlayerFromServerId(v)
				if player ~= -1 then
					local target = GetPlayerPed(player)
					local coords2 = getAbsoluteCoords(target)
					local dist = #(coords - coords2)

					if dist < 5 then
						drawing = true
						DrawText3D(coords2.x, coords2.y, coords2.z + 0.9, currentString)
					end
				end
			end
		end

		if not drawing then
			Citizen.Wait(300)
		end
	end
end)

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)
	my_server_id = GetPlayerServerId(PlayerId())
	removeSuggestion("/open_chat")
	RegisterKeyMapping("open_chat", "Czat tekstowy", "keyboard", "t")
end)

RegisterCommand('open_chat', function(source, args)
	if not chatInputActive then
		if LocalPlayer.state.GptOpen then return end;
		if LocalPlayer.state.DisableChat then return end;
		if LocalPlayer.state.invOpen then
			ESX.ShowNotification("Nie możesz otworzyć chatu, gdy masz otwarty ekwipunek.", 'warning')
			return
		end

		if not IsScreenFadedOut() and not IsPauseMenuActive() then
			chatInputActive = true
			LocalPlayer.state.ChatOpen = true
			SetNuiFocus(true, false)
			if GetEntityAlpha(PlayerPedId()) > 200 and not AdminGroups[playerGroup] then
				TriggerServerEvent("chat:typing_send", true)
			end
			SendNUIMessage({ type = 'ON_OPEN' })
		end
	end
end, false)

AddStateBagChangeHandler("ChatOpen", ("player:%s"):format(GetPlayerServerId(PlayerId())), function(bagName, key, value, reserved, replicated)
    chatOpen = value
	if chatOpen then
		if not blockKeysThread then
			blockKeysThread = true
			Citizen.CreateThreadNow(function()
				while chatOpen do
					if isPhoneOpen then
						DisableControlAction(0, 72,  true) -- Brake
						DisableControlAction(0, 71,  true) -- Accelerate
						DisableControlAction(0, 75,  true) -- Exit
						DisableControlAction(0, 289,  true) -- F2
						DisableControlAction(0, 170,  true) -- F3
						DisableControlAction(0, 30,  true) -- MOVE
						DisableControlAction(0, 31,  true) -- MOVE
						DisableControlAction(0, 32,  true) -- MOVE
						DisableControlAction(0, 33,  true) -- MOVE
						DisableControlAction(0, 34,  true) -- MOVE
						DisableControlAction(0, 35,  true) -- MOVE
						DisableControlAction(0, 22,  true) -- JUMP
						DisableControlAction(0, 21,  true) -- SPRINT
						
						DisableControlAction(0, 177,  true) -- SPRINT
						DisableControlAction(0, 200,  true) -- SPRINT
						DisableControlAction(0, 202,  true) -- SPRINT
						DisableControlAction(0, 322,  true) -- SPRINT
					else
						Citizen.Wait(100)
					end
					Citizen.Wait(0)
				end
				blockKeysThread = false
			end)
		end
	end
end)