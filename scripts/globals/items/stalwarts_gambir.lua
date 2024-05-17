-----------------------------------------
-- ID: 5840
-- Item: bottle_of_stalwarts_gambir
-- Item Effect: RATTP 50 ATTP 50 ACC 100 RACC 100
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ATTACK_BOOST
    local effect2 = tpz.effect.ACCURACY_BOOST
    local power = 50
    local power2 = 100
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration, 0, power, 0)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
    target:addStatusEffect(effect2, power2, 0, duration)
end
