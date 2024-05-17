-----------------------------------------
-- ID: 5850
-- Item: bottle_of_swiftshot_drink
-- Item Effect: Double Shot +100
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.MULTI_SHOTS
    local power = 100
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end
