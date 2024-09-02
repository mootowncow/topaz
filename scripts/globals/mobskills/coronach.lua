---------------------------------------------
--  Coronach
--
--  Description: Annihilator/Ferninand: Temporarily lowers enmity.
--  Type: Physical
--  Shadow per hit
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
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.2
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.2
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0

    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    tpz.aftermath.addStatusEffect(mob, tp, tpz.slot.MAIN, tpz.aftermath.type.RELIC, true, 14)
    return dmg

end
