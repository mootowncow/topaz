---------------------------------------------
--  Spectral Floe
--
--  Description: Deals severe Earth damage to enemies within an area of effect. Additional effect: Burn
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
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    local typeEffect = tpz.effect.PETRIFICATION
    local power = 1
    local duration = 30

    MobStatusEffectMoveSub(mob, target, typeEffect, power, 0, duration, 0, 0, 0)
    return dmg
end
