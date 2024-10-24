---------------------------------------------
--
-- Venom Breath
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 3, 3, 90))

    return typeEffect
end
