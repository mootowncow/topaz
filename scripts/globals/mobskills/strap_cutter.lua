---------------------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobEncumberMove(mob, target, 5, 30)
	skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
