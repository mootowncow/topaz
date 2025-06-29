-----------------------------------
-- Magian Trial Data
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/weaponskillids")
require("scripts/globals/mob_family")
require("scripts/globals/mob_pool")
require("scripts/globals/zone")
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
tpz.magian.TRIAL_ACCEPTED  = 1
tpz.magian.TRIAL_COMPLETED = 2

-- Kills:
-- Family
-- Species
-- Pool
-- During weather / day
-- With x weaponskill
-- With x elemental damage
-- Pet Kills
-- While enemy is under x status effect
-- Specific name (NM kills)

-- All trials need to either be type 'Items', 'Kills', or 'Special'
-- 'Special' only works on listener trials (via C++ core)

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
        mainItem      = tpz.items.MAULERS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MAULERS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
            },
        },
    },

    [1001] = {
        mainItem      = tpz.items.MAULERS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1000,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MAULERS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1002] = {
        mainItem      = tpz.items.MAULERS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1001,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MAULERS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.STR, 2 },
            },
        },
    },

    [1003] = {
        mainItem      = tpz.items.MAULERS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1002,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MAULERS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1005] = {
        mainItem      = tpz.items.ANCHORETS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.ANCHORETS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
            },
        },
    },

    [1006] = {
        mainItem      = tpz.items.ANCHORETS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1005,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.ANCHORETS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
            },
        },
    },

    [1007] = {
        mainItem      = tpz.items.ANCHORETS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1006,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.ANCHORETS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.STR, 2 },
            },
        },
    },

    [1008] = {
        mainItem      = tpz.items.ANCHORETS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1007,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.ANCHORETS_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1010] = {
        mainItem      = tpz.items.MENDING_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MENDING_CAPE,
            itemAugments = {
                { tpz.augments.ENMITY_MINUS, 2 },
            },
        },
    },

    [1011] = {
        mainItem      = tpz.items.MENDING_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1010,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MENDING_CAPE,
            itemAugments = {
                { tpz.augments.ENMITY_MINUS, 2 },
            },
        },
    },

    [1012] = {
        mainItem      = tpz.items.MENDING_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1011,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MENDING_CAPE,
            itemAugments = {
                { tpz.augments.ENMITY_MINUS, 3 },
            },
        },
    },

    [1013] = {
        mainItem      = tpz.items.MENDING_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1012,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.MENDING_CAPE,
            itemAugments = {
                { tpz.augments.ENMITY_MINUS, 4 },
            },
        },
    },

    [1015] = {
        mainItem      = tpz.items.BANE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.BANE_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1020] = {
        mainItem      = tpz.items.GHOSTFYRE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GHOSTFYRE_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1025] = {
        mainItem      = tpz.items.CANNY_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CANNY_CAPE,
            itemAugments = {
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1026] = {
        mainItem      = tpz.items.CANNY_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1025,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CANNY_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1027] = {
        mainItem      = tpz.items.CANNY_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1026,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CANNY_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.DEX, 2 },
            },
        },
    },

    [1028] = {
        mainItem      = tpz.items.CANNY_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1027,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CANNY_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.DEX, 3 },
            },
        },
    },

    [1030] = {
        mainItem      = tpz.items.WEARD_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.WEARD_MANTLE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1035] = {
        mainItem      = tpz.items.NIHT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.NIHT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
            },
        },
    },

    [1036] = {
        mainItem      = tpz.items.NIHT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1035,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.NIHT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1037] = {
        mainItem      = tpz.items.NIHT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1036,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.NIHT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.STR, 2 },
            },
        },
    },

    [1038] = {
        mainItem      = tpz.items.NIHT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1037,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.NIHT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1040] = {
        mainItem      = tpz.items.PASTORALISTS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.PASTORALISTS_MANTLE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1045] = {
        mainItem      = tpz.items.RHAPSODES_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.RHAPSODES_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1050] = {
        mainItem      = tpz.items.LUTIAN_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.LUTIAN_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1055] = {
        mainItem      = tpz.items.TAKAHA_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TAKAHA_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
            },
        },
    },

    [1056] = {
        mainItem      = tpz.items.TAKAHA_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1055,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TAKAHA_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1057] = {
        mainItem      = tpz.items.TAKAHA_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1056,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TAKAHA_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.STR, 2 },
            },
        },
    },

    [1058] = {
        mainItem      = tpz.items.TAKAHA_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1057,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TAKAHA_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1060] = {
        mainItem      = tpz.items.YOKAZE_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.YOKAZE_MANTLE,
            itemAugments = {
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1061] = {
        mainItem      = tpz.items.YOKAZE_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1060,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.YOKAZE_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1062] = {
        mainItem      = tpz.items.YOKAZE_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1061,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.YOKAZE_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.DEX, 2 },
            },
        },
    },

    [1063] = {
        mainItem      = tpz.items.YOKAZE_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1062,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.YOKAZE_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.DEX, 3 },
            },
        },
    },

    [1065] = {
        mainItem      = tpz.items.UPDRAFT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.UPDRAFT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
            },
        },
    },

    [1066] = {
        mainItem      = tpz.items.UPDRAFT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1065,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.UPDRAFT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1067] = {
        mainItem      = tpz.items.UPDRAFT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1066,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.UPDRAFT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.STR, 2 },
            },
        },
    },

    [1068] = {
        mainItem      = tpz.items.UPDRAFT_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1067,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.UPDRAFT_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1070] = {
        mainItem      = tpz.items.CONVEYANCE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CONVEYANCE_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1075] = {
        mainItem      = tpz.items.CORNFLOWER_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CORNFLOWER_CAPE,
            itemAugments = {
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1076] = {
        mainItem      = tpz.items.CORNFLOWER_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1075,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CORNFLOWER_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1077] = {
        mainItem      = tpz.items.CORNFLOWER_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1076,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CORNFLOWER_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.DEX, 2 },
            },
        },
    },

    [1078] = {
        mainItem      = tpz.items.CORNFLOWER_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1077,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.CORNFLOWER_CAPE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.DEX, 3 },
            },
        },
    },

    [1080] = {
        mainItem      = tpz.items.GUNSLINGERS_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GUNSLINGERS_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1085] = {
        mainItem      = tpz.items.DISPERSAL_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.DISPERSAL_MANTLE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1090] = {
        mainItem      = tpz.items.TOETAPPER_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TOETAPPER_MANTLE,
            itemAugments = {
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1091] = {
        mainItem      = tpz.items.TOETAPPER_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1090,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TOETAPPER_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 9 },
                { tpz.augments.ACC, 9 },
            },
        },
    },

    [1092] = {
        mainItem      = tpz.items.TOETAPPER_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1091,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TOETAPPER_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 11 },
                { tpz.augments.ACC, 11 },
                { tpz.augments.DEX, 2 },
            },
        },
    },

    [1093] = {
        mainItem      = tpz.items.TOETAPPER_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1092,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.TOETAPPER_MANTLE,
            itemAugments = {
                { tpz.augments.ATT, 14 },
                { tpz.augments.ACC, 14 },
                { tpz.augments.DEX, 2 },
            },
        },
    },

    [1095] = {
        mainItem      = tpz.items.BOOKWORMS_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAMOOLJA, tpz.mob.family.MAMOOLJAKNIGHT, tpz.mob.family.MAMOOLJA_SWORD, tpz.mob.family.GULOOL_JA_JA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.BOOKWORMS_CAPE,
            itemAugments = {
                { tpz.augments.HP_33, 17 },
                { tpz.augments.PDT, 4 },
            },
        },
    },

    [1100] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 1101,
            [tpz.items.ICE_CLUSTER]         = 1111,
            [tpz.items.WIND_CLUSTER]        = 1121,
            [tpz.items.EARTH_CLUSTER]       = 1131,
            [tpz.items.LIGHTNING_CLUSTER]   = 1141,
            [tpz.items.WATER_CLUSTER]       = 1151,
            [tpz.items.LIGHT_CLUSTER]       = 1161,
            [tpz.items.DARK_CLUSTER]        = 1171
        },
    },

    [1161] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1100,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TONBERRY_ZILART, tpz.mob.family.TONBERRY_COP },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 5 },
            },
        },
    },

    [1162] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1161,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GIANTBIRD, tpz.mob.family.GIANTBIRD_NM },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 7 },
                { tpz.augments.MND, 4 },
            },
        },
    },

    [1163] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1162,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GHRAH_SEA, tpz.mob.family.GHRAH_LIMBUS, tpz.mob.family.GHRAH_UNUSED },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.LIGHT,
        day           = tpz.day.LIGHTSDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 9 },
                { tpz.augments.MND, 5 },
                { tpz.augments.LIGHTRES, 10 },
            },
        },
    },

    [1164] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1163,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.HIPPOGRYPH, tpz.mob.family.HIPPOGRYPH_2 },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.LIGHT,
        day           = tpz.day.LIGHTSDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 12 },
                { tpz.augments.MND, 6 },
                { tpz.augments.LIGHTRES, 12 },
            },
        },
    },

    [1165] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1164,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.CARDIAN },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.LIGHT,
        day           = tpz.day.LIGHTSDAY,
        numRequired   = 450,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 13 },
                { tpz.augments.MND, 7 },
                
            },
        },
    },

    [1166] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1165,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ARTEMISIA },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 14 },
                { tpz.augments.MND, 7 },
                { tpz.augments.LIGHTRES, 17 },
            },
        },
    },

    [1167] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1166,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.VERTHANDI },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.CURE_POTENCY, 14 },
                { tpz.augments.MND, 7 },
                { tpz.augments.REFRESH, 0 },
                { tpz.augments.LIGHTRES, 20 },
            },
        },
    },

    [1171] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1100,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GNOLE },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MACC, 14 },
            },
        },
    },

    [1172] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE, 
        type          = 'Kills',
        previousTrial = 1171,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.AERN },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MACC, 15 },
                { tpz.augments.MP_33, 2 },
            },
        },
    },
    -- TODO: Res of trials, and start adding DARKRES (10-20)

    [1200] = {
        mainItem      = tpz.items.SIDE_SWORD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 1201,
            [tpz.items.ICE_CLUSTER]         = 1211,
            [tpz.items.WIND_CLUSTER]        = 1221,
            [tpz.items.EARTH_CLUSTER]       = 1231,
            [tpz.items.LIGHTNING_CLUSTER]   = 1241,
            [tpz.items.WATER_CLUSTER]       = 1251,
            [tpz.items.LIGHT_CLUSTER]       = 1261,
            [tpz.items.DARK_CLUSTER]        = 1271
        },
    },

    [1201] = {
        mainItem      = tpz.items.SIDE_SWORD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1200,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WIVRE },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 6 },
            },
        },
    },


    [1202] = {
        mainItem      = tpz.items.SOULSABER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1201,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MANTICORE },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 10 },
                { tpz.augments.MAIN_DMG_RATING, 5 },
            },
        },
    },

    [1203] = {
        mainItem      = tpz.items.SOULSABER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1202,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.CLUSTER_1, tpz.mob.family.CLUSTER_2 },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 12 },
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [1204] = {
        mainItem      = tpz.items.SOULSABER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1203,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DRACHENLIZARD },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 13 },
                { tpz.augments.MAIN_DMG_RATING, 8 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
            },
        },
    },

    -- Soulsaber MMM NM x15 next
    -- Soulsaber VNM x 25 NEXT

    [2200] = {
        mainItem      = tpz.items.VULCANS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.FIRE,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.VULCANS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2250] = {
        mainItem      = tpz.items.AQUILOS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.ICE,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.AQUILOS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2300] = {
        mainItem      = tpz.items.AUSTERS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.WIND,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.AUSTERS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2350] = {
        mainItem      = tpz.items.TERRAS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.EARTH,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.TERRAS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2400] = {
        mainItem      = tpz.items.JUPITERS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.THUNDER,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.JUPITERS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2450] = {
        mainItem      = tpz.items.NEPTUNES_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.WATER,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.NEPTUNES_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2500] = {
        mainItem      = tpz.items.APOLLOS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.LIGHT,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.APOLLOS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [2550] = {
        mainItem      = tpz.items.PLUTOS_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.DARK,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.PLUTOS_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    -- TEST TRIALS
    [9000] = {
        mainItem      = tpz.items.DARK_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Effect',
        effect        = tpz.effect.PARALYSIS,
        subType       = 'Magic',
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.DARK_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9001] = {
        mainItem      = tpz.items.FIRE_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        subType       = 'Weather',
        weather       = { tpz.weather.WIND, tpz.weather.GALES },
        day           = tpz.day.WINDSDAY,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.FIRE_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9002] = {
        mainItem      = tpz.items.WATER_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Special',
        specialType   = 'WSUse',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        wsId          = { tpz.ws.HEAVY_SWING },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.WATER_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9003] = {
        mainItem      = tpz.items.WIND_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Special',
        specialType   = 'WSDamage',
        previousTrial = 0,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        wsId          = { tpz.ws.ROCK_CRUSHER },
        wsDmg         = 100,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.WIND_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9004] = {
        mainItem      = tpz.items.EARTH_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Special',
        specialType   = 'ExperiencePoints',
        previousTrial = 0,
        textOffset    = 1,
        subType       = 'Zone',
        zone          = { tpz.zone.BHAFLAU_THICKETS },
        numRequired   = 100000,
        rewardItem    = {
            itemId       = tpz.items.EARTH_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9006] = {
        mainItem      = tpz.items.ICE_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        subType       = 'PetKill',
        previousTrial = 0,
        textOffset    = 1,
        killType       = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.ICE_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9007] = {
        mainItem      = tpz.items.LIGHT_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        killType      = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        previousTrial = 0,
        textOffset    = 1,
        subType      = 'Elemental',
        element       = tpz.magic.ele.FIRE,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.LIGHT_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9008] = {
        mainItem      = tpz.items.THUNDER_STAFF,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        subType       = 'PetKill',
        pet           = 'Ramuh',
        previousTrial = 0,
        textOffset    = 1,
        killType       = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.THUNDER_STAFF,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9009] = {
        mainItem      = tpz.items.DAGGER,
        tradeItem     = tpz.items.NONE,
        type          = 'Effect',
        effect        = tpz.effect.DEFENSE_DOWN,
        subType       = 'AddEffect',
        previousTrial = 0,
        textOffset    = 1,
        killType       = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.DAGGER,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9010] = {
        mainItem      = tpz.items.KUKRI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        subType       = 'UnderEffect',
        effect        = tpz.effect.LEVEL_RESTRICTION,
        previousTrial = 0,
        textOffset    = 1,
        killType       = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.KUKRI,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [9011] = {
        mainItem      = tpz.items.BRONZE_DAGGER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        subType       = 'StatusEffectElement',
        effectElement = tpz.magic.ele.FIRE,
        previousTrial = 0,
        textOffset    = 1,
        killType       = 'Family',
        mob           = { tpz.mob.family.COLIBRI },
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.BRONZE_DAGGER,
            itemAugments = {
                { tpz.augments.MATT, 2 },
            },
        },
    },

    -- Lyft weapon upgrades
    -- Squamous Hide gear
    -- Add previous trials for mass kills before OAT VNM trials and then TON more after to make it even better
    -- Add trials vs EMPTY mobs
    -- Add trials vs zilart beastmen and cactuars
    -- Add trials for Sky God set / weapon trials, requires sky god seals
    -- Add trials for AF weapons that require multiple testimonies. Unique job specific weapons with brand new mods kinda like bonanza weapons
    -- AF Weapon trial part2 to kill vanilla Beastmen Kings many times
    -- Most trials should end with ZNM T3 drops/kills
    -- Trials for older Rare/Ex drops from NM's or quests like Executioner's Axe
    -- TODO: Stenz dark trials
    -- Use Marids!
}
