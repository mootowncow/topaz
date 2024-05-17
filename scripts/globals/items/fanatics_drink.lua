-----------------------------------------
-- ID: 5434
-- Fanatic's Drink
-- Makes user immune to physical damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.PHYSICAL_SHIELD
    local power = 1 
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:delStatusEffect(tpz.effect.MAGIC_SHIELD)
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
