---------------------------------------------
-- Nightmare
-- AOE Sleep with Bio dot
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I

    local params = {}
    params.DEEPSLEEP = true
    MobStatusEffectMove(mob, target, tpz.effect.BIO, 21, 3, 90)
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 3, 90, false, params))

    return typeEffect
end