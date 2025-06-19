-----------------------------------------
-- Spell: Viruna
-- Removes disease or plague from target.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return doNaSpell(caster, target, spell)
end
