-----------------------------------------
-- ID: 5604
-- Item: Elshimo Pachira Fruit
-- Item Effect:  Poison 1HP / Removes 40 HP over 120 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local typeEffect = tpz.effect.POISON

    if (not target:hasStatusEffect(typeEffect)) then
        target:addStatusEffect(typeEffect, 1, 3, 120)
        local effect1 = target:getStatusEffect(typeEffect)
        effect1:unsetFlag(tpz.effectFlag.WALTZABLE)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
