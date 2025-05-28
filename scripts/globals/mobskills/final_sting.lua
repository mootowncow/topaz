---------------------------------------------
--  Final Sting
--
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: magic
--  Element: Magic
--  Only usable below 33% HP
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 385) or (mob:getPool() == 1925)  then 
		return 1
    elseif (mob:getHPP() > 33) then
        return 1
	else
        mob:setLocalVar("self-destruct_hp", mob:getHP())
		return 0
	end
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.50, 1, tpz.magic.ele.LIGHT, 9999, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    mob:setHP(0)
    return dmg
end
