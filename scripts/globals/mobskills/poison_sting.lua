---------------------------------------------------
-- Poison Sting
-- Deals Water damage to targets in a fan-shaped area of effect. Additional effect: Poison
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
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
    params_phys.attack_boost = 50
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)

    local typeEffect = tpz.effect.POISON
    local power = 1
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 3, 90)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    return dmg
end
