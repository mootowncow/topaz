-----------------------------------
--
--     tpz.effect.SENGIKORI
--
-----------------------------------
function onEffectGain(target, effect)
    if target:isPC() then
        target:addMod(tpz.mod.SKILLCHAINDMG, 25)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if target:isPC() then
        target:delMod(tpz.mod.SKILLCHAINDMG, 25)
    end
end
