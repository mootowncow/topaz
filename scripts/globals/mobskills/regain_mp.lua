---------------------------------------------
-- Dynamis Statue (Regain MP)
--
-- Description: Regain MP for party members within area of effect.
--
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(tpz.msg.basic.RECOVERS_MP)
    target:addMP(mp)
    mob:setUnkillable(false)
    mob:setHP(0)
    mob:setLocalVar("restoreProc", 0)

    return mp
end
