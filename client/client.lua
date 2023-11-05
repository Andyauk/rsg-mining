local RSGCore = exports['rsg-core']:GetCoreObject()
local miningstarted = false
local mining
local mineAnimation = 'amb_work@world_human_pickaxe@wall@male_d@base'
local anim = 'base'
local options = {}

local LoadAnimDict = function(dict)
    local isLoaded = HasAnimDictLoaded(dict)

    while not isLoaded do
        RequestAnimDict(dict)
        Wait(5)
        isLoaded = not isLoaded
    end
end


---------------------------
-- draw marker if set to true in config
---------------------------

CreateThread(function()
    while true do
        local sleep = 0
        for mining, v in pairs(Config.MiningLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

---------------------------
-- start mining
---------------------------

Citizen.CreateThread(function()
    for _, mining in pairs(Config.MiningLocations) do
        exports['rsg-core']:createPrompt(mining.location, mining.coords, RSGCore.Shared.Keybinds['E'], 'Start ' .. mining.name, {
            type = 'client',
            event = 'rsg-mining:client:StartMining'
        })
        if mining.showblip == true then
            local MiningBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, mining.coords)
            SetBlipSprite(MiningBlip, 1220803671)
            SetBlipScale(MiningBlip)
            Citizen.InvokeNative(0x9CB1A1623062F402, MiningBlip, mining.name)
        end
    end
end)

RegisterNetEvent('rsg-mining:client:StartMining', function()
    local player = PlayerPedId()
    local hasItem = RSGCore.Functions.HasItem('pickaxe', 1)
    local chance = math.random(1, 100)
    
    if miningstarted == false then
        if hasItem then
            local numberGenerator = math.random(1, 100)
            if numberGenerator <= 5 then
                TriggerServerEvent('rsg-mining:server:breakpickaxe')
            else
                local coords = GetEntityCoords(player)
                local boneIndex = GetEntityBoneIndexByName(player, "SKEL_R_Finger00")
                local pickaxe = CreateObject(GetHashKey("p_pickaxe01x"), coords, true, true, true)
                miningstarted = true

                SetCurrentPedWeapon(player, "WEAPON_UNARMED", true)
                FreezeEntityPosition(player, true)
                ClearPedTasksImmediately(player)
                AttachEntityToEntity(pickaxe, player, boneIndex, -0.35, -0.21, -0.39, -8.0, 47.0, 11.0, true, false, true, false, 0, true)

                TriggerEvent('rsg-mining:client:MineAnimation')

                RSGCore.Functions.Progressbar("mining", "Mining...", 30000, false, true,
                {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    ClearPedTasksImmediately(player)
                    FreezeEntityPosition(player, false)

                    TriggerServerEvent('rsg-mining:server:givestone')

                    SetEntityAsNoLongerNeeded(pickaxe)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)

                    miningstarted = false
                end)
            end
        else
            RSGCore.Functions.Notify('You don\'t have a pickaxe!', 'error')
        end
    else
        RSGCore.Functions.Notify('You are already doing something!', 'primary')
    end
end)

AddEventHandler('rsg-mining:client:MineAnimation', function()
    local player = PlayerPedId()

    LoadAnimDict(mineAnimation)
    Wait(100)
    TaskPlayAnim(player, mineAnimation, anim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)

---------------------------
-- target smelt menu + blip smeltlocations
---------------------------

for _, k in ipairs(Config.SmeltingLocations) do
    exports['rsg-target']:AddBoxZone("Testing", k.coords, 1.45, 1.35, {
        name = "Testing",
        heading = k.heading,
        debugPoly = false,
        minZ = k.minZ,
        maxZ = k.maxZ,
    }, {
        options = {
            {
                type = "client",
                event = "rsg-mining:client:smeltmenu",
                icon = "fas fa-fire",
                label = "Smelt",
            },
        },
        distance = 2.5
    })

    exports['rsg-target']:AddTargetModel(Config.Prop, {
    options = {
        {   icon = 'far fa-gear',
            label = "Smelt item", -- use text '' = 'Title example'
            type = "client",
            event = 'rsg-mining:client:smeltmenu',
        },},
    distance = 2.0,
    })

    if k.showblip == true then
        local SmeltingBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, k.coords)
        SetBlipSprite(SmeltingBlip, GetHashKey("blip_shop_shady_store"), 1)
        SetBlipScale(SmeltingBlip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, SmeltingBlip, k.name)
    end
end

---------------------------
-- menu smeltmenu
---------------------------

local categoryMenus = {}

for _, v in ipairs(Config.SmeltOptions) do
    local smeltitemsMetadata = {}
    local setheader = RSGCore.Shared.Items[tostring(v.receive)].label
    local itemimg = "nui://"..Config.img..RSGCore.Shared.Items[tostring(v.receive)].image

    for i, smeltitem in ipairs(v.smeltitems) do
        table.insert(smeltitemsMetadata, { label = RSGCore.Shared.Items[smeltitem.item].label, value = smeltitem.amount })
    end

    local option = {
        title = setheader,
        icon = itemimg,
        event = 'rsg-mining:client:checksmeltitems',
        metadata = smeltitemsMetadata,
        args = {
            title = setheader,
            smeltitems = v.smeltitems,
            smelttime = v.smelttime,
            receive = v.receive,
            giveamount = v.giveamount,
        }
    }

    -- check if a menu already exists for this category
    if not categoryMenus[v.category] then
        categoryMenus[v.category] = {
            id = 'smelting_menu_' .. v.category,
            title = 'Smelting Menu - ' .. v.category,
            menu = 'smelting_main_menu',
            onBack = function() end,
            options = { option }
        }
    else
        table.insert(categoryMenus[v.category].options, option)
    end
end

-- log menu events by category
for category, menuData in pairs(categoryMenus) do
    RegisterNetEvent('rsg-mining:client:' .. category)
    AddEventHandler('rsg-mining:client:' .. category, function()
        lib.registerContext(menuData)
        lib.showContext(menuData.id)
    end)
end

-- main event to open main menu
RegisterNetEvent('rsg-mining:client:smeltmenu')
AddEventHandler('rsg-mining:client:smeltmenu', function()
    -- show main menu with categories
    local mainMenu = {
        id = 'smelting_main_menu',
        title = 'Smelting Menu',
        options = {}
    }

    for category, menuData in pairs(categoryMenus) do
        table.insert(mainMenu.options, {
            title = category,
            description = 'Explora las recetas para ' .. category,
            icon = 'fa-solid fa-fire',
            event = 'rsg-mining:client:' .. category,
            arrow = true
        })
    end

    lib.registerContext(mainMenu)
    lib.showContext(mainMenu.id)
end)

---------------------------
-- check player has the ingredients to cook item
---------------------------
RegisterNetEvent('rsg-mining:client:checksmeltitems', function(data)
    local input = lib.inputDialog('Smelting Amount', {
        { 
            type = 'input',
            label = 'Amount',
            required = true,
            min = 1, max = 10 
        },
    })

    if not input then return end

    local smeltamount = tonumber(input[1])
    if smeltamount then
        RSGCore.Functions.TriggerCallback('rsg-mining:server:checkingsmeltitems', function(hasRequired)
            if (hasRequired) then
                if Config.Debug == true then
                    print("passed")
                end
                TriggerEvent('rsg-mining:client:smeltitem', data.title, data.smeltitems, tonumber(data.smelttime * smeltamount), data.receive, data.giveamount,  smeltamount)
            else
                if Config.Debug == true then
                    print("failed")
                end
                return
            end
        end, data.smeltitems,  smeltamount)
    end
end)

-- do cooking
RegisterNetEvent('rsg-mining:client:smeltitem', function(title, smeltitems, smelttime, receive, giveamount, smeltamount)
    local ped = PlayerPedId()
    local animDict = 'script_common@shared_scenarios@kneel@mourn@female@a@base'
    local animName = 'base'

    RSGCore.Functions.RequestAnimDict(animDict)

    -- Check if the animation dictionary was successfully loaded
    if HasAnimDictLoaded(animDict) then
        -- Play the animation
        TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)

        -- Use the Oxlib progress circle with a message
        if lib.progressCircle({
            duration = smelttime, -- Adjust the duration as needed
            position = 'bottom',
            useWhileDead = false,
            canCancel = false, -- Change to true if you want to allow canceling
            anim = {
                dict = animDict,
                clip = 'empathise_headshake_f_001',
                flag = 15,
            },
            disableControl = true, -- Disable player control during the animation
            label = 'Smelting ' .. title, -- Your cooking message here
        }) then
            -- Cooking was successful
            TriggerServerEvent('rsg-mining:server:finishsmelting', smeltitems, receive, giveamount, smeltamount)

            -- Stop the animation
            StopAnimTask(ped, animDict, animName, 1.0)
        else
            -- Handle cancelation or failure
            RSGCore.Functions.Notify("Smelting canceled or failed.", 'error')

            -- Cancel the animation
            StopAnimTask(ped, animDict, animName, 1.0)
        end
    else
        -- Handle if the animation dictionary couldn't be loaded
        RSGCore.Functions.Notify("Failed to load animation dictionary.", 'error')
    end
end)

