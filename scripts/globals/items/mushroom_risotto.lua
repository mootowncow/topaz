-----------------------------------------
-- ID: 4434
-- Item: Plate of Mushroom Risotto
-- Food Effect: 3 Hr, All Races
-----------------------------------------
-- MP 30
-- Strength -1
-- Vitality 3
-- Mind 3
-- MP Recovered while healing 2
-- Enmity -4
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end