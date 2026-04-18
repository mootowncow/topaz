---------------------------------------------
-- Phaeosynthesis
--
-- Description: Enhances evasion and gives a potent(12/tick) regen effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only used at night.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 1
    end
	if mob:hasStatusEffect(tpz.effect.EVASION_BOOST) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.EVASION_BOOST
    local power = (target:getEVA() * 0.5)
    local mobName = mob:getName()

    skill:setMsg(MobBuffMove(target, tpz.effect.REGEN, 12, 3, 300))

    if mobName == 'Albumen' or mobName == 'Artemisia' then
        MobBuffMove(target, typeEffect, power, 0, 300)
    end

    return tpz.effect.REGEN
end
