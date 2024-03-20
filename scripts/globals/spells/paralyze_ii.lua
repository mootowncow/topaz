-----------------------------------------
-- Spell: Paralyze II
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
	local meritBonus = caster:getMerit(tpz.merit.PARALYZE_II)
    -- Pull base stats
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    -- Base potency
    local potency = utils.clamp(math.floor(dMND / 4) + 20 + (meritBonus - 1), 10, 30 + (meritBonus - 1))

    potency = calculatePotency(potency, spell:getSkillType(), caster, target)

    local duration = math.random(60, 120)
    local tier = 2
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = meritBonus * 2
    params.effect = tpz.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5, tier)

    return params.effect
end
