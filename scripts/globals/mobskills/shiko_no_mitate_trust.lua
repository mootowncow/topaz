---------------------------------------------
-- Shiko no Mitate (Trust)
-- Enhances defense.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_BOOST
    MobBuffMove(mob, tpz.effect.ISSEKIGAN, 25, 0, 60)
    MobBuffMove(mob, tpz.effect.STONESKIN, 550, 0, 60)
    skill:setMsg(MobBuffMove(mob, typeEffect, 100, 0, 60))
    return typeEffect
end
