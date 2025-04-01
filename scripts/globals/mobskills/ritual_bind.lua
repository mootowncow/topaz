---------------------------------------------
-- Ritual Bind
-- Additional effect: Paralyze and Bind
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BIND
    local typeEffect2 = tpz.effect.PARALYSIS

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect2, 20, 0, 30))

    return typeEffect2
end
