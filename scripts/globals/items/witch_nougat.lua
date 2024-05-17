-----------------------------------------
-- ID: 5645
-- Item: piece_of_witch_nougat
-- Food Effect: 1hour, All Races
-----------------------------------------
-- MP 50
-- Mind 7
-- Agility -3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5645)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 50)
    target:addMod(tpz.mod.MND, 7)
    target:addMod(tpz.mod.AGI, -3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 50)
    target:delMod(tpz.mod.MND, 7)
    target:delMod(tpz.mod.AGI, -3)
end
