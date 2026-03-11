ESX = exports["es_extended"]:getSharedObject()

local function UpdaterenzyxHUD()
    local xPlayer = ESX.GetPlayerData()

    if xPlayer and xPlayer.job and xPlayer.accounts then
        local cash, bank, black = 0, 0, 0
        local serverId = GetPlayerServerId(PlayerId())

        for _, account in pairs(xPlayer.accounts) do
            if account.name == 'money' then
                cash = account.money
            elseif account.name == 'bank' then
                bank = account.money
            elseif account.name == 'black_money' then
                black = account.money
            end
        end

        SendNUIMessage({
            action = "update",
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            cash = cash,
            bank = bank,
            black = black,
            serverId = serverId
        })
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    UpdaterenzyxHUD()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    UpdaterenzyxHUD()
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    UpdaterenzyxHUD()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        UpdaterenzyxHUD()
    end
end)