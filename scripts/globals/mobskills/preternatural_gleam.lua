---------------------------------------------
--  Preternatural Gleam
--
--  Description: Deals Light Damage. Additional effect: Paralysis, Mute, and Enmity reset.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
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
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 70, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.MUTE, 1, 0, 30)
    mob:resetEnmity(target)
    return dmg
end
