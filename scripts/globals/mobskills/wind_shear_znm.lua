---------------------------------------------
--  Wind Shear
--
--  Description: Deals damage to enemies within an area of effect. Additional effect: Knockback
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 10' radial
--  Notes: The knockback is rather severe. Vulpangue uses an enhanced version that inflicts Weight.
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	local CurrentHP = mob:getHPP()
	mob:setLocalVar("HP", CurrentHP)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 3.0
    local CurrentHP = mob:getLocalVar("HP")
    if CurrentHP <= 50 and CurrentHP > 25 then
        dmgmod = 6.0
    end
    if CurrentHP <= 25 then
        dmgmod = 9.0
    end
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 25, 3, 90)
    return dmg
end

