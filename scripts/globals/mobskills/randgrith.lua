---------------------------------------------
--  Randgrith
--
--  Description: Lowers target's evasion. Gullintani/Mjollnir: Temporarily improves accuracy.
--  Type: Physical
--  Range: Melee
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tp = mob:getLocalVar("tp")
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.2
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.2
    params_phys.chr_wsc = 0.0

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, params_phys, 3, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    local duration = 300
    local typeEffect = tpz.effect.EVASION_DOWN
    local power = 32

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)
    tpz.aftermath.addStatusEffect(mob, tp, tpz.slot.MAIN, tpz.aftermath.type.RELIC, true, 11)
    return dmg
end
