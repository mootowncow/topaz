-----------------------------------------
-- ID: 15211
-- Reraise Hairpin
--  This Hairpin functions in the same way as the spell Reraise II.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 7200
    target:delStatusEffectSilent(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 2, 0, duration)
    target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, tpz.effect.RERAISE, tpz.effect.RERAISE)
    target:setEffectUndispellable(tpz.effect.RERAISE)
end
