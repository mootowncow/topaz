---------------------------------------------
-- Lethe Arrows
--
-- Description: Deals a ranged attack to target. Additional effect: Knockback, Bind, and Amnesia
-- Type: Ranged
-- Utsusemi/Blink absorb: Ignores Utsusemi
-- Range: Unknown
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.2
    params_phys.int_wsc = 0.2
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.BIND, 1, 0, 60)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.AMNESIA, 1, 0, 45)
    return dmg
end
