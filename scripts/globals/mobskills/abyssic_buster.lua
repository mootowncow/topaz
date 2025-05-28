---------------------------------------------
-- Abyssic Buster
-- Description: Breat damage.
-- Additional effect: Inflicts Doom upon an enemy. This is not a gaze attack. Turing away will not prevent doom.
-- Range: 30' Frontal Cone
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    elseif (mob:getHPP() > 50) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.DARK, 2500)
    local typeEffect = tpz.effect.DOOM
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.50)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 25, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 2550, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 60)

    return dmg
end
