-----------------------------------------
--  ID: 4209
--  Item: Mind Potion
--  Mind 20
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.MND_BOOST, 20, 0, 30)
    target:addStatusEffect(tpz.effect.INTENSION, 30, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.INTENSION)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
end
