---------------------------------------------
-- Mix: Life Water
-- Regen (20/tick, 1 minute, AoE).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:addStatusEffect(tpz.effect.REGEN, 20, 3, 60)
    skill:setMsg(tpz.msg.basic.GAINS_EFFECT_OF_STATUS)

    return tpz.effect.REGEN
end
