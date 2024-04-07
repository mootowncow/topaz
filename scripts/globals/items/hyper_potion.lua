-----------------------------------------
-- ID: 5254
-- Item: Hyper-Potion
-- Item Effect: Restores 500 HP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    if (target:getHP() == target:getMaxHP()) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.HYPER_POTION)
    local param = item:getParam()
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(param))
 end