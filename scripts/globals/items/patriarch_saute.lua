-----------------------------------------
-- ID: 5677
-- Item: Serving of Patriarch Sautee
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- MP 65
-- Mind 7
-- MP Recovered While Healing 7
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end