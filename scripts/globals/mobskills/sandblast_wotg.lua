---------------------------------------------
-- Sand Blast
-- Deals Earth damage to targets in a fan-shaped area of effect. Additional effect: Blind
-- Range: 8' cone
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 80, 0, 300))

    return typeEffect
end
