-----------------------------------------
-- ID: 15912
-- Item: Lieutenant's Sash
-- On Use: Removes food effect.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.FOOD)
    target:delStatusEffectSilent(tpz.effect.FIELD_SUPPORT_FOOD)
end
