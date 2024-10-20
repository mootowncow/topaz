-----------------------------------------
-- Spell: Banish IV
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 420
    params.multiplier = 1.5
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    dmg = doDivineBanishNuke(caster, target, spell, params)
    return dmg
end
