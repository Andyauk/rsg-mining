local RSGCore = exports['rsg-core']:GetCoreObject()
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

-- wash rock
RegisterNetEvent('rsg-mining:client:StartRockPan')
AddEventHandler('rsg-mining:client:StartRockPan', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
    local mounted = IsPedOnMount(ped)
    local hasItem = RSGCore.Functions.HasItem(Config.itemRock)
    local hasItem2 = RSGCore.Functions.HasItem(Config.itemGoldpan)
    if hasItem and hasItem2 then
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
                    LocalPlayer.state:set("inv_busy", true, true)
                    Wait(6000)
                    ClearPedTasks(ped)
                    GoldShake()
                    local randomwait = math.random(12000,28000)
                    Wait(randomwait)
                    DeletePan(prop_goldpan)

                        TriggerServerEvent('rsg-mining:server:washrocks')

                    panning = false
                    canPan = false
                    LocalPlayer.state:set("inv_busy", false, true)
                else
                    lib.notify({ title = 'Need river', description = 'You need the river to goldpan', type = 'primary' })
                end
            else
                lib.notify({ title = 'Need item', description = 'You are already goldpanning', type = 'error' })
            end
        else
            lib.notify({ title = 'Error', description = 'You are mounted', type = 'error' })
        end
    else
        lib.notify({ title = 'Error', description = 'You dont have the required items', type = 'error' })
    end
end)

RegisterNetEvent('rsg-mining:client:StartGoldPan')
AddEventHandler('rsg-mining:client:StartGoldPan', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
    local mounted = IsPedOnMount(ped)
    local hasItem = RSGCore.Functions.HasItem(Config.itemGoldpan)
    if hasItem then
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
                    LocalPlayer.state:set("inv_busy", true, true)
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
                    LocalPlayer.state:set("inv_busy", false, true)
                else
                    lib.notify({ title = 'Need river', description = 'You need the river to goldpan', type = 'primary' })
                end
            else
                lib.notify({ title = 'Need item', description = 'You are already goldpanning', type = 'error' })
            end
        else
            lib.notify({ title = 'Error', description = 'You are mounted', type = 'error' })
        end
    else
        lib.notify({ title = 'Error', description = 'You need a Goldpan to do this', type = 'error' })
    end
end)