-----------------------------------------
-- ID: 5273
-- Old Quiver +3
-- When used, you will obtain one partial stack of Crude Arrows +3
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
    target:addItem(18184, math.random(99))
    local ID = zones[target:getZoneID()]
    target:messageSpecial(ID.text.ITEM_OBTAINED, 18184)
end
