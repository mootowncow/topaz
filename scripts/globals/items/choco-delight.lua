-----------------------------------------
-- ID: 4283
-- Item: cup_of_choco-delight
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Magic Regen While Healing 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4283)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 15)
    target:addMod(tpz.mod.FOOD_MP_CAP, 110)   
	target:addMod(tpz.mod.MND, 2)
	target:addMod(tpz.mod.INT, 2)
	target:addMod(tpz.mod.ACC, -20)
	target:addMod(tpz.mod.RACC, -20)
	target:addMod(tpz.mod.CONSERVE_MP, 11)
	target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 15)
    target:delMod(tpz.mod.FOOD_MP_CAP, 110)
	target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.INT, 2)
	target:delMod(tpz.mod.ACC, -20)
	target:delMod(tpz.mod.RACC, -20)
	target:delMod(tpz.mod.CONSERVE_MP, 11)
    target:delMod(tpz.mod.MPHEAL, 1)
end
