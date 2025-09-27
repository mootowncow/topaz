-----------------------------------------
-- Spell: Fire V
-- Deals fire damage to an enemy.
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
    spellParams.V0   = 1130
    spellParams.V50  = 1405
    spellParams.V100 = 1690
    spellParams.V200 = 2160
    spellParams.V300 = 2530
    spellParams.V400 = 2815
    spellParams.V500 = 3012
    spellParams.V600plus = 3112
    spellParams.M0   = 5.5
    spellParams.M50  = 5.7
    spellParams.M100 = 4.7
    spellParams.M200 = 3.7
    spellParams.M300 = 2.85
    spellParams.M400 = 1.97
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
