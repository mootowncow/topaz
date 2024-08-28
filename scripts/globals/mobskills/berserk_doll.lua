---------------------------------------------
-- Berserk (Dolls)
--
-- Description: Grants the effect of Warcry to user(despite being called berserk..)
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- +33% Attack
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
    local power = math.floor(mob:getStat(tpz.mod.ATT) * 0.33)
    local duration = 120

    local typeEffect = tpz.effect.WARCRY
    skill:setMsg(MobBuffMove(target, typeEffect, power, 0, duration))

    return typeEffect
end
