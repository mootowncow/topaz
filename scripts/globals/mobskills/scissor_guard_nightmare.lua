---------------------------------------------
-- Scissor Guard
-- Grants -90% physical damage taken
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.PROTECT) then
		return 1
	end
    return 0
end
function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PROTECT
    local power = 9654
    local tick = 0
    local duration = 10

    skill:setMsg(MobBuffMove(mob, typeEffect, power, tick, duration))
    tpz.pet.handleJugBuffs(target, mob, skill, typeEffect, power, tick, duration)
    SetBuffUndispellable(mob, typeEffect)

    return typeEffect
end
