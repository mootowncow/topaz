-----------------------------------------
-- ID: 4301
-- Item: Pear au Lait
-- Item Effect: Restores 300 HP over 300 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
	target:addStatusEffect(tpz.effect.REGEN, 3, 3, 300)
end
