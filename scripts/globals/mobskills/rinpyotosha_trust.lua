---------------------------------------------
-- Rinpyotosha (Trust)
--
-- Description: Grants nearby party members and self Attack Boost (+25%)
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self and nearby party members within 20'.
-----------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = tpz.effect.ATTACK_BOOST
    skill:setMsg(MobBuffMove(target, typeEffect, power, 0, duration))

    return typeEffect
end
