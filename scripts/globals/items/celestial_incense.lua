-----------------------------------------
-- ID: 5434
-- Celestial Incense
-- Makes user immune to ranged damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.ARROW_SHIELD
    local power = 1
    local duration = 12

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
        target:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
