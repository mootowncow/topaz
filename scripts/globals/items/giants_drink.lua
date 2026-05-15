-----------------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +100% HP
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local itemId = GetItem(tpz.items.BOTTLE_OF_GIANTS_DRINK):getID()
    local power = 100
    local duration = 900
    return tpz.itemUtils.temps.HPBoost(target, itemId, power, duration)
end
