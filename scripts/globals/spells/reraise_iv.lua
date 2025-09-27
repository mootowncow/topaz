-----------------------------------------
-- Spell: Reraise 4
-----------------------------------------

require("scripts/globals/status")

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    target:delStatusEffectSilent(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 4, 0, 3600) --reraise 4, 60min duration

    return tpz.effect.RERAISE
end
