Config = {}

Config.img = "rsg-inventory/html/images/"

---------------------------
-- CONFIG goldpaning 
---------------------------
Config.propGoldpan = "P_CS_MININGPAN01X"
Config.itemGoldpan = "goldpan"
Config.itemRock = "rock"

-- set the amount of nuggets to give
Config.GoldChance = 80 -- (80 = 20% changce of not finding gold) / (70 = 30% changce of not finding gold).. and so on

-- set the amount of nuggets to give in hotspot
Config.HSSmallRewardAmount   = 1
Config.HSMediumRewardAmount  = 2
Config.HSHSLargeRewardAmount = 3
Config.HSGoldChance = 20 -- (70 = 30% changce of not finding gold

Config.HotspotZones = { 
    [1] = {
        zones = { 
            vector2(-2668.4643554688, -331.17501831055),
            vector2(-2676.6958007813, -345.48364257813),
            vector2(-2692.796875, -341.9401550293),
            vector2(-2691.8974609375, -334.74746704102)
        },
        minZ = 142.12985229492,
        maxZ = 143.64106750488
    },
    [2] = {
        zones = { 
            vector2(1542.0013427734, -7162.8862304688),
            vector2(1547.5384521484, -7171.96875),
            vector2(1556.6940917969, -7168.587890625),
            vector2(1550.9084472656, -7158.328125)
        },
        minZ = 62.612213134766,
        maxZ = 63.129043579102
    },
}

Config.WaterTypes = {
    [1] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495,    ["watertype"] = "river"},
    [2] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443,    ["watertype"] = "river"},
    [3] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193,    ["watertype"] = "river"},
    [4] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360,    ["watertype"] = "river"},
    [5] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421,    ["watertype"] = "river"},
    [6] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007,      ["watertype"] = "river"},
    [7] =  {["name"] = "Beartooth Beck",        ["waterhash"] = 650214731,      ["watertype"] = "river"},
    [8] =  {["name"] = "Deadboot Creek",        ["waterhash"] = 1245451421,     ["watertype"] = "river"},
    [9] =  {["name"] = "Spider Gorge",          ["waterhash"] = -218679770,     ["watertype"] = "river"},
    [10] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481,    ["watertype"] = "river"},
    [11] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515,    ["watertype"] = "river"},
    [12] =  {["name"] = "Random1",              ["waterhash"] = 231313522,      ["watertype"] = "river"},
    [13] =  {["name"] = "Random2",              ["waterhash"] = 2005774838,     ["watertype"] = "river"},
    [14] =  {["name"] = "Random3",              ["waterhash"] = -1287619521,    ["watertype"] = "river"},
    [15] =  {["name"] = "Random4",              ["waterhash"] = -1308233316,    ["watertype"] = "river"},
    [16] =  {["name"] = "Random5",              ["waterhash"] = -196675805,     ["watertype"] = "river"},
    [17] =  {["name"] = "Arroyo De La Vibora",  ["waterhash"] = -49694339,      ["watertype"] = "river"},
}

Config.RewardPaning = {
    "salt",
    'coal',
    "char",
    "rock",
    "sand",
}

---------------------------
-- CONFIG smelt
---------------------------

Config.propSmelt = 'p_goldsmeltburner01x' --'p_baseburner01x', 
Config.itemSmelt = "goldsmelt"
Config.UseGoldSmeltItem = true

Config.SmeltLocations = true -- can active 'true' / desactive 'false'
Config.SmeltingLocations = {
    {        name = 'Smelter',         coords = vector3(-370.5368, 795.87225, 115.66062),         heading = 125.98059,         minZ = 114.66062,        maxZ = 117.66062,        showblip = true    },
    {        name = 'Smelter',         coords = vector3(-2396.335, -2376.617, 61.053844),         heading = 355.44912,         minZ = 59.29764,         maxZ = 63.29764,         showblip = true    }, 
    {        name = 'Smelter',         coords = vector3(2516.4436, -1456.448, 46.146656),         heading = 272.17373,         minZ = 44.29764,         maxZ = 48.29764,         showblip = true    },
    {        name = 'Smelter',         coords = vector3(-370.5368, 795.87225, 115.66062),         heading = 125.98059,         minZ = 114.66062,        maxZ = 117.66062,        showblip = true    },
}

