---------------------------------------------
-- Fortifying Wail
-- Family: Qutrub
-- Description: Let's out a wail that applies Protect to itself and nearby allies.
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: AoE
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.PROTECT) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 250
    local duration = 300
    local typeEffect = tpz.effect.PROTECT

    skill:setMsg(MobBuffMove(target, typeEffect, power, 0, duration))
    return typeEffect
end
