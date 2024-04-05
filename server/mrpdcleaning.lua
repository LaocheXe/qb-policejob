local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-policejob:server:finishCleaning', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('bank', math.random(100, 150))
    TriggerClientEvent('QBCore:Notify', src, "You got some cash for doing some cleaning", "success", 2500)
   
    local common = math.random(1, 100)
    if common < 5 then
        Player.Functions.AddItem("cashroll", math.random(1, 1), false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cashroll"], "add")
    end

end)




 


 