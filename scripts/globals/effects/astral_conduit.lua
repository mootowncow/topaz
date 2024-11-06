-----------------------------------
--
--     tpz.effect.ASTRAL_CONDUIT
--     
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.ASTRAL_CONDUIT_EFFECT)

    target:addPetMod(tpz.mod.BP_DAMAGE, jpValue)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.ASTRAL_CONDUIT_EFFECT)

    target:delPetMod(tpz.mod.BP_DAMAGE, jpValue)
end
