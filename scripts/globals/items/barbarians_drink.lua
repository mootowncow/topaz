-----------------------------------------
-- ID: 5385
-- Barbarian's Drink
-- Increases Attack of the user by 50%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ATTACK_BOOST
    local power = 50
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration, 0, power, 0)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
