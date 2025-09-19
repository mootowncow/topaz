-----------------------------------------
-- Spell: Thunder V
-- Deals lightning damage to an enemy.
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
    spellParams.V0   = 1250
    spellParams.V50  = 1475
    spellParams.V100 = 1750
    spellParams.V200 = 2200
    spellParams.V300 = 2550
    spellParams.V400 = 2825
    spellParams.V500 = 3020
    spellParams.V600plus = 3120
    spellParams.M0   = 4.5
    spellParams.M50  = 5.5
    spellParams.M100 = 4.5
    spellParams.M200 = 3.5
    spellParams.M300 = 2.75
    spellParams.M400 = 1.95
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
