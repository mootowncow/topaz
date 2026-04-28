-----------------------------------------
-- Spell: Adloquium
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
	duration = calculateDurationForLvl(duration, 41, target:getMainLvl())

    local power = enhskill / 60 -- 50 TP/tick at 300 enhancing skill

    if not target:addStatusEffect(tpz.effect.REGAIN, power, 3, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    end

    return tpz.effect.REGAIN
end
