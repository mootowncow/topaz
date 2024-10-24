-----------------------------------------
-- ID: 5917
-- Item: Choco-scroll
-- Food Effect: 3 Min, All Races
-----------------------------------------
-- Mind 1
-- Speed 12.5%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5917)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.MOVE_SPEED_QUICKENING, 13)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.MOVE_SPEED_QUICKENING, 13)
end
