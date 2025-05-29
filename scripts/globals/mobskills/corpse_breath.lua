---------------------------------------------
--  Corpse Breath
--
--  Description: Deals dark damage to enemies within a fan-shaped area originating from the caster.
-- Additional effect: Blindness.
--  Type: Magical Dark (Element)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.DARK, 1100)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 60, 3, 90)
    return dmg
end
