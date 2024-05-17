-----------------------------------------
-- ID: 5729
-- Item: serving_of_bavarois
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP 20
-- Intelligence 3
-- hHP +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5729)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.STR, -2)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MPHEAL, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.STR, -2)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MPHEAL, 5)
end
