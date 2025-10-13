-----------------------------------------
-- Spell: Valor Minuet IV
-- Grants Attack bonus to all allies.
-----------------------------------------
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.MINUET)
end
