---------------------------------------------
--  Torrent
--  Description: Removes and encumbers a random amount of equipment
--  Type: Magical Enfeebling
--  Ignore Shadows, Single target
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobEncumberMove(mob, target, 5, 30)
	skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
