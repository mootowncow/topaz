--------------------------------------
-- Spell: Gekka: Ichi
--     Grants Enmity Boost +30 for Caster
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.ENMITY_BOOST
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    caster:delStatusEffectSilent(tpz.effect.PAX)
    caster:addStatusEffect(effect, 30, 0, duration)
    return effect
end
