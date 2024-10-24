-----------------------------------------
--  ID: 4201
--  Item: Dexterity Potion
--  Dexterity 20
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
    target:addStatusEffect(tpz.effect.DEX_BOOST, 20, 0, 30)
	target:addStatusEffect(tpz.effect.POTENCY, 100, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.POTENCY)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 900)
end
