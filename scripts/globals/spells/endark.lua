-----------------------------------------
-- Spell: Endark
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end


function onSpellCast(caster, target, spell)
    local effect = tpz.effect.ENDARK
    local magicSkill = target:getSkillLevel(tpz.skill.DARK_MAGIC)
    local potency = (12 + math.floor(magicSkill / 20) * 3) - math.floor(magicSkill / 40)

    if target:addStatusEffect(effect, potency, 0, 180) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end
