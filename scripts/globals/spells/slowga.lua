-----------------------------------------
-- Spell: Slowga
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
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    --Power
    -- Lowest ~30.1%
    -- Highest ~40.1%
    local power = utils.clamp(math.floor(dMND * 73 / 5) + 2380, 3010, 4010)
    power = calculatePotency(power, spell:getSkillType(), caster, target)

    --Duration, including resistance
    local duration = 180
    local tier = 3
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SLOW
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5, 0, tier)

    return params.effect
end
