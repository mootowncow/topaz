-----------------------------------
-- tpz.effect.SWORDPLAY
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HASTE_ABILITY, 1500)
    target:addMod(tpz.mod.INQUARTATA, 33)
    target:addMod(tpz.mod.UDMGMAGIC, -33)
    target:addMod(tpz.mod.STATUSRESTRAIT, 150)
    target:addMod(tpz.mod.DISPELRESTRAIT, 95)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HASTE_ABILITY, 1500)
    target:delMod(tpz.mod.INQUARTATA, 33)
    target:delMod(tpz.mod.UDMGMAGIC, -33)
    target:delMod(tpz.mod.STATUSRESTRAIT, 150)
    target:delMod(tpz.mod.DISPELRESTRAIT, 95)
end
