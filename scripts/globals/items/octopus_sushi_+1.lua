-----------------------------------------
-- ID: 5694
-- Item: plate_of_octopus_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Strength 2
-- Accuracy % 15 (cap 72)
-- Ranged Accuracy % 15 (cap 72)
-- Resist Sleep +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5694)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.MATT, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 16)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:addMod(tpz.mod.FOOD_RACCP, 16)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 76)
    target:addMod(tpz.mod.SLEEPRESTRAIT, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.MATT, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 16)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:delMod(tpz.mod.FOOD_RACCP, 16)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 76)
    target:delMod(tpz.mod.SLEEPRESTRAIT, 2)
end
