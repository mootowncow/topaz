-----------------------------------------
--
-- Spell: Temper
--
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.MULTI_STRIKES
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 60, target:getMainLvl())

    local power = math.floor(enhskill / 30)
    power = power + 100 -- multi_strikes.lua will set this as triple attack for any mod over 100. i.e. 125 power is 25% triple attack

    if target:addStatusEffect(effect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end
