---------------------------------------------------
-- Bitter Elegy
---------------------------------------------
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ELEGY

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 5000, 0, 90))

    return typeEffect
end
