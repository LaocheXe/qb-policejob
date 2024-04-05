CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            local Torso = GetPedDrawableVariation(ped, 11)
			local Undershirt = GetPedDrawableVariation(ped, 8)
			local Shoes = GetPedDrawableVariation(ped, 6)
            local Legs = GetPedDrawableVariation(ped, 4)
            if Torso == 315 and Undershirt == 151 and Legs == 120 and Shoes == 71 or Torso == 325 and Undershirt == 187 and Legs == 120 and Shoes == 52 then
                SetEntityProofs(ped, false, true, false, false, false, true, false, false)
			else 
				SetEntityProofs(ped, false, false, false, false, false, false, false, false)
            end
        end
    end
end)





 