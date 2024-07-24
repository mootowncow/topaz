---------------------------------------------
-- Max Potion
--
-- Description: Heals Target
-- Type: Healing
-- Utsusemi/Blink absorb: N/A
-- Range: 21 Yalms
-- Notes: Restores 500 HP
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
     return MobHealMoveExact(mob, target, skill, 500)
end
