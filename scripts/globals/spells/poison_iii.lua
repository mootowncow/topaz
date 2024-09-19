-----------------------------------------
-- Spell: Poison III
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    local power = math.min(caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 15 + 1, 25)

    power = calculatePotency(power, spell:getSkillType(), caster, target)

    local duration = 180

    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)
    local tier = 3

    TryApplyEffect(caster, target, spell, params.effect, power, 3, duration, resist, 0.5, tier)

    return params.effect
end
