ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("dope-waiterJob:giveMoney")
AddEventHandler("dope-waiterJob:giveMoney", function(FirstPedSelectedOrderPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('money', FirstPedSelectedOrderPrice)
end)
