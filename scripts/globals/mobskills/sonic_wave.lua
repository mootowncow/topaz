---------------------------------------------
-- Sonic Wave
-- Reduces defense of enemies in an area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_DOWN
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 40, 0, 300))

    return typeEffect
end
