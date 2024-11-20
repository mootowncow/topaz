---------------------------------------------
-- Broadside Barrage
--
-- Description: Damage, INT Down (-19), and MND (-19) Down. Notorious Monsters have an enhanced conal version.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local zone = mob:getZoneID()
    local expansion = GetZoneByExpansion(zone)
    if (expansion == 'COP') or (expansion == 'TOAU') or (expansion == 'WOTG') then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.2
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.2
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
	target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.INT_DOWN, 19, 15, 60)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.MND_DOWN, 19, 15, 60)
    return dmg
end
