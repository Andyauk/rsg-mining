local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-mining/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

-----------------------------------------------------------------------

RegisterServerEvent('rsg-mining:server:givestone')
AddEventHandler('rsg-mining:server:givestone', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local chance = math.random(1, 100)
    local rock = math.random(1, 3)
    local playername = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local citizenid = Player.PlayerData.citizenid

    Player.Functions.AddItem('rock', rock)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['rock'], "add")

    if chance <= 50 then
        local salt = math.random(1, 3)
        Player.Functions.AddItem('rocksalt', salt)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['rocksalt'], "add")
    end
end)

RegisterServerEvent('rsg-mining:server:washrocks')
AddEventHandler('rsg-mining:server:washrocks', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local chance = math.random(1, 100)
    local checkItem = Player.Functions.GetItemByName('rock')
    local item = Config.RareAward[math.random(1, #Config.RareAward)]
    local item2 = Config.UncommonAward[math.random(1, #Config.UncommonAward)]
    local item3 = Config.Normal[math.random(1, #Config.Normal)]

    if chance <= 5 then
        
        if checkItem.amount > 3 and chance <= 13 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem('rock', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem('rock', remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "add")
            else end

        elseif checkItem.amount <= 2 then

            Player.Functions.RemoveItem('rock', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
        end

    elseif chance > 15 and chance <= 45 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem('rock', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item2, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item2], "add")

            if ore <= 2 then

                remaining = 3 - ore
                Player.Functions.AddItem('rock', remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "add")

            else end
            
        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem('rock', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item2, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item2], "add")
        end

    elseif chance > 47 and chance <= 68 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem('rock', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item3, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item3], "add")

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem('rock', remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "add")

            else end

        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem('rock', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            Player.Functions.AddItem(item3, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item3], "add")
        end

    elseif chance > 50 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem('rock', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
            

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem('rock', remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "add")

            else end

        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem('rock', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['rock'], "remove")
        end
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.destroyed_rock'), 'error')
    end
end)

-- remove pickaxe if broken
RegisterServerEvent('rsg-mining:server:removeitem')
AddEventHandler('rsg-mining:server:removeitem', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if item == 'pickaxe' then
        Player.Functions.RemoveItem('pickaxe', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pickaxe'], "add")
        RSGCore.Functions.Notify(src, Lang:t('success.your_pickaxe_broke'), 'success')
    else
        RSGCore.Functions.Notify(src, Lang:t('error.something_went_wrong'), 'error')
        print('something went wrong with the script could be exploint!')
    end
end)

-----------------------------------------------------------------------------------------------------------------
-- Smelting
-- check player has the smeltitems
RSGCore.Functions.CreateCallback('rsg-mining:server:checkingsmeltitems', function(source, cb, smeltitems, smeltamount)
    local src = source
    local hasItems = false
    local icheck = 0
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(smeltitems) do
        if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount * smeltamount then
            icheck = icheck + 1
            if icheck == #smeltitems then
                cb(true)
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_the_required_items').. RSGCore.Shared.Items[tostring(v.item)].label, 'error')
            cb(false)
            return
        end
    end
end)

-- finish smelting
RegisterServerEvent('rsg-mining:server:finishsmelting')
AddEventHandler('rsg-mining:server:finishsmelting', function(smeltitems, receive, giveamount, smeltamount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- remove ingredients
    for k, v in pairs(smeltitems) do
        if Config.Debug == true then
            print(v.item)
            print(v.amount)
        end
        local requiredAmount = v.amount * smeltamount
        Player.Functions.RemoveItem(v.item, requiredAmount)    
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
    end
    -- add cooked item
    Player.Functions.AddItem(receive, giveamount * smeltamount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")
    local labelReceive = RSGCore.Shared.Items[receive].label
    TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.smelting_successful')..' '..smeltamount..' ' .. labelReceive, 'success')
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
