-----------------------------------
--
--    tpz.effect.MINNE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEF, effect:getPower())
    if target:isPC() then
        target:addMod(tpz.mod.DMGPHYS, -10)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEF, effect:getPower())
    if target:isPC() then
        target:delMod(tpz.mod.DMGPHYS, -10)
    end
end
