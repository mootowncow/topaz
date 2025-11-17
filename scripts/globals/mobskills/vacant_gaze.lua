---------------------------------------------
-- Blank Gaze
-- Gaze dispel (Removes up to 3 effects)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local effect = 0
    if (target:isFacing(mob)) then
        local dispels = {
            MobDispelMove(mob, target, skill, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE),
            MobDispelMove(mob, target, skill, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE),
            MobDispelMove(mob, target, skill, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE),
        }

        local dispelCount = 0
        for _, effect in ipairs(dispels) do
            if effect ~= tpz.effect.NONE then
                dispelCount = dispelCount + 1
            end
        end

        if dispelCount > 0 then
            skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
            return dispelCount
        else
            skill:setMsg(tpz.msg.basic.SKILL_MISS)
            return 0
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    end

    return effect
end
