-----------------------------------------
-- Spell: Army's Paeon VIII (Mobs only)
-- Gradually restores target's HP.
-----------------------------------------
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.PAEON)
end