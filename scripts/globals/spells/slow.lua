-----------------------------------------
-- Spell: Slow
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
    -- Lowest ~7.3%
    -- Highest ~29.2%
    local power = utils.clamp(math.floor(dMND * 75 / 5) + 1825, 730, 2920)    
    power = calculatePotency(power, spell:getSkillType(), caster, target)
    --print(string.format("step1: %u",power))
	--GetPlayerByID(6):PrintToPlayer(string.format("Slow amount: %u",power))

    --printf("Duration : %u", duration)
    --printf("Potency : %u", potency)
    --Duration
    local duration = 180
    local tier = 1
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 10
    params.effect = tpz.effect.SLOW
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5, 0, tier)

    return params.effect
end
