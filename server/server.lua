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

---------------------------
-- use item
---------------------------
-- use goldsmelt
RSGCore.Functions.CreateUseableItem(Config.itemSmelt, function(source, item)
    local src = source
	TriggerClientEvent('rsg-mining:client:setupgoldsmelt', src, item.name)
end)

-- use goldpan
RSGCore.Functions.CreateUseableItem(Config.itemGoldpan, function(source, item)
    local src = source
    TriggerClientEvent("rsg-mining:client:StartGoldPan", src, item.name)
end)

-- use rock
RSGCore.Functions.CreateUseableItem(Config.itemRock, function(source, item)
    local src = source
	TriggerClientEvent('rsg-mining:client:StartRockPan', src, item.name)
end) 

---------------------------
-- mining
---------------------------

RegisterServerEvent('rsg-mining:server:givestone')
AddEventHandler('rsg-mining:server:givestone', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local chance = math.random(1, 100)
    local rock = math.random(1, 3)
    local playername = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local citizenid = Player.PlayerData.citizenid

    Player.Functions.AddItem(Config.itemRock, rock)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[Config.itemRock], "add")

    if chance <= 50 then
        local salt = math.random(1, 3)
        Player.Functions.AddItem('rocksalt', salt)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['rocksalt'], "add")
    end
end)

---------------------------
-- remove pickaxe if broken
---------------------------

RegisterServerEvent('rsg-mining:server:breakpickaxe')
AddEventHandler('rsg-mining:server:breakpickaxe', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if item == Config.itemMining then
        Player.Functions.RemoveItem(Config.itemMining, 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[Config.itemMining], "add")
        
        TriggerClientEvent('ox_lib:notify', src, {title = 'Success', description =  Lang:t('success.your_pickaxe_broke'), type = 'success' })
            
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Error', description =  Lang:t('error.something_went_wrong'), type = 'error' })
            print('something went wrong with the script could be exploint!')
    end
end)

---------------------------
-- Smelting
---------------------------

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
            TriggerClientEvent('ox_lib:notify', src, {title = 'Error', description =  'You dont have the required items '.. RSGCore.Shared.Items[tostring(v.item)].label, type = 'error' })
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

    TriggerClientEvent('ox_lib:notify', src, {title = 'Success', description =  'Smelting successful'..' '..smeltamount..' ' .. labelReceive, type = 'success' })

end)

---------------------------
-- paning washrocks
---------------------------

