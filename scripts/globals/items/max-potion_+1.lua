-----------------------------------------
-- ID: 4125
-- Item: Max-Potion +1
-- Item Effect: Restores 1100 HP
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
    local item = GetItem(tpz.items.MAX_POTION +1)
    local param = item:getParam()
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(param))
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 180)
 end