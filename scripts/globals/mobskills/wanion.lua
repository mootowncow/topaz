---------------------------------------------
-- Wanion
-- Transfers all ailments the Seether itself has to players in AoE range.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local isAOE = true
    
    return MobTransferEnfeeblesMove(mob, target, skill, isAOE)
end
