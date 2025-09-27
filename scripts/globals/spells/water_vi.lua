-----------------------------------------
-- Spell: Water V
-- Deals water damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = false
    spellParams.resistBonus = 25
    spellParams.V0   = 1010
    spellParams.V50  = 1335
    spellParams.V100 = 1630
    spellParams.V200 = 2120
    spellParams.V300 = 2510
    spellParams.V400 = 2805
    spellParams.V500 = 3004
    spellParams.V600plus = 3104
    spellParams.M0   = 6.5
    spellParams.M50  = 5.9
    spellParams.M100 = 4.9
    spellParams.M200 = 3.9
    spellParams.M300 = 2.95
    spellParams.M400 = 1.99
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
