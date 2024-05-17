-----------------------------------------
-- ID: 4329
-- Item: serving_of_newt_flambe
-- Food Effect: 240Min, All Races
-----------------------------------------
-- +3 STR
-- +4 AGI
-- +12% ranged attack(Cap: 55)
-- -12 enmity
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

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4329)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_RATTP, 12)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 55)
    target:addMod(tpz.mod.ENMITY, -12)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_RATTP, 12)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 55)
    target:delMod(tpz.mod.ENMITY, -12)
end
