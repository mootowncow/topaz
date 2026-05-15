-----------------------------------------
-- ID: 4172
-- Item: Wizards Drink
-- Item Effect: +100% MP
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local itemId = GetItem(tpz.items.BOTTLE_OF_WIZARDS_DRINK):getID()
    local power = 100
    local duration = 900
    return tpz.itemUtils.temps.MPBoost(target, itemId, power, duration)
end
