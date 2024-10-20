---------------------------------------------
-- Stasis
--
-- Description: Paralyzes targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
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
    local shadows = MOBPARAM_1_SHADOW
    local dmg = MobFinalAdjustments(10, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, shadows)

    local typeEffect = tpz.effect.PARALYSIS


    if (MobPhysicalHit(mob, skill)) then
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 15, 0, 300))
        mob:resetEnmity(target)
        return typeEffect
    end

    return shadows
end
