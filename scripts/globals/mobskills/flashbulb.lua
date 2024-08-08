---------------------------------------------
-- Flashbulb
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local element = tpz.magic.ele.LIGHT
    local skillType = jobUtil.GetAutoMainSkill(mob)
    local bonus = 256
    local resist = applyResistanceAddEffect(mob, target, element, bonus, tpz.effect.FLASH, skillType)
    local duration = 12 * resist

    if (resist > 0.5) then
        if target:addStatusEffect(tpz.effect.FLASH, 300, 3, duration) then
            -- master:PrintToPlayer(string.format("Targets accuracy lowered to... %i", target:getACC()))
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.JA_MISS_2)
    end

    target:addEnmity(mob, 180, 1280)
    target:updateClaim(mob)

    return tpz.effect.FLASH
end
