---------------------------------------------------
-- Meltdown
-- Reactor failure causes self-destruct, dealing magic damage to targets in an area of effect.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:getPool() == 1049 then --Disaster Idol
		return 1
	end
    mob:setLocalVar("self-destruct_hp", mob:getHP())
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.50, 1, tpz.magic.ele.NONE, 2000, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    mob:setHP(0)
    return dmg
end
