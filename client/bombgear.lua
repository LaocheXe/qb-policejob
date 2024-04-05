CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            local Torso = GetPedDrawableVariation(ped, 11)
			local Undershirt = GetPedDrawableVariation(ped, 8)
			local Shoes = GetPedDrawableVariation(ped, 6)
            local Legs = GetPedDrawableVariation(ped, 4)
            if Torso == 186 and Undershirt == 97 and Legs == 84 and Shoes == 3 or Torso == 186 and Undershirt == 97 and Legs == 84 and Shoes == 3 then
                SetEntityProofs(ped, true, true, true, false, true, true, false, false)
			else 
				SetEntityProofs(ped, false, false, false, false, false, false, false, false)
            end
        end
    end
end)

