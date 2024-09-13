-----------------------------------------
-- Spell: Dread Spikes
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
    local duration = calculateDuration(SPIKE_EFFECT_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local typeEffect = tpz.effect.DREAD_SPIKES
    local drainAmount = target:getMaxHP() / 2

    drainAmount = drainAmount * (100 + caster:getMod(tpz.mod.DREAD_SPIKES_EFFECT)) / 100)

    if target:addStatusEffect(typeEffect, 0, 0, duration, 0, drainAmount, 1) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    -- For tracking what skill to use for spikes MACC formula in C++
    target:setCharVar("drkSpikes", 1)

    return typeEffect
end
