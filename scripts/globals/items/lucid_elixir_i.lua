-----------------------------------------
-- ID: 5830
-- Item: Lucid Elixir I
-- Item Effect: Restores 50% of HP and MP
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
    local item = GetItem(tpz.items.LUCID_ELIXIR_I)
    local param = item:getParam() / 100
    target:addHP(target:getMaxHP() * param)
    target:addMP(target:getMaxMP() * param)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end
