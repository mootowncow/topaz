-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
    -- the effect restore strengh of 1 every 3 ticks.
    local power = effect:getPower()
    if (power > 10) then
        effect:setPower(power - 10)
    end
end

function onEffectLose(target, effect)
end
