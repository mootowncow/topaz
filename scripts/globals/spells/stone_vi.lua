-----------------------------------------
-- Spell: Stone V
-- Deals earth damage to an enemy.
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
    spellParams.V0   = 950
    spellParams.V50  = 1300
    spellParams.V100 = 1600
    spellParams.V200 = 2100
    spellParams.V300 = 2500
    spellParams.V400 = 2800
    spellParams.V500 = 3000
    spellParams.V600plus = 3100
    spellParams.M0   = 7
    spellParams.M50  = 6
    spellParams.M100 = 5
    spellParams.M200 = 4
    spellParams.M300 = 3
    spellParams.M400 = 2
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
