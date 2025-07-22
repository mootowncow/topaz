---------------------------------------------
-- Quake Stomp
--
-- Description: Stomps the ground to boost next attack.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.BOOST) then
		return 1
	end
	
  if (mob:getFamily() == 91) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1680) then
        return 0
    else
        return 1
    end
  end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 100
    local duration = 300

    local typeEffect = tpz.effect.BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    target:setEffectUndispellable(typeEffect)
    return typeEffect
end
