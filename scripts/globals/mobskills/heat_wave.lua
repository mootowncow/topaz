---------------------------------------------
--  Heat Wave
--
--  Description: Deals fire damage that lowers Agility and gradually reduces HP of enemies within range.
--  Type: Magical (Fire)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 3339) and mob:AnimationSub() > 0 then -- Reacton
        return 0
    end
	if (mob:getPool() == 1426) or (mob:getPool() == 416) or (mob:getPool() == 6587) and mob:AnimationSub() >= 0
    or (mob:getPool() == 9057) and mob:AnimationSub() >= 0 then 
		return 0
	else
		return 1
	end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local power = 40
    skill:setMsg(MobStatusEffectMoveSub(mob, target, typeEffect, power, 3, 15, 0, 33, 0))

    return typeEffect
end
