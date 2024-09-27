-----------------------------------------
-- Spell: Magnetite Cloud
-- Deals earth damage to enemies within a fan-shaped area originating from the caster. Additional effect: Weight
-- Spell cost: 86 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2
-- Level: 46
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Scission, Gravitation, and Darkness
-- Combos: Magic Defense Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = 0
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.EARTH
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.eco = ECO_NONE

    local damage = BlueBreathSpell(caster, target, spell, params, 0.75)
	damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.effect = tpz.effect.WEIGHT
    BlueTryEnfeeble(caster, target, spell, damage, 25, 0, 180, params)

    return damage
end
