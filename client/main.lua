-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
isHandcuffed = false
cuffType = 1
isEscorted = false
PlayerJob = {}
onDuty = false
local DutyBlips = {}
local lastPickedVehicle = nil

Citizen.CreateThread(function() while true do DistantCopCarSirens(false) -- Setting to false will disable the distant sirens 
    Citizen.Wait(400) 
    end 
end)


RegisterNetEvent("police:client:OpenPDLocker")
AddEventHandler("police:client:OpenPDLocker", function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "lspdlocker_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 200000, slots = 100})
    TriggerEvent("inventory:client:SetCurrentStash", "lspdlocker_"..QBCore.Functions.GetPlayerData().citizenid)
end)

RegisterNetEvent("police:client:OpenPDLocker2")
AddEventHandler("police:client:OpenPDLocker2", function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "lspdlocker2_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 200000, slots = 100})
    TriggerEvent("inventory:client:SetCurrentStash", "lspdlocker2_"..QBCore.Functions.GetPlayerData().citizenid)
end)


RegisterNetEvent("police:client:OpenRangerLocker")
AddEventHandler("police:client:OpenRangerLocker", function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "rangerlocker_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 200000, slots = 100})
    TriggerEvent("inventory:client:SetCurrentStash", "rangerlocker_"..QBCore.Functions.GetPlayerData().citizenid)
end)


CreateThread(function()
    exports['qb-target']:AddBoxZone("LSPDLockers", vector3(462.0, -995.92, 30.69), 1.0, 4.0, {
        name = "LSPDLockers",
        heading = 0.00,
        debugPoly = false,
        minZ = 29.4,
        maxZ = 33.0,
        }, {
            options = { 
            {
              type = "client",
              event = 'police:client:OpenPDLocker',
              icon = 'fas fa-hand-holding',
              label = 'Open Locker'
            },
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("LSPDLockers2", vector3(-1084.43, -827.63, 15.64), 1.0, 4.0, {
        name = "LSPDLockers2",
        heading = 38.0,
        debugPoly = false,
        minZ = 14.4,
        maxZ = 17.0,
        }, {
            options = { 
            {
              type = "client",
              event = 'police:client:OpenPDLocker2',
              icon = 'fas fa-hand-holding',
              label = 'Open Locker'
            },
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("RangerLockers", vector3(387.37, 799.79, 187.46), 1.0, 2.5, {
        name = "RangerLockers",
        heading = 0.0,
        debugPoly = false,
        minZ = 185.4,
        maxZ = 189.0,
        }, {
            options = { 
            {
              type = "client",
              event = 'police:client:OpenRangerLocker',
              icon = 'fas fa-hand-holding',
              label = 'Open Locker'
            },
        },
        distance = 1.5,
    })
  end)
  
  -- Functions
  local function CreateDutyBlips(playerId, playerLabel, playerJob, playerLocation)
      local ped = GetPlayerPed(playerId)
      local blip = GetBlipFromEntity(ped)
      if not DoesBlipExist(blip) then
          if NetworkIsPlayerActive(playerId) then
              blip = AddBlipForEntity(ped)
          else
              blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
          end
          SetBlipSprite(blip, 1)
          ShowHeadingIndicatorOnBlip(blip, true)
          SetBlipRotation(blip, math.ceil(playerLocation.w))
          SetBlipScale(blip, 1.0)
          if playerJob == "police" then
              SetBlipColour(blip, 42)
          else
              SetBlipColour(blip, 5)
          end
          SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentString(playerLabel)
          EndTextCommandSetBlipName(blip)
          DutyBlips[#DutyBlips+1] = blip
      end
  
      if GetBlipFromEntity(PlayerPedId()) == blip then
          -- Ensure we remove our own blip.
          RemoveBlip(blip)
      end
  end
  
  
-- Events
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
    isHandcuffed = false
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:UpdateBlips")
    TriggerServerEvent("police:server:UpdateCurrentCops")

    if player.metadata.tracker then
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = 13,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    else
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = -1,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    end

    if PlayerJob and PlayerJob.name ~= "police" then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent('police:server:UpdateBlips')
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:UpdateCurrentCops")
    isHandcuffed = false
    isEscorted = false
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    if DutyBlips then
        for _, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.name == "police" and PlayerJob.name ~= "police" then
        if JobInfo.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end

    if JobInfo.name ~= "police" then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
    PlayerJob = JobInfo
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('police:client:sendBillingMail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message = Lang:t('email.message', {value = gender, value2 = charinfo.lastname, value3 = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('police:client:UpdateBlips', function(players)
    if PlayerJob and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance') and
        onDuty then
        if DutyBlips then
            for _, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
        if players then
            for _, data in pairs(players) do
                local id = GetPlayerFromServerId(data.source)
                CreateDutyBlips(id, data.label, data.job, data.location)

            end
        end
    end
end)

RegisterNetEvent('police:client:policeAlert', function(coords, text)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    QBCore.Functions.Notify({text = text, caption = street1name.. ' ' ..street2name}, 'police')
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Lang:t('info.blip_text', {value = text})
    SetBlipSprite(blip, 60)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipText)
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        SetBlipAlpha(blip2, transG)
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)



RegisterNetEvent('police:client:SendToJail', function(time)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    isHandcuffed = false
    isEscorted = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    TriggerEvent("prison:client:Enter", time)
end)

RegisterNetEvent('police:client:SendPoliceEmergencyAlert', function()
    local Player = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "panicbutton1", 0.2)
    TriggerServerEvent('police:server:policeAlert', Lang:t('info.officer_down', {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign}))
   TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.officer_down', {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign}))
end)

RegisterNetEvent('police:client:PanicButton', function()
    local Player = QBCore.Functions.GetPlayerData()
    TriggerEvent('animations:client:EmoteCommandStart', {"texting"})
    QBCore.Functions.Progressbar('gift_box', 'Sending Distress Signal', 650, false, true, { 
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "panicbutton1", 0.2)
    TriggerServerEvent('police:server:policeAlert', Lang:t('info.panic_button', {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign}))
    end)
end)


RegisterNetEvent('police:client:SendMechanicEmergencyAlert', function()
    local Player = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('police:server:mechanicAlert', "LSPD Tow Request", {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign})
 end)

-- Threads
CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 60)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 29)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)





