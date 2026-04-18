---------------------------------------------
-- Fatal Scream
-- Used by Albumen and Artemisia.
-- Description: Inflicts Doom upon an enemy. This is not a gaze attack. Turing away will not prevent doom.
-- 10 second cooldown
-- Only used below 50% HP
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp <= 50) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM

    if target:hasStatusEffect(tpz.effect.FEALTY) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 10, 3, 30))
    end

    return tpz.effect.DOOM
end
