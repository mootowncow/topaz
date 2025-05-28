---------------------------------------------
--  Blistering Roar
--
--  Description: Deals fire damage to enemies in AOE. Additional effect: Terror
-- Gains Defense Bonus, Magic Defense Bonus, and flame aura
--  Type: Magical (Fire)
--
--  Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local dmgmod = MobHPBasedMove(mob, target, 0.125, 1, tpz.magic.ele.FIRE, 750)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    MobBuffMove(mob, tpz.effect.DEFENSE_BOOST, 100, 0, 90)
    MobBuffMove(mob, tpz.effect.MAGIC_DEF_BOOST, 50, 0, 90)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 15)
    return dmg
end
