-----------------------------------------
-- ID: 5770
-- Item: Super Reraiser
-- Item Effect: This potion functions the same way as the spell Reraise.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 3600
    target:delStatusEffectSilent(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 3, 0, duration)
    target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, tpz.effect.RERAISE, tpz.effect.RERAISE)
    target:setEffectUndispellable(tpz.effect.RERAISE)
end
