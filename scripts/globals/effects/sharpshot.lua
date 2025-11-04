-----------------------------------
--
--    tpz.effect.SHARPSHOT
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/spell_data")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SHARPSHOT_EFFECT) * 2
    local taintPower = math.floor(target:getMainLvl() / 5)

    target:addMod(tpz.mod.RACC, effect:getPower())
    target:addMod(tpz.mod.RATT, jpValue)
    target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.TAINT)
    target:addMod(tpz.mod.ENSPELL_DMG, taintPower)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.SHARPSHOT_EFFECT) * 2

    target:delMod(tpz.mod.RACC, effect:getPower())
    target:delMod(tpz.mod.RATT, jpValue)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end
