-----------------------------------------
--  ID: 42020
--  Item: Intelligence Potion
--  Intelligence 20
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
    target:addStatusEffect(tpz.effect.INT_BOOST, 20, 0, 30)
    target:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 50, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.MAGIC_ATK_BOOST)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
end
