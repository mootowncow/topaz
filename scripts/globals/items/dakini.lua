-----------------------------------------
-- Item: Dakini
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/items")
require("scripts/globals/augments")
require("scripts/globals/item_utils")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    return TryAdditionalEffectAugment(player, target, tpz.skill.DAGGER, 255)
end

