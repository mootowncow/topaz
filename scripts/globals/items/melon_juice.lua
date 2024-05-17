-----------------------------------------
-- ID: 4424
-- Item: Melon Juice
-- Item Effect: Restores 90 MP over 135 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
        target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 135)
end
