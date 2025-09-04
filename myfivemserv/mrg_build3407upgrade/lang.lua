Citizen.CreateThread(function()
    local langFiles = {
        "mp2024_02"
    }

    for _, dlc in ipairs(langFiles) do
        local data = LoadResourceFile(GetCurrentResourceName(), "stream/"..dlc.."/lang/global.txt")
        if data then
            for line in data:gmatch("[^\r\n]+") do
                local key, text = line:match("^([^=]+)%s*=%s*(.+)$")
                if key and text then
                    key = key:match("^%s*(.-)%s*$")
                    if key:match("^0x[%x]+$") then
                        local numHash = tonumber(key)
                        if numHash then
                            AddTextEntryByHash(numHash, text)
                        end
                    else
                        AddTextEntry(key, text)
                    end
                end
            end
        end
    end
end)
