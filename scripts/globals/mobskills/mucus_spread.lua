---------------------------------------------
-- Mucus Spread
-- AOE Slow
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW
    skill:setMsg(MobHasteOverwriteSlowMove(mob, target, 5000, 0, 90, 0, 0, 2))

    return typeEffect
end
