-----------------------------------------
-- Spell: Infrasonics
-- Lowers the evasion of enemies within a fan-shaped area originating from the caster
-- Spell cost: 42 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 4
-- Stat Bonus: INT+1
-- Level: 65
-- Casting Time: 5 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Induration, Distortion, Darkness
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
    params.effect = tpz.effect.EVASION_DOWN
    params.eco = ECO_LIZARD
    local power = 20

    local typeEffect = tpz.effect.EVASION_DOWN

    BlueTryEnfeeble(caster, target, spell, 1, power, 0, 180, params)

    return typeEffect
end
