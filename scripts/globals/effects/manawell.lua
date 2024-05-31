-----------------------------------
--
--     tpz.effect.MANAWELL
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.MANAWELL_EFFECT)
    target:addMod(tpz.mod.REFRESH, 120)
    target:addMod(tpz.mod.MAGIC_DAMAGE, jpValue)

    effect:setPower(target:speed())
    target:speed(0)

    if not target:hasStatusEffect(tpz.effect.SILENCE) and not target:hasStatusEffect(tpz.effect.MUTE) then
        target:addStatusEffect(tpz.effect.MUTE, 1, 0, 30)
    end
    if not target:hasStatusEffect(tpz.effect.AMNESIA) then
        target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, 30)
    end
    if not target:hasStatusEffect(tpz.effect.MUDDLE) then
        target:addStatusEffect(tpz.effect.MUDDLE, 1, 0, 30)
    end
    local effect = target:getStatusEffect(tpz.effect.AMNESIA)
    effect:unsetFlag(tpz.effectFlag.WALTZABLE)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.MANAWELL_EFFECT)
    target:delMod(tpz.mod.REFRESH, 120)
    target:delMod(tpz.mod.MAGIC_DAMAGE, jpValue)

    target:speed(effect:getPower())

    local mute = target:getStatusEffect(tpz.effect.MUTE)
    if (mute) then
        local duration = math.ceil((mute:getTimeRemaining()) / 1000)
        if (duration <= 30) then
            target:delStatusEffect(tpz.effect.MUTE)
        end
    end

    local amnesia = target:getStatusEffect(tpz.effect.AMNESIA)
    if (amnesia) then
        local duration = math.ceil((amnesia:getTimeRemaining()) / 1000)
        if (duration <= 30) then
            target:delStatusEffect(tpz.effect.AMNESIA)
        end
    end
    local muddle = target:getStatusEffect(tpz.effect.MUDDLE)
    if (muddle) then
        local duration = math.ceil((muddle:getTimeRemaining()) / 1000)
        if (duration <= 30) then
            target:delStatusEffect(tpz.effect.MUDDLE)
        end
    end
end
