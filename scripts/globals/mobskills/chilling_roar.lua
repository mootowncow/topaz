---------------------------------------------
-- Absolute Terror
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local power = 30
    -- Three minutes is WAY too long, especially on Wyrms. Reduced to Wiki's definition of 'long time'. Reference: http://wiki.ffxiclopedia.org/wiki/Absolute_Terror
    local duration = 10 -- changed from 30
    if skill:isAoE() then
        duration = 10
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect

end
