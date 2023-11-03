# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- github : https://github.com/Rexshack-RedM

# Dependancies
- rsg-core

# Installation
- ensure that the dependancies are added and started
- add rsg-mining to your resources folder
- add items to your "\rsg-core\shared\items.lua"
- add images to your "\rsg-inventory\html\images"

- Place this code at the top of rsg-essentials/client/nearwater.lua:

local RockPrompt

- Search for function DrinkPrompt() in rsg-essentials/client/nearwater.lua and add this under it:

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
        PromptSetStandardMode(RockPrompt, true) - Change this to - PromptSetHoldMode(RockPrompt, true) -- if you would like hold button instead of tap.
        PromptSetGroup(RockPrompt, RiverGroup)
        PromptRegisterEnd(RockPrompt)
    end)
end

- Search for PromptHasHoldModeCompleted(DrinkPrompt) in rsg-essentials/client/nearwater.lua and add this under it:

-- wash rock

if PromptHasStandardModeCompleted(RockPrompt) then -- Change this to - PromptHasHoldModeComplete(RockPrompt, true) -- if you would like hold button instead of tap and you set the first added code to Hold also.
    if not isWashing then
        TriggerEvent('rsg-river:client:checkrocks')   
    else end 
end

- Example:

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


# Starting the resource
- add the following to your server.cfg file : ensure rsg-mining