Config.SmeltOptions = {

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

---------------------------
-- mining
---------------------------

Config.KeyMining = 'E'

Config.Cooldown = 20 -- seconds
Config.itemMining = 'pickaxe'
Config.propMining = "p_pickaxe01x"

-- set item rewards amount
Config.SmallRewardAmount = 1
Config.MediumRewardAmount = 2

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

-- mining locations

Config.MiningLocations = {
    {name = 'Minas GriW',	location = 'mining1', coords = vector3(-1424.091, 1176.6002, 226.3431),	showblip = true, showmarker = false},
    {name = 'Minas',	location = 'mining2', coords = vector3(-1417.508, 1171.145, 226.57142),		showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining3', coords = vector3(-1425.11, 1173.34, 226.22),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining4', coords = vector3(-1430.49, 1176.11, 226.33),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining5', coords = vector3(-1422.86, 1187.35, 225.47),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining6', coords = vector3(-1414.73, 1185.32, 225.48),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining7', coords = vector3(-1411.92, 1182.53, 225.55),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining8', coords = vector3(-1409.72, 1190.29, 225.46),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining9', coords = vector3(-1405.99, 1194.99, 225.37),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining10', coords = vector3(-1415.83, 1197.11, 225.14),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining11', coords = vector3(-1420.33, 1201.63, 225.36),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining12', coords = vector3(-1429.2, 1202.06, 225.53),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining13', coords = vector3(-1421.24, 1217.51, 222.45),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining14', coords = vector3(-1412.51, 1212.7, 222.42),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining15', coords = vector3(-1406.02, 1207.38, 222.87),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining16', coords = vector3(-1415.12, 1201.39, 224.71),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining17', coords = vector3(-1444.72, 1202.9, 226.33),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining18', coords = vector3(-1446.54, 1195.84, 226.35),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining19', coords = vector3(-1444.63, 1192.29, 226.44),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining20', coords = vector3(-1400.83, 1175.13, 222.08),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining21', coords = vector3(-1396.7, 1170.83, 222.19),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining22', coords = vector3(-1393.61, 1171.83, 222.58),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining23', coords = vector3(-1394.68, 1169.74, 222.38),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining24', coords = vector3(-1387.02, 1182.16, 222.21),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining25', coords = vector3(-1388.55, 1177.58, 221.88),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining26', coords = vector3(-1392.99, 1186.0, 222.01),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining27', coords = vector3(-1418.91, 1193.09, 225.37),			showblip = false, showmarker = false},
	{name = 'Minas GriW',	location = 'mining28', coords = vector3(-1393.31, 1185.81, 221.96),			showblip = false, showmarker = false},

    {name = 'Minas Ann',	location = 'mining29', coords = vector3(2763.174, 1406.2044, 68.444854),	showblip = true, showmarker = false},
    {name = 'Minas',	location = 'mining30', coords = vector3(2726.7871, 1384.9691, 68.878173),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining31', coords = vector3(2717.3491, 1314.0633, 69.75164),		showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining32', coords = vector3(2757.26, 1332.74, 70.05),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining33', coords = vector3(2759.25, 1310.11, 69.95),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining34', coords = vector3(2759.29, 1304.02, 69.95),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining35', coords = vector3(2756.77, 1302.42, 69.95),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining36', coords = vector3(2720.28, 1313.35, 69.72),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining37', coords = vector3(2715.84, 1313.54, 69.72),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining38', coords = vector3(2712.59, 1313.71, 69.76),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining39', coords = vector3(2712.84, 1308.56, 69.72),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining40', coords = vector3(2710.81, 1308.82, 69.73),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining41', coords = vector3(2734.29, 1331.67, 69.65),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining42', coords = vector3(2731.69, 1329.38, 69.62),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining43', coords = vector3(2729.2, 1330.23, 69.62),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining44', coords = vector3(2728.85, 1332.17, 69.64),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining45', coords = vector3(2740.86, 1351.4, 68.16),				howblip = false},
	{name = 'Minas',	location = 'mining46', coords = vector3(2738.09, 1355.64, 68.18),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining47', coords = vector3(2724.29, 1374.61, 68.9),				showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining48', coords = vector3(2722.89, 1376.78, 68.89),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining49', coords = vector3(2721.05, 1378.13, 68.86),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining50', coords = vector3(2724.21, 1384.51, 68.83),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining51', coords = vector3(2727.69, 1389.01, 68.83),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining52', coords = vector3(2724.28, 1390.48, 68.77),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining53', coords = vector3(2724.41, 1409.41, 68.76),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining54', coords = vector3(2747.34, 1414.73, 68.83),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining55', coords = vector3(2744.97, 1413.19, 68.8),				showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining56', coords = vector3(2758.88, 1405.76, 68.59),			showblip = false, showmarker = false},
    {name = 'Minas',	location = 'mining57', coords = vector3(2763.78, 1378.77, 67.89),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining58', coords = vector3(2767.42, 1371.01, 68.03),			showblip = false, showmarker = false},
	{name = 'Minas Ann',	location = 'mining59', coords = vector3(2757.97, 1371.05, 68.05),			showblip = false, showmarker = false},

	{name = 'Minas Gri',	location = 'mining60', coords = vector3(835.76275, 1931.185, 259.84646),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining61', coords = vector3(835.62109, 1925.5421, 259.289),		showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining62', coords = vector3(831.66693, 1920.0919, 259.37493),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining63', coords = vector3(836.15, 1927.5, 258.84),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining64', coords = vector3(833.1, 1920.89, 259.51),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining65', coords = vector3(826.92, 1920.46, 259.7),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining67', coords = vector3(821.47, 1929.84, 258.73),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining68', coords = vector3(817.16, 1928.08, 258.11),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining69', coords = vector3(813.67, 1928.98, 257.93),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining70', coords = vector3(809.78, 1926.06, 257.31),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining71', coords = vector3(809.89, 1922.87, 257.12),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining72', coords = vector3(801.54, 1921.51, 254.91),			showblip = false, showmarker = false},
	{name = 'Minas Gri',	location = 'mining73', coords = vector3(804.91, 1923.71, 256.95),			showblip = false, showmarker = false},

	{name = 'Minas Ely',	location = 'mining74', coords = vector3(2354.16, 1006.88, 73.4),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining75', coords = vector3(2352.19, 1012.76, 74.07),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining76', coords = vector3(2350.19, 1019.97, 76.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining77', coords = vector3(2345.53, 1023.2, 76.93),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining78', coords = vector3(2342.92, 1027.77, 76.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining79', coords = vector3(2334.42, 1029.31, 77.1),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining80', coords = vector3(2330.23, 1031.28, 77.21),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining81', coords = vector3(2326.58, 1035.66, 77.2),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining82', coords = vector3(2317.57, 1031.64, 79.17),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining83', coords = vector3(2312.23, 1031.49, 79.48),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining84', coords = vector3(2305.2, 1033.1, 79.77),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining85', coords = vector3(2299.93, 1035.26, 79.27),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining86', coords = vector3(2297.31, 1030.7, 80.2),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining87', coords = vector3(2293.52, 1043.19, 79.53),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining88', coords = vector3(2289.87, 1043.29, 79.43),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining89', coords = vector3(2297.84, 1055.88, 81.27),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining90', coords = vector3(2299.75, 1058.66, 82.3),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining91', coords = vector3(2303.41, 1062.37, 83.58),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining92', coords = vector3(2298.58, 1070.67, 83.38),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining93', coords = vector3(2292.88, 1073.44, 80.82),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining94', coords = vector3(2283.59, 1068.59, 80.52),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining95', coords = vector3(2279.49, 1061.59, 78.75),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining96', coords = vector3(2274.15, 1061.84, 78.23),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining97', coords = vector3(2285.33, 1078.37, 82.57),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining98', coords = vector3(2285.64, 1082.64, 83.63),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining99', coords = vector3(2296.07, 1086.71, 86.52),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining100', coords = vector3(2304.87, 1087.39, 90.55),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining101', coords = vector3(2305.08, 1093.37, 93.74),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining102', coords = vector3(2296.86, 1095.28, 93.66),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining103', coords = vector3(2307.23, 1103.12, 94.44),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining104', coords = vector3(2297.41, 1108.77, 95.24),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining105', coords = vector3(2290.69, 1113.26, 95.86),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining106', coords = vector3(2284.13, 1120.63, 96.34),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining107', coords = vector3(2294.3, 1123.18, 96.97),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining108', coords = vector3(2310.9, 1143.38, 96.29),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining109', coords = vector3(2305.19, 1134.49, 96.31),			showblip = false, showmarker = false},
	{name = 'Minas Ely',	location = 'mining110', coords = vector3(2312.26, 1140.96, 96.37),			showblip = false, showmarker = false},

	{name = 'Minas Ans',	location = 'mining111', coords = vector3(2357.69, 1388.77, 106.69),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining112', coords = vector3(2341.91, 1398.42, 104.61),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining113', coords = vector3(2344.81, 1405.81, 102.92),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining114', coords = vector3(2335.91, 1409.24, 100.89),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining115', coords = vector3(2330.24, 1412.15, 98.05),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining116', coords = vector3(2328.46, 1416.88, 96.12),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining117', coords = vector3(2321.19, 1419.22, 94.6),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining118', coords = vector3(2314.84, 1420.48, 93.07),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining119', coords = vector3(2314.04, 1430.77, 88.7),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining120', coords = vector3(2311.38, 1435.17, 86.57),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining121', coords = vector3(2307.11, 1434.33, 88.92),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining122', coords = vector3(2303.58, 1451.0, 83.24),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining123', coords = vector3(2299.54, 1460.91, 83.27),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining124', coords = vector3(2288.8, 1464.46, 83.16),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining125', coords = vector3(2277.98, 1468.19, 83.19),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining126', coords = vector3(2279.61, 1471.73, 82.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining127', coords = vector3(2269.37, 1473.61, 83.19),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining128', coords = vector3(2271.42, 1484.22, 82.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining129', coords = vector3(2272.84, 1488.48, 82.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining130', coords = vector3(2278.35, 1489.35, 83.3),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining131', coords = vector3(2271.64, 1489.74, 86.53),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining132', coords = vector3(2267.55, 1482.58, 87.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining133', coords = vector3(2273.32, 1478.84, 88.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining134', coords = vector3(2284.02, 1485.09, 93.34),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining135', coords = vector3(2282.93, 1489.58, 93.36),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining136', coords = vector3(2270.96, 1485.86, 95.97),			showblip = false, showmarker = false},
	{name = 'Minas Ans',	location = 'mining137', coords = vector3(2269.21, 1489.6, 96.06),			showblip = false, showmarker = false},

	{name = 'Minas Ans',	location = 'mining138', coords = vector3(-1518.4, 723.82, 126.92),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining139', coords = vector3(-1516.68, 729.32, 126.78),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining140', coords = vector3(-1519.11, 733.51, 126.35),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining141', coords = vector3(-1520.3, 737.95, 125.92),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining142', coords = vector3(-1516.29, 737.03, 125.98),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining143', coords = vector3(-1516.29, 740.44, 125.81),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining144', coords = vector3(-1518.52, 742.8, 126.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining145', coords = vector3(-1516.24, 731.54, 126.54),			showblip = false, showmarker = false},

	{name = 'Minas Sha',	location = 'mining146', coords = vector3(-2125.29, 33.06, 265.55),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining147', coords = vector3(-2124.45, 44.98, 262.54),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining148', coords = vector3(-2124.92, 55.02, 259.15),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining149', coords = vector3(-2124.32, 57.87, 258.51),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining150', coords = vector3(-2123.67, 68.7, 256.79),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining151', coords = vector3(-2125.48, 73.6, 255.24),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining152', coords = vector3(-2135.53, 79.65, 252.44),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining153', coords = vector3(-2131.78, 84.39, 250.77),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining154', coords = vector3(-2142.65, 82.15, 250.75),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining155', coords = vector3(-2148.74, 85.99, 249.54),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining156', coords = vector3(-2154.59, 91.42, 246.92),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining157', coords = vector3(-2154.98, 96.86, 245.09),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining158', coords = vector3(-2151.42, 103.18, 244.69),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining159', coords = vector3(-2148.89, 99.39, 244.14),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining160', coords = vector3(-2136.44, 105.23, 243.34),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining161', coords = vector3(-2132.58, 111.75, 240.87),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining162', coords = vector3(-2138.44, 122.33, 238.4),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining163', coords = vector3(-2126.13, 127.83, 237.09),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining164', coords = vector3(-2096.18, 118.33, 239.84),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining165', coords = vector3(-2091.73, 109.18, 243.68),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining166', coords = vector3(-2084.36, 103.18, 247.36),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining167', coords = vector3(-2096.26, 87.63, 250.26),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining168', coords = vector3(-2111.37, 77.02, 253.8),			showblip = false, showmarker = false},

	{name = 'Minas Big',	location = 'mining169', coords = vector3(-2336.35, 106.89, 222.7),	showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining170', coords = vector3(-2351.29, 110.35, 217.85),		showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining172', coords = vector3(-2351.36, 113.74, 217.56),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining173', coords = vector3(-2356.32, 111.48, 217.01),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining174', coords = vector3(-2361.78, 111.74, 216.73),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining175', coords = vector3(-2366.5, 109.81, 216.88),				showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining176', coords = vector3(-2370.83, 116.36, 216.76),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining177', coords = vector3(-2363.75, 118.72, 216.78),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining178', coords = vector3(-2368.19, 123.69, 216.85),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining179', coords = vector3(-2367.07, 125.25, 216.95),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining180', coords = vector3(-2312.44, 95.24, 225.22),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining181', coords = vector3(-2311.14, 88.43, 223.87),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining182', coords = vector3(-2314.03, 88.17, 222.85),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining183', coords = vector3(-2319.24, 80.52, 221.78),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining184', coords = vector3(-2333.25, 84.16, 219.51),			showblip = false, showmarker = false},

	{name = 'Minas Lit',	location = 'mining185', coords = vector3(-2661.58, 689.51, 184.12),			showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining186', coords = vector3(-2663.69, 694.86, 183.99),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining187', coords = vector3(-2668.33, 690.06, 184.19),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining188', coords = vector3(-2672.77, 691.66, 182.65),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining189', coords = vector3(-2673.27, 696.11, 181.78),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining190', coords = vector3(-2676.8, 696.33, 181.49),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining191', coords = vector3(-2676.84, 698.59, 181.51),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining192', coords = vector3(-2679.56, 693.63, 181.16),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining193', coords = vector3(-2683.82, 689.94, 179.4),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining194', coords = vector3(-2687.17, 687.81, 178.97),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining195', coords = vector3(-2688.2, 685.68, 178.92),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining196', coords = vector3(-2688.36, 694.95, 178.46),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining197', coords = vector3(-2702.28, 707.56, 176.17),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining198', coords = vector3(-2708.28, 703.59, 175.37),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining199', coords = vector3(-2715.58, 697.18, 175.41),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining200', coords = vector3(-2718.21, 691.17, 175.41),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining201', coords = vector3(-2717.57, 683.34, 175.76),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining202', coords = vector3(-2720.5, 682.59, 175.77),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining203', coords = vector3(-2720.39, 686.19, 179.47),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining204', coords = vector3(-2717.98, 692.72, 178.31),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining205', coords = vector3(-2713.51, 695.88, 178.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining206', coords = vector3(-2711.04, 690.95, 177.64),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining207', coords = vector3(-2726.33, 699.88, 176.27),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining208', coords = vector3(-2723.55, 700.49, 176.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining209', coords = vector3(-2722.81, 706.92, 174.31),			showblip = false, showmarker = false},	
	{name = 'Minas',	location = 'mining210', coords = vector3(-2722.81, 706.92, 174.31),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining211', coords = vector3(-2729.19, 716.08, 169.81),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining212', coords = vector3(-2720.7, 716.22, 170.81),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining213', coords = vector3(-2720.76, 722.89, 171.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining214', coords = vector3(-2725.53, 729.74, 171.58),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining215', coords = vector3(-2721.86, 731.62, 172.2),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining216', coords = vector3(-2732.46, 722.7, 170.08),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining217', coords = vector3(-2729.57, 718.29, 170.42),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining218', coords = vector3(-2715.67, 726.09, 176.4),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining219', coords = vector3(-2708.09, 731.77, 175.79),			showblip = false, showmarker = false},	
	{name = 'Minas',	location = 'mining220', coords = vector3(-2712.6, 722.49, 177.14),	showblip = false, showmarker = false},

	{name = 'Minas Gap',	location = 'mining221', coords = vector3(-5964.34, -3198.97, -21.59),			showblip = true, showmarker = false},
	{name = 'Minas',	location = 'mining222', coords = vector3(-5961.88, -3189.47, -21.58),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining223', coords = vector3(-5958.81, -3189.17, -21.69),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining224', coords = vector3(-5955.4, -3180.29, -22.38),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining225', coords = vector3(-5962.31, -3173.65, -23.13),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining226', coords = vector3(-5970.45, -3167.7, -25.22),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining227', coords = vector3(-5977.7, -3166.1, -26.0),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining228', coords = vector3(-5981.11, -3162.14, -26.43),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining229', coords = vector3(-5984.89, -3166.12, -26.59),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining230', coords = vector3(-5974.98, -3167.22, -25.59),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining231', coords = vector3(-5983.65, -3148.61, -27.6),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining232', coords = vector3(-5992.52, -3146.67, -27.63),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining233', coords = vector3(-5996.27, -3142.75, -27.67),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining234', coords = vector3(-6002.46, -3144.66, -28.43),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining235', coords = vector3(-6011.36, -3150.33, -28.56),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining236', coords = vector3(-6016.26, -3152.16, -28.47),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining237', coords = vector3(-6015.56, -3144.19, -28.63),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining238', coords = vector3(-6017.31, -3135.99, -27.72),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining239', coords = vector3(-6011.19, -3117.96, -25.92),			showblip = false, showmarker = false},	
	{name = 'Minas',	location = 'mining240', coords = vector3(-5996.67, -3124.16, -25.65),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining241', coords = vector3(-5989.18, -3124.46, -25.57),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining242', coords = vector3(-5984.47, -3132.4, -26.64),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining243', coords = vector3(-5991.74, -3138.7, -26.95),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining244', coords = vector3(-5992.33, -3145.91, -27.51),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining245', coords = vector3(-5984.58, -3147.65, -27.72),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining246', coords = vector3(-5971.21, -3153.2, -28.45),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining247', coords = vector3(-5964.69, -3150.92, -28.72),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining248', coords = vector3(-5967.5, -3146.64, -28.75),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining249', coords = vector3(-5964.04, -3131.86, -29.65),			showblip = false, showmarker = false},	
	{name = 'Minas',	location = 'mining250', coords = vector3(-5978.47, -3124.3, -30.91),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining251', coords = vector3(-5979.3, -3121.9, -31.06),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining252', coords = vector3(-5983.03, -3117.99, -31.09),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining253', coords = vector3(-5987.02, -3118.65, -28.56),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining254', coords = vector3(-5983.47, -3123.56, -28.36),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining255', coords = vector3(-5978.35, -3114.56, -30.72),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining256', coords = vector3(-5972.69, -3116.23, -28.59),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining257', coords = vector3(-5961.25, -3116.13, -29.68),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining258', coords = vector3(-5986.23, -3101.51, -24.58),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining259', coords = vector3(-5991.97, -3104.22, -24.58),			showblip = false, showmarker = false},	
	{name = 'Minas',	location = 'mining260', coords = vector3(-5998.04, -3097.75, -23.56),	showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining261', coords = vector3(-6006.71, -3108.02, -24.57),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining262', coords = vector3(-6001.12, -3110.77, -25.45),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining263', coords = vector3(-5993.96, -3111.59, -25.63),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining264', coords = vector3(-6010.16, -3117.94, -25.8),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining265', coords = vector3(-6013.96, -3129.22, -27.61),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining266', coords = vector3(-6016.86, -3136.82, -27.82),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining267', coords = vector3(-6007.91, -3146.68, -28.65),			showblip = false, showmarker = false},
	{name = 'Minas',	location = 'mining268', coords = vector3(-6009.61, -3143.35, -28.88),			showblip = false, showmarker = false},
}