-----------------------------------------
-- Spell: Poisonga III
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 180
    local pINT = caster:getStat(tpz.mod.INT)
    local mINT = target:getStat(tpz.mod.INT)

    local dINT = (pINT - mINT)
    local power = math.min(caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 15 + 1, 25)
    if power > 25 then
        power = 25
    end

    power = calculatePotency(power, spell:getSkillType(), caster, target)

    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.POISON

    local resist = applyResistanceEffect(caster, target, spell, params)
    TryApplyEffect(caster, target, spell, params.effect, power, 3, duration, resist, 0.5)

    return params.effect
end
