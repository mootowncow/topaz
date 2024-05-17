-----------------------------------------
-- ID: 6259
-- Item: akamochi+1
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP + 30 (Pet & Master)
-- Vitality + 4 (Pet & Master)
-- Attack + 17% Cap: 54 (Pet & Master) Pet Cap: 81
-- Accuracy + 11% Cap: 54 (Pet & Master) Pet Cap: 81
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6261)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 16)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:addMod(tpz.mod.FOOD_RACCP, 16)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 76)
    target:addPetMod(tpz.mod.HP, 30)
    target:addPetMod(tpz.mod.VIT, 4)
    target:addPetMod(tpz.mod.FOOD_ACCP, 11)
    target:addPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:addPetMod(tpz.mod.FOOD_RACCP, 11)
    target:addPetMod(tpz.mod.FOOD_RACC_CAP, 81)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 16)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 76)
    target:delMod(tpz.mod.FOOD_RACCP, 16)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 76)
    target:delPetMod(tpz.mod.HP, 30)
    target:delPetMod(tpz.mod.VIT, 4)
    target:delPetMod(tpz.mod.FOOD_ACCP, 11)
    target:delPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:delPetMod(tpz.mod.FOOD_RACCP, 11)
    target:delPetMod(tpz.mod.FOOD_RACC_CAP, 81)
end
