-----------------------------------
--
--  tpz.effect.SHINING_RUBY
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SHINING_RUBY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SHINING_RUBY, effect:getPower())
end
