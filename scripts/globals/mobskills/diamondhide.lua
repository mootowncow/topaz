---------------------------------------------
-- Diamondhide
--
-- Description: Gives the effect of "Stoneskin."
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.STONESKIN) then
		return 1
	end
	
	if mob:getMainJob() == tpz.job.WAR or mob:getMainJob() == tpz.job.PLD or mob:getMainJob() == tpz.job.DRK then
		return 0
	end
    
	return 1
end

function onMobWeaponSkill(target, mob, skill)
    local power = 800
    skill:setMsg(MobBuffMove(target, tpz.effect.STONESKIN, power, 0, 300))
    return tpz.effect.STONESKIN
end
