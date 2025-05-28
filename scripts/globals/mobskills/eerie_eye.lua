---------------------------------------------------
-- Eerie Eye
-- silence + amnesia
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE
    local typeEffectTwo = tpz.effect.AMNESIA

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 120))
    MobGazeMove(mob, target, typeEffectTwo, 1, 0, 120)

    return typeEffect
end