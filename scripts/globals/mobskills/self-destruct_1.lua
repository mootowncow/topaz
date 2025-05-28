---------------------------------------------------
-- self_destruct_razon
-- Weapon skill for Fire in the sky(ENM)
-- 1 Cluster
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")

function onMobSkillCheck(target, mob, skill)
	if mob:AnimationSub() == 2 then
		return 0
	end
	return 1
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 1.0, 1, tpz.magic.ele.FIRE, 1500, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
	if (mob:getPool() == 3333) then-- Razon 
		local amount = 1500 * skill:getTotalTargets()
		local dmg = MobFinalAdjustments(amount, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
        return dmg
	end
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    mob:setHP(0)
	return dmg
end