RegisterServerEvent('rsg-mining:server:washrocks')
AddEventHandler('rsg-mining:server:washrocks', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local chance = math.random(1, 100)
    local checkItem = Player.Functions.GetItemByName(Config.itemRock)
    local item = Config.RareAward[math.random(1, #Config.RareAward)]
    local item2 = Config.UncommonAward[math.random(1, #Config.UncommonAward)]
    local item3 = Config.Normal[math.random(1, #Config.Normal)]

    if chance <= 5 then
        
        if checkItem.amount > 3 and chance <= 13 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem(Config.itemRock, 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem(Config.itemRock, remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "add")
            else end

        elseif checkItem.amount <= 2 then

            Player.Functions.RemoveItem(Config.itemRock, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")

        end

        TriggerClientEvent('ox_lib:notify', src, {title = 'Wow..', description =  'Add item and destroyed rock', type = 'primary' })

    elseif chance > 15 and chance <= 45 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem(Config.itemRock, 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item2, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item2], "add")

            TriggerClientEvent('ox_lib:notify', src, {title = 'Wow..', description =  'Add item and destroyed rock', type = 'primary' })

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem(Config.itemRock, remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "add")
                TriggerClientEvent('ox_lib:notify', src, {title = 'Wow..', description =  'Add rock and destroyed rock', type = 'primary' })
            else end

        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem(Config.itemRock, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item2, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item2], "add")
        end

        TriggerClientEvent('ox_lib:notify', src, {title = 'Wow..', description =  'Add item and destroyed rock', type = 'primary' })

    elseif chance > 47 and chance <= 68 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem(Config.itemRock, 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item3, ore)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item3], "add")

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem(Config.itemRock, remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "add")

            else end

        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem(Config.itemRock, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
            Player.Functions.AddItem(item3, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item3], "add")
        end

        TriggerClientEvent('ox_lib:notify', src, {title = 'Wow..', description =  'Add item and destroyed rock', type = 'primary' })

    elseif chance > 50 then

        if checkItem.amount >= 3 then
            local ore = math.random(1, 3)
            local remaining = 0
            Player.Functions.RemoveItem(Config.itemRock, 3)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")

            if ore <= 2 then
                remaining = 3 - ore
                Player.Functions.AddItem(Config.itemRock, remaining)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "add")
            else end

        elseif checkItem.amount <= 2 then
            Player.Functions.RemoveItem(Config.itemRock, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.itemRock], "remove")
        end

        TriggerClientEvent('ox_lib:notify', src, {title = 'Error', description =  'Destroyed rock', type = 'error' })

    end
end)

---------------------------
-- goldpaning
---------------------------

-- give reward
RegisterServerEvent('rsg-mining:server:rewardgoldpaning')
AddEventHandler('rsg-mining:server:rewardgoldpaning', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local foundgold = math.random(1,100)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname

    if foundgold < Config.GoldChance then
        local chance = math.random(1,100)
        if chance <= 50 then
            local item1 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
            -- add items
            Player.Functions.AddItem(item1, Config.SmallRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")

            TriggerClientEvent('ox_lib:notify', src, {title = 'Have lucky', description =  'not much this pan', type = 'primary' })

            -- webhook
            TriggerEvent('rsg-log:server:CreateLog', 'goldpanning', 'Gold Found 🌟', 'yellow', firstname..' '..lastname..' found a gold nugget!')

        elseif chance >= 50 and chance <= 100 then -- medium reward
            local item1 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
            local item2 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
            -- add items
            Player.Functions.AddItem(item1, Config.MediumRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
            Player.Functions.AddItem(item2, Config.MediumRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")

            TriggerClientEvent('ox_lib:notify', src, {title = 'Have lucky', description = 'looks like good gold', type = 'primary' })

            -- webhook
            TriggerEvent('rsg-log:server:CreateLog', 'goldpanning', 'Gold Fever 🌟', 'yellow', firstname..' '..lastname..' found two gold nuggets!')
        end
    else

        TriggerClientEvent('ox_lib:notify', src, {title = 'Best lucky', description = 'no gold this time..', type = 'primary' })

    end
end)

-- give hotspot reward
RegisterServerEvent('rsg-mining:server:hotspotrewardgoldpaning')
AddEventHandler('rsg-mining:server:hotspotrewardgoldpaning', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local foundgold = math.random(1,100)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname

        if foundgold < Config.HSGoldChance then
            local chance = math.random(1,100)
            if chance <= 50 then
                local item1 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
                -- add items
                Player.Functions.AddItem(item1, Config.HSSmallRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")

                TriggerClientEvent('ox_lib:notify', src, {title = 'Have lucky', description =  'not much this pan', type = 'primary' })

                -- webhook
                TriggerEvent('rsg-log:server:CreateLog', 'goldpanning', 'Mega Gold Found 🌟', 'yellow', firstname..' '..lastname..' found a gold nugget!')
            end
            if chance >= 50 and chance <= 80 then -- medium reward
                local item1 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
                local item2 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
                -- add items
                Player.Functions.AddItem(item1, Config.HSMediumRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
                Player.Functions.AddItem(item2, Config.HSMediumRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")

                TriggerClientEvent('ox_lib:notify', src, {title = 'Have lucky', description = 'looks like good gold', type = 'primary' })

                -- webhook
                TriggerEvent('rsg-log:server:CreateLog', 'goldpanning', 'Mega Gold Fever 🌟', 'yellow', firstname..' '..lastname..' found two gold nuggets!')
            end
            if chance > 80 then -- large reward
                local item1 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
                local item2 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]
                local item3 = Config.RewardPaning[math.random(1, #Config.RewardPaning)]

                -- add items
                Player.Functions.AddItem(item1, Config.HSLargeRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
                Player.Functions.AddItem(item2, Config.HSLargeRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
                Player.Functions.AddItem(item3, Config.HSLargeRewardAmount)
                TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item3], "add")

                TriggerClientEvent('ox_lib:notify', src, {title = 'Jackpot', description = 'gold fever rewards..', type = 'primary' })

                -- webhook
                TriggerEvent('rsg-log:server:CreateLog', 'goldpanning', 'Mega Jackpot Gold Find 🌟', 'yellow', firstname..' '..lastname..' found three gold nuggets!')
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {title = 'Best lucky', description = 'no gold this time..', type = 'primary' })
    end
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
