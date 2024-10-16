-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addPetMod(tpz.mod.ACC, effect:getPower())
    target:addPetMod(tpz.mod.RACC, effect:getPower())

end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delPetMod(tpz.mod.ACC, effect:getPower())
    target:delPetMod(tpz.mod.RACC, effect:getPower())
end
