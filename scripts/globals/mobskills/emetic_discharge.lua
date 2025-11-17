---------------------------------------------
-- Emetic Discharge
-- Used by: Bloodlapper and Brummbar
-- Description: Transfers all ailments to target
-- Type: Enfeebling
-- Utsusemi/Blink absorb: 3 shadows
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isNM()) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local isAOE = true
    utils.takeShadows(target, 1, math.random(2, 3))
    
    return MobTransferEnfeeblesMove(mob, target, skill, isAOE)
end
