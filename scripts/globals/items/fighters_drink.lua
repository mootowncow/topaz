-----------------------------------------
-- ID: 5386
-- Fighters's Drink
-- Increases Accuracy of the user by 100
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ACCURACY_BOOST
    local power = 100
    local duration = 90

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
