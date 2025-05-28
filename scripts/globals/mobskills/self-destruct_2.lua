---------------------------------------------------
-- self_destruct_razon
-- Weapon skill for Fire in the sky(ENM)
-- 2 Clusters
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")

function onMobSkillCheck(target, mob, skill)
	if mob:AnimationSub() == 1 then
		return 0
	end
	
	return 1
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.33, 1, tpz.magic.ele.FIRE, 1500)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
	if (mob:getPool() == 3333) then-- Razon 
		local HP = mob:getHPP()
		local amount = 750 * skill:getTotalTargets()
		local dmg = MobFinalAdjustments(amount, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
		if HP < 33 then
		   dmg = 0
		end
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
        return dmg
	end
    mob:AnimationSub(2)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)

	return dmg
end
