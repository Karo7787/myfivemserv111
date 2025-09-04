local Tablet
local MiniGame ={}
local HackStatus = false

-- NUI
MiniGame.Open = function()
	SendNUIMessage({
		action = "open",
		base = Config.MingameBase,
		timeLimit = Config.MinigameTimeLimit,
		attemptLimit = Config.MingameAttemptLimit
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback('close', function(data, cb)
	cb('ok')
	HackStatus = data
	Wait(500)
	ClearPedTasks(PlayerPedId())
	Wait(500)
	DeleteObject(Tablet)
	if HackStatus then
		TriggerEvent('projectx-paletobankrobbery:client:VaultHack', true)
	else
		TriggerEvent('projectx-paletobankrobbery:client:VaultHack', false)
	end
	SetNuiFocus(false, false)
	ClearPedTasks(PlayerPedId())
	DeleteObject(Tablet)
end)

-- Events
RegisterNetEvent('decrypto-edit:client:starthack')
AddEventHandler('decrypto-edit:client:starthack', function()
	MiniGame.Open()
end)