-----------------------------------------
-- Spell: Wind Carol
-- Increases wind resistance for party members within the area of effect.
-----------------------------------------
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.CAROL)
end
