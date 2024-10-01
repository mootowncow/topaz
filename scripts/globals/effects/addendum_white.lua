-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    if target:isPC() then
        target:recalculateAbilitiesTable()
    end
    local bonus = effect:getPower()
    local regen = effect:getSubPower()

    target:addMod(tpz.mod.WHITE_MAGIC_COST, -10)
    target:addMod(tpz.mod.WHITE_MAGIC_CAST, -10)
    target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
    target:addMod(tpz.mod.BLACK_MAGIC_COST, 20)
    target:addMod(tpz.mod.BLACK_MAGIC_CAST, 20)
    target:addMod(tpz.mod.BLACK_MAGIC_RECAST, 20)

    -- Regen and Accuracy bonus to SCH main only
    if (target:getMainJob() == tpz.job.SCH) then
        target:addMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(tpz.mod.REGEN_DURATION, 120)
        target:addMod(tpz.mod.ACC, 50)
    end

    if target:isPC() or target:isTrust() then
        target:recalculateSkillsTable()
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if target:isPC() then
        target:recalculateAbilitiesTable()
    end
    local bonus = effect:getPower()
    local regen = effect:getSubPower()

    target:delMod(tpz.mod.WHITE_MAGIC_COST, -10)
    target:delMod(tpz.mod.WHITE_MAGIC_CAST, -10)
    target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
    target:delMod(tpz.mod.BLACK_MAGIC_COST, 20)
    target:delMod(tpz.mod.BLACK_MAGIC_CAST, 20)
    target:delMod(tpz.mod.BLACK_MAGIC_RECAST, 20)

    -- Regen and Accuracy bonus to SCH main only
    if (target:getMainJob() == tpz.job.SCH) then
        target:delMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(tpz.mod.REGEN_DURATION, 120)
        target:delMod(tpz.mod.ACC, 50)
    end

    if target:isPC() then
        target:recalculateSkillsTable()
    end
end
