---------------------------------------------
-- Cocoon
-- Enhances defense.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.DEFENSE_BOOST) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, 100, 0, 180))
    if mob:getName() == 'Champion_Crawler' then
        MobBuffMove(mob, tpz.effect.DAMAGE_SPIKES, math.random(50, 75), 0, 180)
    end

    return typeEffect
end
