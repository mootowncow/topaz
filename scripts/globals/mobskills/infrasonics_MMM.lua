---------------------------------------------
-- Infrasonics (MMM)
-- Reduces evasion of targets in area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION

    skill:setMsg(MobStatusEffectMoveSub(mob, target, typeEffect, 1, 0, 5, 0, 0, 0))

    return typeEffect
end
