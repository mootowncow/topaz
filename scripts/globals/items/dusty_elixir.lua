-----------------------------------------
-- ID: 5433
-- Item: Dusty Elixir
-- Item Effect: Instantly restores 50% of HP and MP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.DUSTY_ELIXIR)
    local param = item:getParam() / 100
    target:addHP(target:getMaxHP() * param)
    target:addMP(target:getMaxMP() * param)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end
