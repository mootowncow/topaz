-----------------------------------------
-- Spell: Enlight
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end


function onSpellCast(caster, target, spell)
    local effect = tpz.effect.ENLIGHT
    local magicskill = target:getSkillLevel(tpz.skill.DIVINE_MAGIC)
    local potency = math.floor(((magicskill / 20) * 3)) + (12 - (math.floor(magicskill / 40)))

    if target:addStatusEffect(effect, potency, 0, 180) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end
