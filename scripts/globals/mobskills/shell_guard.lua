---------------------------------------------
-- Shell Guard
-- Increases defense of user.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    CheckQuadavModel(mob, skill, 2116, 358, 1560)
	if mob:hasStatusEffect(tpz.effect.DEFENSE_BOOST) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 25
    local typeEffect = tpz.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 600))
    return typeEffect
end
