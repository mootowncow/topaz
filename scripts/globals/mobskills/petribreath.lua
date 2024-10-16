---------------------------------------------
-- Petribreath
--
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown  cone, Seen up to 15' distance.
-- Notes:
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
    skill:setMsg(MobStatusEffectMoveSub(mob, target, typeEffect, 1, 0, 60, 0, 0, 0))
    return typeEffect
end
