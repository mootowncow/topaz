---------------------------------------------------
-- Homing Missle
--
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset=targetmaxHP*0.20

    if (targetcurrentHP > hpset) then
        dmg= targetcurrentHP - hpset
    else
        dmg = 0
    end
	
	if target:hasStatusEffect(tpz.effect.FEALTY) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        dmg = 0
	else
		target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
        mob:resetEnmity(target)
	end
    return dmg
end
