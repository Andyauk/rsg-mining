Config = {}

Config.img = "rsg-inventory/html/images/"

-- set the item rewards
Config.RareAward = {
    'diamond',
    'ruby',
    'emerald',
    'goldore',    
    'silver_ore'
}

Config.UncommonAward = {
    'steel_ore',
    'rocksalt', 
    'copper_ore'
}

Config.Normal = {
    'rock',
    'rocksalt',
    'iron_ore',
    'coal',
    'aluminum_ore'
}

-- set item rewards amount
Config.SmallRewardAmount = 1
Config.MediumRewardAmount = 2

-- mining locations
Config.MiningLocations = {
    {name = 'Mining', location = 'mining-1', coords = vector3(-1424.091, 1176.6002,226.3431),   showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-2', coords = vector3(-1417.508, 1171.145, 226.57142),  showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-3', coords = vector3(2763.174, 1406.2044,68.444854),   showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-4', coords = vector3(2726.7871, 1384.9691, 68.878173), showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-5', coords = vector3(2717.3491, 1314.0633, 69.75164),  showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-6', coords = vector3(835.76275, 1931.185, 259.84646),  showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-7', coords = vector3(835.62109, 1925.5421, 259.289),   showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-8', coords = vector3(831.66693, 1920.0919, 259.37493), showblip = true, showmarker = true},
    {name = 'Mining', location = 'mining-9', coords = vector3(825.7395, 1922.6685, 259.20452),  showblip = true, showmarker = true},
}

Config.SmeltingLocations = {
    {
        name = 'Smelter', 
        coords = vector3(-370.5368, 795.87225, 115.66062), 
        heading = 125.98059, 
        minZ = 114.66062, 
        maxZ = 117.66062, 
        showblip = true
    },
    {
        name = 'Smelter', 
        coords = vector3(-2396.335, -2376.617, 61.053844), 
        heading = 355.44912, 
        minZ = 59.29764, 
        maxZ = 63.29764, 
        showblip = true
    }, 
    {
        name = 'Smelter', 
        coords = vector3(2516.4436, -1456.448, 46.146656), 
        heading = 272.17373, 
        minZ = 44.29764, 
        maxZ = 48.29764, 
        showblip = true
    },
    {
        name = 'Smelter', 
        coords = vector3(-370.5368, 795.87225, 115.66062), 
        heading = 125.98059,
        minZ = 114.66062,
        maxZ = 117.66062, 
        showblip = true
    },



}

Config.SmeltOptions = {

    {
        category = "Gold",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "largenugget", amount = 20 },
        },
        receive = "goldbar",
        giveamount = 1
    },
    {
        category = "Gold",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "mediumnugget", amount = 40 },
        },
        receive = "goldbar",
        giveamount = 1
    },
    {
        category = "Gold",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "smallnugget", amount = 80 },
        },
        receive = "goldbar",
        giveamount = 1
    },
    {
        category = "Ore",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "copper_ore", amount = 1 },
            [2] = { item = "coal", amount = 1 },
            [3] = { item = "wood", amount = 1 },
        },
        receive = "copper",
        giveamount = 1
    },
    {
        category = "Ore",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "aluminum_ore", amount = 1 },
            [2] = { item = "coal", amount = 2 },
            [3] = { item = "wood", amount = 1 },
        },
        receive = "aluminum",
        giveamount = 1
    },
    {
        category = "Ore",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "iron_ore", amount = 1 },
            [2] = { item = "coal", amount = 1 },
            [3] = { item = "water", amount = 1 },
        },
        receive = "iron",
        giveamount = 1
    },
    {
        category = "Ore",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "steel_ore", amount = 1 },
            [2] = { item = "coal", amount = 1 },
            [3] = { item = "wood", amount = 1 },
            [4] = { item = "water", amount = 2 },
        },
        receive = "steel",
        giveamount = 1
    },
    {
        category = "Ore",
        smelttime = 20000,
        smeltitems = {
            [1] = { item = "silver_ore", amount = 1 },
            [2] = { item = "rocksalt", amount = 1 },
            [3] = { item = "wood", amount = 1 },
        },
        receive = "silver",
        giveamount = 1
    },
    
}

