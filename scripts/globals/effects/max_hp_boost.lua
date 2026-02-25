-----------------------------------
--
-- tpz.effect.MAX_HP_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local currentHpPercent = target:getHPP()
    target:addMod(tpz.mod.HPP, effect:getPower())

    -- Set HP percent back to what it was before the HP boost
    target:queue(0, function(target)
        target:setHPP(currentHpPercent)
    end)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPP, effect:getPower())
end
