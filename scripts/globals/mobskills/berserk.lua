---------------------------------------------
-- Berserk
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BERSERK
    skill:setMsg(MobBuffMoveSub(mob, typeEffect, 41, 0, 30, 0, 41, 0))
    return typeEffect
end
