-----------------------------------------
-- ID: 4150
-- Item: Eye Drops
-- Item Effect: This potion remedies blindness.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:hasStatusEffect(tpz.effect.BLINDNESS) == true) then
        local effect = target:getStatusEffect(tpz.effect.BLINDNESS)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BLINDNESS)
        end
    end
end

