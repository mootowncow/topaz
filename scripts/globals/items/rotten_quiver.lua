-----------------------------------------
-- ID: 4196
-- Rotten Quiver
-- When used, you will obtain 18 Old Arrows
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

function onItemUse(target)
    target:addItem(17331, 99)
    local ID = zones[target:getZoneID()]
    target:messageSpecial(ID.text.ITEM_OBTAINED, 17331)
end
