---------------------------------------------
-- Deathly Diminuendo 
-- AOE Curse and Bio
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CURSE_I

    MobStatusEffectMoveSub(mob, target, skill, tpz.effect.BIO, 56, 3, 180, 0, 15, 3)
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 50, 0, 45))

    return typeEffect
end
