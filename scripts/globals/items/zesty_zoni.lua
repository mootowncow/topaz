-----------------------------------------
-- ID: 5619
-- Item: Bowl of Zesti Zoni
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- HP 12
-- MP 12
-- Strength 2
-- Dexterity 2
-- Vitality 2
-- Agility 2
-- Accuracy +2
-- Ranged Accuracy +2
-- Attack +2
-- Ranged Attack +2
-- Evasion +2
-- MP Recovered while healing 1
-- HP Recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5619)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 50)
    target:addMod(tpz.mod.MP, 50)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 55)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 50)
    target:delMod(tpz.mod.MP, 50)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 55)
end
