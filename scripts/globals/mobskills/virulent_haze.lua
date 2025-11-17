---------------------------------------------
--  Virulent Haze
--
--  Description: Inflicts fire damage in a cone. Additional Effect: Burn and Addle
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 9' aoe
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
	return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    MobStatusEffectMoveSub(mob, target, tpz.effect.BURN, 25, 3, 60, 0, 69, 0)
    MobStatusEffectMove(mob, target, tpz.effect.ADDLE, 25, 0, 50)
    return dmg
end
