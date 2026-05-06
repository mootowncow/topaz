---------------------------------------------------
-- Big Scissors: Deals 50% of the targets HP in damage in a frontal cone.
-- Additional effect: Resets enmity.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local percent = 50
    local hpp = utils.getMaxHPPercent(target, percent)
    local hitsLanded = 1
    local dmg = MobFinalAdjustments(hpp, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    if (MobPhysicalHit(mob, skill)) then
        mob:resetEnmity(target)
    end
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, hitsLanded) end
    return dmg
end
