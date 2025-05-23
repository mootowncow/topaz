-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/spell_data")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getPower() == 6592 then -- Inferno Howl
        local potency = math.floor(target:getMainLvl() / 3)
        target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.INFERNO_HOWL)
        target:addMod(tpz.mod.ENSPELL_DMG, potency)
    else
        target:addMod(tpz.mod.ENSPELL, tpz.magic.element.FIRE)
        target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.ENSPELL_DMG, 0)
    target:setMod(tpz.mod.ENSPELL, 0)
end
