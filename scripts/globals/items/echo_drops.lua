-----------------------------------------
-- ID: 4151
-- Item: Echo Drops
-- Item Effect: This potion remedies silence.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)

    if (target:hasStatusEffect(tpz.effect.SILENCE) == true) then
        local effect = target:getStatusEffect(tpz.effect.SILENCE)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.SILENCE)
        else
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        end
    end
end

