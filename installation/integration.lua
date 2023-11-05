-- Read Carefully

-- Place this code at the top of rsg-essentials/client/nearwater.lua:

local RockPrompt

-- Search for function DrinkPrompt() in rsg-essentials/client/nearwater.lua and add this under it:

-- set RockPrompt
function RockPrompt()
    Citizen.CreateThread(function()
        local str ="Wash Stone"
        local wait = 0
        RockPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(RockPrompt, RSGCore.Shared.Keybinds['E'])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(RockPrompt, str)
        PromptSetEnabled(RockPrompt, true)
        PromptSetVisible(RockPrompt, true)
        PromptSetStandardMode(RockPrompt, true) -- Change this to - PromptSetHoldMode(RockPrompt, true) -- if you would like hold button instead of tap.
        PromptSetGroup(RockPrompt, RiverGroup)
        PromptRegisterEnd(RockPrompt)
    end)
end

-- Add This Anywhere in rsg-essentials/client/nearwater.lua:

AddEventHandler('rsg-river:client:checkrocks', function()
    local hasItem = RSGCore.Functions.HasItem('rock', 1)
    if hasItem then
        TriggerEvent('rsg-river:client:washrocks')
    else
        RSGCore.Functions.Notify('You have no more stone to wash!', 'error')
    end
end)

-- Search for PromptHasHoldModeCompleted(DrinkPrompt) in rsg-essentials/client/nearwater.lua and add this under it:

-- wash rock
if PromptHasStandardModeCompleted(RockPrompt) then -- Change this to - PromptHasHoldModeComplete(RockPrompt, true) -- if you would like hold button instead of tap and you set the first added code to Hold also.
    if not isWashing then
        TriggerEvent('rsg-river:client:checkrocks')   
    else end 
end

-- Example:

-- Old Code
if PromptHasHoldModeCompleted(DrinkPrompt) then
    TriggerEvent('rsg-river:client:drink')    
end

-- Added Code
if PromptHasStandardModeCompleted(RockPrompt) then
    if not isWashing then
        TriggerEvent('rsg-river:client:checkrocks')   
    else end 
end

----------------------------------------------------------------------------------------