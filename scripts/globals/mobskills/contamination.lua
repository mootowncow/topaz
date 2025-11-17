---------------------------------------------
-- Contamination
-- Transfers all ailments the mob has to players in AoE range.
-- Only used after Contagion Transfer
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getLocalVar("effectsDrained") > 0 then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local isAOE = true

    mob:setLocalVar("effectsDrained", 0)
    return MobTransferEnfeeblesMove(mob, target, skill, isAOE)
end

