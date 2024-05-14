---------------------------------------------
-- Cutpurse
-- Description: Randomly encumbers one piece of equipment.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobEncumberMove(mob, target, 1, 30)
	skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
