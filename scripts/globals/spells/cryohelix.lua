--------------------------------------
-- Spell: Cryohelix
-- Deals ice damage that gradually reduces a target's HP. Damage dealt is greatly affected by the weather.
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local helix = doHelix(caster, target, spell, HELIX_TIER_1)

    return helix
end
