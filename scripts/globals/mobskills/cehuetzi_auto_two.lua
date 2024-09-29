---------------------------------------------
-- Cehuetzi Auto two
--
--  Description: Deals ice damage to a target
-- Additional effect: Magic defense down
--  Type: Magical
-- Element: Ice
--  Utsusemi/Blink absorb: Ignores shadows.
--  Range: Melee
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MAGIC_DEF_DOWN
    local power = 25
    local dmgmod = 1.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.ICE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 90)
    MobAutoAttackMoveMsg(skill)
    return dmg
end
