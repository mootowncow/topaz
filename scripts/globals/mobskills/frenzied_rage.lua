---------------------------------------------
-- Frenzied Rage
--
-- Description: Attack Boost
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 100% Attack Boost.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ATTACK_BOOST
    local power = 18
    local tick = 0
    local duration = 120


    skill:setMsg(MobBuffMove(target, typeEffect, power, tick, duration))
    tpz.pet.handleJugBuffs(target, mob, skill, typeEffect, power, tick, duration)

    return typeEffect
end
