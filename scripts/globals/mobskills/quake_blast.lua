---------------------------------------------
--  Quake Blast
--  Description: Deals earth damage in a 20 yard AOE.
--  Additional effect: Removes all equipment
--  Type: Magical Enfeebling
--  Ignores Shadows
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5
    local baseDamage = mob:getWeaponDmg()*3
    local info = MobMagicalMove(mob, target, skill, baseDamage, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobEncumberMove(mob, target, 16, 20)
	return dmg
end
