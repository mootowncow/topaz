---------------------------------------------
-- Spider Web
-- Entangles all targets in an area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobHasteOverwriteSlowMove(mob, target, 5000, 0, 90, 0, 0, 2))

    return tpz.effect.SLOW
end
