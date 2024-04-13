---------------------------------------------
-- Petal Pirouette
--
-- Description: Whirling petals reduce tp to zero.
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
    local tpReduced = 0
    local targetTP = target:getTP()
    target:setTP(tpReduced)

    skill:setMsg(tpz.msg.basic.TP_REDUCED)

    return targetTP
end
