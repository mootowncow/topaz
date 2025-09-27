-----------------------------------------
-- Spell: Blizzard V
-- Deals ice damage to an enemy.
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
    spellParams.V0   = 1190
    spellParams.V50  = 1440
    spellParams.V100 = 1720
    spellParams.V200 = 2180
    spellParams.V300 = 2540
    spellParams.V400 = 2820
    spellParams.V500 = 3016
    spellParams.V600plus = 3116
    spellParams.M0   = 5
    spellParams.M50  = 5.6
    spellParams.M100 = 4.6
    spellParams.M200 = 3.6
    spellParams.M300 = 2.8
    spellParams.M400 = 1.96
    spellParams.M500 = 1
    spellParams.M600plus = 1

    return doElementalNuke(caster, spell, target, spellParams)
end
