---------------------------------------------
--  Sucker Punch
--
--  Description: Deals damage to a single target. Additional effect: Stun and 75% defense down.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores Shadows
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

    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)

    local typeEffect = tpz.effect.STUN
    local typeEffectTwo = tpz.effect.DEFENSE_DOWN
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffectTwo, 75, 0, 30)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
