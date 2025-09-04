function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry("gstsul1", "Sultan Hycade")
	AddTextEntry("gstsulrs1", "Sultan RS Hycade")
end)
