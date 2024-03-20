-----------------------------------------
-- Spell: Radiant Breath
-- Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
-- Spell cost: 116 MP
-- Monster Type: Wyverns
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+1, HP+5
-- Level: 54
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
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
    params.diff = 0
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.LIGHT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.eco = ECO_DRAGON

    local damage = BlueBreathSpell(caster, target, spell, params, 1)
	damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.effect = tpz.effect.SLOW
    BlueTryEnfeeble(caster, target, spell, damage, 3500, 0, 180, params)

    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    local duration = 120
    local isMaaIllmutheBestower = target:getPool() == 2465

    if isMaaIllmutheBestower then
        duration = 30
        target:addTP(3000)
    end

    params.effect = tpz.effect.SILENCE
    BlueTryEnfeeble(caster, target, spell, damage, 1, 0, duration, params)

    return damage
end
