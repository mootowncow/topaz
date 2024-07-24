---------------------------------------------
-- Mix: Samson's Strength
-- STR/DEX/VIT/AGI/INT/MND/CHR Boost (+10, 1 minute, AoE).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    for statBoost = tpz.effect.STR_BOOST, tpz.effect.CHR_BOOST do
        target:addStatusEffect(statBoost, 10, 0, 60)
    end
    skill:setMsg(tpz.msg.basic.ALL_PARAMETERS_BOOSTED) -- GAINS_EFFECT_OF_STATUS?

    return 0
end
