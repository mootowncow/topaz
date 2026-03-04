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
    if caster:isAutomaton() then
        enhskill = caster:getSkillLevel(tpz.skill.AUTOMATON_MAGIC)
    end

    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 60, target:getMainLvl())

    -- 25% at 300 skill
    local power = math.floor(enhskill / 15) + 5

    if target:addStatusEffect(effect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end
