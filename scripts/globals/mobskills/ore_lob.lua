---------------------------------------------
--  Ore Lob
--
--  Description: Deals high damage in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: Yes
--  Range: Unknown range
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
    local dmgmod = 3
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
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    return dmg
end
