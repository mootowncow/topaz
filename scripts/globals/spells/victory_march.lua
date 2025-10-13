-----------------------------------------
-- Spell: Victory March
-- Gives party members Haste
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doBuffSong(caster, target, spell, tpz.effect.MARCH)
end
