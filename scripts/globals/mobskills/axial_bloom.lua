---------------------------------------------
-- Axial Bloom
--
-- Description: Attempts to bind nearby targets with petals.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-- Closed mouth only (Aimation Sub 4)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 4) or (mob:AnimationSub() == 1) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BIND
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 45))
    return typeEffect
end
