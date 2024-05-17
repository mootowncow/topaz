-----------------------------------------
-- ID: 5390
-- Braver's Drink
-- Gives +15 to all Attributes
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    
    local power = 15
    local duration = 180

    -- TODO messaging ?  Could use a capture
    target:addStatusEffect(tpz.effect.STR_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.DEX_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.VIT_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.AGI_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.INT_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.MND_BOOST, power, 0, duration)
    target:addStatusEffect(tpz.effect.CHR_BOOST, power, 0, duration)
    target:messagePublic(tpz.msg.basic.ITEM_ALL_STATS_BOOSTED, target, effect, effect)
end
