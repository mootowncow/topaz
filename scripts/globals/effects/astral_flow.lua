-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    if target:isPC() then
        local jpBonus = target:getJobPointLevel(tpz.jp.ASTRAL_FLOW_EFFECT) * 5

        if jpBonus > 0 then
            target:addPetMod(tpz.mod.STR, jpBonus)
            target:addPetMod(tpz.mod.DEX, jpBonus)
            target:addPetMod(tpz.mod.VIT, jpBonus)
            target:addPetMod(tpz.mod.AGI, jpBonus)
            target:addPetMod(tpz.mod.INT, jpBonus)
            target:addPetMod(tpz.mod.MND, jpBonus)
            target:addPetMod(tpz.mod.CHR, jpBonus)
        end
        target:recalculateAbilitiesTable()
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if target:isPC() then
        local jpBonus = target:getJobPointLevel(tpz.jp.ASTRAL_FLOW_EFFECT) * 5

        if jpBonus > 0 then
            target:delPetMod(tpz.mod.STR, jpBonus)
            target:delPetMod(tpz.mod.DEX, jpBonus)
            target:delPetMod(tpz.mod.VIT, jpBonus)
            target:delPetMod(tpz.mod.AGI, jpBonus)
            target:delPetMod(tpz.mod.INT, jpBonus)
            target:delPetMod(tpz.mod.MND, jpBonus)
            target:delPetMod(tpz.mod.CHR, jpBonus)
        end
        target:recalculateAbilitiesTable()
    end
end
