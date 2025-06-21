-----------------------------------
-- Magian Trial Data
-----------------------------------
require('scripts/globals/status')
require('scripts/globals/mob_family')
-----------------------------------
tpz = tpz or {}
tpz.magian = tpz.magian or {}

-- Trial data requires that all conditions be defined per table if they are to be
-- checked.  Undefined (nil) values for specific keys will be ignored in the applied
-- listener.

-- Available Options to define:
-- tradeItem  : Item required for trades to delivery crate

-- ORCUS_MANDIBLE is only used for OAT staff...add to more?

tpz.magian.TRIAL_AVAILABLE = 0
tpz.magian.TRIAL_ACCEPTED    = 1
tpz.magian.TRIAL_COMPLETED = 2

-- Kills
-- family
-- Species
-- Pool
-- During weather / day
-- With x weaponskill

tpz.magian.trials = {
    [1] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.WARGFANGS,
            itemAugments = {
                { tpz.augments.DMG, 16 },
                { tpz.augments.DELAY_65, 0 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [2] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.DAYBREAK_SOUL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 50,
        rewardItem    = {
            itemId       = tpz.items.PUGILISTS,
            itemAugments = {
                { tpz.augments.DMG, 5 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_THRICE },
            },
        },
    },

    [50] = {
        mainItem      = tpz.items.PEELER,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.ATHAME,
            itemAugments = {
                { tpz.augments.DMG, 12 },
                { tpz.augments.DELAY, 20 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [100] = {
        mainItem      = tpz.items.SIDE_SWORD,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.ANTEA,
            itemAugments = {
                { tpz.augments.DMG, 16 },
                { tpz.augments.DELAY_33, 3 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [101] = {
        mainItem      = tpz.items.BREAK_BLADE,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.SALAMAND_SWORD,
            itemAugments = {
                { tpz.augments.DMG, 29 },
                { tpz.augments.DELAY, 23 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [150] = {
        mainItem      = tpz.items.CHOPPER,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.PUNISHER,
            itemAugments = {
                { tpz.augments.DMG, 18 },
                { tpz.augments.DELAY, 31 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [200] = {
        mainItem      = tpz.items.LUMBERJACK,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.LUCHTAINE,
            itemAugments = {
                { tpz.augments.DMG, 31 },
                { tpz.augments.DELAY, 9 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [250] = {
        mainItem      = tpz.items.FARMHAND,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.VENGEANCE,
            itemAugments = {
                { tpz.augments.DMG, 32 },
                { tpz.augments.DELAY, 9 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [300] = {
        mainItem      = tpz.items.RANSEUR,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.BRADAMANTE,
            itemAugments = {
                { tpz.augments.DMG, 31 },
                { tpz.augments.DELAY, 20 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [350] = {
        mainItem      = tpz.items.KIBASHIRI,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.ISATU,
            itemAugments = {
                { tpz.augments.DMG, 13 },
                { tpz.augments.DELAY, 9 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [400] = {
        mainItem      = tpz.items.DONTO,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.KURODACHI,
            itemAugments = {
                { tpz.augments.DMG, 27 },
                { tpz.augments.DELAY, 19 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [450] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.GOEDENDAG,
            itemAugments = {
                { tpz.augments.DMG, 19 },
                { tpz.augments.DELAY_33, 7 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [500] = {
        mainItem      = tpz.items.CROOK,
        tradeItem     = tpz.items.ORCUS_MANDIBLE,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.DANDA,
            itemAugments = {
                { tpz.augments.DMG, 40 },
                { tpz.augments.DELAY, 12 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [501] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.GOSHAWK,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 22 },
                { tpz.augments.RANGED_DELAY, 23 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [502] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 501,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.KESTREL,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 22 },
                { tpz.augments.RANGED_DELAY, 23 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [503] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 502,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.ASTRILD,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 22 },
                { tpz.augments.RANGED_DELAY, 23 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [550] = {
        mainItem      = tpz.items.THUNDERSTICK,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.DRAGONMAW,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 27 },
                { tpz.augments.RANGED_DELAY_65, 5 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [1000] = {
        mainItem      = tpz.items.HEAVY_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.HEAVY_MANTLE,
            itemAugments = {
                { tpz.augments.HP, 50 },
                { tpz.augments.PDT, -5 },
            },
        },
    },

    [1000] = {
        mainItem      = tpz.items.HEAVY_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.HEAVY_MANTLE,
            itemAugments = {
                { tpz.augments.HP, 75 },
                { tpz.augments.PDT, -5 },
                { tpz.augments.MDT, -5 },
            },
        },
    },

    [1050] = {
        mainItem      = tpz.items.TIGER_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TIGER_MANTLE,
            itemAugments = {
                { tpz.augments.ACC, 10 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [1100] = {
        mainItem      = tpz.items.RAPTOR_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.RAPTOR_MANTLE,
            itemAugments = {
                { tpz.augments.RACC, 10 },
                { tpz.augments.RATTK, 10 },
            },
        },
    },

    [1150] = {
        mainItem      = tpz.items.GREEN_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GREEN_CAPE,
            itemAugments = {
                { tpz.augments.MP, 50 },
                { tpz.augments.ENMITY_MINUS, 5 },
            },
        },
    },

    [1200] = {
        mainItem      = tpz.items.COTTON_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.COTTON_CAPE,
            itemAugments = {
                { tpz.augments.MACC, 3 },
                { tpz.augments.MATT, 3 },
            },
        },
    },
}
