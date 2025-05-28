---------------------------------------------
-- Slaverous Gale
--
-- Description: Deals earth damage that inflicts Plague and Slow effects on targets in front of the caster
-- Type: Magical (Earth)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.EARTH, 3000)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.2)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    local typeEffect = tpz.effect.PLAGUE

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
    MobStatusEffectMove(mob, target, typeEffect, 5, 3, 300)
    obHasteOverwriteSlowMove(mob, target, 5000, 0, 90, 0, 0, 2)
    return dmg
end
