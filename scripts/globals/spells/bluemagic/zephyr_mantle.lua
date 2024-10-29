-----------------------------------------
-- Spell: Zephyr Mantle
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 31 MP
-- Monster Type: Dragons
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+2
-- Level: 65
-- Casting Time: 7 seconds
-- Recast Time: 60 seconds
-- Duration: 5 minutes
--
-- Combos: Conserve MP
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.BLINK
    local numShadows = 4
    local duration = 300
    local tick = 0
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, numShadows, tick, duration, subid, subpower, tier, params, bonus)
end