---------------------------
-- gold smelt prop
---------------------------

local goldsmelt = false

local function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

RegisterNetEvent('rsg-mining:client:setupgoldsmelt')
AddEventHandler('rsg-mining:client:setupgoldsmelt', function()
    if Config.UseGoldSmeltItem == true then
        local ped = PlayerPedId()
        if goldsmelt == true then
            CrouchAnim()
            Wait(6000)
            ClearPedTasks(ped)
            SetEntityAsMissionEntity(smelt)
            DeleteObject(smelt)
            
            lib.notify({ title = 'Save item', description = 'your iten is pickup', type = 'inform' })
            
            goldsmelt = false
        elseif goldsmelt == false then
            CrouchAnim()
            Wait(6000)
            ClearPedTasks(ped)
            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
            local prop = CreateObject(GetHashKey(Config.Prop), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            smelt = prop

            lib.notify({ title = 'Deployed item', description = 'your gold smelt deployed', type = 'inform' })
            
            goldsmelt = true
        end
    else end
end, false)

---------------------------
-- goldpaning + rockpaning
---------------------------

local panning = false
local canPan = false
-------------------
local Zones = {}
local hotspot = false
-------------------
-- create hotspot zones
CreateThread(function() 
    for k=1, #Config.HotspotZones do
        Zones[k] = PolyZone:Create(Config.HotspotZones[k].zones, {
            minZ = Config.HotspotZones[k].minz,
            maxZ = Config.HotspotZones[k].maxz,
            debugPoly = false,
        })
        Zones[k]:onPlayerInOut(function(isPointInside)
            if isPointInside then
                hotspot = true
            else
                hotspot = false
            end
        end)
    end
end)

-- ensure prop is loaded
local function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

local function AttachPan()
    if not DoesEntityExist(prop_goldpan) then
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local modelHash = GetHashKey("P_CS_MININGPAN01X")  
    LoadModel(modelHash)    
    prop_goldpan = CreateObject(modelHash, coords.x+0.30, coords.y+0.10,coords.z, true, false, false)
    SetEntityVisible(prop_goldpan, true)
    SetEntityAlpha(prop_goldpan, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, prop_goldpan, true)   
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    AttachEntityToEntity(prop_goldpan, PlayerPedId(), boneIndex, 0.2, 0.0, -0.20, -100.0, -50.0, 0.0, false, false, false, true, 2, true)
    SetModelAsNoLongerNeeded(modelHash)
    end
end

local function GoldShake()
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false)
end

