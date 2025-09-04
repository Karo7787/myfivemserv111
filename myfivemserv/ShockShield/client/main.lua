local ascii = [[


$$$$$$\  $$\                           $$\          $$$$$$\  $$\       $$\           $$\       $$\ 
$$  __$$\ $$ |                          $$ |       $$  __$$\ $$ |      \__|          $$ |      $$ |
$$ /  \__|$$$$$$$\   $$$$$$\   $$$$$$$\ $$ |  $$\  $$ /  \__|$$$$$$$\  $$\  $$$$$$\  $$ | $$$$$$$ |
\$$$$$$\  $$  __$$\ $$  __$$\ $$  _____|$$ | $$  | \$$$$$$\  $$  __$$\ $$ |$$  __$$\ $$ |$$  __$$ |
 \____$$\ $$ |  $$ |$$ /  $$ |$$ /      $$$$$$  /   \____$$\ $$ |  $$ |$$ |$$$$$$$$ |$$ |$$ /  $$ |
$$\   $$ |$$ |  $$ |$$ |  $$ |$$ |      $$  _$$<   $$\   $$ |$$ |  $$ |$$ |$$   ____|$$ |$$ |  $$ |
\$$$$$$  |$$ |  $$ |\$$$$$$  |\$$$$$$$\ $$ | \$$\  \$$$$$$  |$$ |  $$ |$$ |\$$$$$$$\ $$ |\$$$$$$$ |
 \______/ \__|  \__| \______/  \_______|\__|  \__|  \______/ \__|  \__|\__| \_______|\__| \_______|


                                     You are safe with us :)
]]
print(ascii)

HitBoxDectection = function()
    local min <const>, max <const> = GetModelDimensions(`mp_m_freemode_01`)
    for dimension, vec in pairs({
        min = vec(-0.60951751470566, -0.25000002980232, -1.2999999523163),
        max = vec(0.60998106002808, 0.25000002980232, 0.94499999284744)
    }) do
        for i=1, 3 do
            if dimension == 'min' and min[i] < vec[i] or dimension == 'max' and max[i] > vec[i] then
                local currentDimensions <const> = {
                    min = min,
                    max = max
                }

                TriggerServerEvent('ShockShield:detection', "hitbox")
                return
            end
        end
    end
end

ExplosiveAmmoDetection = function()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    local damageType = GetWeaponDamageType(weapon)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_EXPLOSION"), 0.0)

    local explosiveDamageTypes = { 4, 5, 6, 13 }
    local isExplosive = false

    for _, damage in ipairs(explosiveDamageTypes) do
        if damage == damageType then
            isExplosive = true
            break
        end
    end

    if isExplosive then
        TriggerServerEvent('ShockShield:detection', "Explosive Ammo")
    end
end


AimAssistDetection = function()
    if GetLocalPlayerAimState() ~= 3 then        
        TriggerServerEvent('ShockShield:detection', "AimAssist")
    end
end

Try = 0

SpeedDetection = function()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then
        local speed = GetEntitySpeed(ped)
        if speed > 11 and not IsPedJumping(ped) and not IsPedFalling(ped) then
            if Try >= 2 then
                TriggerServerEvent('ShockShield:detection', "Speed")
                Try = 0
            else
                Try = Try +1
            end
        else
            Try = 0
        end
    end
end


-- AddEventHandler('gameEventTriggered', function(event, data)
--     if event ~= 'CEventNetworkEntityDamage' then return end
--     local victim, attacker, victim_died, weapon = data[1], data[2], data[6], data[7]
--     if not IsPedAPlayer(victim) then return end
    
--     local player = PlayerId()
--     if victim_died and NetworkGetPlayerIndexFromPed(victim) ~= player then
--         local killer_client_id = NetworkGetPlayerIndexFromPed(attacker)
        
--         if killer_client_id and NetworkIsPlayerActive(killer_client_id) then
--             local attacker = GetPlayerPed(killer_client_id)
--             local attempt = 0
--             for i = 0, 3, 1 do
--                 if not HasEntityClearLosToEntityInFront(attacker, victim) and not HasEntityClearLosToEntity(attacker, victim, 17) and HasEntityClearLosToEntity_2(attacker, victim, 17) == 0 then
--                     attempt = attempt + 1
--                 end
--                 Wait(10)
--             end
            
--             if (attempt >= 3) then
--                 TriggerServerEvent('ShockShield:detection', "Magic Bullet")
--             end
--         end
--     end
-- end)


Citizen.CreateThread(function()
    while true do
        HitBoxDectection()
        ExplosiveAmmoDetection()
        SpeedDetection()
        SetPedInfiniteAmmoClip(PlayerPedId(), false)
        Wait(7500)
    end
end)


Citizen.CreateThread(function()
    while true do
        AimAssistDetection()
        Wait(15000)
    end
end)
