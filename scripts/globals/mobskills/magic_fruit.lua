---------------------------------------------
-- Magic Fruit
--
-- Description: Restores HP for the target party member.
-- Type: Magical (Light)
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getName() == "Aegyptopithecus") then
        skill:setActivationTime(3500)
    else
        skill:setActivationTime(1500)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    return MobPercentHealMove(mob, target, skill, 0.18)
end
