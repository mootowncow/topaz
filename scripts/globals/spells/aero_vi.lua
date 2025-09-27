-----------------------------------------
-- Spell: Aero V
-- Deals wind damage to an enemy.
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
    spellParams.V0   = 1070
    spellParams.V50  = 1370
    spellParams.V100 = 1660
    spellParams.V200 = 2140
    spellParams.V300 = 2520
    spellParams.V400 = 2810
    spellParams.V500 = 3008
    spellParams.V600plus = 3108
    spellParams.M0   = 6
    spellParams.M50  = 5.8
    spellParams.M100 = 4.8
    spellParams.M200 = 3.8
    spellParams.M300 = 2.9
    spellParams.M400 = 1.98
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
