---------------------------------------------
--  Toxic Spit
--
--  Description: Spews a toxic glob at a single target. Additional effect: Poison
--  Type: Magical Water
-- Range: 10' cone
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: Additional effect can be removed with Poisona.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    local power = 12

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 90)
    local effect1 = target:getStatusEffect(typeEffect)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
    return dmg
end
