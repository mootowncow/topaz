---------------------------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
-- If used by Agrios, resets enmity if it lands
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local agrios = mob:getPool() == 64
    local alkyoneus = mob:getPool() == 87

    if agrios or alkyoneus then
        return 0
    end
    -- Ranged attack only used when target is out of range
    if (mob:checkDistance(target) >= 4) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.0
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    params_phys.NO_FIRST_HIT_BONUS = true
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    local agrios = mob:getPool() == 64
    if agrios then
        if (MobPhysicalHit(mob, skill)) then
            mob:resetEnmity(target)
        end
    end
    return dmg
end
