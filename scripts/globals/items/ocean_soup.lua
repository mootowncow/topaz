-----------------------------------------
-- ID: 4285
-- Item: bowl_of_ocean_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- Health 25
-- Dexterity 3
-- Vitality 5
-- Defense % 25
-- Defense Cap 125
-- Conserve MP +12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4285)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 175)
    target:addMod(tpz.mod.CONSERVE_MP, 12)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 175)
    target:delMod(tpz.mod.CONSERVE_MP, 12)
end