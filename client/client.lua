local RSGCore = exports['rsg-core']:GetCoreObject()
local miningstarted = false
local mining
local mineAnimation = 'amb_work@world_human_pickaxe@wall@male_d@base'
local anim = 'base'
local cooldownSecondsRemaining = Config.Cooldown

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
        exports['rsg-core']:createPrompt(mining.location, mining.coords, RSGCore.Shared.Keybinds[Config.KeyMining], 'Start ' .. mining.name, {
            type = 'client',
            event = 'rsg-mining:client:StartMining'
        })
        if mining.showblip == true then
            local MiningBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, mining.coords)
            SetBlipSprite(MiningBlip, 1220803671)
            SetBlipScale(MiningBlip, 0.8)
            Citizen.InvokeNative(0x9CB1A1623062F402, MiningBlip, mining.name)
        end
    end
end)

-- cooldown timer
local function cooldownTimer()
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
            --print(cooldownSecondsRemaining)
        end
    end)
end

RegisterNetEvent('rsg-mining:client:StartMining', function()
    local player = PlayerPedId()
    local hasItem = RSGCore.Functions.HasItem(Config.itemMining, 1)
    local chance = math.random(1, 100)
    if isBusy == false and cooldownSecondsRemaining == 0 then
        if miningstarted == false then
            if hasItem then
                isBusy = true
                local numberGenerator = math.random(1, 100)
                if numberGenerator <= 5 then
                    TriggerServerEvent('rsg-mining:server:breakpickaxe')
                else
                    local coords = GetEntityCoords(player)
                    local boneIndex = GetEntityBoneIndexByName(player, "SKEL_R_Finger00")
                    local pickaxe = CreateObject(GetHashKey(Config.PropMining), coords, true, true, true)
                    miningstarted = true

                    SetCurrentPedWeapon(player, "WEAPON_UNARMED", true)
                    FreezeEntityPosition(player, true)
                    ClearPedTasksImmediately(player)
                    AttachEntityToEntity(pickaxe, player, boneIndex, -0.35, -0.21, -0.39, -8.0, 47.0, 11.0, true, false, true, false, 0, true)

                    TriggerEvent('rsg-mining:client:MineAnimation')
                    LocalPlayer.state:set("inv_busy", true, true)

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
                        LocalPlayer.state:set("inv_busy", false, true)
                        SetEntityAsNoLongerNeeded(pickaxe)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)

                        miningstarted = false
                    end)
                end
                cooldownTimer()
                isBusy = false
            else
                lib.notify({ title = 'Error', description = 'You don\'t have a pickaxe!', type = 'error' })
            end
        else
            lib.notify({ title = 'Inform', description = 'You are already doing something!', type = 'primary' })
        end
    else
        lib.notify({ title = 'Inform', description = 'Rest your muscles!', type = 'primary' })
    end
end)

AddEventHandler('rsg-mining:client:MineAnimation', function()
    local player = PlayerPedId()

    LoadAnimDict(mineAnimation)
    Wait(100)
    TaskPlayAnim(player, mineAnimation, anim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)