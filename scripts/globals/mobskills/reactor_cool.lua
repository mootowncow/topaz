---------------------------------------------
-- Reactor Cool
-- Gives Undispellable Ice Spikes and Defense Boost
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
    local typeEffect = tpz.effect.ICE_SPIKES
    local typeEffect2 = tpz.effect.DEFENSE_BOOST
	local enhskill = mob:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
	if enhskill == 0 then
		enhskill = 1
	end
    local power = 20 + (enhskill / 30)

    -- Todo: check message behavior, this double setMsg() looks wrong
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 30))
    local effect1 = mob:getStatusEffect(tpz.effect.ICE_SPIKES)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
    skill:setMsg(MobBuffMove(mob, typeEffect2, 25, 0, 30))
    local effect2 = mob:getStatusEffect(tpz.effect.DEFENSE_BOOST)
    effect2:unsetFlag(tpz.effectFlag.DISPELABLE)

    return typeEffect
end
