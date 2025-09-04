ESX = exports.es_extended:getSharedObject()

RegisterCommand("trafficsign", function(a, args) -- /trafficsign 1 or /trafficsign 2
	local xPlayer = ESX.GetPlayerData()
	if xPlayer.job.name == "police" or xPlayer.job.name == "lsfd" then
		TriggerEvent("mmtraffic:trafficsign", tonumber(args[1]))
	end
end, false)

RegisterCommand("traffic", function(a, args) -- /traffic 1 or /traffic 2
	local xPlayer = ESX.GetPlayerData()
	if xPlayer.job.name == "police" or xPlayer.job.name == "lsfd" then
		TriggerEvent("mmtraffic:traffic", tonumber(args[1]))
	end
end, false)

RegisterCommand("clearanim", function(a, args)
	ClearPedTasks(PlayerPedId())
end, false)