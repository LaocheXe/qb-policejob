local QBCore = exports['qb-core']:GetCoreObject()
local cleanSpot = nil
local cleaningPos = nil
local onDuty = false

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function CleanAnim()
    local time = 5
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
            end
        end
    end)
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetRandomCleaning()
    local randSeed = math.random(1, #Config["cleaning"].cleaningLocations)
    cleaningPos = {}
    cleaningPos.x = Config["cleaning"].cleaningLocations[randSeed].x
    cleaningPos.y = Config["cleaning"].cleaningLocations[randSeed].y
    cleaningPos.z = Config["cleaning"].cleaningLocations[randSeed].z
end


-- Threads

CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), true)

        if #(pos - vector3(467.2, -1002.61, 27.0)) < 15 and not IsPedInAnyVehicle(PlayerPedId(), false) and cleanSpot == nil then
            DrawMarker(2, 467.2, -1002.61, 27.0, 0.9, 0, 0, 0, 0, 0, 0.2001, 0.2001, 0.2001, 255, 255, 255, 255, 0, 0, 0, 0)
            if #(pos - vector3(467.2, -1002.61, 27.0)) < 1.5 then
                if onDuty then
                    DrawText3D(467.2, -1002.61, 27.0, "~g~E~w~ - Stop Cleaning")
                else
                    DrawText3D(467.2, -1002.61, 27.0, "~g~E~w~ -  Start Cleaning")
                end
                if IsControlJustReleased(0, 38) then
                    onDuty = not onDuty
                    if onDuty then
                        QBCore.Functions.Notify("You Have Started Cleaning", "success")
                    else
                        QBCore.Functions.Notify("You Have Stopped Cleaning", "error")
                    end
                end
            end
        end
    end
end)

CreateThread(function()

    while true do
        Wait(5)
        if onDuty then
            if cleaningPos ~= nil then
                local pos = GetEntityCoords(PlayerPedId(), true)
                if cleanSpot == nil then
                    if #(pos - vector3(cleaningPos.x, cleaningPos.y, cleaningPos.z)) < 2.3 then
                        DrawText3D(cleaningPos.x,cleaningPos.y,cleaningPos.z+ 0.5, "~g~E~w~ - Clean")
                        if IsControlJustReleased(0, 38) then
                            local sweep = math.random(1, 100)
                            if sweep < 50 then
                                TriggerEvent('animations:client:EmoteCommandStart', {"broom"}) 
                            else
                                TriggerEvent('animations:client:EmoteCommandStart', {"mop2"}) 
                            end
                            local cleantime = math.random(6000, 8000)
                            QBCore.Functions.Progressbar("pickup_reycle_package", "Cleaning Up the Area..", cleantime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function()
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('qb-policejob:server:finishCleaning')
                                GetRandomCleaning()
                            end)
                            Wait(cleantime)
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        end
                    else
                        DrawText3D(cleaningPos.x, cleaningPos.y, cleaningPos.z + 1, "Clean")
                    end
                end
            else
                GetRandomCleaning()
            end
        end
    end
end)



 


 