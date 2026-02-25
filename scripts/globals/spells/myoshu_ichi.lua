--------------------------------------
-- Spell: Myoshu: Ichi
-- Grants "Subtle Blow Plus" effect
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.SUBTLE_BLOW_PLUS
    local potency = 10
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end

