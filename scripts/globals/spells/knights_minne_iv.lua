-----------------------------------------
-- Spell: Knight's Minne IV
-- Grants Defense bonus to all allies.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.MINNE)
end
