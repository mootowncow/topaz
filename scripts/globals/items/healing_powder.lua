-----------------------------------------
-- ID: 5322
-- Item: Healing Powder
-- Item Effect: Restores 25% HP to all allies
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.FLASK_OF_HEALING_POWDER)
    local param = item:getParam()
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(param))
end
