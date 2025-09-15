-----------------------------------
--
--     tpz.effect.SACROSANCTITY
--
-----------------------------------
function onEffectGain(target, effect)
    local jpBonus = target:getJobPointLevel(tpz.jp.SACROSANCTITY_EFFECT)

    target:addMod(tpz.mod.ATT, 25)
    target:addMod(tpz.mod.ACC, 25)
    target:addMod(tpz.mod.HASTE_ABILITY, 1000)
    target:addMod(tpz.mod.MDEF, jpBonus)
    target:addMod(tpz.mod.CURE_POTENCY, -50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpBonus = target:getJobPointLevel(tpz.jp.SACROSANCTITY_EFFECT)

    target:delMod(tpz.mod.ATT, 25)
    target:delMod(tpz.mod.ACC, 25)
    target:delMod(tpz.mod.HASTE_ABILITY, 1000)
    target:delMod(tpz.mod.MDEF, jpBonus)
    target:delMod(tpz.mod.CURE_POTENCY, -50)
end
