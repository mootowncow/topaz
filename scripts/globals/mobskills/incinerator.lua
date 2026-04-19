---------------------------------------------
--  Incinerator
--
--  Description: Deals Fire damage to enemies in a cone. Additional effect: Burn
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
    MobStatusEffectMoveSub(mob, target, tpz.effect.BURN, 35, 3, 60, 0, 69, 0)
    return dmg
end
