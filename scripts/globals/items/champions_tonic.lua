-----------------------------------------
-- ID: 5843
-- Champion's Tonic
-- Grants 15% Haste (competitive with the spell) and 50% Critical Hit Rate.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.POTENCY
    local effect2 = tpz.effect.HASTE
    local power = 50
    local power2 = 1465 -- 150/1024 ~14.65%
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
    target:addStatusEffect(effect2, power2, 0, duration)
end
