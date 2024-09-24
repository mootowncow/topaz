---------------------------------------------
--  Desiccation
--  Removes most if not all equipment and resets job ability timers.
-- 	Additional effect: Knockback
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    MobEncumberMove(mob, target, 16, 20)
    target:addMaxRecastToAllAbilities(true)
	skill:setMsg(tpz.msg.basic.NONE)
    return 0
end