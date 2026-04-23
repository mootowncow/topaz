-----------------------------------------
-- Spell: Slow II
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
    local merits = caster:getMerit(tpz.merit.SLOW_II)

    -- Non-players have version is equal to a fully merited version
    if not caster:isPC() then
        merits = 5
    end

	local meritBonus = merits * 100
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    -- Lowest ~12.5%
    -- Highest ~35.1%
    local potency = utils.clamp(math.floor(dMND * 226 / 15) + 2380 + (meritBonus - 100), 1250, 3510 + (meritBonus - 100))
    potency = calculatePotency(potency, spell:getSkillType(), caster, target)

    --Duration, including resistance.
    local duration = 180
    local tier = 2
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = merits * 2
    params.effect = tpz.effect.SLOW
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5, 0, tier)

    return params.effect
end
