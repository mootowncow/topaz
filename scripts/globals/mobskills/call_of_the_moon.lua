---------------------------------------------
-- Call of the Moon
--
-- Description: The enemy gains a high rate of Intimidation.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getName() == 'Rugaroo' then
        return 0
    end
	if mob:hasStatusEffect(tpz.effect.PROWESS_KILLER) then
		return 1
	end
    -- animsub 1= standing, animsub 0 = all fours
    if (mob:AnimationSub() == 0) then
        return 1
    end

    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PROWESS_KILLER
    local moon = utils.getMoonPhase()
    local moonpower = 5

    if (moon == 'Full') then
        moonpower = 40
    elseif (moon == 'Gibbeus') then
        moonpower = 25
    elseif (moon == 'Quarter') then
         moonpower = 15
    elseif (moon == 'Cresecent') then
         moonpower = 10
    elseif (moon == 'New') then
         moonpower = 5
	end
	
	MobBuffMove(mob, typeEffect, moonpower, 0, 60)
	skill:setMsg(tpz.msg.basic.NONE)
    return typeEffect
end
