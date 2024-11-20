-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local hpBoost = target:getMainLvl() * 3

    target:addMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:addMod(tpz.mod.ENMITY, effect:getPower())
    target:addMod(tpz.mod.HP, hpBoost)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local hpBoost = target:getMainLvl() * 3

    target:delMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:delMod(tpz.mod.ENMITY, effect:getPower())
    target:delMod(tpz.mod.HP, hpBoost)
end
