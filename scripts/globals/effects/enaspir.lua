-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/spell_data")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getPower() == 6592 then -- Heavenward Howl - Aspir
        target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.HEAVENWARD_HOWL_ASPIR)  
        target:addMod(tpz.mod.ENSPELL_DMG, 5)
    else
        target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.ASPIR)
        target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end
