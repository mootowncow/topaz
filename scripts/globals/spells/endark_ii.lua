-----------------------------------------
-- Spell: Endark II
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
    -- Skill 500 or less: int(((dark magic skills +2)*5/66)+7)*2.5
    -- https://wiki.ffo.jp/html/21171.html
    local potency = math.floor(((magicSkill +2) *5 /66)+7) *2.5 -- JP value handled in endark.lua effect

    if target:addStatusEffect(effect, potency, 0, 180) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end
