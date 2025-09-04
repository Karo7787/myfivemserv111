lib.locale()
LoadFxAsset = function(asset)
    RequestNamedPtfxAsset(asset)
    while not HasNamedPtfxAssetLoaded(asset) do Wait(100); end
end

Modules = { Alarm(), Job(), Fire(), SCBA() }

Citizen.CreateThread(function()
    for k, v in pairs(Modules) do
        v.Init()
    end
end)