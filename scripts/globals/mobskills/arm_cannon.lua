---------------------------------------------
--  Arm Cannon
--
--  Description: Deals Fire damage in an AOE around the target. Additional effect: Max HP/MP Down and Knockback
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
    MobStatusEffectMove(mob, target, tpz.effect.MAX_HP_DOWN, 50, 0, 45)
    MobStatusEffectMove(mob, target, tpz.effect.MAX_MP_DOWN, 50, 0, 45)
    return dmg
end
