-----------------------------------
--
--     tpz.effect.OVERDRIVE
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    local jpBonus = target:getJobPointLevel(tpz.jp.OVERDRIVE_EFFECT) * 5

    if pet then
        pet:setLocalVar("overdrive", 1)
        pet:addMod(tpz.mod.HASTE_ABILITY, 2500)
        pet:addMod(tpz.mod.MAIN_DMG_RATING, 30)
        pet:addMod(tpz.mod.RANGED_DMG_RATING, 30)
        pet:addMod(tpz.mod.ATTP, 50)
        pet:addMod(tpz.mod.RATTP, 50)
        pet:addMod(tpz.mod.ACC, 100)
        pet:addMod(tpz.mod.RACC, 100)
        pet:addMod(tpz.mod.EVA, 50)
        pet:addMod(tpz.mod.MEVA, 50)
        pet:addMod(tpz.mod.DMG, -50)
        if jpBonus > 0 then
            pet:addMod(tpz.mod.STR, jpBonus)
            pet:addMod(tpz.mod.DEX, jpBonus)
            pet:addMod(tpz.mod.VIT, jpBonus)
            pet:addMod(tpz.mod.AGI, jpBonus)
            pet:addMod(tpz.mod.INT, jpBonus)
            pet:addMod(tpz.mod.MND, jpBonus)
            pet:addMod(tpz.mod.CHR, jpBonus)
        end
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.OVERLOAD_THRESH, 5000)
    local pet = target:getPet()
    local jpBonus = target:getJobPointLevel(tpz.jp.OVERDRIVE_EFFECT) * 5

    if pet and pet:getLocalVar("overdrive") ~= 0 then
        pet:setLocalVar("overdrive", 0)
        pet:delMod(tpz.mod.HASTE_ABILITY, 2500)
        pet:delMod(tpz.mod.MAIN_DMG_RATING, 30)
        pet:delMod(tpz.mod.RANGED_DMG_RATING, 30)
        pet:delMod(tpz.mod.ATTP, 50)
        pet:delMod(tpz.mod.RATTP, 50)
        pet:delMod(tpz.mod.ACC, 100)
        pet:delMod(tpz.mod.RACC, 100)
        pet:delMod(tpz.mod.EVA, 50)
        pet:delMod(tpz.mod.MEVA, 50)
        pet:delMod(tpz.mod.DMG, -50)
        if jpBonus > 0 then
            pet:delMod(tpz.mod.STR, jpBonus)
            pet:delMod(tpz.mod.DEX, jpBonus)
            pet:delMod(tpz.mod.VIT, jpBonus)
            pet:delMod(tpz.mod.AGI, jpBonus)
            pet:delMod(tpz.mod.INT, jpBonus)
            pet:delMod(tpz.mod.MND, jpBonus)
            pet:delMod(tpz.mod.CHR, jpBonus)
        end
    end
end
