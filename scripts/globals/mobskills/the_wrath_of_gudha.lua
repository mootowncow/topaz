---------------------------------------------
--  Wrath of Gu'Dha
--
--  Description: Deals physical damage to enemies within area of effect. Additonal Efect: Knockback and weight.
--  Type: Physical
--  Utsusemi/Blink absorb:3 shadows
--  Range: 15' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local result = 1
    local mobhp = mob:getHPP()
    local diZhoSpongeshell = mob:getPool() == 1069

    if diZhoSpongeshell then
        result = 0
    end

    if (mobhp <= 50) then
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)

    local typeEffect = tpz.effect.WEIGHT

    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.2
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.2
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.NONE, info.hitslanded*math.random(2,3))
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
