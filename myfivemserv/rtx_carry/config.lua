Config = {}

Config.Language = "Polski" -- text language from code

Config.Framework = "standalone" -- types (standalone, qbcore, esx)

Config.InterfaceColor = "#9a6248" -- change interface color, color must be in hex

Config.Target = true -- enable this if you want use target

Config.Targettype = "oxtarget" -- types - qtarget, qbtarget, oxtarget

Config.TargetSystemsNames = {qtarget = "qtarget", qbtarget = "qb-target", oxtarget = "ox_target"}

Config.TargetIcons = {carry1icon = "fa-solid fa-user", carry2icon = "fa-solid fa-user", carry3icon = "fa-solid fa-user"} 

Config.TargetCarryTypesAllowed = { --here you can disable or enable different carry types in the target
	[1] = true, -- Type 1
	[2] = true, -- Type 2
	[3] = true, -- Type 3
}

Config.DefaultKeyBindAccept = "y" -- carry accept key

Config.DefaultKeyBindDecline = "n" -- carry decline key

Config.CarryViaCommand = true -- You can trigger carry via event from some menu for example TriggerEvent("rtx_carry:Carry") for trigger carry with certain type selected for example TriggerEvent("rtx_carry:Carry", "1") Types 1-3

Config.CarryCommand = "carry" -- You can execute carry types withount menu /carry 1 /carry 2 /carry 3

Config.CarryMarker = true -- carry marker to requested player

Config.CarryLine = true -- carry line to requested player

Config.ReleasePlayerViaBind = true -- enable this function if you want to drop the player to the ground by pressing the button

Config.ReleasePlayerViaBindKey = "x" -- -- carry release key

Config.CarryInterfaceWhileCarryed = true -- interface when player is carryed

Config.CarryDistance = 5.0 -- maximum distance from player for carry

Config.CarryDistanceDraw = 5.0 --maximum distance of draw line and marker

Config.RequestDuration = 60 -- in seconds

Config.DisablePlayerKeyboard = false -- if you want disable player keyboard when is carryed

Config.AutoAcceptWhileDeath = false -- auto accept carry when player is death

Config.CarryDisabledInZones = false -- players cannot use carry in config zones if this is enabled

Config.CarryedPlayerCanStopCarry = false -- if carryed player can use /carry from stopping to be carryed

Config.PedTaskCancelImmediately  = true -- if you want use Immediately cancel

Config.StopCarryViaEvent = false -- enable if you want stop carry via event, for example for hospital respawn -- TriggerEvent("rtx_carry:StopCarryViaEvent") -- example trigger that event when player respawn

Config.DisableRunWhileCarryPlayer = false  -- disable run for player which carry someone

Config.DisableRequestSystem = false -- disable carry request system, players will accept carry automaticly

Config.DeathCustomEvent = false -- enable this if you using custom death system example qbcore, you need add this trigger event TriggerEvent("rtx_carry:PlayerIsDead", true) when player dies and you need add this trigger event TriggerEvent("rtx_carry:PlayerIsDead", false) when player is revived

Config.CarryDisabledZones = {
	{coords = vector3(0.0, 0.0, 0.0), radius = 100.0},
}

Config.CarryDefaultOffsets = {
	type1offset = {coords = vector3(0.30, 0.00, 0.65), rotation = vector3(0.5, 0.5, 180.0)}, --default offsets for carry type 1
	type2offset = {coords = vector3(0.02, 0.4, 0.10), rotation = vector3(0.10, 0.30, 90.0)}, --default offsets for carry type 2
	type3offset = {coords = vector3(0.0, -0.07, 0.45), rotation = vector3(0.5, 0.5, 0.0)}, --default offsets for carry type 3
}

Config.CarryModelOffsets = {
    {
        modelname = "player_one", -- ped model
		type1offset = {coords = vector3(0.30, 0.00, 0.65), rotation = vector3(0.5, 0.5, 180.0)}, --offsets for carry type 1
		type2offset = {coords = vector3(0.02, 0.4, 0.10), rotation = vector3(0.10, 0.30, 90.0)}, --offsets for carry type 2
		type3offset = {coords = vector3(0.0, -0.07, 0.45), rotation = vector3(0.5, 0.5, 0.0)}, --offsets for carry type 3
	},
}

Config.PlayerLoadedEvent = { -- load methods of carry
	esx = "esx:playerLoaded", 
	qbcore = "QBCore:Client:OnPlayerLoaded",
	standalone = "playerLoaded",
	customevent = true, -- enable this if you dont want load carry after player loaded to server. (enable this for example for servers with multicharacter)
	standaloneevent = false, -- enable this if you dont want load carry after player loaded to server. (for standalone version)
}

-- EVENTS

function Notify(text)
	-- exports["rtx_notify"]:Notify("Carry", text, 5000, "info") -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
	exports["mrg_ui"]:SendNotification({
		message = text,
		time = duration
	})
end

function DisableCarryKeyboard()
	DisableControlAction(0, 16, true) -- Next Weapon
	DisableControlAction(0, 17, true) -- Select Previous Weapon
	DisableControlAction(0, 22, true) -- Jump
	DisableControlAction(0, 23, true) -- Enter vehicle
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 26, true) -- Look Behind
	DisableControlAction(0, 36, true) -- Input Duck/Sneak
	DisableControlAction(0, 37, true) -- Weapon Wheel
	DisableControlAction(0, 44, true) -- Cover
	DisableControlAction(0, 47, true) -- Detonate
	DisableControlAction(0, 55, true) -- Dive
	DisableControlAction(0, 69, true) -- Vehicle attack
	DisableControlAction(0, 73, true) -- Vehicle attack
	DisableControlAction(0, 81, true) -- Next Radio (Vehicle)
	DisableControlAction(0, 82, true) -- Previous Radio (Vehicle)
	DisableControlAction(0, 91, true) -- Passenger Aim (Vehicle)
	DisableControlAction(0, 92, true) -- Passenger Attack (Vehicle)
	DisableControlAction(0, 99, true) -- Select Next Weapon (Vehicle)
	DisableControlAction(0, 106, true) -- Control Override (Vehicle)
	DisableControlAction(0, 114, true) -- Fly Attack (Flying)
	DisableControlAction(0, 115, true) -- Next Weapon (Flying)
	DisableControlAction(0, 121, true) -- Fly Camera (Flying)
	DisableControlAction(0, 122, true) -- Control OVerride (Flying)
	DisableControlAction(0, 135, true) -- Control OVerride (Sub)
	DisableControlAction(0, 140, true) -- Melee attack light
	DisableControlAction(0, 142, true) -- Attack alternate
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 30, true) -- Player Movement
	DisableControlAction(0, 31, true) -- Player Movement
end