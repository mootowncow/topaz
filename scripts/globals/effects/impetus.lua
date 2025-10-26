-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    local body = target:getEquipID(tpz.slot.BODY)
    local tantraCyclas_plus1 = body == 11185
    local tantraCyclas_plus2 = body == 11085
    -- TODO: Emp armor

	target:addMod(tpz.mod.ATT, effect:getPower())
    target:addMod(tpz.mod.CRITHITRATE, effect:getSubPower())

    -- if tantraCyclas_plus1 or tantraCyclas_plus2 then
    --     target:addMod(tpz.mod.ACC, effect:getPower())
    -- end

    -- if tantraCyclas_plus2 then
    --     target:addMod(tpz.mod.CRIT_DMG_INCREASE, effect:getSubPower())
    -- end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local body = target:getEquipID(tpz.slot.BODY)
    local tantraCyclas_plus1 = body == 11185
    local tantraCyclas_plus2 = body == 11085
    -- TODO: Emp armor

    target:delMod(tpz.mod.ATT, effect:getPower())
    target:delMod(tpz.mod.CRITHITRATE, effect:getSubPower())

    -- if tantraCyclas_plus1 or tantraCyclas_plus2 then
    --     target:delMod(tpz.mod.ACC, effect:getPower())
    -- end

    -- if tantraCyclas_plus2 then
    --     target:delMod(tpz.mod.CRIT_DMG_INCREASE, effect:getSubPower())
    -- end
end
