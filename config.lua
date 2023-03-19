Config = {}

Config.Framework = 'esx' -- 'esx' or 'qb'
Config.Target = 'ox_target' -- 'ox_target', 'qtarget' or 'qb-target'

Config.Cooldown = 30 -- cooldown time (in seconds)

Config.MaxCommonReward = 8 -- max amount of common items you can find
Config.MaxUncommonReward = 3 -- max stack of uncommon items you can find
Config.MaxRareReward = 1 -- max stack of uncommon items you can find

Config.CommonRewards = { -- common items that can be found in dumpsters - (60% chance)
    'bread',
    'water',
    'trash',
    'electric_scrap',
    'wires',
    'moldysandwich',
}

Config.UncommonRewards = { -- uncommon items that can be found in dumpsters - (25% chance)
    'plastic',
    'steel',
    'copper',
    'aluminum',
    'iron',
}

Config.RareRewards = { -- rare items that can be found in dumpsters - (5% chance)
    'gold',
    'diamond',
    'electronickit',
    'phone',
    'usb',
    'drill',
}