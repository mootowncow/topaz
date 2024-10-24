---------------------------------------------
-- Infernal Deliverance
-- Description: Deals damage to targets in range. Additional effect: Stun
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.25
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
	
	target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
	MobStatusEffectMove(mob, target, tpz.effect.STUN, 0, 0, 8)

    return dmg
end
