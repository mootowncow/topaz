-----------------------------------------
-- Spell: Blind
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
    -- Pull base stats.
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.MND) -- INT vs targets MND

    -- Base power
    -- Min cap: 5 at -80 dINT
    -- Max cap: 50 at 120 dINT
    local basePotency = utils.clamp(math.floor(dINT * 9 / 40 + 23), 5, 30)  -- changed max cap to -30 which is 75 era acurate
    local potency = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = math.random(180, 300)

    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5)

    return params.effect
end
