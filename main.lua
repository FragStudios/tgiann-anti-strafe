local pressAmount = 0 -- Leave this at 0
local timeout = 250 -- Adjust this if you like to reduce speedboosting/strafing even more

local function breakStrafe(key, time)
    CreateThread(function()
        local finishTime = GetGameTimer() + time
        while finishTime > GetGameTimer() do
            SetControlNormal(0, key, 1.0) -- This stops the speedboosting
            Wait(0)
        end
    end)
end

CreateThread(function()
    while true do
        Wait(1000)
        if pressAmount > 4 then -- Basically this checks if you are speedboosting
            local key = IsControlJustPressed(0, 30) and 30 or 31
            breakStrafe(key, timeout)
        end
        pressAmount = 0
    end
end)

CreateThread(function()
    while true do
        local time = 1000
        if IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId()) then -- Can we actually aim in a vehicle? I guess so.. If driveby is enabled
            time = 0
            if IsControlJustPressed(0, 31) or IsControlJustPressed(0, 30) then -- If D or S key is pressed + 1 to press amount
                pressAmount = pressAmount + 1
            end
        end
        Wait(time)
    end
end)
