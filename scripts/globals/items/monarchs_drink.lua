-----------------------------------------
-- ID: 5393
-- Monarch's Drink
-- Grants a regain.  30 tp/tick over 3 mins for a total of 1,800
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    if target:hasStatusEffect(tpz.effect.REGAIN) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
    end
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.REGAIN
    local power = 3
    local duration = 180

    if (target:addStatusEffect(effect, power, 3, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
