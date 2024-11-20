-----------------------------------------
-- Spell: Regen III
-- Gradually restores target's HP.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local power = getRegenPotency(caster, target, 20)
    local duration = calculateDuration(60 + getRegenDurationBonuses(caster, target), spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 59, target:getMainLvl())

    if target:addStatusEffect(tpz.effect.REGEN, power, 3, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return tpz.effect.REGEN
end
