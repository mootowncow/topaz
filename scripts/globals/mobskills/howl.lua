---------------------------------------------
-- Howl
--
-- Description: Grants the effect of Warcry to user and any linked allies.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self and nearby mobs of same family and/or force up to 20'.
-----------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.WARCRY) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = math.floor(target:getStat(tpz.mod.ATT) * 0.25)
    local duration = 180

    local typeEffect = tpz.effect.WARCRY
    skill:setMsg(MobBuffMove(target, typeEffect, power, 0, duration))

    return typeEffect
end
