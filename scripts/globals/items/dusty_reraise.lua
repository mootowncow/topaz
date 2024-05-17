-----------------------------------------
-- ID: 5436
-- name: dusty_scroll_of_reraise
-- effect: grants reraise III for 10m
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.RERAISE
    local power = 3
    local duration = 3600

    if (target:addStatusEffect(effect, power, 3, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
