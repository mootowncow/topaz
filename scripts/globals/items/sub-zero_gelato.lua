-----------------------------------------
-- ID: 5155
-- Item: cone_of_sub-zero_gelato
-- Food Effect: 1Hr, All Races
-----------------------------------------
-- HP 10
-- MP % 16 (cap 80)
-- MP Recovered While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5155)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.FOOD_MPP, 16)
    target:addMod(tpz.mod.FOOD_MP_CAP, 80)
    target:addMod(tpz.mod.ENH_MAGIC_DURATION, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.FOOD_MPP, 16)
    target:delMod(tpz.mod.FOOD_MP_CAP, 80)
    target:delMod(tpz.mod.ENH_MAGIC_DURATION, 10)
end
