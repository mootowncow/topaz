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

tpz.magian.trials = {
    [tpz.items.PUGILISTS] = -- Main weapon
    {
        [tpz.items.DAYBREAK_SOUL] = -- Secondary trade
        {
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

        [tpz.items.BABY_BLOBDINGNAG] =
        {
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
        }
    },
}
