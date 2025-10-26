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
-- TODO: Swap Scythe and Polearm trial #'s? Sword is also in wrong spot?

tpz.magian.trials = {
    [1] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 2,
            [tpz.items.ICE_CLUSTER]         = 12,
            [tpz.items.WIND_CLUSTER]        = 22,
            [tpz.items.EARTH_CLUSTER]       = 32,
            [tpz.items.LIGHTNING_CLUSTER]   = 42,
            [tpz.items.WATER_CLUSTER]       = 52,
            [tpz.items.LIGHT_CLUSTER]       = 62,
            [tpz.items.DARK_CLUSTER]        = 72,
            [tpz.items.FIRE_CRYSTAL]        = 82,
            [tpz.items.ICE_CRYSTAL]         = 92
        },
    },

    [2] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BIRD },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 4 },
            },
        },
    },

    [3] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 2,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LIZARD, tpz.mob.family.ICELIZARD, tpz.mob.family.HIGHLANDER_LIZARD },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 4 },
                { tpz.augments.DELAYMINUS, 4 },
            },
        },
    },

    [4] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 3,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WAMOURACAMPA },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 5 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [5] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 4,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CONDOR },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 6 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [6] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 5,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TERROR_FLY },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [7] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 6,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DAWON },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 8 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [42] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LEECH, tpz.mob.family.LEECH_TOAU },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 4 },
            },
        },
    },

    [43] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 42,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.SEAMONK },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 4 },
                { tpz.augments.DELAYMINUS, 4 },
            },
        },
    },

    [44] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 43,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.POROGGO },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.LIGHTNING,
        day           = tpz.day.LIGHTNINGDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 5 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [45] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 44,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DRACHENLIZARD },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.LIGHTNING,
        day           = tpz.day.LIGHTNINGDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 6 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.DEX, 3 },
            },
        },
    },

    [46] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 45,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.NIMBLE_NELSON },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.DEX, 4 },
                { tpz.augments.ACC, 8 },
            },
        },
    },

    [47] = {
        mainItem      = tpz.items.CATS_CLAWS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 46,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.VERTHANDI },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.CATS_CLAWS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 8 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.DEX, 5 },
                { tpz.augments.ACC, 10 },
            },
        },
    },

    [82] = {
        mainItem      = tpz.items.PUGILISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.EBA },
        numRequired   = 3,
        rewardItem    = {
            itemId       = tpz.items.SIMIAN_FISTS,
            itemAugments = {
            },
        },
    },

    [83] = {
        mainItem      = tpz.items.SIMIAN_FISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 82,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.BOROKA },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.SIMIAN_FISTS,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [84] = {
        mainItem      = tpz.items.SIMIAN_FISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 83,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.WAILER },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.SIMIAN_FISTS,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [85] = {
        mainItem      = tpz.items.SIMIAN_FISTS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 84,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TAURI },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.WARGFANGS,
            itemAugments = {
            },
        },
    },

    [86] = {
        mainItem      = tpz.items.WARGFANGS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 85,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.WARGFANGS,
            itemAugments = {
                { tpz.augments.DMG, 16 },
                { tpz.augments.DELAYMINUS, 15 },
            },
        },
    },

    [87] = {
        mainItem      = tpz.items.WARGFANGS,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 86,
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

    --[[ TODO
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
    ]]

    [100] = {
        mainItem      = tpz.items.PEELER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 101,
            [tpz.items.ICE_CLUSTER]         = 111,
            [tpz.items.WIND_CLUSTER]        = 121,
            [tpz.items.EARTH_CLUSTER]       = 131,
            [tpz.items.LIGHTNING_CLUSTER]   = 141,
            [tpz.items.WATER_CLUSTER]       = 151,
            [tpz.items.LIGHT_CLUSTER]       = 161,
            [tpz.items.DARK_CLUSTER]        = 171,
            [tpz.items.FIRE_CRYSTAL]        = 181,
            [tpz.items.ICE_CRYSTAL]         = 191
        },
    },

    [101] = {
        mainItem      = tpz.items.PEELER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 100,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BIRD },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 6 },
            },
        },
    },

    [102] = {
        mainItem      = tpz.items.DAKINI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 101,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LIZARD, tpz.mob.family.ICELIZARD, tpz.mob.family.HIGHLANDER_LIZARD },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 5 },
                { tpz.augments.DELAYMINUS, 10 },
            },
        },
    },

    [103] = {
        mainItem      = tpz.items.DAKINI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 102,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WAMOURACAMPA },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.DELAYMINUS, 12 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [104] = {
        mainItem      = tpz.items.DAKINI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 103,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CONDOR },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 8 },
                { tpz.augments.DELAYMINUS, 13 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [105] = {
        mainItem      = tpz.items.DAKINI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 104,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TERROR_FLY },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 10 },
                { tpz.augments.DELAYMINUS, 15 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [106] = {
        mainItem      = tpz.items.DAKINI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 105,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DAWON },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.DAKINI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 9 },
                { tpz.augments.DELAYMINUS, 4 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [181] = {
        mainItem      = tpz.items.PEELER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 100,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.MAHISHA },
        numRequired   = 3,
        rewardItem    = {
            itemId       = tpz.items.RENEGADE,
            itemAugments = {
            },
        },
    },

    [182] = {
        mainItem      = tpz.items.RENEGADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 181,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.AIATAR },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.RENEGADE,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [183] = {
        mainItem      = tpz.items.RENEGADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 182,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.PROVOKER },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.RENEGADE,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [184] = {
        mainItem      = tpz.items.RENEGADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 183,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.URAGNITE },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.ATHAME,
            itemAugments = {
            },
        },
    },

    [185] = {
        mainItem      = tpz.items.ATHAME,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 184,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.ATHAME,
            itemAugments = {
                { tpz.augments.DMG, 12 },
                { tpz.augments.DELAYMINUS, 15 },
            },
        },
    },

    [186] = {
        mainItem      = tpz.items.ATHAME,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 185,
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

    [200] = {
        mainItem      = tpz.items.BREAK_BLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 201,
            [tpz.items.ICE_CLUSTER]         = 211,
            [tpz.items.WIND_CLUSTER]        = 221,
            [tpz.items.EARTH_CLUSTER]       = 231,
            [tpz.items.LIGHTNING_CLUSTER]   = 241,
            [tpz.items.WATER_CLUSTER]       = 251,
            [tpz.items.LIGHT_CLUSTER]       = 261,
            [tpz.items.DARK_CLUSTER]        = 271,
            [tpz.items.FIRE_CRYSTAL]        = 281,
            [tpz.items.ICE_CRYSTAL]         = 291
        },
    },

    [201] = {
        mainItem      = tpz.items.BREAK_BLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 200,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MAGICPOT },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [202] = {
        mainItem      = tpz.items.BRAND_DARCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 201,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.COCKATRICE },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [203] = {
        mainItem      = tpz.items.BRAND_DARCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 202,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MORBOL, tpz.mob.family.MORBOL_NM },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 10 },
                { tpz.augments.STR, 7 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [204] = {
        mainItem      = tpz.items.BRAND_DARCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 203,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TSETSE_FLY },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 12 },
                { tpz.augments.STR, 8 },
                { tpz.augments.ATTK, 20 },
            },
        },
    },

    [205] = {
        mainItem      = tpz.items.BRAND_DARCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 204,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.COCCINELLIDAE },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 14 },
                { tpz.augments.STR, 9 },
                { tpz.augments.ATTK, 25 },
            },
        },
    },

    [206] = {
        mainItem      = tpz.items.BRAND_DARCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 205,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.KRABKATOA },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.BRAND_DARCON,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 16 },
                { tpz.augments.STR, 10 },
                { tpz.augments.ATTK, 30 },
            },
        },
    },

    [281] = {
        mainItem      = tpz.items.BREAK_BLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 200,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DEVIATOR },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SUNBLADE,
            itemAugments = {
            },
        },
    },

    [282] = {
        mainItem      = tpz.items.SUNBLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 281,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.KEREMET },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.SUNBLADE,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [283] = {
        mainItem      = tpz.items.SUNBLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 282,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.GYRE_CARLIN },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.SUNBLADE,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [284] = {
        mainItem      = tpz.items.SUNBLADE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 283,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BUFFALO },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.SALAMAND_SWORD,
            itemAugments = {
            },
        },
    },

    [285] = {
        mainItem      = tpz.items.SALAMAND_SWORD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 284,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.SALAMAND_SWORD,
            itemAugments = {
                { tpz.augments.DMG, 29 },
            },
        },
    },

    [286] = {
        mainItem      = tpz.items.SALAMAND_SWORD,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 285,
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

    [300] = {
        mainItem      = tpz.items.CHOPPER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 301,
            [tpz.items.ICE_CLUSTER]         = 311,
            [tpz.items.WIND_CLUSTER]        = 321,
            [tpz.items.EARTH_CLUSTER]       = 331,
            [tpz.items.LIGHTNING_CLUSTER]   = 341,
            [tpz.items.WATER_CLUSTER]       = 351,
            [tpz.items.LIGHT_CLUSTER]       = 361,
            [tpz.items.DARK_CLUSTER]        = 371,
            [tpz.items.FIRE_CRYSTAL]        = 381,
            [tpz.items.ICE_CRYSTAL]         = 391
        },
    },

    [301] = {
        mainItem      = tpz.items.CHOPPER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 300,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GHOST },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 3 },
            },
        },
    },

    [302] = {
        mainItem      = tpz.items.SKEGGIOLD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 301,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.SLIME, tpz.mob.family.SLIME_NM },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 9 },
                { tpz.augments.DELAYMINUS, 3 },
            },
        },
    },

    [303] = {
        mainItem      = tpz.items.SKEGGIOLD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 302,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WYVERN },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 10 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [304] = {
        mainItem      = tpz.items.SKEGGIOLD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 303,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.GOUGER_BEETLE },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 11 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [305] = {
        mainItem      = tpz.items.SKEGGIOLD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 304,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.GORIB },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 12 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [306] = {
        mainItem      = tpz.items.SKEGGIOLD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 305,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.VERTHANDI },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.SKEGGIOLD,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 13 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [381] = {
        mainItem      = tpz.items.CHOPPER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 300,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.SATIATOR },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SPLINTER,
            itemAugments = {
            },
        },
    },

    [382] = {
        mainItem      = tpz.items.SPLINTER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 381,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.MINOTAUR },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.SPLINTER,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [383] = {
        mainItem      = tpz.items.SPLINTER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 382,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ACHO },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.SPLINTER,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [384] = {
        mainItem      = tpz.items.SPLINTER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 383,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.DIREMITE },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.PUNISHER,
            itemAugments = {
            },
        },
    },

    [385] = {
        mainItem      = tpz.items.PUNISHER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 384,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.PUNISHER,
            itemAugments = {
                { tpz.augments.DMG, 18 },
                { tpz.augments.DELAYMINUS, 15 },
            },
        },
    },

    [386] = {
        mainItem      = tpz.items.PUNISHER,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 385,
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

    [400] = {
        mainItem      = tpz.items.FARMHAND,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 401,
            [tpz.items.ICE_CLUSTER]         = 411,
            [tpz.items.WIND_CLUSTER]        = 421,
            [tpz.items.EARTH_CLUSTER]       = 431,
            [tpz.items.LIGHTNING_CLUSTER]   = 441,
            [tpz.items.WATER_CLUSTER]       = 451,
            [tpz.items.LIGHT_CLUSTER]       = 461,
            [tpz.items.DARK_CLUSTER]        = 471,
            [tpz.items.FIRE_CRYSTAL]        = 481,
            [tpz.items.ICE_CRYSTAL]         = 491
        },
    },

    [401] = {
        mainItem      = tpz.items.FARMHAND,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 400,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.COEURL },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [402] = {
        mainItem      = tpz.items.SEVERANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 401,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.FLAN },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [403] = {
        mainItem      = tpz.items.SEVERANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 402,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MARID },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 16 },
                { tpz.augments.STR, 7 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [404] = {
        mainItem      = tpz.items.SEVERANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 403,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.HISPID_RARAB },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 18 },
                { tpz.augments.STR, 8 },
                { tpz.augments.ATTK, 20 },
            },
        },
    },

    [405] = {
        mainItem      = tpz.items.SEVERANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 404,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.SEUA_PEEK },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 20 },
                { tpz.augments.STR, 9 },
                { tpz.augments.ATTK, 25 },
            },
        },
    },

    [406] = {
        mainItem      = tpz.items.SEVERANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 405,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ORCUS },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.SEVERANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 22 },
                { tpz.augments.STR, 10 },
                { tpz.augments.ATTK, 30 },
            },
        },
    },

    [481] = {
        mainItem      = tpz.items.FARMHAND,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 400,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CEREBRATOR },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.STIGMA,
            itemAugments = {
            },
        },
    },

    [482] = {
        mainItem      = tpz.items.STIGMA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 481,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.HELIODROMOS },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.STIGMA,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [483] = {
        mainItem      = tpz.items.STIGMA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 482,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.FROSTED_SOUL },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.STIGMA,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [484] = {
        mainItem      = tpz.items.STIGMA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 483,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.CORSE },
        numRequired   = 480,
        rewardItem    = {
            itemId       = tpz.items.VENGEANCE,
            itemAugments = {
            },
        },
    },

    [485] = {
        mainItem      = tpz.items.VENGEANCE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 484,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.VENGEANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING_33, 0 },
            },
        },
    },

    [486] = {
        mainItem      = tpz.items.VENGEANCE,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 485,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.VENGEANCE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING_33, 0 },
                { tpz.augments.DELAY, 9 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [500] = {
        mainItem      = tpz.items.RANSEUR,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 501,
            [tpz.items.ICE_CLUSTER]         = 511,
            [tpz.items.WIND_CLUSTER]        = 521,
            [tpz.items.EARTH_CLUSTER]       = 531,
            [tpz.items.LIGHTNING_CLUSTER]   = 541,
            [tpz.items.WATER_CLUSTER]       = 551,
            [tpz.items.LIGHT_CLUSTER]       = 561,
            [tpz.items.DARK_CLUSTER]        = 571,
            [tpz.items.FIRE_CRYSTAL]        = 581,
            [tpz.items.ICE_CRYSTAL]         = 591
        },
    },

    [501] = {
        mainItem      = tpz.items.RANSEUR,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 500,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.OPO_OPO },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [502] = {
        mainItem      = tpz.items.STRIBOG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 501,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.HOUND, tpz.mob.family.HOUND_BOREAL },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [503] = {
        mainItem      = tpz.items.STRIBOG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 502,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.RAM },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 16 },
                { tpz.augments.STR, 7 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [504] = {
        mainItem      = tpz.items.STRIBOG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 503,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CHAMPION_CRAWLER },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 18 },
                { tpz.augments.STR, 8 },
                { tpz.augments.ATTK, 20 },
            },
        },
    },

    [505] = {
        mainItem      = tpz.items.STRIBOG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 504,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.BLOODDRINKER },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 20 },
                { tpz.augments.STR, 9 },
                { tpz.augments.ATTK, 25 },
            },
        },
    },

    [506] = {
        mainItem      = tpz.items.STRIBOG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 505,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LORD_RUTHVEN },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.STRIBOG,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 22 },
                { tpz.augments.STR, 10 },
                { tpz.augments.ATTK, 30 },
            },
        },
    },

    [581] = {
        mainItem      = tpz.items.RANSEUR,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 500,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.COVETER },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments = {
            },
        },
    },

    [582] = {
        mainItem      = tpz.items.COPPERHEAD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 581,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.IMDUGUD },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [583] = {
        mainItem      = tpz.items.COPPERHEAD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 582,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LOBAIS },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [584] = {
        mainItem      = tpz.items.COPPERHEAD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 583,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.ANTLION },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.BRADAMANTE,
            itemAugments = {
            },
        },
    },

    [585] = {
        mainItem      = tpz.items.BRADAMANTE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 584,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.BRADAMANTE,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING_33, 31 },
            },
        },
    },

    [586] = {
        mainItem      = tpz.items.BRADAMANTE,
        tradeItem     = tpz.items.BABY_BLOBDINGNAG,
        type          = 'Items',
        previousTrial = 585,
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

    [600] = {
        mainItem      = tpz.items.KIBASHIRI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 601,
            [tpz.items.ICE_CLUSTER]         = 611,
            [tpz.items.WIND_CLUSTER]        = 621,
            [tpz.items.EARTH_CLUSTER]       = 631,
            [tpz.items.LIGHTNING_CLUSTER]   = 641,
            [tpz.items.WATER_CLUSTER]       = 651,
            [tpz.items.LIGHT_CLUSTER]       = 661,
            [tpz.items.DARK_CLUSTER]        = 671,
            [tpz.items.FIRE_CRYSTAL]        = 681,
            [tpz.items.ICE_CRYSTAL]         = 691
        },
    },

    [601] = {
        mainItem      = tpz.items.KIBASHIRI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 600,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.FUNGUAR, tpz.mob.family.FUNGUAR_ELECTRUMCAP },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 3 },
            },
        },
    },

    [602] = {
        mainItem      = tpz.items.KUINA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 601,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TREANT },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 9 },
                { tpz.augments.DELAYMINUS, 3 },
            },
        },
    },

    [603] = {
        mainItem      = tpz.items.KUINA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 602,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.ZDEI },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 10 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [604] = {
        mainItem      = tpz.items.KUINA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 603,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DURIUMSHELL },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 11 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [605] = {
        mainItem      = tpz.items.KUINA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 604,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DZOAVITS },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 12 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [606] = {
        mainItem      = tpz.items.KUINA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 605,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.VERTHANDI },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.KUINA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 13 },
                { tpz.augments.DELAYMINUS, 3 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [681] = {
        mainItem      = tpz.items.KIBASHIRI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 600,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.COVETER },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.KORURI,
            itemAugments = {
            },
        },
    },

    [682] = {
        mainItem      = tpz.items.KORURI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 681,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.IMDUGUD },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.KORURI,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [683] = {
        mainItem      = tpz.items.KORURI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 682,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LOBAIS },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.KORURI,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [684] = {
        mainItem      = tpz.items.KORURI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 683,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.ANTLION },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.ISATU,
            itemAugments = {
            },
        },
    },

    [685] = {
        mainItem      = tpz.items.ISATU,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 684,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.ISATU,
            itemAugments = {
                { tpz.augments.DMG, 13 },
                { tpz.augments.DELAYMINUS, 15 },
            },
        },
    },

    [686] = {
        mainItem      = tpz.items.ISATU,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 685,
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

    [700] = {
        mainItem      = tpz.items.DONTO,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 701,
            [tpz.items.ICE_CLUSTER]         = 711,
            [tpz.items.WIND_CLUSTER]        = 721,
            [tpz.items.EARTH_CLUSTER]       = 731,
            [tpz.items.LIGHTNING_CLUSTER]   = 741,
            [tpz.items.WATER_CLUSTER]       = 751,
            [tpz.items.LIGHT_CLUSTER]       = 761,
            [tpz.items.DARK_CLUSTER]        = 771,
            [tpz.items.FIRE_CRYSTAL]        = 781,
            [tpz.items.ICE_CRYSTAL]         = 791
        },
    },

    [701] = {
        mainItem      = tpz.items.DONTO,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 700,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WORM, tpz.mob.family.BIGWORM },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [702] = {
        mainItem      = tpz.items.EFUNOTACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 701,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BEE },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [703] = {
        mainItem      = tpz.items.EFUNOTACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 702,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GHRAH_SEA },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 11 },
                { tpz.augments.STR, 7 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [704] = {
        mainItem      = tpz.items.EFUNOTACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 703,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.FROZEN_GHOUL_DRK, tpz.mob.pool.FROZEN_GHOUL_BLM },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 13 },
                { tpz.augments.STR, 8 },
                { tpz.augments.ATTK, 20 },
            },
        },
    },

    [705] = {
        mainItem      = tpz.items.EFUNOTACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 704,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TIPUA },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 15 },
                { tpz.augments.STR, 9 },
                { tpz.augments.ATTK, 25 },
            },
        },
    },

    [706] = {
        mainItem      = tpz.items.EFUNOTACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 705,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.BLOBDINGNAG },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.EFUNOTACHI,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 17 },
                { tpz.augments.STR, 10 },
                { tpz.augments.ATTK, 30 },
            },
        },
    },

    [781] = {
        mainItem      = tpz.items.DONTO,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 700,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DEVIATOR },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments = {
            },
        },
    },

    [782] = {
        mainItem      = tpz.items.SHIRODACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 781,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.SHIELDTRAP },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [783] = {
        mainItem      = tpz.items.SHIRODACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 782,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.BALOR },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [784] = {
        mainItem      = tpz.items.SHIRODACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 783,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.HIPPOGRYPH, tpz.mob.family.HIPPOGRYPH_2 },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.KURODACHI,
            itemAugments = {
            },
        },
    },

    [785] = {
        mainItem      = tpz.items.KURODACHI,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 784,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.KURODACHI,
            itemAugments = {
                { tpz.augments.DMG, 27 },
            },
        },
    },

    [786] = {
        mainItem      = tpz.items.KURODACHI,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 785,
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

    [800] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 801,
            [tpz.items.ICE_CLUSTER]         = 811,
            [tpz.items.WIND_CLUSTER]        = 821,
            [tpz.items.EARTH_CLUSTER]       = 831,
            [tpz.items.LIGHTNING_CLUSTER]   = 841,
            [tpz.items.WATER_CLUSTER]       = 851,
            [tpz.items.LIGHT_CLUSTER]       = 861,
            [tpz.items.DARK_CLUSTER]        = 871,
            [tpz.items.FIRE_CRYSTAL]        = 881,
            [tpz.items.ICE_CRYSTAL]         = 891
        },
    },


    [801] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 800,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.AHRIMAN },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.DELAYMINUS, 5 },
            },
        },
    },

    [802] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 801,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.DOOMED, tpz.mob.family.JNUN },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.DELAYMINUS, 5 },
            },
        },
    },

    [803] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 802,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.EUVHI },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 9 },
                { tpz.augments.DELAYMINUS, 5 },
                { tpz.augments.ADDEFF_FIREDMG_5, 10 },
            },
        },
    },

    [804] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 803,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DRACHENLIZARD },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 11 },
                { tpz.augments.DELAYMINUS, 5 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [805] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 804,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.KERWAN },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 13 },
                { tpz.augments.DELAYMINUS, 5 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [806] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 805,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DAWON },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.INGRIMM,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 15 },
                { tpz.augments.DELAYMINUS, 5 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [861] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 800,
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

    [862] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 861,
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

    [863] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 862,
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

    [864] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 863,
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

    [865] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 864,
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

    [866] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 865,
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

    [867] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 866,
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

    [871] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 800,
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

    [872] = {
        mainItem      = tpz.items.INGRIMM,
        tradeItem     = tpz.items.NONE, 
        type          = 'Kills',
        previousTrial = 871,
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
    -- TODO: Rest of trials, and start adding DARKRES (10-20)

    [881] = {
        mainItem      = tpz.items.STENZ,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 800,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.PROVOKER },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments = {
            },
        },
    },

    [882] = {
        mainItem      = tpz.items.RAGEBLOW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 881,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.UNSTABLE_CLUSTER },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [883] = {
        mainItem      = tpz.items.RAGEBLOW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 882,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CAITHLEANN },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [884] = {
        mainItem      = tpz.items.RAGEBLOW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 883,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.FLYTRAP },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.GOEDENDAG,
            itemAugments = {
            },
        },
    },

    [885] = {
        mainItem      = tpz.items.GOEDENDAG,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 884,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.GOEDENDAG,
            itemAugments = {
                { tpz.augments.DMG, 19 },
            },
        },
    },

    [886] = {
        mainItem      = tpz.items.GOEDENDAG,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 885,
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

    [900] = {
        mainItem      = tpz.items.CROOK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 901,
            [tpz.items.ICE_CLUSTER]         = 911,
            [tpz.items.WIND_CLUSTER]        = 921,
            [tpz.items.EARTH_CLUSTER]       = 931,
            [tpz.items.LIGHTNING_CLUSTER]   = 941,
            [tpz.items.WATER_CLUSTER]       = 951,
            [tpz.items.LIGHT_CLUSTER]       = 961,
            [tpz.items.DARK_CLUSTER]        = 971,
            [tpz.items.FIRE_CRYSTAL]        = 981,
            [tpz.items.ICE_CRYSTAL]         = 991
        },
    },

    [981] = {
        mainItem      = tpz.items.CROOK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 900,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DEVIATOR },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments = {
            },
        },
    },

    [982] = {
        mainItem      = tpz.items.SHILLELAGH,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 981,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.AIATAR },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [983] = {
        mainItem      = tpz.items.SHILLELAGH,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 982,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.INDICH },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [984] = {
        mainItem      = tpz.items.SHILLELAGH,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 983,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.SNOLL },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.DANDA,
            itemAugments = {
            },
        },
    },

    [985] = {
        mainItem      = tpz.items.DANDA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 984,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.DANDA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING_33, 8 },
            },
        },
    },

    [986] = {
        mainItem      = tpz.items.DANDA,
        tradeItem     = tpz.items.ORCUS_MANDIBLE,
        type          = 'Items',
        previousTrial = 985,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.DANDA,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING_33, 8 },
                { tpz.augments.DELAY, 12 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

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
            [tpz.items.DARK_CLUSTER]        = 1271,
            [tpz.items.FIRE_CRYSTAL]        = 1281,
            [tpz.items.ICE_CRYSTAL]         = 1291
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
                { tpz.augments.MAIN_DMG_RATING, 5 },
                { tpz.augments.DELAYMINUS, 10 },
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
                { tpz.augments.MAIN_DMG_RATING, 7 },
                { tpz.augments.DELAYMINUS, 12 },
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
                { tpz.augments.MAIN_DMG_RATING, 8 },
                { tpz.augments.DELAYMINUS, 13 },
                { tpz.augments.ADDEFF_FIREDMG_5, 15 },
                { tpz.augments.STR, 3 },
            },
        },
    },

    [1205] = {
        mainItem      = tpz.items.SOULSABER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1204,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.DICEY_DORCUS },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 10 },
                { tpz.augments.DELAYMINUS, 15 },
                { tpz.augments.STR, 4 },
                { tpz.augments.ATTK, 12 },
            },
        },
    },

    [1206] = {
        mainItem      = tpz.items.SOULSABER,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1205,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ORCUS },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.SOULSABER,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 12 },
                { tpz.augments.DELAYMINUS, 20 },
                { tpz.augments.STR, 5 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [1281] = {
        mainItem      = tpz.items.SIDE_SWORD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1200,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TRES_DUENDES },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments = {
            },
        },
    },

    [1282] = {
        mainItem      = tpz.items.SCHIAVONA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1281,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CARMINE_DOBSONFLY },
        numRequired   = 70,
        rewardItem    = {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [1283] = {
        mainItem      = tpz.items.SCHIAVONA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1282,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ELEL },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [1284] = {
        mainItem      = tpz.items.SCHIAVONA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1283,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.EFT },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.ANTEA,
            itemAugments = {
            },
        },
    },

    [1285] = {
        mainItem      = tpz.items.ANTEA,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1284,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.ANTEA,
            itemAugments = {
                { tpz.augments.DMG, 16 },
                { tpz.augments.DELAYMINUS, 6 },
            },
        },
    },

    [1286] = {
        mainItem      = tpz.items.ANTEA,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 1285,
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

    [1300] = {
        mainItem      = tpz.items.LUMBERJACK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 1301,
            [tpz.items.ICE_CLUSTER]         = 1311,
            [tpz.items.WIND_CLUSTER]        = 1321,
            [tpz.items.EARTH_CLUSTER]       = 1331,
            [tpz.items.LIGHTNING_CLUSTER]   = 1341,
            [tpz.items.WATER_CLUSTER]       = 1351,
            [tpz.items.LIGHT_CLUSTER]       = 1361,
            [tpz.items.DARK_CLUSTER]        = 1371,
            [tpz.items.FIRE_CRYSTAL]        = 1381,
            [tpz.items.ICE_CRYSTAL]         = 1391
        },
    },

    [1301] = {
        mainItem      = tpz.items.LUMBERJACK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1300,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BUGARD },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [1302] = {
        mainItem      = tpz.items.HEPHAESTUS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1301,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.BOMB },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.ATTK, 10 },
            },
        },
    },

    [1303] = {
        mainItem      = tpz.items.HEPHAESTUS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1302,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.WAMOURA },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 16 },
                { tpz.augments.STR, 7 },
                { tpz.augments.ATTK, 15 },
            },
        },
    },

    [1304] = {
        mainItem      = tpz.items.HEPHAESTUS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1303,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.pool.CONDOR },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 18 },
                { tpz.augments.STR, 8 },
                { tpz.augments.ATTK, 20 },
            },
        },
    },

    [1305] = {
        mainItem      = tpz.items.HEPHAESTUS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1304,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.pool.KENDI },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 20 },
                { tpz.augments.STR, 9 },
                { tpz.augments.ATTK, 25 },
            },
        },
    },

    [1306] = {
        mainItem      = tpz.items.HEPHAESTUS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1305,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.pool.BLOBDINGNAG },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.HEPHAESTUS,
            itemAugments = {
                { tpz.augments.MAIN_DMG_RATING, 22 },
                { tpz.augments.STR, 10 },
                { tpz.augments.ATTK, 30 },
            },
        },
    },

    [1381] = {
        mainItem      = tpz.items.LUMBERJACK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1300,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.WAILER },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.SAGARIS,
            itemAugments = {
            },
        },
    },

    [1382] = {
        mainItem      = tpz.items.SAGARIS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1381,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.EBA },
        numRequired   = 3,
        rewardItem    = {
            itemId       = tpz.items.SAGARIS,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [1383] = {
        mainItem      = tpz.items.SAGARIS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1382,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LOBAIS },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.SAGARIS,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [1384] = {
        mainItem      = tpz.items.SAGARIS,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1383,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.MOBLIN, tpz.mob.family.BUGBEAR },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.LUCHTAINE,
            itemAugments = {
            },
        },
    },

    [1385] = {
        mainItem      = tpz.items.LUCHTAINE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1384,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.LUCHTAINE,
            itemAugments = {
                { tpz.augments.DMG, 31 },
            },
        },
    },

    [1386] = {
        mainItem      = tpz.items.LUCHTAINE,
        tradeItem     = tpz.items.RUTHVENS_NAIL,
        type          = 'Items',
        previousTrial = 1385,
        textOffset    = 1,
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.LUCHTAINE,
            itemAugments = {
                { tpz.augments.DMG, 31 },
                { tpz.augments.SPECIAL, tpz.augments.special.OCC_ATTACK_TWICE },
            },
        },
    },

    [1400] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 1401,
            [tpz.items.ICE_CLUSTER]         = 1411,
            [tpz.items.WIND_CLUSTER]        = 1421,
            [tpz.items.EARTH_CLUSTER]       = 1431,
            [tpz.items.LIGHTNING_CLUSTER]   = 1441,
            [tpz.items.WATER_CLUSTER]       = 1451,
            [tpz.items.LIGHT_CLUSTER]       = 1461,
            [tpz.items.DARK_CLUSTER]        = 1471,
            [tpz.items.FIRE_CRYSTAL]        = 1481,
            [tpz.items.ICE_CRYSTAL]         = 1491
        },
    },

    [1401] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1400,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.SCORPION },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [1402] = {
        mainItem      = tpz.items.GYRFALCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1401,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GOLEM },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.RATTK, 10 },
            },
        },
    },

    [1403] = {
        mainItem      = tpz.items.GYRFALCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1402,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GHRAH_SEA },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 15 },
                { tpz.augments.STR, 7 },
                { tpz.augments.RATTK, 15 },
            },
        },
    },

    [1404] = {
        mainItem      = tpz.items.GYRFALCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1403,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.GNOLETRAP },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 17 },
                { tpz.augments.STR, 9 },
                { tpz.augments.RATTK, 20 },
            },
        },
    },

    [1405] = {
        mainItem      = tpz.items.GYRFALCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1404,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.PURUSHAMRIGA },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 19 },
                { tpz.augments.STR, 9 },
                { tpz.augments.RATTK, 25 },
            },
        },
    },

    [1406] = {
        mainItem      = tpz.items.GYRFALCON,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1405,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LORD_RUTHVEN },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.GYRFALCON,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 21 },
                { tpz.augments.STR, 10 },
                { tpz.augments.RATTK, 30 },
            },
        },
    },

    [1481] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1400,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.MAHISHA },
        numRequired   = 3,
        rewardItem    = {
            itemId       = tpz.items.KESTREL,
            itemAugments = {
            },
        },
    },

    [1482] = {
        mainItem      = tpz.items.KESTREL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1481,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.LUAITH },
        numRequired   = 4,
        rewardItem    = {
            itemId       = tpz.items.KESTREL,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [1483] = {
        mainItem      = tpz.items.KESTREL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1482,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CARMINE_DOBSONFLY },
        numRequired   = 70,
        rewardItem    = {
            itemId       = tpz.items.KESTREL,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [1484] = {
        mainItem      = tpz.items.KESTREL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1483,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.DHALMEL },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.GOSHAWK,
            itemAugments = {
            },
        },
    },

    [1485] = {
        mainItem      = tpz.items.GOSHAWK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1484,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.GOSHAWK,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 26 },
                { tpz.augments.RANGED_DELAYMINUS_33, 0 },
            },
        },
    },

    [1486] = {
        mainItem      = tpz.items.SPARROW,
        tradeItem     = tpz.items.KRABKATOA_SHELL,
        type          = 'Items',
        previousTrial = 1485,
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

    [1500] = {
        mainItem      = tpz.items.THUNDERSTICK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 0,
        branches      = {
            [tpz.items.FIRE_CLUSTER]        = 1501,
            [tpz.items.ICE_CLUSTER]         = 1511,
            [tpz.items.WIND_CLUSTER]        = 1521,
            [tpz.items.EARTH_CLUSTER]       = 1531,
            [tpz.items.LIGHTNING_CLUSTER]   = 1541,
            [tpz.items.WATER_CLUSTER]       = 1551,
            [tpz.items.LIGHT_CLUSTER]       = 1561,
            [tpz.items.DARK_CLUSTER]        = 1571,
            [tpz.items.FIRE_CRYSTAL]        = 1581,
            [tpz.items.ICE_CRYSTAL]         = 1591
        },
    },

    [1501] = {
        mainItem      = tpz.items.THUNDERSTICK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1500,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GIANT_BATS },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 250,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.STR, 5 },
            },
        },
    },

    [1502] = {
        mainItem      = tpz.items.HURACAN,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1501,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.DOLL },
        subType       = 'Weather',
        weather       = 'Any',
        numRequired   = 300,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.STR, 6 },
                { tpz.augments.RATTK, 10 },
            },
        },
    },

    [1503] = {
        mainItem      = tpz.items.HURACAN,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1502,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.AERN },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 350,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 15 },
                { tpz.augments.STR, 7 },
                { tpz.augments.RATTK, 15 },
            },
        },
    },

    [1504] = {
        mainItem      = tpz.items.HURACAN,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1503,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.CHAMPION_CRAWLER },
        subType       = 'Weather',
        weather       = tpz.weatherGroup.FIRE,
        day           = tpz.day.FIRESDAY,
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 17 },
                { tpz.augments.STR, 9 },
                { tpz.augments.RATTK, 20 },
            },
        },
    },

    [1505] = {
        mainItem      = tpz.items.HURACAN,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1504,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.RAHU },
        numRequired   = 15,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 19 },
                { tpz.augments.STR, 9 },
                { tpz.augments.RATTK, 25 },
            },
        },
    },

    [1506] = {
        mainItem      = tpz.items.HURACAN,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1505,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.BLOBDINGNAG },
        numRequired   = 25,
        rewardItem    = {
            itemId       = tpz.items.HURACAN,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 13 },
                { tpz.augments.STR, 10 },
                { tpz.augments.RATTK, 30 },
            },
        },
    },

    [1581] = {
        mainItem      = tpz.items.THUNDERSTICK,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1500,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.TRES_DUENDES },
        numRequired   = 5,
        rewardItem    = {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments = {
            },
        },
    },

    [1582] = {
        mainItem      = tpz.items.BLUE_STEEL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1581,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.UNSTABLE_CLUSTER },
        numRequired   = 7,
        rewardItem    = {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments = {
                { tpz.augments.ATTK, 3 },
            },
        },
    },

    [1583] = {
        mainItem      = tpz.items.BLUE_STEEL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1582,
        textOffset    = 1,
        killType      = 'Specific',
        mob           = { tpz.mob.pool.ELEL },
        numRequired   = 10,
        rewardItem    = {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments = {
                { tpz.augments.ATTK, 5 },
            },
        },
    },

    [1584] = {
        mainItem      = tpz.items.BLUE_STEEL,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1583,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.GIANTBIRD, tpz.mob.family.GIANTBIRD_NM },
        numRequired   = 400,
        rewardItem    = {
            itemId       = tpz.items.DRAGONMAW,
            itemAugments = {
            },
        },
    },

    [1585] = {
        mainItem      = tpz.items.DRAGONMAW,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1584,
        textOffset    = 1,
        killType      = 'Species',
        mob           = { tpz.eco.EMPTY },
        numRequired   = 600,
        rewardItem    = {
            itemId       = tpz.items.DRAGONMAW,
            itemAugments = {
                { tpz.augments.RANGED_DMG_RATING, 27 },
                { tpz.augments.RANGED_DELAYMINUS_33, 0 },
            },
        },
    },

    [1586] = {
        mainItem      = tpz.items.DRAGONMAW,
        tradeItem     = tpz.items.EYE_OF_VERTHANDI,
        type          = 'Items',
        previousTrial = 1585,
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.CURE_POTENCY, 2 },
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
                { tpz.augments.CURE_POTENCY, 3 },
                { tpz.augments.ENH_MAGIC_DURATION, 4 },
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
                { tpz.augments.CURE_POTENCY, 4 },
                { tpz.augments.ENH_MAGIC_DURATION, 9 },
                { tpz.augments.ENMITY_MINUS, 2 },
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
                { tpz.augments.CURE_POTENCY, 5 },
                { tpz.augments.ENH_MAGIC_DURATION, 14 },
                { tpz.augments.ENMITY_MINUS, 3 },
                { tpz.augments.MND, 3 },
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
                { tpz.augments.MATT, 2 },
            },
        },
    },

    [1016] = {
        mainItem      = tpz.items.BANE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1015,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.BANE_CAPE,
            itemAugments = {
                { tpz.augments.MATT, 3 },
                { tpz.augments.MACC, 2 },
            },
        },
    },

    [1017] = {
        mainItem      = tpz.items.BANE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1016,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.BANE_CAPE,
            itemAugments = {  
                { tpz.augments.MATT, 4 },
                { tpz.augments.MACC, 3 },
                { tpz.augments.CONSERVE_MP, 4 },
            },
        },
    },

    [1018] = {
        mainItem      = tpz.items.BANE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1017,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.BANE_CAPE,
            itemAugments = {
                { tpz.augments.MATT, 5 },
                { tpz.augments.MACC, 4 },
                { tpz.augments.CONSERVE_MP, 9 },
                { tpz.augments.REGENPOTENCY, 10 },
            },
        },
    },

    [1019] = {
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
                { tpz.augments.MACC, 2 },
            },
        },
    },

    [1020] = {
        mainItem      = tpz.items.GHOSTFYRE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1019,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GHOSTFYRE_CAPE,
            itemAugments = {
                { tpz.augments.MACC, 3 },
                { tpz.augments.ENSPELL_DMG_BONUS, 3 },
            },
        },
    },

    [1021] = {
        mainItem      = tpz.items.GHOSTFYRE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1020,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GHOSTFYRE_CAPE,
            itemAugments = {  
                { tpz.augments.MACC, 4 },
                { tpz.augments.ENSPELL_DMG_BONUS, 4 },
                { tpz.augments.ENH_MAGIC_DURATION, 7 },
            },
        },
    },

    [1022] = {
        mainItem      = tpz.items.GHOSTFYRE_CAPE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1021,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.GHOSTFYRE_CAPE,
            itemAugments = {
                { tpz.augments.MACC, 5 },
                { tpz.augments.ENSPELL_DMG_BONUS, 5 },
                { tpz.augments.ENH_MAGIC_DURATION, 14 },
                { tpz.augments.ACC, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.PET_ATTK_RATTK, 9 },
                -- Pet Acc / Attk / DA / Store TP / Crit / Regain
            },
        },
    },

    [1041] = {
        mainItem      = tpz.items.PASTORALISTS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1040,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.TROLL, tpz.mob.family.TROLLGURFURLUR, tpz.mob.family.TROLL_EXCAVATIONDUTY },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.PASTORALISTS_MANTLE,
            itemAugments = {
                { tpz.augments.PET_ATTK_RATTK, 9 },
                { tpz.augments.PET_ACC_RACC, 9 },
            },
        },
    },

    [1042] = {
        mainItem      = tpz.items.PASTORALISTS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1041,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.LAMIAE, tpz.mob.family.MERROW, tpz.mob.family.MEDUSA },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.PASTORALISTS_MANTLE,
            itemAugments = {
                { tpz.augments.PET_ATTK_RATTK, 11 },
                { tpz.augments.PET_ACC_RACC, 11 },
                { tpz.augments.PET_DOUBLE_ATTACK, 2 },
            },
        },
    },

    [1043] = {
        mainItem      = tpz.items.PASTORALISTS_MANTLE,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        previousTrial = 1042,
        textOffset    = 1,
        killType      = 'Family',
        mob           = { tpz.mob.family.QUTRUB1, tpz.mob.family.QUTRUB2, tpz.mob.family.QUTRUB3 },
        numRequired   = 5000,
        rewardItem    = {
            itemId       = tpz.items.PASTORALISTS_MANTLE,
            itemAugments = {
                { tpz.augments.PET_ATTK_RATTK, 14 },
                { tpz.augments.PET_ACC_RACC, 14 },
                { tpz.augments.PET_DOUBLE_ATTACK, 3 },
                { tpz.augments.PET_HASTE, 2 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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
                { tpz.augments.ATTK, 9 },
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
                { tpz.augments.ATTK, 11 },
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
                { tpz.augments.ATTK, 14 },
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

    [9012] = {
        mainItem      = tpz.items.LONGSWORD,
        tradeItem     = tpz.items.NONE,
        type          = 'Kills',
        subType       = 'Region',
        region        = { tpz.region.VOLLBOW },
        previousTrial = 0,
        textOffset    = 1,
        numRequired   = 1000,
        rewardItem    = {
            itemId       = tpz.items.LONGSWORD,
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
    -- HQ stave trials require elemental Kills
    -- HQ Stave final trial, finish all staves trials then can combine into Chatoyant Staff
    -- Something that requires experience in zilart dungeons
    -- TODO: Stenz dark trials
    -- Use Marids!
    -- Antlions, corse, diremite, buffalo, flytrap, snoll, cluster, hippogryph
}
