---------------------------------------------
-- Mix: Elemental Power
-- Magic Attack Boost (+20, 1 minute, AoE).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 20, 0, 60)
    skill:setMsg(tpz.msg.basic.GAINS_EFFECT_OF_STATUS)

    return tpz.effect.MAGIC_ATK_BOOST
end
