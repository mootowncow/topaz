-----------------------------------------
-- ID: 4175
-- Item: Vile Elixir +1
-- Item Effect: Instantly restores 55% of HP and MP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    if target:getMaxHP() == target:getHP() and target:getMaxMP() == target:getMP() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.VILE_ELIXIR +1)
    local param = item:getParam() / 100
    target:addHP(target:getMaxHP() * param)
    target:addMP(target:getMaxMP() * param)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end
