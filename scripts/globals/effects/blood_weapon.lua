-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:delStatusEffectSilent(tpz.effect.AUSPICE)
    target:delStatusEffectSilent(tpz.effect.ENSTONE)
    target:delStatusEffectSilent(tpz.effect.ENSTONE_II)
    target:delStatusEffectSilent(tpz.effect.ENWATER)
    target:delStatusEffectSilent(tpz.effect.ENWATER_II)
    target:delStatusEffectSilent(tpz.effect.ENAERO)
    target:delStatusEffectSilent(tpz.effect.ENAERO_II)
    target:delStatusEffectSilent(tpz.effect.ENFIRE)
    target:delStatusEffectSilent(tpz.effect.ENFIRE_II)
    target:delStatusEffectSilent(tpz.effect.ENBLIZZARD)
    target:delStatusEffectSilent(tpz.effect.ENBLIZZARD_II)
    target:delStatusEffectSilent(tpz.effect.ENTHUNDER)
    target:delStatusEffectSilent(tpz.effect.ENTHUNDER_II)
    target:delStatusEffectSilent(tpz.effect.ENLIGHT)
    target:delStatusEffectSilent(tpz.effect.ENDARK)

    target:setMod(tpz.mod.ENSPELL, tpz.magic.enspell.BLOOD_WEAPON)
    target:setMod(tpz.mod.ENSPELL_DMG, 1)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if target:hasStatusEffect(tpz.effect.SOUL_ENSLAVEMENT) then
        target:setMod(tpz.mod.ENSPELL, tpz.magic.enspell.SOUL_ENSLAVEMENT)
    else
        target:setMod(tpz.mod.ENSPELL,  0)
    end
    target:delMod(tpz.mod.ENSPELL_DMG, 0)
end
