-----------------------------------------
-- Spell: Cocoon
-- Enhances defense
-- Spell cost: 10 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: VIT+3
-- Level: 8
-- Casting Time: 1.75 seconds
-- Recast Time: 60 seconds
-- Duration: 90 seconds
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.DEFENSE_BOOST
    local power = 50
    local duration = 300
    local tick = 0
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end
