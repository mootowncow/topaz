---------------------------------------------
--  Impale
--
--  Description: Deals damage to a single target. Additional effect: Paralysis (NM version AE applies a strong poison effect and resets enmity on target)
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow (NM version ignores shadows)
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
    local typeEffect = tpz.effect.PARALYSIS
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.3
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    params_phys.attack_boost = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local shadows = info.hitslanded

    if mob:isNM()  then
        shadows = MOBPARAM_IGNORE_SHADOWS
        typeEffect = tpz.effect.POISON
        mob:resetEnmity(target)
    end

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, shadows)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 90)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end

    return dmg
end
