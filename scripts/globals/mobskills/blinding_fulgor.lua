---------------------------------------------
--  Searing Tempest
--
--  Description: Deals severe Light damage to enemies within an area of effect. Additional effect: Burn
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    local typeEffect = tpz.effect.FLASH
    local power = 300

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 300)
    return dmg
end
