-----------------------------------------
-- ID: 5174
-- Item: tavnazian_taco
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 20
-- Magic 20
-- Dexterity 4
-- Agility 4
-- Vitality 6
-- Charisma 4
-- Defense % 25
-- HP Recovered While Healing 1
-- MP Recovered While Healing 1
-- Defense Cap 150
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5174)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 150)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 150)
    target:delMod(tpz.mod.HPHEAL, 1)
end
