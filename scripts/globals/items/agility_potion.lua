-----------------------------------------
--  ID: 4205
--  Item: Agility Potion
--  Agility 7
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
    target:addStatusEffect(tpz.effect.AGI_BOOST, 20, 0, 30)
	target:addStatusEffect(tpz.effect.EVASION_BOOST, 1000, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.EVASION_BOOST)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
end
