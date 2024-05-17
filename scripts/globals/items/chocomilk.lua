-----------------------------------------
-- ID: 4498
-- Item: cup_of_chocomilk
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Magic Regen While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4498)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 15)
    target:addMod(tpz.mod.FOOD_MP_CAP, 100)   
	target:addMod(tpz.mod.MND, 2)
	target:addMod(tpz.mod.INT, 2)
	target:addMod(tpz.mod.ACC, -20)
	target:addMod(tpz.mod.RACC, -20)
	target:addMod(tpz.mod.CONSERVE_MP, 10)
	target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 15)
    target:delMod(tpz.mod.FOOD_MP_CAP, 100)
	target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.INT, 2)
	target:delMod(tpz.mod.ACC, -20)
	target:delMod(tpz.mod.RACC, -20)
	target:delMod(tpz.mod.CONSERVE_MP, 10)
    target:delMod(tpz.mod.MPHEAL, 1)
end
