---------------------------------------------
--  Pinning Shot
--
--  Description: Delivers a threefold ranged attack to targets in an area of effect. Additional effect: Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown
--  Notes: Used only by Medusa.
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
    local dmgmod = 1.25
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.3
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded*math.random(2, 3))

    local typeEffect = tpz.effect.BIND

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 300)
    return dmg
end
