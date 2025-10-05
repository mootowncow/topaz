--------------------------------------
-- Spell: Absorb-ACC
-- Steals an enemy's accuracy.
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doAbsorbSpell(caster, target, spell, tpz.effect.ACCURACY_BOOST)
end

