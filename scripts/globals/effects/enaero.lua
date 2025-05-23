-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getPower() == 6592 then -- Katabatic Blades
        local potency = math.floor(target:getMainLvl() / 3)
        target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.KATABATIC_BLADES)
        target:addMod(tpz.mod.ENSPELL_DMG, potency)
    else
        target:addMod(tpz.mod.ENSPELL, tpz.magic.element.WIND)
        target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end
