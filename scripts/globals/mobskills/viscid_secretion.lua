---------------------------------------------
-- Viscid Secretion
-- Conal Slow and Gravity.
-- Resets hate.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 25, 0, 300)
    skill:setMsg(MobHasteOverwriteSlowMove(mob, target, 5000, 0, 90, 0, 0, 2)) 
    mob:resetEnmity(target)

    return typeEffect
end
