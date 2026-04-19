---------------------------------------------
--  Cauterizing Field
--
--  Description: Deals Fire damage in an AOE to nearby enemies. Additional effect: Burn and Amnesia
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4.0
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    MobStatusEffectMoveSub(mob, target, tpz.effect.BURN, 28, 3, 60, 0, 59, 0)
    MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 30)
    return dmg
end
