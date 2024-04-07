-----------------------------------------
-- ID: 4255
-- Item: Mana Powder
-- Item Effect: Restores 25% of maximum MP to nearby allies
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.PINCH_OF_MANA_POWDER)
    local param = item:getParam() / 100
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, target:addMP(target:getMaxMP() * param))
end
