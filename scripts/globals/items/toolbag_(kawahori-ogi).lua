-----------------------------------------
-- ID: 5310
-- Toolbag Kawa
-- When used, you will obtain one stack of kawahori-ogi
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
    target:addItem(1167, 99)
    local ID = zones[target:getZoneID()]
    target:messageSpecial(ID.text.ITEM_OBTAINED, 1167)
end

