---------------------------------------------
--  Dark Mist
--  Family: Gargouille
--  Description: Deals dark damage to an enemy. Additional effect: Weight
--  Type: Magical (dark)
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Radial
--  Notes: Only used when flying
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() ~=1) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5
    local typeEffect = tpz.effect.WEIGHT

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)

    return dmg
end
