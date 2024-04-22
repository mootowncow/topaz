---------------------------------------------
--  Ore Toss
--
--  Description: Deals high damage in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: Yes
--  Range: Unknown range
-- Damage Scales from 1~3x from 1" ~ 10".
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/mobs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    CheckQuadavModel(mob, skill, 2116, 355)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
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
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)

    local distance = mob:checkDistance(target)
    distance = utils.clamp(distance, 1, 20)
    -- damage Scales from 1~3x from 1" ~ 10".
    dmg = dmg * (distance / 10)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    return dmg
end
