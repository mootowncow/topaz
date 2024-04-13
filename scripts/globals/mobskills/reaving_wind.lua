---------------------------------------------
-- Reaving Wind
--
-- Description: 	TP reset to 0. Knockbacks anyone who gets within a certain range periodically.
-- Type: Knockback Aura
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local reset = 0
    local targetTP = target:getTP()
    if (target:getTP() == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(tpz.msg.basic.TP_REDUCED)
    end
	mob:AnimationSub(2)
	mob:setLocalVar("ReavingWindAura", os.time() + 60)
	mob:setLocalVar("KnockBackTick", os.time() + 6)
	
    return targetTP
end