-- delete goldpan prop
local function DeletePan(entity)
    DeleteObject(entity)
    DeleteEntity(entity)
    Wait(100)          
    ClearPedTasks(PlayerPedId())
end

--[[]] RegisterNetEvent('rsg-mining:client:StartRockPan')
AddEventHandler('rsg-mining:client:StartRockPan', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
    local mounted = IsPedOnMount(ped)
    if mounted == false then
        if panning == false then
            for k,v in pairs(Config.WaterTypes) do 
                if water == Config.WaterTypes[k]["waterhash"] then
                    canPan = true
                    break
                end
            end
            if canPan == true then
                panning = true
                AttachPan()
                CrouchAnim()
                Wait(6000)
                ClearPedTasks(ped)
                GoldShake()
                local randomwait = math.random(12000,28000)
                Wait(randomwait)
                DeletePan(prop_goldpan)
                --if hotspot == true then
                    TriggerServerEvent('rsg-mining:server:washrocks')
                --end
                panning = false
                canPan = false
            else
                lib.notify({ title = 'Need river', description = 'you need the river to goldpan', type = 'primary' })
            end
        else
            lib.notify({ title = 'Need item', description = 'you are already goldpanning', type = 'error' })
        end
    else
        lib.notify({ title = 'error', description = 'you are mounted', type = 'error' })
    end
end) 

RegisterNetEvent('rsg-mining:client:StartGoldPan')
AddEventHandler('rsg-mining:client:StartGoldPan', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
    local mounted = IsPedOnMount(ped)
    if mounted == false then
        if panning == false then
            for k,v in pairs(Config.WaterTypes) do 
                if water == Config.WaterTypes[k]["waterhash"] then
                    canPan = true
                    break
                end
            end
            if canPan == true then
                panning = true
                AttachPan()
                CrouchAnim()
                Wait(6000)
                ClearPedTasks(ped)
                GoldShake()
                local randomwait = math.random(12000,28000)
                Wait(randomwait)
                DeletePan(prop_goldpan)
                if hotspot == true then
                    TriggerServerEvent('rsg-mining:server:hotspotrewardgoldpaning')
                else
                    TriggerServerEvent('rsg-mining:server:rewardgoldpaning')
                end
                panning = false
                canPan = false
            else
                lib.notify({ title = 'Need river', description = 'you need the river to goldpan', type = 'primary' })
            end
        else
            lib.notify({ title = 'Need item', description = 'you are already goldpanning', type = 'error' })
        end
    else
        lib.notify({ title = 'error', description = 'you are mounted', type = 'error' })
    end
end)