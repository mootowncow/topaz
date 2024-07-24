---------------------------------------------
-- Mix: Insominant
-- Grants Monberaux Negate Sleep.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.NEGATE_SLEEP
    local power = 1
    local tick = 0
    local duration = 180

    skill:setMsg(MobBuffMove(mob, typeEffect, power, tick, duration)) -- GAINS_EFFECT_OF_STATUS ?

    return typeEffect
end
