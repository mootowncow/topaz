-----------------------------------------
-- ID: 5437
-- Item: Flask of Strange Milk
-- Medicine Effects: (Instant, 10 minutes)
-- 6HP/3 second regen
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.REGEN
    local power = 20
    local duration = 600

    if (target:addStatusEffect(effect, power, 3, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
