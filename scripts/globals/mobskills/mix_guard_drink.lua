---------------------------------------------
-- Mix: Guard Drink
-- Protect (220 defense, 5 minutes, AoE) and Shell (-29% MDT, 5 Minutes, AoE).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:addStatusEffect(tpz.effect.SHELL, 29, 0, 300)
    target:addStatusEffect(tpz.effect.PROTECT, 220, 0, 300)
    skill:setMsg(tpz.msg.basic.GAINS_EFFECT_OF_STATUS)

    return tpz.effect.PROTECT
end
