---------------------------------------------
-- Mix: Dragon Shield
-- Magic Defense Boost (+10, 1 minute, AoE).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 10, 0, 60)
    skill:setMsg(tpz.msg.basic.GAINS_EFFECT_OF_STATUS)

    return tpz.effect.MAGIC_DEF_BOOST
end
