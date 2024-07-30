---------------------------------------------
-- Rejuvenation (Trust)
-- Radius: AoE
-- Restores 25% of the target's maximum HP and MP, as well as 500 TP
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
    local hpRestore = target:getMaxHP() * 0.25
    local mpRestore = target:getMaxMP() * 0.25
    local tpRestore = 500

    target:addHP(hpRestore)
    target:addMP(mpRestore)
    target:addTP(tpRestore)

    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    return hpRestore
end

