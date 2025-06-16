-----------------------------------
-- Magian Trial Data
-----------------------------------
require('scripts/globals/status')
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
tpz.magian.TRIAL_ACTIVE    = 1
tpz.magian.TRIAL_COMPLETED = 2

tpz.magian.trials = {
    [tpz.items.PUGILISTS] = -- Main weapon
    {
        [tpz.items.BABY_BLOBDINGNAG] =  -- Secondary trade
        {
            trial = 1,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.WARGFANGS,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 16 },
                    [2] = { tpz.augments.DELAY_65, 0 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },

        [tpz.items.DAYBREAK_SOUL] =
        {
            trial = 2,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 50,
            rewardItem = {
                itemId = tpz.items.PUGILISTS,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 5 },
                    [2] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_THRICE },
                },
            },
        },
    },

    [tpz.items.PEELER] =
    {
        [tpz.items.EYE_OF_VERTHANDI] =
        {
            trial = 50,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.ATHAME,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 12 },
                    [2] = { tpz.augments.DELAY, 20 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.SIDE_SWORD] =
    {
        [tpz.items.RUTHVENS_NAIL] =
        {
            trial = 100,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.ANTEA,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 16 },
                    [2] = { tpz.augments.DELAY_33, 3 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.BREAK_BLADE] =
    {
        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 101,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.SALAMAND_SWORD,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 29 },
                    [2] = { tpz.augments.DELAY, 23 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.CHOPPER] =
    {
        [tpz.items.BABY_BLOBDINGNAG] =
        {
            trial = 150,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.PUNISHER,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 18 },
                    [2] = { tpz.augments.DELAY, 31 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.LUMBERJACK] =
    {
        [tpz.items.RUTHVENS_NAIL] =
        {
            trial = 200,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.LUCHTAINE,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 31 },
                    [2] = { tpz.augments.DELAY, 9 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.FARMHAND] =
    {
        [tpz.items.EYE_OF_VERTHANDI] =
        {
            trial = 250,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.VENGEANCE,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 32 },
                    [2] = { tpz.augments.DELAY, 9 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.RANSEUR] =
    {
        [tpz.items.BABY_BLOBDINGNAG] =
        {
            trial = 300,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.BRADAMANTE,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 31 },
                    [2] = { tpz.augments.DELAY, 20 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.KIBASHIRI] =
    {
        [tpz.items.RUTHVENS_NAIL] =
        {
            trial = 350,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.ISATU,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 13 },
                    [2] = { tpz.augments.DELAY, 9 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.DONTO] =
    {
        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 400,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.KURODACHI,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 27 },
                    [2] = { tpz.augments.DELAY, 19 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.STENZ] =
    {
        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 450,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.GOEDENDAG,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 19 },
                    [2] = { tpz.augments.DELAY_33, 7 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.CROOK] =
    {
        [tpz.items.ORCUS_MANDIBLE] =
        {
            trial = 500,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.DANDA,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 40 },
                    [2] = { tpz.augments.DELAY, 12 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.SPARROW] =
    {
        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 500,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.GOSHAWK,
                itemAugments = {
                    [1] = { tpz.augments.RANGED_DMG_RATING, 22 },
                    [2] = { tpz.augments.RANGED_DELAY, 23 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },

        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 501,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.KESTREL,
                itemAugments = {
                    [1] = { tpz.augments.RANGED_DMG_RATING, 22 },
                    [2] = { tpz.augments.RANGED_DELAY, 23 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },

        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 502,
            previousTrial = 501,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.KESTREL,
                itemAugments = {
                    [1] = { tpz.augments.RANGED_DMG_RATING, 22 },
                    [2] = { tpz.augments.RANGED_DELAY, 23 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },

        [tpz.items.KRABKATOA_SHELL] =
        {
            trial = 503,
            previousTrial = 502,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.ASTRILD,
                itemAugments = {
                    [1] = { tpz.augments.RANGED_DMG_RATING, 22 },
                    [2] = { tpz.augments.RANGED_DELAY, 23 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    [tpz.items.THUNDERSTICK] =
    {
        [tpz.items.EYE_OF_VERTHANDI] =
        {
            trial = 550,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.DRAGONMAW,
                itemAugments = {
                    [1] = { tpz.augments.RANGED_DMG_RATING, 27 },
                    [2] = { tpz.augments.RANGED_DELAY_65, 5 },
                    [3] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_TWICE },
                },
            },
        },
    },

    --[[ Harp / Shield NYI
    [tpz.items.PYF_HARP] =
    {
        [tpz.items.DAYBREAK_SOUL] =
        {
            trial = 600,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.PUGILISTS,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 5 },
                    [2] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_THRICE },
                },
            },
        },
    },

    [tpz.items.UTILIS_SHIELD] =
    {
        [tpz.items.DAYBREAK_SOUL] =
        {
            trial = 650,
            previousTrial = 0,
            textOffset = 1,
            numRequired = 10,
            rewardItem = {
                itemId = tpz.items.PUGILISTS,
                itemAugments = {
                    [1] = { tpz.augments.DMG, 5 },
                    [2] = { tpz.augments.SPECIAL,  tpz.augments.special.OCC_ATTACK_THRICE },
                },
            },
        },
    },
    ]]--
}
