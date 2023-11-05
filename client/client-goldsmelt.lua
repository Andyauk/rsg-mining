local RSGCore = exports['rsg-core']:GetCoreObject()

---------------------------
-- target smelt menu + blip smeltlocations
---------------------------

for _, k in ipairs(Config.SmeltingLocations) do
    if Config.SmeltLocations == true then
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
    end
    exports['rsg-target']:AddTargetModel(Config.propSmelt, {
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

local options = {}
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
    local animDict = 'amb_work@prop_human_repair_wagon_wheel_on@front@male_a@idle_a'
    local animName = 'idle_a'

    RSGCore.Functions.RequestAnimDict(animDict)
    local success = lib.skillCheck({{areaSize = 50, speedMultiplier = 0.5}}, {'w', 'a', 's', 'd'})
    if success == true then
	    -- Check if the animation dictionary was successfully loaded
	    if HasAnimDictLoaded(animDict) then
		-- Play the animation
		TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
		LocalPlayer.state:set("inv_busy", true, true)
	
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
		    LocalPlayer.state:set("inv_busy", false, true)
		else
		    -- Handle cancelation or failure
		    RSGCore.Functions.Notify("Smelting canceled or failed.", 'error')
	
		    -- Cancel the animation
		    StopAnimTask(ped, animDict, animName, 1.0)
		    LocalPlayer.state:set("inv_busy", false, true)
		end
	    else
		-- Handle if the animation dictionary couldn't be loaded
		lib.notify({ title = 'Error', description = "Failed to load animation dictionary.", type = 'error' })
	    end
    else
	SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
        lib.notify({ title = 'Try again!', description = 'Have you never craft?', type = 'error' })
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
            local prop = CreateObject(GetHashKey(Config.propSmelt), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            smelt = prop

            lib.notify({ title = 'Deployed item', description = 'your gold smelt deployed', type = 'inform' })

            goldsmelt = true
        end
    else end
end, false)
