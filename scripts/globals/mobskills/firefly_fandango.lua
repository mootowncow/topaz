---------------------------------------------
-- Firefly Fandango
--
-- Description: AoE magical damage Additional effect: Paralysis, Flash, and Max MP Down
-- Type: Magical
-- Element: Light
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.FLASH
    local typeEffectTwo = tpz.effect.PARALYSIS
    local typeEffectThree = tpz.effect.MAX_MP_DOWN
    local dmgmod = 7.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg , mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobStatusEffectMoveSub(mob, target, typeEffect, 300, 3, 18, 0, 0, 0)
    MobStatusEffectMove(mob, target, typeEffectTwo, 33, 0, 30)
    MobStatusEffectMove(mob, target, typeEffectThree, 25, 0, 30)
    return dmg
end