-----------------------------------------
-- ID: 5750
-- Item: bowl_of_goulash
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- VIT +3
-- INT -2
-- Accuracy +10% (cap 54)
-- DEF +10% (cap 30)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5750)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.MP, 40)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.CHR, 4)
    target:addMod(tpz.mod.MPHEAL, 3)

end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.MP, 40)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.CHR, 4)
    target:delMod(tpz.mod.MPHEAL, 3)

end
