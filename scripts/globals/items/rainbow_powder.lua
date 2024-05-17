-----------------------------------------
-- ID: 5362
-- Rainbow Powder
-- When applied, it makes things invisible.
-- Longer duration than Prism Powder
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 1080
    target:delStatusEffectSilent(tpz.effect.INVISIBLE)
    target:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
end
