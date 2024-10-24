-----------------------------------------
-- ID: 4129
-- Item: Ether +1
-- Item Effect: Restores 55 MP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    if (target:getMP() == target:getMaxMP()) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.ETHER +1)
    local param = item:getParam()
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, target:addMP(param))
end
