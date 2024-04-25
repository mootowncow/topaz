---------------------------------------------
-- Intimidate
-- Inflicts slow on targets in a fan-shaped area of effect.
-- Removes haste, very potent slow(100%)
-- Resets hate
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobHasteOverwriteSlowMove(mob, target, 10000, 0, 5, 0, 0, 2))
    mob:resetEnmity(target)

    return typeEffect
end
