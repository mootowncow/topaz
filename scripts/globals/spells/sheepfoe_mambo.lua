-----------------------------------------
-- Spell: Sheepfoe Mambo
-- Grants evasion bonus to all members.
-----------------------------------------
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.MAMBO)
end
