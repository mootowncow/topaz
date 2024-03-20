-----------------------------------------
-- Spell: Bad Breath
-- Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster
-- Spell cost: 212 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 5
-- Stat Bonus: INT+2, MND+2
-- Level: 61
-- Casting Time: 8.75 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: Fast Cast
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
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
    params.eco = ECO_PLANTOID

    local damage = BlueBreathSpell(caster, target, spell, params, 2)
	damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.effect = tpz.effect.PARALYSIS
    BlueTryEnfeeble(caster, target, spell, damage, 20, 0, 180, params)

    params.effect = tpz.effect.WEIGHT
    BlueTryEnfeeble(caster, target, spell, damage, 50, 0, 180, params)

    params.effect = tpz.effect.POISON
    BlueTryEnfeeble(caster, target, spell, damage, 15, 3, 180, params)

    params.effect = tpz.effect.SLOW
    BlueTryEnfeeble(caster, target, spell, damage, 2000, 0, 180, params)

    local duration = 120
    local isMaaIllmutheBestower = target:getPool() == 2465

    if isMaaIllmutheBestower then
        duration = 30
        target:addTP(3000)
    end

    params.effect = tpz.effect.SILENCE
    BlueTryEnfeeble(caster, target, spell, damage, 1, 0, duration, params)

    params.effect = tpz.effect.BIND
    BlueTryEnfeeble(caster, target, spell, damage, 1, 0, 45, params)

    params.effect = tpz.effect.BLINDNESS
    BlueTryEnfeeble(caster, target, spell, damage, 30, 0, 180, params)

    return damage
end
