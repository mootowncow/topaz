-----------------------------------------
-- Spell: Sneak
-- Lessens chance of being detected by sound.
-- Duration is random number between 30 seconds and 5 minutes.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if not target:hasStatusEffect(tpz.effect.SNEAK) then

        --local duration = calculateDuration(math.random(420, 540), spell:getSkillType(), spell:getSpellGroup(), caster, target)
        local duration = calculateDuration(math.random(30, 300), spell:getSkillType(), spell:getSpellGroup(), caster, target)

        duration = duration + target:getMod(tpz.mod.SNEAK_DURATION)

        duration = calculateDurationForLvl(duration, 20, target:getMainLvl())

        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        target:addStatusEffect(tpz.effect.SNEAK, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.SNEAK
end
