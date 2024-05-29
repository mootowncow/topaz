-----------------------------------
-- Magian Trial Data
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/status')
-----------------------------------
tpz = tpz or {}
tpz.magian = tpz.magian or {}

-- Trial data requires that all conditions be defined per table if they are to be
-- checked.  Undefined (nil) values for specific keys will be ignored in the applied
-- listener.

-- Available Options to define:
-- tradeItem  : Item required for trades to delivery crate

tpz.magian.trials =
{
    [2] = -- Nocuous Weapon x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PEELER,
        },

        textOffset  = 1,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.RENEGADE,
        },
    },

    [3] = -- Black Triple Stars x3
    {
        previousTrial = 2,
        requiredItem  =
        {
            itemId = tpz.items.RENEGADE,
        },

        textOffset  = 2,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },
    },

    [4] = -- Serra x3
    {
        previousTrial = 3,
        requiredItem  =
        {
            itemId       = tpz.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },

        textOffset  = 3,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },
    },

    [5] = -- Bugbear Strongman x4
    {
        previousTrial = 4,
        requiredItem  =
        {
            itemId       = tpz.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.KARTIKA,
        },
    },

    [6] = -- La Velue x4
    {
        previousTrial = 5,
        requiredItem  =
        {
            itemId       = tpz.items.KARTIKA,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },
    },

    [7] = -- Hovering Hotpot x4
    {
        previousTrial = 6,
        requiredItem  =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack +3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },
    },

    [8] = -- Yacumama x6
    {
        previousTrial = 7,
        requiredItem  =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack +7
            },
        },
    },

    [9] = -- Feuerunke x6
    {
        previousTrial = 8,
        requiredItem  =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack +5
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 4 }, -- DMG: +5
            },
        },
    },

    [10] = -- Arcana x400
    {
        previousTrial = 4,
        requiredItem  =
        {
            itemId       = tpz.items.RENEGADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack +5
            },
        },

        textOffset   = 68,
        defeatMob    = true,
        mobEcosystem = tpz.ecosystem.ARCANA,
        numRequired  = 400,

        rewardItem =
        {
            itemId = tpz.items.ATHAME,
        },
    },

    [11] = -- Hippogryph x300
    {
        previousTrial = 10,
        requiredItem  =
        {
            itemId = tpz.items.ATHAME,
        },

        textOffset  = 69,
        mobFamily   = set{ 140, 141 },
        numRequired = 300,

        rewardItem =
        {
            itemId = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },
    },

    [12] = -- Eye of Verthandi x10
    {
        previousTrial = 11,
        requiredItem  =
        {
            itemId       = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },

        textOffset  = 70,
        tradeItem   = tpz.items.EYE_OF_VERTHANDI,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = {  45, 12 }, -- DMG: +13
                [2] = { 752, 20 }, -- Delay:+21
                [3] = { 912, 10 }, -- Occ. atk. twice
            }
        },
    },

    [13] = -- Amorphs x500
    {
        previousTrial = 11,
        requiredItem  =
        {
            itemId       = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 14 }, -- Delay:-15
            },
        },

        textOffset   = 71,
        defeatMob    = true,
        mobEcosystem = tpz.ecosystem.AMORPH,
        numRequired  = 500,

        rewardItem =
        {
            itemId       = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 29 }, -- Delay:-30
            },
        },
    },

    [14] = -- Plantoids x600
    {
        previousTrial = 13,
        requiredItem  =
        {
            itemId       = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 764, 29 }, -- Delay:-30
            },
        },

        textOffset   = 72,
        defeatMob    = true,
        mobEcosystem = tpz.ecosystem.PLANTOID,
        numRequired  = 600,

        rewardItem =
        {
            itemId       = tpz.items.ATHAME,
            itemAugments =
            {
                [1] = { 757, 7 }, -- Delay:-40
            },
        },
    },

    [68] = -- Tumbling Truffle x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PUGILISTS,
        },

        textOffset  = 4,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SIMIAN_FISTS,
        },
    },

    [69] = -- Helldiver x3
    {
        previousTrial = 68,
        requiredItem  =
        {
            itemId = tpz.items.SIMIAN_FISTS,
        },

        textOffset  = 5,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [70] = -- Orctrap x3
    {
        previousTrial = 69,
        requiredItem  =
        {
            itemId       = tpz.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 6,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [71] = -- Intulo x4
    {
        previousTrial = 70,
        requiredItem  =
        {
            itemId       = tpz.items.SIMIAN_FISTS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
        },
    },

    [72] = -- Ramponneau x4
    {
        previousTrial = 71,
        requiredItem  =
        {
            itemId = tpz.items.MANTIS,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [73] = -- Keeper of Halidom x4
    {
        previousTrial = 72,
        requiredItem  =
        {
            itemId       = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [74] = -- Shoggoth x6
    {
        previousTrial = 73,
        requiredItem  =
        {
            itemId       = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [75] = -- Farruca Fly x6
    {
        previousTrial = 74,
        requiredItem  =
        {
            itemId       = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [82] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PUGILISTS,
        },

        textOffset     = 99,
        dayWeather     = tpz.magianElement.ANY,
        defeatMob      = true,
        mobSuperFamily = set{ 56 },
        numRequired    = 50,

        rewardItem =
        {
            itemId = tpz.items.CATS_CLAWS,
        },
    },

    [150] = -- Serpopard Ishtar x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SIDE_SWORD,
        },

        textOffset  = 7,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SCHIAVONA,
        },
    },

    [151] = -- Tottering Toby x3
    {
        previousTrial = 150,
        requiredItem  =
        {
            itemId = tpz.items.SCHIAVONA,
        },

        textOffset  = 8,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [152] = -- Drooling Daisy x3
    {
        previousTrial = 151,
        requiredItem  =
        {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 9,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [153] = -- Gargantua x4
    {
        previousTrial = 152,
        requiredItem  =
        {
            itemId       = tpz.items.SCHIAVONA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.NOBILIS,
        },
    },

    [154] = -- Megalobugard x4
    {
        previousTrial = 153,
        requiredItem  =
        {
            itemId = tpz.items.NOBILIS,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [155] = -- Ratatoskr x4
    {
        previousTrial = 154,
        requiredItem  =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [156] = -- Jyeshtha x6
    {
        previousTrial = 155,
        requiredItem  =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [157] = -- Capricornus x6
    {
        previousTrial = 156,
        requiredItem  =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [216] = -- Bloodpool Vorax x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BREAK_BLADE,
        },

        textOffset  = 10,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SUNBLADE,
        },
    },

    [217] = -- Golden Bat x3
    {
        previousTrial = 216,
        requiredItem  =
        {
            itemId = tpz.items.SUNBLADE,
        },

        textOffset  = 11,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [218] = -- Slippery Sucker x3
    {
        previousTrial = 217,
        requiredItem  =
        {
            itemId       = tpz.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 12,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [219] = -- Seww the Squidlimbed x4
    {
        previousTrial = 218,
        requiredItem  =
        {
            itemId       = tpz.items.SUNBLADE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.ALBION,
        },
    },

    [220] = -- Ankabut x4
    {
        previousTrial = 219,
        requiredItem  =
        {
            itemId = tpz.items.ALBION,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [221] = -- Okyupete x4
    {
        previousTrial = 220,
        requiredItem  =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [222] = -- Urd x6
    {
        previousTrial = 221,
        requiredItem  =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [223] = -- Lamprey Lord x6
    {
        previousTrial = 222,
        requiredItem  =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [282] = -- Panzer Percival x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHOPPER,
        },

        textOffset  = 13,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SPLINTER,
        },
    },

    [283] = -- Ge'Dha Evileye x3
    {
        previousTrial = 282,
        requiredItem  =
        {
            itemId = tpz.items.SPLINTER,
        },

        textOffset  = 14,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [284] = -- Bashe x3
    {
        previousTrial = 283,
        requiredItem  =
        {
            itemId       = tpz.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 15,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [285] = -- Intulo x4
    {
        previousTrial = 284,
        requiredItem  =
        {
            itemId       = tpz.items.SPLINTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.BONEBITER,
        },
    },

    [286] = -- Ramponneau x4
    {
        previousTrial = 285,
        requiredItem  =
        {
            itemId = tpz.items.BONEBITER,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [287] = -- Keeper of Halidom x4
    {
        previousTrial = 286,
        requiredItem  =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [288] = -- Shoggoth x6
    {
        previousTrial = 287,
        requiredItem  =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [289] = -- Farruca Fly x6
    {
        previousTrial = 288,
        requiredItem  =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },
    },

    [364] = -- Hoo Mjuu the Torrent x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LUMBERJACK,
        },

        textOffset  = 16,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SAGARIS,
        },
    },

    [365] = -- Daggerclaw Dracos x3
    {
        previousTrial = 364,
        requiredItem  =
        {
            itemId = tpz.items.SAGARIS,
        },

        textOffset  = 17,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [366] = -- Namtar x3
    {
        previousTrial = 365,
        requiredItem  =
        {
            itemId       = tpz.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 18,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [367] = -- Gargantua x4
    {
        previousTrial = 366,
        requiredItem  =
        {
            itemId       = tpz.items.SAGARIS,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.BONESPLITTER,
        },
    },

    [368] = -- Megalobugard x4
    {
        previousTrial = 367,
        requiredItem  =
        {
            itemId = tpz.items.BONESPLITTER,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [369] = -- Ratatoskr x4
    {
        previousTrial = 368,
        requiredItem  =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [370] = -- Jyeshtha x6
    {
        previousTrial = 369,
        requiredItem  =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [371] = -- Capricornus x6
    {
        previousTrial = 370,
        requiredItem  =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },
    },

    [430] = -- Slendlix Spindlethumb x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RANSEUR,
        },

        textOffset  = 19,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.COPPERHEAD,
        },
    },

    [431] = -- Herbage Hunter x3
    {
        previousTrial = 430,
        requiredItem  =
        {
            itemId = tpz.items.COPPERHEAD,
        },

        textOffset  = 20,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [432] = -- Kirata x3
    {
        previousTrial = 431,
        requiredItem  =
        {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 21,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [433] = -- Intulo x4
    {
        previousTrial = 432,
        requiredItem  =
        {
            itemId       = tpz.items.COPPERHEAD,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 48,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.OATHKEEPER,
        },
    },

    [434] = -- Ramponneau x4
    {
        previousTrial = 433,
        requiredItem  =
        {
            itemId = tpz.items.OATHKEEPER,
        },

        textOffset  = 49,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [435] = -- Keeper of Halidom x4
    {
        previousTrial = 434,
        requiredItem  =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 50,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [436] = -- Shoggoth x6
    {
        previousTrial = 435,
        requiredItem  =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 51,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [437] = -- Farruca Fly x6
    {
        previousTrial = 436,
        requiredItem  =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 52,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [512] = -- Barbastelle x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FARMHAND,
        },

        textOffset  = 22,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.STIGMA,
        },
    },

    [513] = -- Ah Puch x3
    {
        previousTrial = 512,
        requiredItem  =
        {
            itemId = tpz.items.STIGMA,
        },

        textOffset  = 23,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [514] = -- Donggu x3
    {
        previousTrial = 513,
        requiredItem  =
        {
            itemId       = tpz.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 24,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [515] = -- Bugbear Strongman x4
    {
        previousTrial = 514,
        requiredItem  =
        {
            itemId       = tpz.items.STIGMA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.ULTIMATUM,
        },
    },

    [516] = -- La Velue x4
    {
        previousTrial = 515,
        requiredItem  =
        {
            itemId = tpz.items.ULTIMATUM,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [517] = -- Hovering Hotpot x4
    {
        previousTrial = 516,
        requiredItem  =
        {
            itemId = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [518] = -- Yacumama x6
    {
        previousTrial = 517,
        requiredItem  =
        {
            itemId = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [519] = -- Feuerunke x6
    {
        previousTrial = 518,
        requiredItem  =
        {
            itemId = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [578] = -- Zi'Ghi Boneeater x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KIBASHIRI,
        },

        textOffset  = 25,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.KORURI,
        },
    },

    [579] = -- Lumbering Lambert x3
    {
        previousTrial = 578,
        requiredItem  =
        {
            itemId = tpz.items.KORURI,
        },

        textOffset  = 26,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [580] = -- Deadly Dodo x3
    {
        previousTrial = 579,
        requiredItem  =
        {
            itemId       = tpz.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 27,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [581] = -- Gargantua x4
    {
        previousTrial = 580,
        requiredItem  =
        {
            itemId       = tpz.items.KORURI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 53,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.MOZU,
        },
    },

    [582] = -- Megalobugard x4
    {
        previousTrial = 581,
        requiredItem  =
        {
            itemId = tpz.items.MOZU,
        },

        textOffset  = 54,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [583] = -- Ratatoskr x4
    {
        previousTrial = 582,
        requiredItem  =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 55,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [584] = -- Jyeshtha x6
    {
        previousTrial = 583,
        requiredItem  =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 56,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [585] = -- Capricornus x6
    {
        previousTrial = 584,
        requiredItem  =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 57,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [644] = -- Vuu Puqu the Beguiler x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DONTO,
        },

        textOffset  = 28,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SHIRODACHI,
        },
    },

    [645] = -- Buburimboo x3
    {
        previousTrial = 644,
        requiredItem  =
        {
            itemId = tpz.items.SHIRODACHI,
        },

        textOffset  = 29,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [646] = -- Zo'Khu Blackcloud x3
    {
        previousTrial = 645,
        requiredItem  =
        {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 30,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [647] = -- Seww the Squidlimbed x4
    {
        previousTrial = 646,
        requiredItem  =
        {
            itemId       = tpz.items.SHIRODACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.RADENNOTACHI,
        },
    },

    [648] = -- Ankabut x4
    {
        previousTrial = 647,
        requiredItem  =
        {
            itemId = tpz.items.RADENNOTACHI,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [649] = -- Okyupete x4
    {
        previousTrial = 648,
        requiredItem  =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [650] = -- Urd x6
    {
        previousTrial = 649,
        requiredItem  =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [651] = -- Lamprey Lord x6
    {
        previousTrial = 650,
        requiredItem  =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [710] = -- Stray Mary x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.STENZ,
        },

        textOffset  = 31,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.RAGEBLOW,
        },
    },

    [711] = -- Hawkeyed Dnatbat x3
    {
        previousTrial = 710,
        requiredItem  =
        {
            itemId = tpz.items.RAGEBLOW,
        },

        textOffset  = 32,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [712] = -- Dune Widow x3
    {
        previousTrial = 711,
        requiredItem  =
        {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 33,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [713] = -- Seww the Squidlimbed x4
    {
        previousTrial = 712,
        requiredItem  =
        {
            itemId       = tpz.items.RAGEBLOW,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.CULACULA,
        },
    },

    [714] = -- Ankabut x4
    {
        previousTrial = 713,
        requiredItem  =
        {
            itemId = tpz.items.CULACULA,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [715] = -- Okyupete x4
    {
        previousTrial = 714,
        requiredItem  =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [716] = -- Urd x6
    {
        previousTrial = 715,
        requiredItem  =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [717] = -- Lamprey Lord x6
    {
        previousTrial = 716,
        requiredItem  =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },
    },

    [776] = -- Teporingo x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CROOK,
        },

        textOffset  = 34,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.SHILLELAGH,
        },
    },

    [777] = -- Valkurm Emperor x3
    {
        previousTrial = 776,
        requiredItem  =
        {
            itemId = tpz.items.SHILLELAGH,
        },

        textOffset  = 35,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [778] = -- Hyakume x3
    {
        previousTrial = 777,
        requiredItem  =
        {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 36,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [779] = -- Gloomanita x4
    {
        previousTrial = 778,
        requiredItem  =
        {
            itemId       = tpz.items.SHILLELAGH,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 63,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.SLAINE,
        },
    },

    [780] = -- Mischievous Micholas x4
    {
        previousTrial = 779,
        requiredItem  =
        {
            itemId = tpz.items.SLAINE,
        },

        textOffset  = 64,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },
    },

    [781] = -- Cactuar Cantautor x4
    {
        previousTrial = 780,
        requiredItem  =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 2 }, -- Attack+3
            },
        },

        textOffset  = 65,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },
    },

    [782] = -- Erebus x6
    {
        previousTrial = 781,
        requiredItem  =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 4 }, -- Attack+5
            },
        },

        textOffset  = 66,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },
    },

    [783] = -- Skuld x6
    {
        previousTrial = 782,
        requiredItem  =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 25, 6 }, -- Attack+7
            },
        },

        textOffset  = 67,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },
    },

    [891] = -- Desmodont x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.THUNDERSTICK,
        },

        textOffset  = 37,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.BLUE_STEEL,
        },
    },

    [892] = -- Moo Ouzi the Swiftblade x3
    {
        previousTrial = 891,
        requiredItem  =
        {
            itemId = tpz.items.BLUE_STEEL,
        },

        textOffset  = 38,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [893] = -- Ni'Zho Bladebender x3
    {
        previousTrial = 892,
        requiredItem  =
        {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 39,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [894] = -- Bugbear Strongman x4
    {
        previousTrial = 893,
        requiredItem  =
        {
            itemId       = tpz.items.BLUE_STEEL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 43,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.MAGNATUS,
        },
    },

    [895] = -- La Velue x4
    {
        previousTrial = 894,
        requiredItem  =
        {
            itemId = tpz.items.MAGNATUS,
        },

        textOffset  = 44,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [896] = -- Hovering Hotpot x4
    {
        previousTrial = 895,
        requiredItem  =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 45,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [897] = -- Yacumama x6
    {
        previousTrial = 896,
        requiredItem  =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 46,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },
    },

    [898] = -- Feuerunke x6
    {
        previousTrial = 897,
        requiredItem  =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },

        textOffset  = 47,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },
    },

    [941] = -- Be'Hya Hundredwall x3
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SPARROW,
        },

        textOffset  = 40,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.KESTREL,
        },
    },

    [942] = -- Jolly Green x3
    {
        previousTrial = 941,
        requiredItem  =
        {
            itemId = tpz.items.KESTREL,
        },

        textOffset  = 41,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [943] = -- Trembler Tabitha x3
    {
        previousTrial = 942,
        requiredItem  =
        {
            itemId       = tpz.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 42,
        numRequired = 3,

        rewardItem =
        {
            itemId       = tpz.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [944] = -- Seww the Squidlimbed x4
    {
        previousTrial = 943,
        requiredItem  =
        {
            itemId       = tpz.items.KESTREL,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 58,
        numRequired = 4,

        rewardItem =
        {
            itemId = tpz.items.ASTRILD,
        },
    },

    [945] = -- Ankabut x4
    {
        previousTrial = 944,
        requiredItem  =
        {
            itemId = tpz.items.ASTRILD,
        },

        textOffset  = 59,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },
    },

    [946] = -- Okyupete x4
    {
        previousTrial = 945,
        requiredItem  =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 2 }, -- Rng.Atk.+3
            },
        },

        textOffset  = 60,
        numRequired = 4,

        rewardItem =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },
    },

    [947] = -- Urd x6
    {
        previousTrial = 946,
        requiredItem  =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 4 }, -- Rng.Atk.+5
            },
        },

        textOffset  = 61,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },
    },

    [948] = -- Lamprey Lord x6
    {
        previousTrial = 947,
        requiredItem  =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 29, 6 }, -- Rng.Atk.+7
            },
        },

        textOffset  = 62,
        numRequired = 6,

        rewardItem =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },
    },

    [991] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU,
        },

        textOffset     = 349,
        defeatMob      = false, -- NOTE: This is a sub-requirement of useWeaponskill
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.MERCY_STROKE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },
    },

    [992] =
    {
        previousTrial = 991,
        requiredItem  =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },

        textOffset     = 350,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.MERCY_STROKE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1003] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI,
        },

        textOffset     = 357,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.FINAL_HEAVEN,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1004] =
    {
        previousTrial = 1003,
        requiredItem  =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 358,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.FINAL_HEAVEN,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },
    },

    [1012] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR,
        },

        textOffset     = 363,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.KNIGHTS_OF_ROUND,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },
    },

    [1013] =
    {
        previousTrial = 1012,
        requiredItem  =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },

        textOffset     = 364,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.KNIGHTS_OF_ROUND,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1024] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK,
        },

        textOffset     = 371,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.SCOURGE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1025] =
    {
        previousTrial = 1024,
        requiredItem  =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 372,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.SCOURGE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },
    },

    [1027] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER,
        },

        textOffset     = 373,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.ONSLAUGHT,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1028] =
    {
        previousTrial = 1027,
        requiredItem  =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 374,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.ONSLAUGHT,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },
    },

    [1033] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA,
        },

        textOffset     = 377,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.METATRON_TORMENT,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1034] =
    {
        previousTrial = 1033,
        requiredItem  =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 378,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.METATRON_TORMENT,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },
    },

    [1039] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR,
        },

        textOffset     = 381,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.GEIRSKOGUL,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1040] =
    {
        previousTrial = 1039,
        requiredItem  =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 382,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.GEIRSKOGUL,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },
    },

    [1045] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE,
        },

        textOffset     = 385,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.CATASTROPHE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1046] =
    {
        previousTrial = 1045,
        requiredItem  =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 386,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.CATASTROPHE,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },
    },

    [1051] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU,
        },

        textOffset     = 389,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.BLADE_METSU,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },
    },

    [1052] =
    {
        previousTrial = 1051,
        requiredItem  =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 0 }, -- DMG:+1
            },
        },

        textOffset     = 390,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.BLADE_METSU,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1057] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO,
        },

        textOffset     = 393,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.TACHI_KAITEN,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1058] =
    {
        previousTrial = 1057,
        requiredItem  =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 394,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.TACHI_KAITEN,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 4 }, -- DMG:+5
            },
        },
    },

    [1063] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR,
        },

        textOffset     = 397,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.RANDGRITH,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },
    },

    [1064] =
    {
        previousTrial = 1063,
        requiredItem  =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 398,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.RANDGRITH,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 7 }, -- DMG:+8
            },
        },
    },

    [1069] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM,
        },

        textOffset     = 401,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.GATE_OF_TARTARUS,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 3 }, -- DMG:+4
            },
        },
    },

    [1070] =
    {
        previousTrial = 1069,
        requiredItem  =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 3 }, -- DMG:+4
            },
        },

        textOffset     = 402,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.GATE_OF_TARTARUS,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 9 }, -- DMG:+10
            },
        },
    },

    [1081] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR,
        },

        textOffset     = 409,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.CORONACH,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 1 }, -- DMG:+2 (Ranged)
            },
        },
    },

    [1082] =
    {
        previousTrial = 1081,
        requiredItem  =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 1 }, -- DMG:+2 (Ranged)
            },
        },

        textOffset     = 410,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.CORONACH,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 5 }, -- DMG:+6 (Ranged)
            },
        },
    },

    [1090] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI,
        },

        textOffset     = 415,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.NAMAS_ARROW,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 1 }, -- DMG:+2 (Ranged)
            },
        },
    },

    [1091] =
    {
        previousTrial = 1090,
        requiredItem  =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 1 }, -- DMG:+2 (Ranged)
            },
        },

        textOffset     = 416,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.NAMAS_ARROW,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 4 }, -- DMG:+5 (Ranged)
            },
        },
    },

    [1092] = -- Tammuz x8
    {
        previousTrial = 9,
        requiredItem  =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 4 }, -- DMG:+5
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.KARTIKA,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },
    },

    [1138] = -- Chesma x8
    {
        previousTrial = 75,
        requiredItem  =
        {
            itemId       = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1139] =
    {
        previousTrial = 1138,
        requiredItem  =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },

        textOffset  = 70,
        tradeItem   = tpz.items.TWO_LEAF_CHLORIS_BUD,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA,
        },
    },

    [1140] =
    {
        previousTrial = 1138,
        requiredItem  =
        {
            itemId = tpz.items.MANTIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },

        textOffset  = 70,
        tradeItem   = tpz.items.COIN_OF_ADVANCEMENT,
        numRequired = 15,

        rewardItem =
        {
            itemId = tpz.items.REVENANT_FISTS,
        },
    },

    [1200] = -- Tammuz x8
    {
        previousTrial = 156,
        requiredItem  =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.NOBILIS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1246] = -- Chesma x8
    {
        previousTrial = 223,
        requiredItem  =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.ALBION,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [1292] = -- Tammuz x8
    {
        previousTrial = 289,
        requiredItem  =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 5 }, -- DMG:+6
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.BONEBITER,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1354] = -- Chesma x8
    {
        previousTrial = 371,
        requiredItem  =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.BONESPLITTER,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },
    },

    [1400] = -- Chesma x8
    {
        previousTrial = 437,
        requiredItem  =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.OATHKEEPER,
            itemAugments =
            {
                [1] = { 45, 13 }, -- DMG:+14
            },
        },
    },

    [1462] = -- Tammuz x8
    {
        previousTrial = 519,
        requiredItem  =
        {
            itemId = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.ULTIMATUM,
            itemAugments =
            {
                [1] = { 45, 13 }, -- DMG:+14
            },
        },
    },

    [1508] = -- Tammuz x8
    {
        previousTrial = 585,
        requiredItem  =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.MOZU,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1554] = -- Chesma x8
    {
        previousTrial = 651,
        requiredItem  =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.RADENNOTACHI,
            itemAugments =
            {
                [1] = { 45, 11 }, -- DMG:+12
            },
        },
    },

    [1600] = -- Tammuz x8
    {
        previousTrial = 717,
        requiredItem  =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.CULACULA,
            itemAugments =
            {
                [1] = { 45, 15 }, -- DMG:+16
            },
        },
    },

    [1646] = -- Chesma x8
    {
        previousTrial = 783,
        requiredItem  =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 12 }, -- DMG:+13
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.SLAINE,
            itemAugments =
            {
                [1] = { 45, 14 }, -- DMG:+15
            },
        },
    },

    [1758] = -- Tammuz x8
    {
        previousTrial = 898,
        requiredItem  =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 6 }, -- DMG:+7
            },
        },

        textOffset  = 417,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.MAGNATUS,
            itemAugments =
            {
                [1] = { 45, 7 }, -- DMG:+8
            },
        },
    },

    [1783] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ANARCHY,
        },

        textOffset     = 768,
        defeatMob      = false,
        useWeaponskill = tpz.weaponskill.HOT_SHOT,
        numRequired    = 100,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  0 }, -- DMG:+1 (Ranged)
                [2] = { 1076, 1 }, -- Hot Shot: DMG:+10%
            },
        },
    },

    [1784] =
    {
        previousTrial = 1783,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  0 }, -- DMG:+1 (Ranged)
                [2] = { 1076, 1 }, -- Hot Shot: DMG:+10%
            },
        },

        textOffset     = 769,
        defeatMob      = false,
        useWeaponskill = tpz.weaponskill.SPLIT_SHOT,
        numRequired    = 200,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  2 }, -- DMG:+3 (Ranged)
                [2] = { 1077, 1 }, -- Split Shot: DMG:+10%
            },
        },
    },

    [1785] =
    {
        previousTrial = 1784,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  2 }, -- DMG:+3 (Ranged)
                [2] = { 1077, 1 }, -- Split Shot: DMG:+10%
            },
        },

        textOffset     = 770,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.SNIPER_SHOT,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  4 }, -- DMG:+5 (Ranged)
                [2] = { 1078, 1 }, -- Sniper Shot: DMG:+10%
            },
        },
    },

    [1786] =
    {
        previousTrial = 1785,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  4 }, -- DMG:+5 (Ranged)
                [2] = { 1078, 1 }, -- Sniper Shot: DMG:+10%
            },
        },

        textOffset     = 771,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.DETONATOR,
        numRequired    = 500,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  9 }, -- DMG:+10 (Ranged)
                [2] = { 1079, 1 }, -- Detonator: DMG:+10%
            },
        },
    },

    [1787] =
    {
        previousTrial = 1785,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  4 }, -- DMG:+5 (Ranged)
                [2] = { 1078, 1 }, -- Sniper Shot: DMG:+10%
            },
        },

        textOffset     = 788,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = set{
            tpz.weaponskill.HOT_SHOT,
            tpz.weaponskill.SPLIT_SHOT,
            tpz.weaponskill.SNIPER_SHOT,
            tpz.weaponskill.SLUG_SHOT,
            tpz.weaponskill.BLAST_SHOT,
            tpz.weaponskill.HEAVY_SHOT,
            tpz.weaponskill.DETONATOR,
            tpz.weaponskill.CORONACH,
            tpz.weaponskill.TRUEFLIGHT,
            tpz.weaponskill.LEADEN_SALUTE,
            tpz.weaponskill.NUMBING_SHOT,
            tpz.weaponskill.WILDFIRE,
            tpz.weaponskill.LAST_STAND,
            tpz.weaponskill.TERMINUS,
        },

        numRequired = 800,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746, 6 }, -- DMG:+7 (Ranged)
                [2] = { 142, 7 }, -- "Store TP"+8
            },
        },
    },

    [1788] = -- Chesma x8
    {
        previousTrial = 948,
        requiredItem  =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 9 }, -- DMG:+10
            },
        },

        textOffset  = 418,
        numRequired = 8,

        rewardItem =
        {
            itemId       = tpz.items.ASTRILD,
            itemAugments =
            {
                [1] = { 45, 10 }, -- DMG:+11
            },
        },
    },

    [1818] =
    {
        previousTrial = 992,
        requiredItem  =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 652,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.MERCY_STROKE,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1819] =
    {
        previousTrial = 1818,
        requiredItem  =
        {
            itemId       = tpz.items.MANDAU,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 653,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.MERCY_STROKE,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_80,
        },
    },

    [1826] =
    {
        previousTrial = 1004,
        requiredItem  =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },

        textOffset     = 358,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.FINAL_HEAVEN,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 7 }, -- DMG:+8
            },
        },
    },

    [1827] =
    {
        previousTrial = 1826,
        requiredItem  =
        {
            itemId       = tpz.items.SPHARAI,
            itemAugments =
            {
                [1] = { 740, 7 },
            },
        },

        textOffset     = 661,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.FINAL_HEAVEN,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_80,
        },
    },

    [1832] =
    {
        previousTrial = 1013,
        requiredItem  =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 1 }, -- DMG:+2
            },
        },

        textOffset     = 666,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.KNIGHTS_OF_ROUND,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },
    },

    [1833] =
    {
        previousTrial = 1832,
        requiredItem  =
        {
            itemId       = tpz.items.EXCALIBUR,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 667,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.DRAGON,
        useWeaponskill = tpz.weaponskill.KNIGHTS_OF_ROUND,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_80,
        },
    },

    [1840] =
    {
        previousTrial = 1025,
        requiredItem  =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },

        textOffset     = 674,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.SCOURGE,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 9 }, -- DMG:+10
            },
        },
    },

    [1841] =
    {
        previousTrial = 1840,
        requiredItem  =
        {
            itemId       = tpz.items.RAGNAROK,
            itemAugments =
            {
                [1] = { 740, 9 }, -- DMG:+10
            },
        },

        textOffset     = 675,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.SCOURGE,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_80,
        },
    },

    [1842] =
    {
        previousTrial = 1028,
        requiredItem  =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },

        textOffset     = 676,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.ONSLAUGHT,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },
    },

    [1843] =
    {
        previousTrial = 1842,
        requiredItem  =
        {
            itemId       = tpz.items.GUTTLER,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },

        textOffset     = 677,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.ONSLAUGHT,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_80,
        },
    },

    [1846] =
    {
        previousTrial = 1034,
        requiredItem  =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },

        textOffset     = 680,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.METATRON_TORMENT,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },
    },

    [1847] =
    {
        previousTrial = 1846,
        requiredItem  =
        {
            itemId       = tpz.items.BRAVURA,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },

        textOffset     = 681,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.METATRON_TORMENT,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_80,
        },
    },

    [1850] =
    {
        previousTrial = 1040,
        requiredItem  =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },

        textOffset     = 684,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.GEIRSKOGUL,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },
    },

    [1851] =
    {
        previousTrial = 1850,
        requiredItem  =
        {
            itemId       = tpz.items.GUNGNIR,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },

        textOffset     = 685,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.GEIRSKOGUL,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_80,
        },
    },

    [1854] =
    {
        previousTrial = 1046,
        requiredItem  =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 6 }, -- DMG:+7
            },
        },

        textOffset     = 688,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.CATASTROPHE,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },
    },

    [1855] =
    {
        previousTrial = 1854,
        requiredItem  =
        {
            itemId       = tpz.items.APOCALYPSE,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },

        textOffset     = 689,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.CATASTROPHE,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_80,
        },
    },

    [1858] =
    {
        previousTrial = 1052,
        requiredItem  =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 2 }, -- DMG:+3
            },
        },

        textOffset     = 692,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.BLADE_METSU,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 3 }, -- DMG:+4
            },
        },
    },

    [1859] =
    {
        previousTrial = 1858,
        requiredItem  =
        {
            itemId       = tpz.items.KIKOKU,
            itemAugments =
            {
                [1] = { 740, 3 }, -- DMG:+4
            },
        },

        textOffset     = 693,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.BLADE_METSU,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_80,
        },
    },

    [1862] =
    {
        previousTrial = 1058,
        requiredItem  =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 4 }, -- DMG:+5
            },
        },

        textOffset     = 696,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.TACHI_KAITEN,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },
    },

    [1863] =
    {
        previousTrial = 1862,
        requiredItem  =
        {
            itemId       = tpz.items.AMANOMURAKUMO,
            itemAugments =
            {
                [1] = { 740, 5 }, -- DMG:+6
            },
        },

        textOffset     = 697,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.TACHI_KAITEN,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_80,
        },
    },

    [1866] =
    {
        previousTrial = 1064,
        requiredItem  =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 7 }, -- DMG:+8
            },
        },

        textOffset     = 700,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AMORPH,
        useWeaponskill = tpz.weaponskill.RANDGRITH,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },
    },

    [1867] =
    {
        previousTrial = 1866,
        requiredItem  =
        {
            itemId       = tpz.items.MJOLLNIR,
            itemAugments =
            {
                [1] = { 740, 8 }, -- DMG:+9
            },
        },

        textOffset     = 701,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.RANDGRITH,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_80,
        },
    },

    [1870] =
    {
        previousTrial = 1070,
        requiredItem  =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 9 }, -- DMG:+10
            },
        },

        textOffset     = 704,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.GATE_OF_TARTARUS,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 11 }, -- DMG:+12
            },
        },
    },

    [1871] =
    {
        previousTrial = 1870,
        requiredItem  =
        {
            itemId       = tpz.items.CLAUSTRUM,
            itemAugments =
            {
                [1] = { 740, 11 }, -- DMG:+12
            },
        },

        textOffset     = 705,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.GATE_OF_TARTARUS,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_80,
        },
    },

    [1878] =
    {
        previousTrial = 1082,
        requiredItem  =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 5 }, -- DMG:+6 (Ranged)
            },
        },

        textOffset     = 712,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.CORONACH,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 7 }, -- DMG:+8 (Ranged)
            },
        },
    },

    [1879] =
    {
        previousTrial = 1878,
        requiredItem  =
        {
            itemId       = tpz.items.ANNIHILATOR,
            itemAugments =
            {
                [1] = { 746, 7 }, -- DMG:+8 (Ranged)
            },
        },

        textOffset     = 713,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.CORONACH,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_80,
        },
    },

    [1884] =
    {
        previousTrial = 1091,
        requiredItem  =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 4 }, -- DMG:+5 (Ranged)
            },
        },

        textOffset     = 718,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = tpz.weaponskill.NAMAS_ARROW,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 7 }, -- DMG:+8 (Ranged)
            },
        },
    },

    [1885] =
    {
        previousTrial = 1884,
        requiredItem  =
        {
            itemId       = tpz.items.YOICHINOYUMI,
            itemAugments =
            {
                [1] = { 746, 7 }, -- DMG:+8 (Ranged)
            },
        },

        textOffset     = 719,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.NAMAS_ARROW,
        numRequired    = 300,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_80,
        },
    },

    [1909] =
    {
        previousTrial = 1139,
        requiredItem  =
        {
            itemId = tpz.items.VERETHRAGNA,
        },

        textOffset  = 70,
        tradeItem   = tpz.items.ULHUADSHIS_FANG,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA_85,
        },
    },

    [2247] =
    {
        previousTrial = 1786,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746,  9 }, -- DMG:+10 (Ranged)
                [2] = { 1079, 1 }, -- Detonator: DMG:+10%
            },
        },

        textOffset     = 995,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.DETONATOR,
        numRequired    = 300,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY_P1,
            itemAugments =
            {
                [1] = { 327,  9 }, -- Weapon Skill:DMG:+10%
            },
        },
    },

    [2248] =
    {
        previousTrial = 1787,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY,
            itemAugments =
            {
                [1] = { 746, 6 }, -- DMG:+7 (Ranged)
                [2] = { 142, 7 }, -- "Store TP"+8
            },
        },

        textOffset     = 788,
        defeatMob      = false,
        mobEcosystem   = tpz.ecosystem.LIZARD,
        useWeaponskill = set{
            tpz.weaponskill.HOT_SHOT,
            tpz.weaponskill.SPLIT_SHOT,
            tpz.weaponskill.SNIPER_SHOT,
            tpz.weaponskill.SLUG_SHOT,
            tpz.weaponskill.BLAST_SHOT,
            tpz.weaponskill.HEAVY_SHOT,
            tpz.weaponskill.DETONATOR,
            tpz.weaponskill.CORONACH,
            tpz.weaponskill.TRUEFLIGHT,
            tpz.weaponskill.LEADEN_SALUTE,
            tpz.weaponskill.NUMBING_SHOT,
            tpz.weaponskill.WILDFIRE,
            tpz.weaponskill.LAST_STAND,
            tpz.weaponskill.TERMINUS,
        },

        numRequired = 800,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY_P1,
            itemAugments =
            {
                [1] = { 142, 12 }, -- "Store TP"+13
            },
        },
    },

    [2249] =
    {
        previousTrial = 1819,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU_80,
        },

        textOffset     = 949,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.DRAGON,
        useWeaponskill = tpz.weaponskill.MERCY_STROKE,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_85,
        },
    },

    [2253] =
    {
        previousTrial = 1827,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI_80,
        },

        textOffset     = 953,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.FINAL_HEAVEN,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_85,
        },
    },

    [2256] =
    {
        previousTrial = 1833,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR_80,
        },

        textOffset     = 956,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.KNIGHTS_OF_ROUND,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_85,
        },
    },

    [2260] =
    {
        previousTrial = 1841,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK_80,
        },

        textOffset     = 960,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.ARCANA,
        useWeaponskill = tpz.weaponskill.SCOURGE,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_85,
        },
    },

    [2261] =
    {
        previousTrial = 1843,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER_80,
        },

        textOffset     = 961,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.ONSLAUGHT,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_85,
        },
    },

    [2263] =
    {
        previousTrial = 1847,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA_80,
        },

        textOffset     = 963,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.DRAGON,
        useWeaponskill = tpz.weaponskill.METATRON_TORMENT,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_85,
        },
    },

    [2265] =
    {
        previousTrial = 1855,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE_80,
        },

        textOffset     = 967,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BEAST,
        useWeaponskill = tpz.weaponskill.CATASTROPHE,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_85,
        },
    },

    [2267] =
    {
        previousTrial = 1851,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR_80,
        },

        textOffset     = 965,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.GEIRSKOGUL,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_85,
        },
    },

    [2269] =
    {
        previousTrial = 1859,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU_80,
        },

        textOffset     = 969,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.BLADE_METSU,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_85,
        },
    },

    [2271] =
    {
        previousTrial = 1863,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO_80,
        },

        textOffset     = 971,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.AQUAN,
        useWeaponskill = tpz.weaponskill.TACHI_KAITEN,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_85,
        },
    },

    [2273] =
    {
        previousTrial = 1867,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR_80,
        },

        textOffset     = 973,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.BIRD,
        useWeaponskill = tpz.weaponskill.RANDGRITH,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_85,
        },
    },

    [2275] =
    {
        previousTrial = 1871,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM_80,
        },

        textOffset     = 975,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = tpz.weaponskill.GATE_OF_TARTARUS,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_85,
        },
    },

    [2279] =
    {
        previousTrial = 1885,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI_80,
        },

        textOffset     = 982,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.VERMIN,
        useWeaponskill = tpz.weaponskill.NAMAS_ARROW,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_85,
        },
    },

    [2280] =
    {
        previousTrial = 1879,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR_80,
        },

        textOffset     = 979,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = tpz.weaponskill.CORONACH,
        numRequired    = 400,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_85,
        },
    },

    [2307] =
    {
        previousTrial = 1909,
        requiredItem  =
        {
            itemId = tpz.items.VERETHRAGNA_85,
        },

        textOffset  = 70,
        tradeItem   = tpz.items.DRAGUAS_SCALE,
        numRequired = 75,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA_90,
        },
    },

    [2660] =
    {
        previousTrial = 2249,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU_85,
        },

        textOffset  = 1085,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_90,
        },
    },

    [2657] =
    {
        previousTrial = 2247,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY_P1,
            itemAugments =
            {
                [1] = { 327, 9 }, -- Weapon Skill:DMG:+10%
            },
        },

        textOffset     = 1101,
        defeatMob      = true,
        mobEcosystem   = tpz.ecosystem.PLANTOID,
        useWeaponskill = set{
            tpz.weaponskill.HOT_SHOT,
            tpz.weaponskill.SPLIT_SHOT,
            tpz.weaponskill.SNIPER_SHOT,
            tpz.weaponskill.SLUG_SHOT,
            tpz.weaponskill.BLAST_SHOT,
            tpz.weaponskill.HEAVY_SHOT,
            tpz.weaponskill.DETONATOR,
            tpz.weaponskill.CORONACH,
            tpz.weaponskill.TRUEFLIGHT,
            tpz.weaponskill.LEADEN_SALUTE,
            tpz.weaponskill.NUMBING_SHOT,
            tpz.weaponskill.WILDFIRE,
            tpz.weaponskill.LAST_STAND,
            tpz.weaponskill.TERMINUS,
        },

        numRequired = 300,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY_P2,
            itemAugments =
            {
                [1] = { 746, 1 }, -- DMG:+2 (Ranged)
                [2] = { 327, 9 }, -- Weapon Skill:DMG:+10%
            },
        },
    },

    [2658] =
    {
        previousTrial = 2247,
        requiredItem  =
        {
            itemId       = tpz.items.ANARCHY_P1,
            itemAugments =
            {
                [1] = { 327, 9 }, -- Weapon Skill:DMG:+10%
            },
        },

        textOffset     = 1115,
        defeatMob      = false,
        minDamage      = 400,
        mobEcosystem   = tpz.ecosystem.UNDEAD,
        useWeaponskill = set{
            tpz.weaponskill.HOT_SHOT,
            tpz.weaponskill.SPLIT_SHOT,
            tpz.weaponskill.SNIPER_SHOT,
            tpz.weaponskill.SLUG_SHOT,
            tpz.weaponskill.BLAST_SHOT,
            tpz.weaponskill.HEAVY_SHOT,
            tpz.weaponskill.DETONATOR,
            tpz.weaponskill.CORONACH,
            tpz.weaponskill.TRUEFLIGHT,
            tpz.weaponskill.LEADEN_SALUTE,
            tpz.weaponskill.NUMBING_SHOT,
            tpz.weaponskill.WILDFIRE,
            tpz.weaponskill.LAST_STAND,
            tpz.weaponskill.TERMINUS,
        },

        numRequired = 500,

        rewardItem =
        {
            itemId       = tpz.items.ANARCHY_P2,
            itemAugments =
            {
                [1] = { 761, 27 }, -- Delay:+60 (Ranged)
                [2] = { 353, 19 }, -- TP Bonus +1000
            },
        },
    },

    [2664] =
    {
        previousTrial = 2253,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI_85,
        },

        textOffset  = 1083,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_90,
        },
    },

    [2667] =
    {
        previousTrial = 2256,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR_85,
        },

        textOffset  = 1084,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_90,
        },
    },

    [2671] =
    {
        previousTrial = 2260,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK_85,
        },

        textOffset  = 1084,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_90,
        },
    },

    [2672] =
    {
        previousTrial = 2261,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER_85,
        },

        textOffset  = 1082,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_90,
        },
    },

    [2674] =
    {
        previousTrial = 2263,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA_85,
        },

        textOffset  = 1084,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_90,
        },
    },

    [2676] =
    {
        previousTrial = 2265,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE_85,
        },

        textOffset  = 1081,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_90,
        },
    },

    [2678] =
    {
        previousTrial = 2267,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR_85,
        },

        textOffset  = 1082,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_90,
        },
    },

    [2680] =
    {
        previousTrial = 2269,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU_85,
        },

        textOffset  = 1083,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_90,
        },
    },

    [2682] =
    {
        previousTrial = 2271,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO_85,
        },

        textOffset  = 1081,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_90,
        },
    },

    [2684] =
    {
        previousTrial = 2273,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR_85,
        },

        textOffset  = 1085,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_90,
        },
    },

    [2686] =
    {
        previousTrial = 2275,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM_85,
        },

        textOffset  = 1082,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_90,
        },
    },

    [2690] =
    {
        previousTrial = 2279,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI_85,
        },

        textOffset  = 1081,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_90,
        },
    },

    [2691] =
    {
        previousTrial = 2280,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR_85,
        },

        textOffset  = 1083,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_90,
        },
    },

    [2713] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN,
        },

        textOffset  = 1131,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_80,
        },
    },

    [2714] =
    {
        previousTrial = 2713,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN_80,
        },

        textOffset  = 1133,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_85,
        },
    },

    [2715] =
    {
        previousTrial = 2714,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN_85,
        },

        textOffset  = 1085,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_90,
        },
    },

    [2740] =
    {
        previousTrial = 2307,
        requiredItem  =
        {
            itemId = tpz.items.VERETHRAGNA_90,
        },

        textOffset  = 70,
        tradeItem   = tpz.items.PLATE_OF_HEAVY_METAL,
        numRequired = 1500,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA_95,
        },
    },

    [3093] =
    {
        previousTrial = 2660,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU_90,
        },

        textOffset  = 1178,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_95,
        },
    },

    [3097] =
    {
        previousTrial = 2664,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI_90,
        },

        textOffset  = 1177,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_95,
        },
    },

    [3100] =
    {
        previousTrial = 2667,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR_90,
        },

        textOffset  = 1179,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_95,
        },
    },

    [3104] =
    {
        previousTrial = 2671,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK_90,
        },

        textOffset  = 1180,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_95,
        },
    },

    [3105] =
    {
        previousTrial = 2672,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER_90,
        },

        textOffset  = 1181,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_95,
        },
    },

    [3107] =
    {
        previousTrial = 2674,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA_90,
        },

        textOffset  = 1182,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_95,
        },
    },

    [3109] =
    {
        previousTrial = 2676,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE_90,
        },

        textOffset  = 1184,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_95,
        },
    },

    [3111] =
    {
        previousTrial = 2678,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR_90,
        },

        textOffset  = 1183,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_95,
        },
    },

    [3113] =
    {
        previousTrial = 2680,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU_90,
        },

        textOffset  = 1185,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_95,
        },
    },

    [3115] =
    {
        previousTrial = 2682,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO_90,
        },

        textOffset  = 1186,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_95,
        },
    },

    [3117] =
    {
        previousTrial = 2684,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR_90,
        },

        textOffset  = 1187,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_95,
        },
    },

    [3119] =
    {
        previousTrial = 2686,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM_90,
        },

        textOffset  = 1188,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_95,
        },
    },

    [3123] =
    {
        previousTrial = 2690,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI_90,
        },

        textOffset  = 1189,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_95,
        },
    },

    [3124] =
    {
        previousTrial = 2691,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR_90,
        },

        textOffset  = 1190,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_95,
        },
    },

    [3128] =
    {
        previousTrial = 2715,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN_90,
        },

        textOffset  = 1191,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_95,
        },
    },

    [3203] =
    {
        previousTrial = 2740,
        requiredItem  =
        {
            itemId = tpz.items.VERETHRAGNA_95,
        },

        textOffset  = 70,
        tradeItem   = tpz.items.PINCH_OF_RIFTCINDER,
        numRequired = 60,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA_99,
        },
    },

    [3556] =
    {
        previousTrial = 3093,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_99,
        },
    },

    [3560] =
    {
        previousTrial = 3097,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_99,
        },
    },

    [3563] =
    {
        previousTrial = 3100,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_99,
        },
    },

    [3567] =
    {
        previousTrial = 3104,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_99,
        },
    },

    [3568] =
    {
        previousTrial = 3105,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_99,
        },
    },

    [3570] =
    {
        previousTrial = 3107,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_99,
        },
    },

    [3572] =
    {
        previousTrial = 3109,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_99,
        },
    },

    [3574] =
    {
        previousTrial = 3111,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_99,
        },
    },

    [3576] =
    {
        previousTrial = 3113,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_99,
        },
    },

    [3578] =
    {
        previousTrial = 3115,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_99,
        },
    },

    [3581] =
    {
        previousTrial = 3117,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_99,
        },
    },

    [3582] =
    {
        previousTrial = 3119,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_99,
        },
    },

    [3586] =
    {
        previousTrial = 3123,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_99,
        },
    },

    [3587] =
    {
        previousTrial = 3124,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_99,
        },
    },

    [3591] =
    {
        previousTrial = 3128,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_99,
        },
    },

    [3593] =
    {
        previousTrial = 3203,
        requiredItem  =
        {
            itemId = tpz.items.VERETHRAGNA_99,
        },

        textOffset  = 70,
        tradeItem   = tpz.items.PINCH_OF_RIFTCINDER,
        numRequired = 3000,

        rewardItem =
        {
            itemId = tpz.items.VERETHRAGNA_99_II,
        },
    },

    [3606] =
    {
        previousTrial = 3556,
        requiredItem  =
        {
            itemId = tpz.items.MANDAU_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.MANDAU_99_II,
        },
    },

    [3610] =
    {
        previousTrial = 3560,
        requiredItem  =
        {
            itemId = tpz.items.SPHARAI_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.SPHARAI_99_II,
        },
    },

    [3613] =
    {
        previousTrial = 3563,
        requiredItem  =
        {
            itemId = tpz.items.EXCALIBUR_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.EXCALIBUR_99_II,
        },
    },

    [3617] =
    {
        previousTrial = 3567,
        requiredItem  =
        {
            itemId = tpz.items.RAGNAROK_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.RAGNAROK_99_II,
        },
    },

    [3618] =
    {
        previousTrial = 3568,
        requiredItem  =
        {
            itemId = tpz.items.GUTTLER_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.GUTTLER_99_II,
        },
    },

    [3620] =
    {
        previousTrial = 3570,
        requiredItem  =
        {
            itemId = tpz.items.BRAVURA_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.BRAVURA_99_II,
        },
    },

    [3622] =
    {
        previousTrial = 3572,
        requiredItem  =
        {
            itemId = tpz.items.APOCALYPSE_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.APOCALYPSE_99_II,
        },
    },

    [3624] =
    {
        previousTrial = 3574,
        requiredItem  =
        {
            itemId = tpz.items.GUNGNIR_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.GUNGNIR_99_II,
        },
    },

    [3626] =
    {
        previousTrial = 3576,
        requiredItem  =
        {
            itemId = tpz.items.KIKOKU_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.KIKOKU_99_II,
        },
    },

    [3628] =
    {
        previousTrial = 3578,
        requiredItem  =
        {
            itemId = tpz.items.AMANOMURAKUMO_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.AMANOMURAKUMO_99_II,
        },
    },

    [3630] =
    {
        previousTrial = 3581,
        requiredItem  =
        {
            itemId = tpz.items.MJOLLNIR_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.MJOLLNIR_99_II,
        },
    },

    [3632] =
    {
        previousTrial = 3582,
        requiredItem  =
        {
            itemId = tpz.items.CLAUSTRUM_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.CLAUSTRUM_99_II,
        },
    },

    [3636] =
    {
        previousTrial = 3586,
        requiredItem  =
        {
            itemId = tpz.items.YOICHINOYUMI_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.YOICHINOYUMI_99_II,
        },
    },

    [3637] =
    {
        previousTrial = 3587,
        requiredItem  =
        {
            itemId = tpz.items.ANNIHILATOR_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.ANNIHILATOR_99_II,
        },
    },

    [3641] =
    {
        previousTrial = 3591,
        requiredItem  =
        {
            itemId = tpz.items.GJALLARHORN_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.GJALLARHORN_99_II,
        },
    },

    [4156] = -- Ravager's mask -> Ravager's mask +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_MASK,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.RAVAGERS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_MASK_P1,
        },
    },

    [4157] = -- Tantra Crown -> Tantra Crown +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_CROWN,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.TANTRA_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_CROWN_P1,
        },
    },

    [4158] = -- Orison Cap -> Orison Cap +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_CAP,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.ORISON_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ORISON_CAP_P1,
        },
    },

    [4159] = -- Goetia Petasos -> Goetia Petasos +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_PETASOS,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.GOETIA_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_PETASOS_P1,
        },
    },

    [4160] = -- Estoqueur's Chappel -> Estoqueur's Chappel +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_CHAPPEL,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.ESTOQUEURS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_CHAPPEL_P1,
        },
    },

    [4161] = -- Raider's Bonnet -> Raider's Bonnet +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_BONNET,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.RAIDERS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_BONNET_P1,
        },
    },

    [4162] = -- Creed Armet -> Creed Armet +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CREED_ARMET,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.CREED_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CREED_ARMET_P1,
        },
    },

    [4163] = -- Bale Burgeonet -> Bale Burgeonet +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BALE_BURGEONET,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.BALE_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.BALE_BURGEONET_P1,
        },
    },

    [4164] = -- Ferine Cabasset -> Ferine Cabasset +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_CABASSET,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.FERINE_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.FERINE_CABASSET_P1,
        },
    },

    [4165] = -- Aoidos' Calot -> Aoidos' Calot +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_CALOT,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.AOIDOS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_CALOT_P1,
        },
    },

    [4166] = -- Sylvan Gapette -> Sylvan Gapette +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_GAPETTE,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.SYLVAN_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_GAPETTE_P1,
        },
    },

    [4167] = -- Unkai Kabuto -> Unkai Kabuto +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_KABUTO,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.UNKAI_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_KABUTO_P1,
        },
    },

    [4168] = -- Iga Zukin -> Iga Zukin +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.IGA_ZUKIN,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.IGA_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.IGA_ZUKIN_P1,
        },
    },

    [4169] = -- Lancer's Mezail -> Lancer's Mezail +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_MEZAIL,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.LANCERS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_MEZAIL_P1,
        },
    },

    [4170] = -- Caller's Horn -> Caller's Horn +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_HORN,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.CALLERS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_HORN_P1,
        },
    },

    [4171] = -- Mavi Kavuk -> Mavi Kavuk +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_KAVUK,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.MAVI_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.MAVI_KAVUK_P1,
        },
    },

    [4172] = -- Navarch's Tricorne -> Navarch's Tricorne +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_TRICORNE,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.NAVARCHS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_TRICORNE_P1,
        },
    },

    [4173] = -- Cirque Cappello -> Cirque Cappello +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_CAPPELLO,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.CIRQUE_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_CAPPELLO_P1,
        },
    },

    [4174] = -- Charis Tiara -> Charis Tiara +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TIARA,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.CHARIS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TIARA_P1,
        },
    },

    [4175] = -- Savant's Bonnet -> Savant's Bonnet +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_BONNET,
        },

        textOffset  = 1049,
        tradeItem   = tpz.items.SAVANTS_SEAL_HEAD,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_BONNET_P1,
        },
    },

    [4176] = -- Ravager's Cuisses -> Ravager's Cuisses +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_CUISSES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.RAVAGERS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_CUISSES_P1,
        },
    },

    [4177] = -- Tantra Hose -> Tantra Hose +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_HOSE,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.TANTRA_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_HOSE_P1,
        },
    },

    [4178] = -- Orison Pantaloons -> Orison Pantaloons +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_PANTALOONS,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.ORISON_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ORISON_PANTALOONS_P1,
        },
    },

    [4179] = -- Goetia Chausses -> Goetia Chausses +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_CHAUSSES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.GOETIA_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_CHAUSSES_P1,
        },
    },

    [4180] = -- Estoqueur's Fuseau -> Estoqueur's Fuseau +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_FUSEAU,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.ESTOQUEURS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_FUSEAU_P1,
        },
    },

    [4181] = -- Raider's Culottes -> Raider's Culottes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_CULOTTES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.RAIDERS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_CULOTTES_P1,
        },
    },

    [4182] = -- Creed Cuisses -> Creed Cuisses +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CREED_CUISSES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.CREED_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CREED_CUISSES_P1,
        },
    },

    [4183] = -- Bale Flanchard -> Bale Flanchard +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BALE_FLANCHARD,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.BALE_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.BALE_FLANCHARD_P1,
        },
    },

    [4184] = -- Ferine Quijotes -> Ferine Quijotes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_QUIJOTES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.FERINE_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.FERINE_QUIJOTES_P1,
        },
    },

    [4185] = -- Aoidos' Rhingrave -> Aoidos' Rhingrave +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_RHINGRAVE,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.AOIDOS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_RHINGRAVE_P1,
        },
    },

    [4186] = -- Sylvan Bragues -> Sylvan Bragues +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_BRAGUES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.SYLVAN_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_BRAGUES_P1,
        },
    },

    [4187] = -- Unkai Haidate -> Unkai Haidate +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_HAIDATE,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.UNKAI_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_HAIDATE_P1,
        },
    },

    [4188] = -- Iga Hakama -> Iga Hakama +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.IGA_HAKAMA,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.IGA_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.IGA_HAKAMA_P1,
        },
    },

    [4189] = -- Lancer's Cuissots -> Lancer's Cuissots +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_CUISSOTS,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.LANCERS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_CUISSOTS_P1,
        },
    },

    [4190] = -- Caller's Spats -> Caller's Spats +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_SPATS,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.CALLERS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_SPATS_P1,
        },
    },

    [4191] = -- Mavi Tayt -> Mavi Tayt +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_TAYT,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.MAVI_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.MAVI_TAYT_P1,
        },
    },

    [4192] = -- Navarch's Culottes -> Navarch's Culottes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_CULOTTES,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.NAVARCHS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_CULOTTES_P1,
        },
    },

    [4193] = -- Cirque Pantaloni -> Cirque Pantaloni +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_PANTALONI,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.CIRQUE_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_PANTALONI_P1,
        },
    },

    [4194] = -- Charis Tights -> Charis Tights +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TIGHTS,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.CHARIS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TIGHTS_P1,
        },
    },

    [4195] = -- Savant's Pants -> Savant's Pants +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_PANTS,
        },

        textOffset  = 1055,
        tradeItem   = tpz.items.SAVANTS_SEAL_LEGS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_PANTS_P1,
        },
    },

    [4196] = -- Ravager's Calligae -> Ravager's Calligae +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_CALLIGAE,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.RAVAGERS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_CALLIGAE_P1,
        },
    },

    [4197] = -- Tantra Gaiters -> Tantra Gaiters +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_GAITERS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.TANTRA_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_GAITERS_P1,
        },
    },

    [4198] = -- Orison Duckbills -> Orison Duckbills +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_DUCKBILLS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.ORISON_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ORISON_DUCKBILLS_P1,
        },
    },

    [4199] = -- Goetia Sabots -> Goetia Sabots +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_SABOTS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.GOETIA_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_SABOTS_P1,
        },
    },

    [4200] = -- Estoqueur's Houseaux -> Estoqueur's Houseaux +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_HOUSEAUX,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.ESTOQUEURS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_HOUSEAUX_P1,
        },
    },

    [4201] = -- Raider's Poulaines -> Raider's Poulaines +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_POULAINES,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.RAIDERS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_POULAINES_P1,
        },
    },

    [4202] = -- Creed Sabatons -> Creed Sabatons +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CREED_SABATONS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.CREED_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CREED_SABATONS_P1,
        },
    },

    [4203] = -- Bale Sollerets -> Bale Sollerets +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BALE_SOLLERETS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.BALE_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.BALE_SOLLERETS_P1,
        },
    },

    [4204] = -- Ferine Ocreae -> Ferine Ocreae +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_OCREAE,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.FERINE_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.FERINE_OCREAE_P1,
        },
    },

    [4205] = -- Aoidos' Cothurnes -> Aoidos' Cothurnes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_COTHURNES,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.AOIDOS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_COTHURNES_P1,
        },
    },

    [4206] = -- Sylvan Bottillons -> Sylvan Bottillons +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_BOTTILLONS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.SYLVAN_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_BOTTILLONS_P1,
        },
    },

    [4207] = -- Unkai Sune-Ate -> Unkai Sune-Ate +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_SUNE_ATE,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.UNKAI_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_SUNE_ATE_P1,
        },
    },

    [4208] = -- Iga Kyahan -> Iga Kyahan +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.IGA_KYAHAN,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.IGA_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.IGA_KYAHAN_P1,
        },
    },

    [4209] = -- Lancer's Schynbalds -> Lancer's Schynbalds +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_SCHYNBALDS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.LANCERS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_SCHYNBALDS_P1,
        },
    },

    [4210] = -- Caller's Pigaches -> Caller's Pigaches +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_PIGACHES,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.CALLERS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_PIGACHES_P1,
        },
    },

    [4211] = -- Mavi Basmak -> Mavi Basmak +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_BASMAK,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.MAVI_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.MAVI_BASMAK_P1,
        },
    },

    [4212] = -- Navarch's Bottes -> Navarch's Bottes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_BOTTES,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.NAVARCHS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_BOTTES_P1,
        },
    },

    [4213] = -- Cirque Scarpe -> Cirque Scarpe +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_SCARPE,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.CIRQUE_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_SCARPE_P1,
        },
    },

    [4214] = -- Charis Toe Shoes -> Charis Toe Shoes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TOE_SHOES,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.CHARIS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TOE_SHOES_P1,
        },
    },

    [4215] = -- Savant's Loafers -> Savant's Loafers +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_LOAFERS,
        },

        textOffset  = 842,
        tradeItem   = tpz.items.SAVANTS_SEAL_FEET,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_LOAFERS_P1,
        },
    },

    [4216] =
    {
        previousTrial = 4156,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_MASK_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.STONE_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_MASK_P2,
        },
    },

    [4217] =
    {
        previousTrial = 4157,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_CROWN_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.JEWEL_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_CROWN_P2,
        },
    },

    [4218] =
    {
        previousTrial = 4158,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_CAP_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.STONE_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ORISON_CAP_P2,
        },
    },

    [4219] =
    {
        previousTrial = 4159,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_PETASOS_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.COIN_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_PETASOS_P2,
        },
    },

    [4220] =
    {
        previousTrial = 4160,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_CHAPPEL_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.JEWEL_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_CHAPPEL_P2,
        },
    },

    [4221] =
    {
        previousTrial = 4161,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_BONNET_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.STONE_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_BONNET_P2,
        },
    },

    [4222] =
    {
        previousTrial = 4162,
        requiredItem  =
        {
            itemId = tpz.items.CREED_ARMET_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.CARD_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CREED_ARMET_P2,
        },
    },

    [4223] =
    {
        previousTrial = 4163,
        requiredItem  =
        {
            itemId = tpz.items.BALE_BURGEONET_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.COIN_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.BALE_BURGEONET_P2,
        },
    },

    [4224] =
    {
        previousTrial = 4164,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_CABASSET_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.COIN_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.FERINE_CABASSET_P2,
        },
    },

    [4225] =
    {
        previousTrial = 4165,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_CALOT_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.STONE_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_CALOT_P2,
        },
    },

    [4226] =
    {
        previousTrial = 4166,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_GAPETTE_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.STONE_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_GAPETTE_P2,
        },
    },

    [4227] =
    {
        previousTrial = 4167,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_KABUTO_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.JEWEL_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_KABUTO_P2,
        },
    },

    [4228] =
    {
        previousTrial = 4168,
        requiredItem  =
        {
            itemId = tpz.items.IGA_ZUKIN_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.COIN_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.IGA_ZUKIN_P2,
        },
    },

    [4229] =
    {
        previousTrial = 4169,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_MEZAIL_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.CARD_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_MEZAIL_P2,
        },
    },

    [4230] =
    {
        previousTrial = 4170,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_HORN_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.COIN_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_HORN_P2,
        },
    },

    [4231] =
    {
        previousTrial = 4171,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_KAVUK_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.CARD_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MAVI_KAVUK_P2,
        },
    },

    [4232] =
    {
        previousTrial = 4172,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_TRICORNE_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.JEWEL_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_TRICORNE_P2,
        },
    },

    [4233] =
    {
        previousTrial = 4173,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_CAPPELLO_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.JEWEL_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_CAPPELLO_P2,
        },
    },

    [4234] =
    {
        previousTrial = 4174,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TIARA_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.CARD_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TIARA_P2,
        },
    },

    [4235] =
    {
        previousTrial = 4175,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_BONNET_P1,
        },

        textOffset  = 1050,
        tradeItem   = tpz.items.CARD_OF_VISION,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_BONNET_P2,
        },
    },

    [4236] =
    {
        previousTrial = 4176,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_CUISSES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.STONE_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_CUISSES_P2,
        },
    },

    [4237] =
    {
        previousTrial = 4177,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_HOSE_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.JEWEL_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_HOSE_P2,
        },
    },

    [4238] =
    {
        previousTrial = 4178,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_PANTALOONS_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.CARD_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ORISON_PANTALOONS_P2,
        },
    },

    [4239] =
    {
        previousTrial = 4179,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_CHAUSSES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.STONE_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_CHAUSSES_P2,
        },
    },

    [4240] =
    {
        previousTrial = 4180,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_FUSEAU_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.COIN_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_FUSEAU_P2,
        },
    },

    [4241] =
    {
        previousTrial = 4181,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_CULOTTES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.COIN_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_CULOTTES_P2,
        },
    },

    [4242] =
    {
        previousTrial = 4182,
        requiredItem  =
        {
            itemId = tpz.items.CREED_CUISSES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.COIN_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CREED_CUISSES_P2,
        },
    },

    [4243] =
    {
        previousTrial = 4183,
        requiredItem  =
        {
            itemId = tpz.items.BALE_FLANCHARD_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.COIN_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.BALE_FLANCHARD_P2,
        },
    },

    [4244] =
    {
        previousTrial = 4184,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_QUIJOTES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.JEWEL_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.FERINE_QUIJOTES_P2,
        },
    },

    [4245] =
    {
        previousTrial = 4185,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_RHINGRAVE_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.COIN_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_RHINGRAVE_P2,
        },
    },

    [4246] =
    {
        previousTrial = 4186,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_BRAGUES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.JEWEL_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_BRAGUES_P2,
        },
    },

    [4247] =
    {
        previousTrial = 4187,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_HAIDATE_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.JEWEL_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_HAIDATE_P2,
        },
    },

    [4248] =
    {
        previousTrial = 4188,
        requiredItem  =
        {
            itemId = tpz.items.IGA_HAKAMA_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.STONE_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.IGA_HAKAMA_P2,
        },
    },

    [4249] =
    {
        previousTrial = 4189,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_CUISSOTS_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.CARD_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_CUISSOTS_P2,
        },
    },

    [4250] =
    {
        previousTrial = 4190,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_SPATS_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.CARD_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_SPATS_P2,
        },
    },

    [4251] =
    {
        previousTrial = 4191,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_TAYT_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.STONE_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MAVI_TAYT_P2,
        },
    },

    [4252] =
    {
        previousTrial = 4192,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_CULOTTES_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.CARD_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_CULOTTES_P2,
        },
    },

    [4253] =
    {
        previousTrial = 4193,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_PANTALONI_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.STONE_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_PANTALONI_P2,
        },
    },

    [4254] =
    {
        previousTrial = 4194,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TIGHTS_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.CARD_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TIGHTS_P2,
        },
    },

    [4255] =
    {
        previousTrial = 4195,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_PANTS_P1,
        },

        textOffset  = 1056,
        tradeItem   = tpz.items.JEWEL_OF_BALANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_PANTS_P2,
        },
    },

    [4256] =
    {
        previousTrial = 4196,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_CALLIGAE_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.STONE_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_CALLIGAE_P2,
        },
    },

    [4257] =
    {
        previousTrial = 4197,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_GAITERS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.COIN_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_GAITERS_P2,
        },
    },

    [4258] =
    {
        previousTrial = 4198,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_DUCKBILLS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.JEWEL_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ORISON_DUCKBILLS_P2,
        },
    },

    [4259] =
    {
        previousTrial = 4199,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_SABOTS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.CARD_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_SABOTS_P2,
        },
    },

    [4260] =
    {
        previousTrial = 4200,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_HOUSEAUX_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.STONE_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_HOUSEAUX_P2,
        },
    },

    [4261] =
    {
        previousTrial = 4201,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_POULAINES_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.JEWEL_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_POULAINES_P2,
        },
    },

    [4262] =
    {
        previousTrial = 4202,
        requiredItem  =
        {
            itemId = tpz.items.CREED_SABATONS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.STONE_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CREED_SABATONS_P2,
        },
    },

    [4263] =
    {
        previousTrial = 4203,
        requiredItem  =
        {
            itemId = tpz.items.BALE_SOLLERETS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.COIN_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.BALE_SOLLERETS_P2,
        },
    },

    [4264] =
    {
        previousTrial = 4204,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_OCREAE_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.CARD_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.FERINE_OCREAE_P2,
        },
    },

    [4265] =
    {
        previousTrial = 4205,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_COTHURNES_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.JEWEL_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_COTHURNES_P2,
        },
    },

    [4266] =
    {
        previousTrial = 4206,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_BOTTILLONS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.CARD_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_BOTTILLONS_P2,
        },
    },

    [4267] =
    {
        previousTrial = 4207,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_SUNE_ATE_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.JEWEL_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_SUNE_ATE_P2,
        },
    },

    [4268] =
    {
        previousTrial = 4208,
        requiredItem  =
        {
            itemId = tpz.items.IGA_KYAHAN_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.CARD_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.IGA_KYAHAN_P2,
        },
    },

    [4269] =
    {
        previousTrial = 4209,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_SCHYNBALDS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.CARD_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_SCHYNBALDS_P2,
        },
    },

    [4270] =
    {
        previousTrial = 4210,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_PIGACHES_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.STONE_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_PIGACHES_P2,
        },
    },

    [4271] =
    {
        previousTrial = 4211,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_BASMAK_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.COIN_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MAVI_BASMAK_P2,
        },
    },

    [4272] =
    {
        previousTrial = 4212,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_BOTTES_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.COIN_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_BOTTES_P2,
        },
    },

    [4273] =
    {
        previousTrial = 4213,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_SCARPE_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.JEWEL_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_SCARPE_P2,
        },
    },

    [4274] =
    {
        previousTrial = 4214,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_TOE_SHOES_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.STONE_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_TOE_SHOES_P2,
        },
    },

    [4275] =
    {
        previousTrial = 4215,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_LOAFERS_P1,
        },

        textOffset  = 843,
        tradeItem   = tpz.items.COIN_OF_VOYAGE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_LOAFERS_P2,
        },
    },

    [4316] = -- Ravager's Mufflers -> Ravager's Mufflers +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_MUFFLERS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.RAVAGERS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_MUFFLERS_P1,
        },
    },

    [4317] = -- Tantra Gloves -> Tantra Gloves +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_GLOVES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.TANTRA_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_GLOVES_P1,
        },
    },

    [4318] = -- Orison Mitts -> Orison Mitts +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_MITTS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.ORISON_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ORISON_MITTS_P1,
        },
    },

    [4319] = -- Goetia Gloves -> Goetia Gloves +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_GLOVES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.GOETIA_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_GLOVES_P1,
        },
    },

    [4320] = -- Estoqueur's Gantherots -> Estoqueur's Gantherots +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_GANTHEROTS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.ESTOQUEURS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_GANTHEROTS_P1,
        },
    },

    [4321] = -- Raider's Armlets -> Raider's Armlets +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_ARMLETS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.RAIDERS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_ARMLETS_P1,
        },
    },

    [4322] = -- Creed Gauntlets -> Creed Gauntlets +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CREED_GAUNTLETS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.CREED_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CREED_GAUNTLETS_P1,
        },
    },

    [4323] = -- Bale Gauntlets -> Bale Gauntlets +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BALE_GAUNTLETS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.BALE_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.BALE_GAUNTLETS_P1,
        },
    },

    [4324] = -- Ferine Manoplas -> Ferine Manoplas +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_MANOPLAS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.FERINE_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.FERINE_MANOPLAS_P1,
        },
    },

    [4325] = -- Aoidos' Manchettes -> Aoidos' Manchettes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_MANCHETTES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.AOIDOS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_MANCHETTES_P1,
        },
    },

    [4326] = -- Sylvan Glovelettes -> Sylvan Glovelettes +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_GLOVELETTES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.SYLVAN_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_GLOVELETTES_P1,
        },
    },

    [4327] = -- Unkai Kote -> Unkai Kote +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_KOTE,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.UNKAI_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_KOTE_P1,
        },
    },

    [4328] = -- Iga Tekko -> Iga Tekko +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.IGA_TEKKO,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.IGA_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.IGA_TEKKO_P1,
        },
    },

    [4329] = -- Lancer's Vambraces -> Lancer's Vambraces +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_VAMBRACES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.LANCERS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_VAMBRACES_P1,
        },
    },

    [4330] = -- Caller's Bracers -> Caller's Bracers +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_BRACERS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.CALLERS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_BRACERS_P1,
        },
    },

    [4331] = -- Mavi Bazubands -> Mavi Bazubands +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_BAZUBANDS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.MAVI_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.MAVI_BAZUBANDS_P1,
        },
    },

    [4332] = -- Navarch's Gants -> Navarch's Gants +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_GANTS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.NAVARCHS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_GANTS_P1,
        },
    },

    [4333] = -- Cirque Ganti -> Cirque Ganti +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_GUANTI,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.CIRQUE_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_GUANTI_P1,
        },
    },

    [4334] = -- Charis Bangles -> Charis Bangles +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_BANGLES,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.CHARIS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_BANGLES_P1,
        },
    },

    [4335] = -- Savant's Bracers -> Savant's Bracers +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_BRACERS,
        },

        textOffset  = 1053,
        tradeItem   = tpz.items.SAVANTS_SEAL_HANDS,
        numRequired = 8,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_BRACERS_P1,
        },
    },

    [4336] = -- Ravager's Lorica -> Ravager's Lorica +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_LORICA,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.RAVAGERS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_LORICA_P1,
        },
    },

    [4337] = -- Tantra Cyclas -> Tantra Cyclas +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_CYCLAS,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.TANTRA_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_CYCLAS_P1,
        },
    },

    [4338] = -- Orison Bliaut -> Orison Bliaut +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_BLIAUD,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.ORISON_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.ORISON_BLIAUD_P1,
        },
    },

    [4339] = -- Goetia Coat -> Goetia Coat +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_COAT,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.GOETIA_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_COAT_P1,
        },
    },

    [4340] = -- Estoqueur's Sayon -> Estoqueur's Sayon +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_SAYON,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.ESTOQUEURS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_SAYON_P1,
        },
    },

    [4341] = -- Raider's Vest -> Raider's Vest +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_VEST,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.RAIDERS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_VEST_P1,
        },
    },

    [4342] = -- Creed Cuirass -> Creed Cuirass +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CREED_CUIRASS,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.CREED_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.CREED_CUIRASS_P1,
        },
    },

    [4343] = -- Bale Cuirass -> Bale Cuirass +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BALE_CUIRASS,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.BALE_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.BALE_CUIRASS_P1,
        },
    },

    [4344] = -- Ferine Gausape -> Ferine Gausape +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_GAUSAPE,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.FERINE_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.FERINE_GAUSAPE_P1,
        },
    },

    [4345] = -- Aoidos' Hongreline -> Aoidos' Hongreline +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_HONGRELINE,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.AOIDOS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_HONGRELINE_P1,
        },
    },

    [4346] = -- Sylvan Caban -> Sylvan Caban +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_CABAN,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.SYLVAN_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_CABAN_P1,
        },
    },

    [4347] = -- Unkai Domaru -> Unkai Domaru +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_DOMARU,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.UNKAI_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_DOMARU_P1,
        },
    },

    [4348] = -- Iga Ningi -> Iga Ningi +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.IGA_NINGI,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.IGA_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.IGA_NINGI_P1,
        },
    },

    [4349] = -- Lancer's Plackart -> Lancer's Plackart +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_PLACKART,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.LANCERS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_PLACKART_P1,
        },
    },

    [4350] = -- Caller's Doublet -> Caller's Doublet +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_DOUBLET,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.CALLERS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_DOUBLET_P1,
        },
    },

    [4351] = -- Mavi Mintan -> Mavi Mintan +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_MINTAN,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.MAVI_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.MAVI_MINTAN_P1,
        },
    },

    [4352] = -- Navarch's Frac -> Navarch's Frac +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_FRAC,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.NAVARCHS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_FRAC_P1,
        },
    },

    [4353] = -- Cirque Farsetto -> Cirque Farsetto +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_FARSETTO,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.CIRQUE_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_FARSETTO_P1,
        },
    },

    [4354] = -- Charis Casaque -> Charis Casaque +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_CASAQUE,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.CHARIS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_CASAQUE_P1,
        },
    },

    [4355] = -- Savant's Gown -> Savant's Gown +1
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_GOWN,
        },

        textOffset  = 1051,
        tradeItem   = tpz.items.SAVANTS_SEAL_BODY,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_GOWN_P1,
        },
    },

    [4356] =
    {
        previousTrial = 4316,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_MUFFLERS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.STONE_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_MUFFLERS_P2,
        },
    },

    [4357] =
    {
        previousTrial = 4317,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_GLOVES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.JEWEL_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_GLOVES_P2,
        },
    },

    [4358] =
    {
        previousTrial = 4318,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_MITTS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.COIN_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ORISON_MITTS_P2,
        },
    },

    [4359] =
    {
        previousTrial = 4319,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_GLOVES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.JEWEL_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_GLOVES_P2,
        },
    },

    [4360] =
    {
        previousTrial = 4320,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_GANTHEROTS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.STONE_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_GANTHEROTS_P2,
        },
    },

    [4361] =
    {
        previousTrial = 4321,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_ARMLETS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.STONE_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_ARMLETS_P2,
        },
    },

    [4362] =
    {
        previousTrial = 4322,
        requiredItem  =
        {
            itemId = tpz.items.CREED_GAUNTLETS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.CARD_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CREED_GAUNTLETS_P2,
        },
    },

    [4363] =
    {
        previousTrial = 4323,
        requiredItem  =
        {
            itemId = tpz.items.BALE_GAUNTLETS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.COIN_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.BALE_GAUNTLETS_P2,
        },
    },

    [4364] =
    {
        previousTrial = 4324,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_MANOPLAS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.STONE_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.FERINE_MANOPLAS_P2,
        },
    },

    [4365] =
    {
        previousTrial = 4325,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_MANCHETTES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.JEWEL_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_MANCHETTES_P2,
        },
    },

    [4366] =
    {
        previousTrial = 4326,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_GLOVELETTES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.COIN_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_GLOVELETTES_P2,
        },
    },

    [4367] =
    {
        previousTrial = 4327,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_KOTE_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.JEWEL_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_KOTE_P2,
        },
    },

    [4368] =
    {
        previousTrial = 4328,
        requiredItem  =
        {
            itemId = tpz.items.IGA_TEKKO_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.CARD_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.IGA_TEKKO_P2,
        },
    },

    [4369] =
    {
        previousTrial = 4329,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_VAMBRACES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.CARD_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_VAMBRACES_P2,
        },
    },

    [4370] =
    {
        previousTrial = 4330,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_BRACERS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.JEWEL_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_BRACERS_P2,
        },
    },

    [4371] =
    {
        previousTrial = 4331,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_BAZUBANDS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.COIN_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.MAVI_BAZUBANDS_P2,
        },
    },

    [4372] =
    {
        previousTrial = 4332,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_GANTS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.CARD_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_GANTS_P2,
        },
    },

    [4373] =
    {
        previousTrial = 4333,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_GUANTI_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.CARD_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_GUANTI_P2,
        },
    },

    [4374] =
    {
        previousTrial = 4334,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_BANGLES_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.COIN_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_BANGLES_P2,
        },
    },

    [4375] =
    {
        previousTrial = 4335,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_BRACERS_P1,
        },

        textOffset  = 1054,
        tradeItem   = tpz.items.STONE_OF_WIELDANCE,
        numRequired = 6,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_BRACERS_P2,
        },
    },

    [4376] =
    {
        previousTrial = 4336,
        requiredItem  =
        {
            itemId = tpz.items.RAVAGERS_LORICA_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.STONE_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.RAVAGERS_LORICA_P2,
        },
    },

    [4377] =
    {
        previousTrial = 4337,
        requiredItem  =
        {
            itemId = tpz.items.TANTRA_CYCLAS_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.CARD_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.TANTRA_CYCLAS_P2,
        },
    },

    [4378] =
    {
        previousTrial = 4338,
        requiredItem  =
        {
            itemId = tpz.items.ORISON_BLIAUD_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.CARD_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.ORISON_BLIAUD_P2,
        },
    },

    [4379] =
    {
        previousTrial = 4339,
        requiredItem  =
        {
            itemId = tpz.items.GOETIA_COAT_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.JEWEL_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.GOETIA_COAT_P2,
        },
    },

    [4380] =
    {
        previousTrial = 4340,
        requiredItem  =
        {
            itemId = tpz.items.ESTOQUEURS_SAYON_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.JEWEL_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.ESTOQUEURS_SAYON_P2,
        },
    },

    [4381] =
    {
        previousTrial = 4341,
        requiredItem  =
        {
            itemId = tpz.items.RAIDERS_VEST_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.COIN_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.RAIDERS_VEST_P2,
        },
    },

    [4382] =
    {
        previousTrial = 4342,
        requiredItem  =
        {
            itemId = tpz.items.CREED_CUIRASS_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.STONE_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.CREED_CUIRASS_P2,
        },
    },

    [4383] =
    {
        previousTrial = 4343,
        requiredItem  =
        {
            itemId = tpz.items.BALE_CUIRASS_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.COIN_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.BALE_CUIRASS_P2,
        },
    },

    [4384] =
    {
        previousTrial = 4344,
        requiredItem  =
        {
            itemId = tpz.items.FERINE_GAUSAPE_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.CARD_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.FERINE_GAUSAPE_P2,
        },
    },

    [4385] =
    {
        previousTrial = 4345,
        requiredItem  =
        {
            itemId = tpz.items.AOIDOS_HONGRELINE_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.STONE_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.AOIDOS_HONGRELINE_P2,
        },
    },

    [4386] =
    {
        previousTrial = 4346,
        requiredItem  =
        {
            itemId = tpz.items.SYLVAN_CABAN_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.COIN_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.SYLVAN_CABAN_P2,
        },
    },

    [4387] =
    {
        previousTrial = 4347,
        requiredItem  =
        {
            itemId = tpz.items.UNKAI_DOMARU_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.JEWEL_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.UNKAI_DOMARU_P2,
        },
    },

    [4388] =
    {
        previousTrial = 4348,
        requiredItem  =
        {
            itemId = tpz.items.IGA_NINGI_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.STONE_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.IGA_NINGI_P2,
        },
    },

    [4389] =
    {
        previousTrial = 4349,
        requiredItem  =
        {
            itemId = tpz.items.LANCERS_PLACKART_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.CARD_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.LANCERS_PLACKART_P2,
        },
    },

    [4390] =
    {
        previousTrial = 4350,
        requiredItem  =
        {
            itemId = tpz.items.CALLERS_DOUBLET_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.COIN_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.CALLERS_DOUBLET_P2,
        },
    },

    [4391] =
    {
        previousTrial = 4351,
        requiredItem  =
        {
            itemId = tpz.items.MAVI_MINTAN_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.STONE_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.MAVI_MINTAN_P2,
        },
    },

    [4392] =
    {
        previousTrial = 4352,
        requiredItem  =
        {
            itemId = tpz.items.NAVARCHS_FRAC_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.COIN_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.NAVARCHS_FRAC_P2,
        },
    },

    [4393] =
    {
        previousTrial = 4353,
        requiredItem  =
        {
            itemId = tpz.items.CIRQUE_FARSETTO_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.JEWEL_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.CIRQUE_FARSETTO_P2,
        },
    },

    [4394] =
    {
        previousTrial = 4354,
        requiredItem  =
        {
            itemId = tpz.items.CHARIS_CASAQUE_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.JEWEL_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.CHARIS_CASAQUE_P2,
        },
    },

    [4395] =
    {
        previousTrial = 4355,
        requiredItem  =
        {
            itemId = tpz.items.SAVANTS_GOWN_P1,
        },

        textOffset  = 1052,
        tradeItem   = tpz.items.CARD_OF_ARDOR,
        numRequired = 9,

        rewardItem =
        {
            itemId = tpz.items.SAVANTS_GOWN_P2,
        },
    },

    [4401] =
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS,
        },

        textOffset  = 1132,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_80,
        },
    },

    [4402] =
    {
        previousTrial = 4401,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS_80,
        },

        textOffset  = 1134,
        numRequired = 3,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_85,
        },
    },

    [4403] =
    {
        previousTrial = 4402,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS_85,
        },

        textOffset  = 1084,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_90,
        },
    },

    [4448] =
    {
        previousTrial = 4403,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS_90,
        },

        textOffset  = 1192,
        numRequired = 10,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_95,
        },
    },

    [4453] =
    {
        previousTrial = 4448,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS_95,
        },

        textOffset  = 1329,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 5,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_99,
        },
    },

    [4654] = -- Warrior's Mask -> Warrior's Mask +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_MASK,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_MASK_P2,
        },
    },

    [4655] = -- Warrior's Mask +1 -> Warrior's Mask +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_MASK_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_MASK_P2,
        },
    },

    [4656] = -- Warrior's Lorica -> Warrior's Lorica +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_LORICA,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_LORICA_P2,
        },
    },

    [4657] = -- Warrior's Lorica +1 -> Warrior's Lorica +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_LORICA_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_LORICA_P2,
        },
    },

    [4658] = -- Warrior's Mufflers -> Warrior's Mufflers +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_MUFFLERS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_MUFFLERS_P2,
        },
    },

    [4659] = -- Warrior's Mufflers +1 -> Warrior's Mufflers +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_MUFFLERS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_MUFFLERS_P2,
        },
    },

    [4660] = -- Warrior's Cuisses -> Warrior's Cuisses +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_CUISSES,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_CUISSES_P2,
        },
    },

    [4661] = -- Warrior's Cuisses +1 -> Warrior's Cuisses +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_CUISSES_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_CUISSES_P2,
        },
    },

    [4662] = -- Warrior's Calligae -> Warrior's Calligae +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_CALLIGAE,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_CALLIGAE_P2,
        },
    },

    [4663] = -- Warrior's Calligae +1 -> Warrior's Calligae +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WARRIORS_CALLIGAE_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WARRIORS_CALLIGAE_P2,
        },
    },

    [4664] = -- Melee Crown -> Melee Crown +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_CROWN,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MELEE_CROWN_P2,
        },
    },

    [4665] = -- Melee Crown +1 -> Melee Crown +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_CROWN_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MELEE_CROWN_P2,
        },
    },

    [4666] = -- Melee Cyclas -> Melee Cyclas +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_CYCLAS,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MELEE_CYCLAS_P2,
        },
    },

    [4667] = -- Melee Cyclas +1 -> Melee Cyclas +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_CYCLAS_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MELEE_CYCLAS_P2,
        },
    },

    [4668] = -- Melee Gloves -> Melee Gloves +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_GLOVES,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MELEE_GLOVES_P2,
        },
    },

    [4669] = -- Melee Gloves +1 -> Melee Gloves +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_GLOVES_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MELEE_GLOVES_P2,
        },
    },

    [4670] = -- Melee Hose -> Melee Hose +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_HOSE,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MELEE_HOSE_P2,
        },
    },

    [4671] = -- Melee Hose +1 -> Melee Hose +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_HOSE_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MELEE_HOSE_P2,
        },
    },

    [4672] = -- Melee Gaiters -> Melee Gaiters +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_GAITERS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MELEE_GAITERS_P2,
        },
    },

    [4673] = -- Melee Gaiters +1 -> Melee Gaiters +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_GAITERS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MELEE_GAITERS_P2,
        },
    },

    [4674] = -- Cleric's Cap -> Cleric's Cap +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_CAP,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_CAP_P2,
        },
    },

    [4675] = -- Cleric's Cap +1 -> Cleric's Cap +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_CAP_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_CAP_P2,
        },
    },

    [4676] = -- Cleric's Briault -> Cleric's Briault +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_BRIAULT,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_BRIAULT_P2,
        },
    },

    [4677] = -- Cleric's Briault +1 -> Cleric's Briault +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_BRIAULT_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_BRIAULT_P2,
        },
    },

    [4678] = -- Cleric's Mitts -> Cleric's Mitts +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_MITTS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_MITTS_P2,
        },
    },

    [4679] = -- Cleric's Mitts +1 -> Cleric's Mitts +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_MITTS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_MITTS_P2,
        },
    },

    [4680] = -- Cleric's Pantaloons -> Cleric's Pantaloons +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_PANTALOONS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_PANTALOONS_P2,
        },
    },

    [4681] = -- Cleric's Pantaloons +1 -> Cleric's Pantaloons +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_PANTALOONS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_PANTALOONS_P2,
        },
    },

    [4682] = -- Cleric's Duckbills -> Cleric's Duckbills +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_DUCKBILLS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_DUCKBILLS_P2,
        },
    },

    [4683] = -- Cleric's Duckbills +1 -> Cleric's Duckbills +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.CLERICS_DUCKBILLS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.CLERICS_DUCKBILLS_P2,
        },
    },

    [4684] = -- Sorcerer's Petasos -> Sorcerer's Petasos +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_PETASOS,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_PETASOS_P2,
        },
    },

    [4685] = -- Sorcerer's Petasos +1 -> Sorcerer's Petasos +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_PETASOS_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_PETASOS_P2,
        },
    },

    [4686] = -- Sorcerer's Coat -> Sorcerer's Coat +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_COAT,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_COAT_P2,
        },
    },

    [4687] = -- Sorcerer's Coat +1 -> Sorcerer's Coat +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_COAT_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_COAT_P2,
        },
    },

    [4688] = -- Sorcerer's Gloves -> Sorcerer's Gloves +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_GLOVES,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_GLOVES_P2,
        },
    },

    [4689] = -- Sorcerer's Gloves +1 -> Sorcerer's Gloves +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_GLOVES_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_GLOVES_P2,
        },
    },

    [4690] = -- Sorcerer's Tonban -> Sorcerer's Tonban +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_TONBAN,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_TONBAN_P2,
        },
    },

    [4691] = -- Sorcerer's Tonban +1 -> Sorcerer's Tonban +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_TONBAN_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_TONBAN_P2,
        },
    },

    [4692] = -- Sorcerer's Sabots -> Sorcerer's Sabots +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_SABOTS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_SABOTS_P2,
        },
    },

    [4693] = -- Sorcerer's Sabots +1 -> Sorcerer's Sabots +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SORCERERS_SABOTS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SORCERERS_SABOTS_P2,
        },
    },

    [4694] = -- Duelist's Chapeau -> Duelist's Chapeau +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_CHAPEAU,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_CHAPEAU_P2,
        },
    },

    [4695] = -- Duelist's Chapeau +1 -> Duelist's Chapeau +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_CHAPEAU_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_CHAPEAU_P2,
        },
    },

    [4696] = -- Duelist's Tabard -> Duelist's Tabard +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_TABARD,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_TABARD_P2,
        },
    },

    [4697] = -- Duelist's Tabard +1 -> Duelist's Tabard +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_TABARD_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_TABARD_P2,
        },
    },

    [4698] = -- Duelist's Gloves -> Duelist's Gloves +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_GLOVES,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_GLOVES_P2,
        },
    },

    [4699] = -- Duelist's Gloves +1 -> Duelist's Gloves +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_GLOVES_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_GLOVES_P2,
        },
    },

    [4700] = -- Duelist's Tights -> Duelist's Tights +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_TIGHTS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_TIGHTS_P2,
        },
    },

    [4701] = -- Duelist's Tights +1 -> Duelist's Tights +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_TIGHTS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_TIGHTS_P2,
        },
    },

    [4702] = -- Duelist's Boots -> Duelist's Boots +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_BOOTS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_BOOTS_P2,
        },
    },

    [4703] = -- Duelist's Boots +1 -> Duelist's Boots +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.DUELISTS_BOOTS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.DUELISTS_BOOTS_P2,
        },
    },

    [4704] = -- Assassin's Bonnet -> Assassin's Bonnet +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_BONNET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_BONNET_P2,
        },
    },

    [4705] = -- Assassin's Bonnet +1 -> Assassin's Bonnet +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_BONNET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_BONNET_P2,
        },
    },

    [4706] = -- Assassin's Vest -> Assassin's Vest +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_VEST,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_VEST_P2,
        },
    },

    [4707] = -- Assassin's Vest +1 -> Assassin's Vest +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_VEST_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_VEST_P2,
        },
    },

    [4708] = -- Assassin's Armlets -> Assassin's Armlets +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_ARMLETS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_ARMLETS_P2,
        },
    },

    [4709] = -- Assassin's Armlets +1 -> Assassin's Armlets +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_ARMLETS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_ARMLETS_P2,
        },
    },

    [4710] = -- Assassin's Culottes -> Assassin's Culottes +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_CULOTTES,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_CULOTTES_P2,
        },
    },

    [4711] = -- Assassin's Culottes +1 -> Assassin's Culottes +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_CULOTTES_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_CULOTTES_P2,
        },
    },

    [4712] = -- Assassin's Poulaines -> Assassin's Poulaines +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_POULAINES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_POULAINES_P2,
        },
    },

    [4713] = -- Assassin's Poulaines +1 -> Assassin's Poulaines +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ASSASSINS_POULAINES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ASSASSINS_POULAINES_P2,
        },
    },

    [4714] = -- Valor Coronet -> Valor Coronet +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_CORONET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VALOR_CORONET_P2,
        },
    },

    [4715] = -- Valor Coronet +1 -> Valor Coronet +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_CORONET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.VALOR_CORONET_P2,
        },
    },

    [4716] = -- Valor Surcoat -> Valor Surcoat +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_SURCOAT,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VALOR_SURCOAT_P2,
        },
    },

    [4717] = -- Valor Surcoat +1 -> Valor Surcoat +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_SURCOAT_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.VALOR_SURCOAT_P2,
        },
    },

    [4718] = -- Valor Gauntlets -> Valor Gauntlets +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_GAUNTLETS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VALOR_GAUNTLETS_P2,
        },
    },

    [4719] = -- Valor Gauntlets +1 -> Valor Gauntlets +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_GAUNTLETS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.VALOR_GAUNTLETS_P2,
        },
    },

    [4720] = -- Valor Breeches -> Valor Breeches +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_BREECHES,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VALOR_BREECHES_P2,
        },
    },

    [4721] = -- Valor Breeches +1 -> Valor Breeches +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_BREECHES_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.VALOR_BREECHES_P2,
        },
    },

    [4722] = -- Valor Leggings -> Valor Leggings +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_LEGGINGS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.VALOR_LEGGINGS_P2,
        },
    },

    [4723] = -- Valor Leggings +1 -> Valor Leggings +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.VALOR_LEGGINGS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.VALOR_LEGGINGS_P2,
        },
    },

    [4724] = -- Abyss Burgeonet -> Abyss Burgeonet +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_BURGEONET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_BURGEONET_P2,
        },
    },

    [4725] = -- Abyss Burgeonet +1 -> Abyss Burgeonet +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_BURGEONET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_BURGEONET_P2,
        },
    },

    [4726] = -- Abyss Cuirass -> Abyss Cuirass +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_CUIRASS,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_CUIRASS_P2,
        },
    },

    [4727] = -- Abyss Cuirass +1 -> Abyss Cuirass +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_CUIRASS_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_CUIRASS_P2,
        },
    },

    [4728] = -- Abyss Gauntlets -> Abyss Gauntlets +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_GAUNTLETS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_GAUNTLETS_P2,
        },
    },

    [4729] = -- Abyss Gauntlets +1 -> Abyss Gauntlets +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_GAUNTLETS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_GAUNTLETS_P2,
        },
    },

    [4730] = -- Abyss Flanchard -> Abyss Flanchard +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_FLANCHARD,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_FLANCHARD_P2,
        },
    },

    [4731] = -- Abyss Flanchard +1 -> Abyss Flanchard +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_FLANCHARD_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_FLANCHARD_P2,
        },
    },

    [4732] = -- Abyss Sollerets -> Abyss Sollerets +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_SOLLERETS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_SOLLERETS_P2,
        },
    },

    [4733] = -- Abyss Sollerets +1 -> Abyss Sollerets +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ABYSS_SOLLERETS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ABYSS_SOLLERETS_P2,
        },
    },

    [4734] = -- Monster Helm -> Monster Helm +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_HELM,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_HELM_P2,
        },
    },

    [4735] = -- Monster Helm +1 -> Monster Helm +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_HELM_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_HELM_P2,
        },
    },

    [4736] = -- Monster Jackcoat -> Monster Jackcoat +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_JACKCOAT,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_JACKCOAT_P2,
        },
    },

    [4737] = -- Monster Jackcoat +1 -> Monster Jackcoat +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_JACKCOAT_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_JACKCOAT_P2,
        },
    },

    [4738] = -- Monster Gloves -> Monster Gloves +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_GLOVES,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_GLOVES_P2,
        },
    },

    [4739] = -- Monster Gloves +1 -> Monster Gloves +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_GLOVES_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_GLOVES_P2,
        },
    },

    [4740] = -- Monster Trousers -> Monster Trousers +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_TROUSERS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_TROUSERS_P2,
        },
    },

    [4741] = -- Monster Trousers +1 -> Monster Trousers +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_TROUSERS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_TROUSERS_P2,
        },
    },

    [4742] = -- Monster Gaiters -> Monster Gaiters +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_GAITERS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_GAITERS_P2,
        },
    },

    [4743] = -- Monster Gaiters +1 -> Monster Gaiters +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MONSTER_GAITERS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MONSTER_GAITERS_P2,
        },
    },

    [4744] = -- Bard's Roundlet -> Bard's Roundlet +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_ROUNDLET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.BARDS_ROUNDLET_P2,
        },
    },

    [4745] = -- Bard's Roundlet +1 -> Bard's Roundlet +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_ROUNDLET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.BARDS_ROUNDLET_P2,
        },
    },

    [4746] = -- Bard's Justaucorps -> Bard's Justaucorps +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_JUSTAUCORPS,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.BARDS_JUSTAUCORPS_P2,
        },
    },

    [4747] = -- Bard's Justaucorps +1 -> Bard's Justaucorps +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_JUSTAUCORPS_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.BARDS_JUSTAUCORPS_P2,
        },
    },

    [4748] = -- Bard's Cuffs -> Bard's Cuffs +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_CUFFS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.BARDS_CUFFS_P2,
        },
    },

    [4749] = -- Bard's Cuffs +1 -> Bard's Cuffs +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_CUFFS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.BARDS_CUFFS_P2,
        },
    },

    [4750] = -- Bard's Cannions -> Bard's Cannions +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_CANNIONS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.BARDS_CANNIONS_P2,
        },
    },

    [4751] = -- Bard's Cannions +1 -> Bard's Cannions +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_CANNIONS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.BARDS_CANNIONS_P2,
        },
    },

    [4752] = -- Bard's Slippers -> Bard's Slippers +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_SLIPPERS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.BARDS_SLIPPERS_P2,
        },
    },

    [4753] = -- Bard's Slippers +1 -> Bard's Slippers +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.BARDS_SLIPPERS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.BARDS_SLIPPERS_P2,
        },
    },

    [4754] = -- Scout's Beret -> Scout's Beret +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BERET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BERET_P2,
        },
    },

    [4755] = -- Scout's Beret +1 -> Scout's Beret +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BERET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BERET_P2,
        },
    },

    [4756] = -- Scout's Jerkin -> Scout's Jerkin +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_JERKIN,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_JERKIN_P2,
        },
    },

    [4757] = -- Scout's Jerkin +1 -> Scout's Jerkin +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_JERKIN_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_JERKIN_P2,
        },
    },

    [4758] = -- Scout's Bracers -> Scout's Bracers +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BRACERS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BRACERS_P2,
        },
    },

    [4759] = -- Scout's Bracers +1 -> Scout's Bracers +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BRACERS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BRACERS_P2,
        },
    },

    [4760] = -- Scout's Braccae -> Scout's Braccae +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BRACCAE,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BRACCAE_P2,
        },
    },

    [4761] = -- Scout's Braccae +1 -> Scout's Braccae +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_BRACCAE_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_BRACCAE_P2,
        },
    },

    [4762] = -- Scout's Socks -> Scout's Socks +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_SOCKS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_SOCKS_P2,
        },
    },

    [4763] = -- Scout's Socks +1 -> Scout's Socks +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SCOUTS_SOCKS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SCOUTS_SOCKS_P2,
        },
    },

    [4764] = -- Saotome Kabuto -> Saotome Kabuto +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_KABUTO,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_KABUTO_P2,
        },
    },

    [4765] = -- Saotome Kabuto +1 -> Saotome Kabuto +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_KABUTO_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_KABUTO_P2,
        },
    },

    [4766] = -- Saotome Domaru -> Saotome Domaru +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_DOMARU,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_DOMARU_P2,
        },
    },

    [4767] = -- Saotome Domaru +1 -> Saotome Domaru +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_DOMARU_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_DOMARU_P2,
        },
    },

    [4768] = -- Saotome Kote -> Saotome Kote +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_KOTE,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_KOTE_P2,
        },
    },

    [4769] = -- Saotome Kote +1 -> Saotome Kote +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_KOTE_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_KOTE_P2,
        },
    },

    [4770] = -- Saotome Haidate -> Saotome Haidate +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_HAIDATE,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_HAIDATE_P2,
        },
    },

    [4771] = -- Saotome Haidate +1 -> Saotome Haidate +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_HAIDATE_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_HAIDATE_P2,
        },
    },

    [4772] = -- Saotome Sune-ate -> Saotome Sune-ate +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_SUNE_ATE,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_SUNE_ATE_P2,
        },
    },

    [4773] = -- Saotome Sune-ate +1 -> Saotome Sune-ate +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SAOTOME_SUNE_ATE_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SAOTOME_SUNE_ATE_P2,
        },
    },

    [4774] = -- Koga Hatsuburi -> Koga Hatsuburi +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_HATSUBURI,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.KOGA_HATSUBURI_P2,
        },
    },

    [4775] = -- Koga Hatsuburi +1 -> Koga Hatsuburi +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_HATSUBURI_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.KOGA_HATSUBURI_P2,
        },
    },

    [4776] = -- Koga Chainmail -> Koga Chainmail +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_CHAINMAIL,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.KOGA_CHAINMAIL_P2,
        },
    },

    [4777] = -- Koga Chainmail +1 -> Koga Chainmail +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_CHAINMAIL_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.KOGA_CHAINMAIL_P2,
        },
    },

    [4778] = -- Koga Tekko -> Koga Tekko +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_TEKKO,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.KOGA_TEKKO_P2,
        },
    },

    [4779] = -- Koga Tekko +1 -> Koga Tekko +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_TEKKO_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.KOGA_TEKKO_P2,
        },
    },

    [4780] = -- Koga Hakama -> Koga Hakama +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_HAKAMA,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.KOGA_HAKAMA_P2,
        },
    },

    [4781] = -- Koga Hakama +1 -> Koga Hakama +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_HAKAMA_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.KOGA_HAKAMA_P2,
        },
    },

    [4782] = -- Koga Kyahan -> Koga Kyahan +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_KYAHAN,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.KOGA_KYAHAN_P2,
        },
    },

    [4783] = -- Koga Kyahan +1 -> Koga Kyahan +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.KOGA_KYAHAN_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.KOGA_KYAHAN_P2,
        },
    },

    [4784] = -- Wyrm Armet -> Wyrm Armet +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_ARMET,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WYRM_ARMET_P2,
        },
    },

    [4785] = -- Wyrm Armet +1 -> Wyrm Armet +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_ARMET_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WYRM_ARMET_P2,
        },
    },

    [4786] = -- Wyrm Mail -> Wyrm Mail +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_MAIL,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WYRM_MAIL_P2,
        },
    },

    [4787] = -- Wyrm Mail +1 -> Wyrm Mail +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_MAIL_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WYRM_MAIL_P2,
        },
    },

    [4788] = -- Wyrm Finger Gauntlets -> Wyrm Finger Gauntlets +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_FINGER_GAUNTLETS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WYRM_FINGER_GAUNTLETS_P2,
        },
    },

    [4789] = -- Wyrm Finger Gauntlets +1 -> Wyrm Finger Gauntlets +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_FINGER_GAUNTLETS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WYRM_FINGER_GAUNTLETS_P2,
        },
    },

    [4790] = -- Wyrm Brais -> Wyrm Brais +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_BRAIS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WYRM_BRAIS_P2,
        },
    },

    [4791] = -- Wyrm Brais +1 -> Wyrm Brais +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_BRAIS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WYRM_BRAIS_P2,
        },
    },

    [4792] = -- Wyrm Greaves -> Wyrm Greaves +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_GREAVES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.WYRM_GREAVES_P2,
        },
    },

    [4793] = -- Wyrm Greaves +1 -> Wyrm Greaves +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.WYRM_GREAVES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.WYRM_GREAVES_P2,
        },
    },

    [4794] = -- Summoner's Horn -> Summoner's Horn +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_HORN,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_HORN_P2,
        },
    },

    [4795] = -- Summoner's Horn +1 -> Summoner's Horn +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_HORN_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_HORN_P2,
        },
    },

    [4796] = -- Summoner's Doublet -> Summoner's Doublet +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_DOUBLET,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_DOUBLET_P2,
        },
    },

    [4797] = -- Summoner's Doublet +1 -> Summoner's Doublet +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_DOUBLET_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_DOUBLET_P2,
        },
    },

    [4798] = -- Summoner's Bracers -> Summoner's Bracers +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_BRACERS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_BRACERS_P2,
        },
    },

    [4799] = -- Summoner's Bracers +1 -> Summoner's Bracers +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_BRACERS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_BRACERS_P2,
        },
    },

    [4800] = -- Summoner's Spats -> Summoner's Spats +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_SPATS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_SPATS_P2,
        },
    },

    [4801] = -- Summoner's Spats +1 -> Summoner's Spats +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_SPATS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_SPATS_P2,
        },
    },

    [4802] = -- Summoner's Pigaches -> Summoner's Pigaches +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_PIGACHES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_PIGACHES_P2,
        },
    },

    [4803] = -- Summoner's Pigaches +1 -> Summoner's Pigaches +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.SUMMONERS_PIGACHES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.SUMMONERS_PIGACHES_P2,
        },
    },

    [4804] = -- Mirage Keffiyeh -> Mirage Keffiyeh +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_KEFFIYEH,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_KEFFIYEH_P2,
        },
    },

    [4805] = -- Mirage Keffiyeh +1 -> Mirage Keffiyeh +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_KEFFIYEH_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_KEFFIYEH_P2,
        },
    },

    [4806] = -- Mirage Jubbah -> Mirage Jubbah +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_JUBBAH,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_JUBBAH_P2,
        },
    },

    [4807] = -- Mirage Jubbah +1 -> Mirage Jubbah +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_JUBBAH_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_JUBBAH_P2,
        },
    },

    [4808] = -- Mirage Bazubands -> Mirage Bazubands +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_BAZUBANDS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_BAZUBANDS_P2,
        },
    },

    [4809] = -- Mirage Bazubands +1 -> Mirage Bazubands +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_BAZUBANDS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_BAZUBANDS_P2,
        },
    },

    [4810] = -- Mirage Shalwar -> Mirage Shalwar +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_SHALWAR,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_SHALWAR_P2,
        },
    },

    [4811] = -- Mirage Shalwar +1 -> Mirage Shalwar +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_SHALWAR_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_SHALWAR_P2,
        },
    },

    [4812] = -- Mirage Charuqs -> Mirage Charuqs +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_CHARUQS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_CHARUQS_P2,
        },
    },

    [4813] = -- Mirage Charuqs +1 -> Mirage Charuqs +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.MIRAGE_CHARUQS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.MIRAGE_CHARUQS_P2,
        },
    },

    [4814] = -- Commodore Tricorne -> Commodore's Tricorne +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_TRICORNE,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.COMMODORES_TRICORNE_P2,
        },
    },

    [4815] = -- Commodore Tricorne +1 -> Commodore's Tricorne +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_TRICORNE_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.COMMODORES_TRICORNE_P2,
        },
    },

    [4816] = -- Commodore Frac -> Commodore Frac +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_FRAC,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_FRAC_P2,
        },
    },

    [4817] = -- Commodore Frac +1 -> Commodore Frac +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_FRAC_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_FRAC_P2,
        },
    },

    [4818] = -- Commodore Gants -> Commodore Gants +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_GANTS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_GANTS_P2,
        },
    },

    [4819] = -- Commodore Gants +1 -> Commodore Gants +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_GANTS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_GANTS_P2,
        },
    },

    [4820] = -- Commodore Trews -> Commodore Trews +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_TREWS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_TREWS_P2,
        },
    },

    [4821] = -- Commodore Trews +1 -> Commodore Trews +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_TREWS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_TREWS_P2,
        },
    },

    [4822] = -- Commodore Bottes -> Commodore Bottes +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_BOTTES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_BOTTES_P2,
        },
    },

    [4823] = -- Commodore Bottes +1 -> Commodore Bottes +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.COMMODORE_BOTTES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.COMMODORE_BOTTES_P2,
        },
    },

    [4824] = -- Pantin Taj -> Pantin Taj +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_TAJ,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_TAJ_P2,
        },
    },

    [4825] = -- Pantin Taj +1 -> Pantin Taj +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_TAJ_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_TAJ_P2,
        },
    },

    [4826] = -- Pantin Tobe -> Pantin Tobe +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_TOBE,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_TOBE_P2,
        },
    },

    [4827] = -- Pantin Tobe +1 -> Pantin Tobe +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_TOBE_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_TOBE_P2,
        },
    },

    [4828] = -- Pantin Dastanas -> Pantin Dastanas +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_DASTANAS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_DASTANAS_P2,
        },
    },

    [4829] = -- Pantin Dastanas +1 -> Pantin Dastanas +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_DASTANAS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_DASTANAS_P2,
        },
    },

    [4830] = -- Pantin Churidars -> Pantin Churidars +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_CHURIDARS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_CHURIDARS_P2,
        },
    },

    [4831] = -- Pantin Churidars +1 -> Pantin Churidars +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_CHURIDARS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_CHURIDARS_P2,
        },
    },

    [4832] = -- Pantin Babouches -> Pantin Babouches +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_BABOUCHES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_BABOUCHES_P2,
        },
    },

    [4833] = -- Pantin Babouches +1 -> Pantin Babouches +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.PANTIN_BABOUCHES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.PANTIN_BABOUCHES_P2,
        },
    },

    [4834] = -- Etoile Tiara -> Etoile Tiara +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TIARA,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TIARA_P2,
        },
    },

    [4835] = -- Etoile Tiara +1 -> Etoile Tiara +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TIARA_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TIARA_P2,
        },
    },

    [4836] = -- Etoile Casaque -> Etoile Casaque +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_CASAQUE,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_CASAQUE_P2,
        },
    },

    [4837] = -- Etoile Casaque +1 -> Etoile Casaque +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_CASAQUE_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_CASAQUE_P2,
        },
    },

    [4838] = -- Etoile Bangles -> Etoile Bangles +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_BANGLES,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_BANGLES_P2,
        },
    },

    [4839] = -- Etoile Bangles +1 -> Etoile Bangles +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_BANGLES_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_BANGLES_P2,
        },
    },

    [4840] = -- Etoile Tights -> Etoile Tights +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TIGHTS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TIGHTS_P2,
        },
    },

    [4841] = -- Etoile Tights +1 -> Etoile Tights +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TIGHTS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TIGHTS_P2,
        },
    },

    [4842] = -- Etoile Toe Shoes -> Etoile Toe Shoes +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TOE_SHOES,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TOE_SHOES_P2,
        },
    },

    [4843] = -- Etoile Toe Shoes +1 -> Etoile Toe Shoes +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ETOILE_TOE_SHOES_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ETOILE_TOE_SHOES_P2,
        },
    },

    [4844] = -- Argute Mortarboard -> Argute Mortarboard +2 - 50 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_MORTARBOARD,
        },

        textOffset  = 1302,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_MORTARBOARD_P2,
        },
    },

    [4845] = -- Argute Mortarboard +1 -> Argute Mortarboard +2 - 30 Forgotten Thought
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_MORTARBOARD_P1,
        },

        textOffset  = 1303,
        tradeItem   = tpz.items.FORGOTTEN_THOUGHT,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_MORTARBOARD_P2,
        },
    },

    [4846] = -- Argute Gown -> Argute Gown +2 - 50 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_GOWN,
        },

        textOffset  = 1304,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_GOWN_P2,
        },
    },

    [4847] = -- Argute Gown +1 -> Argute Gown +2 - 30 Forgotten Hope
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_GOWN_P1,
        },

        textOffset  = 1305,
        tradeItem   = tpz.items.FORGOTTEN_HOPE,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_GOWN_P2,
        },
    },

    [4848] = -- Argute Bracers -> Argute Bracers +2 - 50 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_BRACERS,
        },

        textOffset  = 1306,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_BRACERS_P2,
        },
    },

    [4849] = -- Argute Bracers +1 -> Argute Bracers +2 - 30 Forgotten Touch
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_BRACERS_P1,
        },

        textOffset  = 1307,
        tradeItem   = tpz.items.FORGOTTEN_TOUCH,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_BRACERS_P2,
        },
    },

    [4850] = -- Argute Pants -> Argute Pants +2 - 50 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_PANTS,
        },

        textOffset  = 1308,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_PANTS_P2,
        },
    },

    [4851] = -- Argute Pants +1 -> Argute Pants +2 - 30 Forgotten Journey
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_PANTS_P1,
        },

        textOffset  = 1309,
        tradeItem   = tpz.items.FORGOTTEN_JOURNEY,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_PANTS_P2,
        },
    },

    [4852] = -- Argute Loafers -> Argute Loafers +2 - 50 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_LOAFERS,
        },

        textOffset  = 1310,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 50,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_LOAFERS_P2,
        },
    },

    [4853] = -- Argute Loafers +1 -> Argute Loafers +2 - 30 Forgotten Step
    {
        previousTrial = 0,
        requiredItem  =
        {
            itemId = tpz.items.ARGUTE_LOAFERS_P1,
        },

        textOffset  = 1311,
        tradeItem   = tpz.items.FORGOTTEN_STEP,
        numRequired = 30,

        rewardItem =
        {
            itemId = tpz.items.ARGUTE_LOAFERS_P2,
        },
    },

    [4959] =
    {
        previousTrial = 4665,
        requiredItem  =
        {
            itemId = tpz.items.MELEE_CROWN_P2,
        },

        textOffset  = 1325,
        gainExp     = true,
        zoneId      = set{ tpz.zone.DYNAMIS_XARCABARD, tpz.zone.DYNAMIS_TAVNAZIA },
        numRequired = 20000,

        rewardItem =
        {
            itemId = tpz.items.MELEE_CROWN_P2,
            itemAugments =
            {
                [1] = { 1334, 0 }, -- Enhances 'Penance' Effect
            },
        },
    },

    [5056] =
    {
        previousTrial = 4453,
        requiredItem  =
        {
            itemId = tpz.items.AEGIS_99,
        },

        textOffset  = 1258,
        tradeItem   = tpz.items.VIAL_OF_UMBRAL_MARROW,
        numRequired = 250,

        rewardItem =
        {
            itemId = tpz.items.AEGIS_99_II,
        },
    },
}