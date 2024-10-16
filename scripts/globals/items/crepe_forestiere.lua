-----------------------------------------
-- ID: 5774
-- Item: crepe_forestiere
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Mind 2
-- MP % 10 (cap 35)
-- Magic Accuracy +15
-- Magic Def. Bonus +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5774)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MND, 3)
    target:addMod(tpz.mod.CURE_POTENCY, 7)
    target:addMod(tpz.mod.ENMITY, -1)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MND, 3)
    target:delMod(tpz.mod.CURE_POTENCY, 7)
    target:delMod(tpz.mod.ENMITY, -1)
    target:delMod(tpz.mod.MPHEAL, 3)
end
