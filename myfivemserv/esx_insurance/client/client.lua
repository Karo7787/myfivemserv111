ESX = exports["es_extended"]:getSharedObject()

function MenuInsurance(station)
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('ubezpieczenie:check', function(insTime)
		if insTime ~= nil  then
			ESX.ShowNotification("Twoje ubezpieczenie " .. station .. " jest ważne do " .. insTime)
		else
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'insurance_sell',
			{
				title    = _U('buy_ins', station),
				align    = 'center',
				elements = {
					{label = _U('3_days'),	value = 3},
					{label = _U('7_days'),	value = 7},
					{label = _U('14_days'),	value = 14},
					{label = _U('31_days'),	value = 31},
				}
			}, function(data, menu)
				TriggerServerEvent('ubezpieczenie:sell', station, data.current.value)
				menu.close()
			   end,
			function(data, menu)
				menu.close()
			end
			)
		end
	end, station)
end

exports['dbl_base']:SpawnPed("insuranceoc", 's_m_m_lathandy_01', vec4(-345.2732, -118.2719, 38.0743, 175.27578735352), {
    FreezeEntityPosition = true,
    SetEntityInvincible = true,
    SetBlockingOfNonTemporaryEvents = true,
}, false, false)

local oc_insurance = "s_m_m_lathandy_01"

Citizen.CreateThread(function()
	exports.qtarget:AddTargetModel({oc_insurance},  {
		options = {
		{
			event = "woroworopiesek:otworzoc",
			icon = "fa-solid fa-file-medical",
			label = "Otwórz menu",
		},
	   },
	distance = 1.5
	})
end)

RegisterNetEvent("woroworopiesek:otworzoc", function(station)
	MenuInsurance('OC')
end)

exports['dbl_base']:SpawnPed("insurancenw", 'a_m_y_epsilon_01', vec4(301.8282, -591.0718, 42.3198, 338.57751464844), {
    FreezeEntityPosition = true,
    SetEntityInvincible = true,
    SetBlockingOfNonTemporaryEvents = true,
}, false, false)

local nw_insurance = "a_m_y_epsilon_01"

Citizen.CreateThread(function()
	exports.qtarget:AddTargetModel({nw_insurance},  {
		options = {
		{
			event = "woroworopiesek:otworznw",
			icon = "fa-solid fa-file-medical",
			label = "Otwórz menu",
		},
	   },
	distance = 1.5
	})
end)

RegisterNetEvent("woroworopiesek:otworznw", function(station)
	MenuInsurance('NW')
end)