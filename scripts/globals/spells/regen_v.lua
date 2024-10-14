-----------------------------------------
-- Spell: Regen V
-- Gradually restores target's HP.
-----------------------------------------
-- Scale down duration based on level
-- Composure increases duration 3x
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local hp = math.ceil(40 * (1 + 0.01 * caster:getMod(tpz.mod.REGEN_MULTIPLIER))) -- spell base times gear multipliers
    hp = hp + caster:getMerit(tpz.merit.REGEN_EFFECT) -- bonus hp from merits

    -- Add SCH main light arts bonus
    if caster:getMainJob() == tpz.job.SCH then
        hp = hp + caster:getMod(tpz.mod.LIGHT_ARTS_REGEN) -- bonus hp from light arts
    end

    local duration = calculateDuration(60 + getRegenDurationBonuses(caster, target), spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 99, target:getMainLvl())

    if target:addStatusEffect(tpz.effect.REGEN, hp, 3, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return tpz.effect.REGEN
end
