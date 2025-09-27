-----------------------------------------
-- Spell: Enlight II
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
    -- Up to 500 skill: D = 2×floor( (Divine Magic Skill+85)÷13 ) + floor( (Divine Magic Skill+85)÷26 ) + Enlight Job Points
    -- https://www.bg-wiki.com/ffxi/Enlight_II
    local potency = 2 * math.floor((magicskill + 85) / 13) + math.floor((magicskill + 85) / 26)-- JP value handled in enlight.lua effect

    if target:addStatusEffect(effect, potency, 0, 180) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end 
