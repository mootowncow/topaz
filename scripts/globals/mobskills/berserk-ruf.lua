-----------------------------------
-- Ability: Warcry
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.WARCRY) then
		return 1
	end
    return 0
end

function OnMobWeaponSkill(target, mob, skill)
    local power = math.floor(target:getStat(tpz.mod.ATT) * 0.25)
    local duration = 300

    local typeEffect = tpz.effect.WARCRY
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end


