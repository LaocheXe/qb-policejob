-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local LS_CORE = exports["ls-core"]:GetCoreObject()
local isEscorting = false

-- Functions
exports('IsHandcuffed', function()
    return isHandcuffed
end)

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function IsTargetDead(playerId)
    local retval = false
    local hasReturned = false
    QBCore.Functions.TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
        hasReturned = true
    end, playerId)
    while not hasReturned do
      Wait(10)
    end
    return retval
end

local function HandCuffAnimation()
    local ped = PlayerPedId()
    if isHandcuffed == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    end

    loadAnimDict("mp_arrest_paired")
	Wait(100)
    TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
	Wait(3500)
    TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

local function GetCuffedAnimation(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    loadAnimDict("mp_arrest_paired")
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))

	Wait(100)
	SetEntityHeading(ped, heading)
	TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0 ,true, true, true)
	Wait(2500)
end


-- Events
RegisterNetEvent('police:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle = QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
            for i = GetVehicleMaxNumberOfPassengers(vehicle), 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    ClearPedTasks(ped)
                    DetachEntity(ped, true, false)

                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    local player, distance = LS_CORE.Functions.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("inventory:server:OpenInventory", "search", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SeizeCash', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)


RegisterNetEvent('police:client:RobPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsTargetDead(playerId) then
            QBCore.Functions.Progressbar("robbing_player", Lang:t("progressbar.robbing"), math.random(10000, 12000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "random@shop_robbery",
                anim = "robbery_action_b",
                flags = 16,
            }, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(ped)
                if #(pos - plyCoords) < 2.5 then
                    StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                    local player, distance = LS_CORE.Functions.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
                    local playerId = GetPlayerServerId(player)
                        TriggerServerEvent("inventory:server:OpenInventory", "search", playerId)
                else
                    QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
                end
            end, function() -- Cancel
                StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
            end)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:JailPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t('info.jail_time_input'),
            submitText = Lang:t('info.submit'),
            inputs = {
                {
                    text = Lang:t('info.time_months'),
                    name = "jailtime",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if tonumber(dialog['jailtime']) > 0 then
            --ApplyPrisonerSkin(cuffer)
            TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(dialog['jailtime']))
        else
            QBCore.Functions.Notify(Lang:t("error.time_higher"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

function ApplyPrisonerSkin()

	local playerPed = PlayerPedId()
	local Player = QBCore.Functions.GetPlayerData()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
	if DoesEntityExist(cuffer) then
		local DataMale = { --CHANGE CLOTH HERE
				outfitData = {
			['t-shirt'] = {item = 15,texture = 0},
			['torso2']  ={item = 269,texture = 2},
			['decals'] = {item = 0, texutre = 0},
			['arms']     = {item = 11, texture = 0},
			['pants']  ={item = 59, texture = 2},   
			['shoes']  = {item = 42, texture = 0},
			['vest']  = {item = 0, texture = 0},
			['bag']  = {item = 0, texture = 0},
			['mask']  = {item = 0, texture = 0},
			['hat']  = {item = 0, texture = 0},
				}}
		local DataFemale = {
				outfitData = {
			['t-shirt'] = {item = 3,texture = 0},
			['torso2']  ={item = 38,texture = 3},
			['decals'] = {item = 0, texutre = 0},
			['arms']     = {item = 120, texture = 0},
			['pants']  ={item = 3, texture = 15},   
			['shoes']  = {item = 66, texture = 5},
			['vest']  = {item = 0, texture = 0},
			['bag']  = {item = 0, texture = 0},
			['mask']  = {item = 0, texture = 0},
			['hat']  = {item = 0, texture = 0},
				}}
							
		
				if Player.charinfo.gender == 0 then

					TriggerEvent('qb-clothing:client:loadOutfit', DataMale) --Change Here the Clothing resource
				else
				 	TriggerEvent('qb-clothing:client:loadOutfit', DataFemale) --Change Here the Clothing resource

				end


		SetPedArmour(cuffer, 0)
		ClearPedBloodDamage(cuffer)
		ResetPedVisibleDamage(cuffer)
		ClearPedLastWeaponDamage(cuffer)
		ResetPedMovementClipset(cuffer, 0)


	end
end


RegisterNetEvent('police:client:BillPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t('info.bill'),
            submitText = Lang:t('info.submit'),
            inputs = {
                {
                    text = Lang:t('info.amount'),
                    name = "bill",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if tonumber(dialog['bill']) > 0 then
            TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(dialog['bill']))
        else
            QBCore.Functions.Notify(Lang:t("error.amount_higher"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

Mask = true
RegisterNetEvent('police:client:UnmaskPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            local ped = PlayerPedId()
            local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
            local ad = "missheist_agency2ahelmet"
            RequestAnimDict(dict)
            TaskPlayAnim( cuffer, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait (600)
            ClearPedSecondaryTask(cuffer)
            SetPedPropIndex(cuffer, 0, -1, 0, 2)
            ClearPedProp(cuffer, 0, -1, 0, 2)
            SetPedComponentVariation(cuffer, 1, 0, 0, 1) --remove
            SetPedComponentVariation(cuffer, 1, 0, 0, 1) --remove
            Wait (20000)
            ClearPedTasksImmediately(cuffer)
        else
            QBCore.Functions.Notify("Cannot unmask them", "error")
        end
    else
        QBCore.Functions.Notify("No one nearby to unmask", "error")
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isEscorted then
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:KidnapPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.0 then
                local playerId = GetPlayerServerId(player)
                if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                    TriggerServerEvent("police:server:CuffPlayer", playerId, true)
                    HandCuffAnimation()
                else
                    QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
                end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)

function ColdDown()
    Citizen.CreateThread(function()
    -- 60000 (1 minute)
    Citizen.Wait(500)
    isColddown = false
    end)
end

RegisterNetEvent('police:client:CuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.0 then
            if QBCore.Functions.HasItem("handcuffs") then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                        if not isColddown then
                            TriggerServerEvent("police:server:CuffPlayer", playerId, false)
                            HandCuffAnimation()
                            isColddown = true
                            ColdDown()
                        else 
                            QBCore.Functions.Notify("You cannot cuff them yet.", "error")
                        end
                    else
                        QBCore.Functions.Notify(Lang:t("error.vehicle_cuff"), "error")
                    end
            else
                QBCore.Functions.Notify(Lang:t("error.no_cuff"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed then
            if not isEscorted then
                isEscorted = true
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                RequestAnimDict("nm")

                while not HasAnimDictLoaded("nm") do
                    Wait(10)
                end
                AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(ped, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
                ClearPedTasksImmediately(ped)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:GetKidnappedDragger', function()
    QBCore.Functions.GetPlayerData(function(_)
        if not isEscorting then
            local dragger = PlayerPedId()
            RequestAnimDict("missfinale_c2mcs_1")

            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                Wait(10)
            end
            TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('qb-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
    local ped = PlayerPedId()  
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId)) 
    if not isHandcuffed then
        SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
        AttachEntityToEntity(ped, cuffer, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            if exports['ps-buffs']:HasBuff("luck") then
                Wait(500)
                exports['ps-ui']:Circle(function(success) 
                    Wait(500)
                    GetCuffedAnimation(playerId)
                    if success then 
                        DetachEntity(ped, true, false)
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify("You broke free")
                    else 
                        isHandcuffed = true
                        TriggerServerEvent("police:server:SetHandcuffStatus", true)
                        ClearPedTasksImmediately(ped)
                        DetachEntity(ped, true, false)
                            if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
                                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            end
                        if not isSoftcuff then
                            cuffType = 16
                            QBCore.Functions.Notify("You are cuffed!")
                            carrying = false
                            ClearPedTasks(GetPlayerPed(-1))
                            DetachEntity(GetPlayerPed(-1), true, false)
                            TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
                        else
                            cuffType = 49
                            QBCore.Functions.Notify("You are cuffed, but you can walk")
                            carrying = false
                            ClearPedTasks(GetPlayerPed(-1))
                            DetachEntity(GetPlayerPed(-1), true, false)
                            TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
                        end
                    end
                end, 1, 8)
            else
                Wait(500)
                exports['ps-ui']:Circle(function(success) 
                    Wait(500)
                        GetCuffedAnimation(playerId)
                    if success then 
                            DetachEntity(ped, true, false)
                            ClearPedTasks(PlayerPedId())
                            QBCore.Functions.Notify("You broke free")
                    else 
                        isHandcuffed = true
                        TriggerServerEvent("police:server:SetHandcuffStatus", true)
                        ClearPedTasksImmediately(ped)
                        DetachEntity(ped, true, false)
                            if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
                                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                            end
                        if not isSoftcuff then
                            cuffType = 16
                            QBCore.Functions.Notify("You are cuffed!")
                            carrying = false
                            ClearPedTasks(GetPlayerPed(-1))
                            DetachEntity(GetPlayerPed(-1), true, false)
                            TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
                        else
                            cuffType = 49
                            QBCore.Functions.Notify("You are cuffed, but you can walk")
                            carrying = false
                            ClearPedTasks(GetPlayerPed(-1))
                            DetachEntity(GetPlayerPed(-1), true, false)
                            TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
                        end
                    end
                end, 1, 5)
        end
    else
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(ped, true, false)
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(ped)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        QBCore.Functions.Notify("You are uncuffed!")
    end
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1)
        if isEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
        end

        if isHandcuffed then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed

            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QBCore.Functions.GetPlayerData().metadata["isdead"] then
                loadAnimDict("mp_arresting")
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end
        if not isHandcuffed and not isEscorted then
            Wait(2000)
        end
    end
end)


local holdingBody = false
local carrying = false

RegisterNetEvent('carry:command')
AddEventHandler('carry:command', function()
	if not carrying then
		local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
	
		if closestPlayer ~= -1 and closestDistance <= 1.0 then
			TriggerServerEvent('carry:sync', GetPlayerServerId(closestPlayer))
		end
	else
		QBCore.Functions.notify('no')
	end
end,false)

RegisterNetEvent('carry:syncTarget')
AddEventHandler('carry:syncTarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carrying = true

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
		
	while carrying do

		DisableControlAction(1, 19, true)
		DisableControlAction(0, 34, true)
		DisableControlAction(0, 9, true)
	
		DisableControlAction(0, 288, true)
		DisableControlAction(0, 289, true)
		DisableControlAction(0, 170, true)
		DisableControlAction(0, 73, true)
		DisableControlAction(0, 79, true)
		DisableControlAction(0, 305, true)
		DisableControlAction(0, 82, true)
		DisableControlAction(0, 182, true)

		DisableControlAction(0, 32, true)
		DisableControlAction(0, 8, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(1, 33, true)
		DisableControlAction(1, 34, true)
		DisableControlAction(1, 35, true)
		DisableControlAction(1, 21, true)  -- space
		DisableControlAction(1, 22, true)  -- space
		DisableControlAction(1, 23, true)  -- F
		DisableControlAction(1, 24, true)  -- F
		DisableControlAction(1, 25, true)  -- F
	
	
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions 
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing

		if not IsEntityPlayingAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
			loadAnim("amb@world_human_bum_slumped@male@laying_on_left_side@base")
			TaskPlayAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
		end

		if IsControlJustPressed(0, 47)  then
			carrying = false
			ClearPedTasks(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 2.0 then
				TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
				TriggerEvent('animations:client:EmoteCommandStart', {"bumsleep"})
				QBCore.Functions.Notify('You have broken free.')

			end
		end


		Wait(1)
	end

end)


RegisterNetEvent('carry:syncMe')
AddEventHandler('carry:syncMe', function()
	local playerPed = GetPlayerPed(-1)
    if not carrying then

        QBCore.Functions.Notify('Press E to release carry.')

        carrying = true

        while carrying do
            if not IsEntityPlayingAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
                loadAnim("missfinale_c2mcs_1")
                TaskPlayAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
            end

            if IsControlJustPressed(0, 38) then
                carrying = false
                ClearPedSecondaryTask(GetPlayerPed(-1))
                DetachEntity(GetPlayerPed(-1), true, false)
                carrying = false
                local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 2.0 then
                    TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
                end
            end

            Wait(1)
        end
    else
        QBCore.Functions.Notify('You cannot do that.')
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(GetPlayerPed(-1), true, false)
            carrying = false
    end
end)

RegisterNetEvent('carry:stop')
AddEventHandler('carry:stop', function()
	carrying = false
	ClearPedTasks(PlayerPedId())
	DetachEntity(GetPlayerPed(-1), true, false)
end)


function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



---- ZIPTIE ----

--[[local zip = false
local HandCuff = nil
local zipback = false


RegisterNetEvent('NAT2K15:PLAYANIM')
AddEventHandler('NAT2K15:PLAYANIM', function()
	local ped = PlayerPedId()
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(100)
	end
	TaskPlayAnim(ped, 'mp_arresting', 'a_uncuff', 8.0, -8, 3000, 49, 0, 0, 0, 0)
end)

RegisterNetEvent('NAT2K15:PLAYSOUNDD')
AddEventHandler('NAT2K15:PLAYSOUNDD', function(soundFile, soundVolume)
    SendNUIMessage({transactionType = 'playSound', transactionFile = soundFile, transactionVolume = soundVolume})
end)


RegisterNetEvent('NAT2K15:BACKZIP')
AddEventHandler('NAT2K15:BACKZIP', function(id)
	local player = Closetplayer()
	if(player == false) then return QBCore.Functions.Notify("No one is nearby..", "error") end
	TriggerServerEvent("NAT2K15:SZIPBACK", player)
	TriggerServerEvent("QBCore:Server:RemoveItem", "ziptie", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ziptie"], "remove")
end)


RegisterNetEvent('NAT2K15:UNZIPUSER')
AddEventHandler('NAT2K15:UNZIPUSER', function()
	local player = Closetplayer()
	if(player == false) then return QBCore.Functions.Notify("No one is nearby..", "error") end
	TriggerServerEvent("NAT2K15:FREEDAUSER", player)
end)

RegisterNetEvent('NAT2K15:CZIPBACK')
AddEventHandler('NAT2K15:CZIPBACK', function(playerId)
	local ped = PlayerPedId() 
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId)) 
	if not zip then
		local coords = GetEntityCoords(ped)
		RequestAnimDict("mp_arresting")
		while not HasAnimDictLoaded("mp_arresting") do
			Citizen.Wait(100)
		end
		TaskPlayAnim(ped, "mp_arresting", "idle",8.0,-8,-1,49,0,0,0,0)
        SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
        AttachEntityToEntity(ped, cuffer, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        
		
		if HandCuff ~= nil then
			DetachEntity(HandCuff, true, true)
			DeleteEntity(HandCuff)
		end
		
		SetEnableHandcuffs(ped, true)
        isHandcuffed = true
        TriggerServerEvent("police:server:SetHandcuffStatus", true)
		DisablePlayerFiring(ped, true)
		SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(ped, false)
		FreezeEntityPosition(ped, false)
		DisplayRadar(false)
		zip = true
		HandCuff = CreateObject(GetHashKey("hei_prop_zip_tie_positioned"), coords.x, coords.y, coords.z, true, true, true)
		AttachEntityToEntity(HandCuff, ped, GetPedBoneIndex(ped, 60309), -0.020, 0.035, 0.06, 0.04, 155.0, 80.0, true, false, false, false, 0, true)
		zipback = true
        ClearPedTasks(GetPlayerPed(-1))
        DetachEntity(GetPlayerPed(-1), true, false)
	end
end)


RegisterNetEvent('NAT2K15:BEFREEWEIRDO')
AddEventHandler('NAT2K15:BEFREEWEIRDO', function()
	local ped = PlayerPedId()
	if HandCuff then
		zip = false
		
		DetachEntity(HandCuff, true, true)
		DeleteEntity(HandCuff)
        isHandcuffed = false
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
		zipback = false
		ClearPedSecondaryTask(ped)
		SetEnableHandcuffs(ped, false)
		DisablePlayerFiring(ped, false)
		DisplayRadar(true)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if zipback then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed
			
			if IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3) ~= 1 and zipback then
				RequestAnimDict('mp_arresting')
				TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			end
			if IsEntityPlayingAnim(ped, 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 and zipfront then
				RequestAnimDict('anim@move_m@prisoner_cuffed')
				TaskPlayAnim(ped, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			end
			if zipback then
				Citizen.Wait(600000)
				QBCore.Functions.Notify("Your bindings feel loose...", "info")
				Citizen.Wait(2000)
				local seconds = math.random(8,10)
				local circles = math.random(1,2)
				local ped = PlayerPedId()
				local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
				if success then
					local ped = PlayerPedId()
					if HandCuff then
						zip = false
						DetachEntity(HandCuff, true, true)
						DeleteEntity(HandCuff)
						zipback = false
						zipfront = false
						ClearPedSecondaryTask(ped)
						SetEnableHandcuffs(ped, false)
						DisablePlayerFiring(ped, false)
						DisplayRadar(true)
					end
					QBCore.Functions.Notify("You have broken free", "success")
				else 
					QBCore.Functions.Notify("You feel the restrains tighten", "error")
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)]]
