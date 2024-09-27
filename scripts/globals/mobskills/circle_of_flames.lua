---------------------------------------------
--  Circle of Flames
--
--  Description: Deals damage to targets in an area of effect. Additional effect: Weight
--  Type: Physical
--  Utsusemi/Blink absorb: 1-3 shadows
--  Range: 10' radial
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
	if mob:AnimationSub() == 2 then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.WEIGHT

    MobStatusEffectMove(mob, target, typeEffect, 15, 0, 300)
    local dmgmod = 0.5
	if mob:AnimationSub() == 0 then
		dmgmod = dmgmod + 0.75
	elseif mob:AnimationSub() == 1 then
		dmgmod = dmgmod + 0.5
	end
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
