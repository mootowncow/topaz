-----------------------------------------
-- ID: 5618
-- Item: bowl_of_zoni_broth
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP 10
-- MP 10
-- Strength 1
-- Dexterity 1
-- Vitality 1
-- Agility 1
-- Accuracy +1
-- Ranged Accuracy +1
-- Attack +1
-- Ranged Attack +1
-- Evasion +1
-- HP Recovered While Healing 1
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5618)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 50)
    target:addMod(tpz.mod.MP, 50)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 50)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 50)
    target:delMod(tpz.mod.MP, 50)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 50)
end
