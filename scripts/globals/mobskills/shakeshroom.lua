---------------------------------------------------
-- Shakeshroom
-- Additional effect: Fires a mushroom cap, dealing damage to a single target. Additional effect: disease
-- Range is 14.7 yalms.
-- Piercing damage Ranged Attack.
-- Secondary modifiers: INT: 20%.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getMobMod(tpz.mobMod.VAR) == 2) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DISEASE
    mob:setMobMod(tpz.mobMod.VAR, 3)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.2
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
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_CRIT_VARIES, params_phys, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 300)
    return dmg
end
