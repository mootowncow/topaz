---------------------------------------------
--  Hellstorm
--
--  Description: Deals Fire damage to enemies in a cone, dealing more damage at lower HP.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows.
--  Range: Conal
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 3339) and mob:AnimationSub() > 1 then -- Reacton
        return 0
    end
	if (mob:getPool() == 1426) or (mob:getPool() == 416) (mob:getPool() == 6587)  and mob:AnimationSub() >= 1 then 
		return 0
	else
		return 1
	end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.FIRE, 900)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    return dmg
end

