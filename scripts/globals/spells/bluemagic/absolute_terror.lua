-----------------------------------------
-- Spell: Absolute Terror
-- Enemies within a fan-shaped area originating from the caster are frozen with fear
-- Spell cost: 37 MP
-- Monster Type: Birds
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 2:00
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
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
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 125
    params.eco = ECO_DRAGON
    local duration = 180


    params.effect = tpz.effect.SLOW
    local returnEffect = params.effect
    local power = 3500
    BlueTryEnfeeble(caster, target, spell, 1, power, 0, duration, params)

    params.effect = tpz.effect.PARALYSIS
    power = 30
    BlueTryEnfeeble(caster, target, spell, 1, power, 0, duration, params)

    params.effect = tpz.effect.INHIBIT_TP
    power = 20
    BlueTryEnfeeble(caster, target, spell, 1, power, 0, duration, params)

    return returnEffect
end
