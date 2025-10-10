-----------------------------------------
-- Fleeting Cluster
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

function onItemUse(target, item, itemUser)
    local param = item:getParam()
    local ID = zones[target:getZoneID()]

    target:addItem(tpz.items.REMNANT_OF_A_FLEETING_MEMORY, param)
    target:messageSpecial(ID.text.ITEM_OBTAINED, tpz.items.REMNANT_OF_A_FLEETING_MEMORY)
end

