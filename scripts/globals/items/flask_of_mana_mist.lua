-----------------------------------------
-- ID: 5833
-- Item: Mana Mist
-- Item Effect: Restores 300 MP to nearby allies
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.FLASK_OF_MANA_MIST)
    local param = item:getParam()
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, target:addMP(param))
end
