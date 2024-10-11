-----------------------------------
--
-- tpz.effect.ELEMENTAL_SFORZO
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FIREDEF, 256)
    target:addMod(tpz.mod.ICEDEF, 256)
    target:addMod(tpz.mod.WINDDEF, 256)
    target:addMod(tpz.mod.EARTHDEF, 256)
    target:addMod(tpz.mod.THUNDERDEF, 256)
    target:addMod(tpz.mod.WATERDEF, 256)
    target:addMod(tpz.mod.LIGHTDEF, 256)
    target:addMod(tpz.mod.DARKDEF, 256)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FIREDEF, 256)
    target:delMod(tpz.mod.ICEDEF, 256)
    target:delMod(tpz.mod.WINDDEF, 256)
    target:delMod(tpz.mod.EARTHDEF, 256)
    target:delMod(tpz.mod.THUNDERDEF, 256)
    target:delMod(tpz.mod.WATERDEF, 256)
    target:delMod(tpz.mod.LIGHTDEF, 256)
    target:delMod(tpz.mod.DARKDEF, 256)
end
