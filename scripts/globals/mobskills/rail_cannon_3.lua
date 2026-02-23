---------------------------------------------------
-- Rail Cannon 3 gears
-- 3 Gears: Rail Cannon is AoE and strips Utsusemi
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if (mob:AnimationSub() == 0) then --Needs to be tested
		return 0
	else
		return 1
	end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)

	return dmg
end
