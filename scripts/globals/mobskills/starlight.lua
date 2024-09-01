---------------------------------------------------
-- Starlight
-- Restores HP and MP. Amount restored varies with TP.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tp = mob:getLocalVar("tp")
    local lvl = mob:getSkillLevel(tpz.skill.CLUB)
    if (tp == nil) or (tp == 0) then
        tp = 1000
    end
    local recovery = lvl * 0.22
    local recoveryFinal = recovery * (tp / 1000)

    target:addHP(recoveryFinal)
    target:addMP(recoveryFinal)
    skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_MP)
    return recoveryFinal
end

