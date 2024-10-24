---------------------------------------------
--  Mangle
--  Family: Qutrub
--  Description: Deals damage in a threefold attack to targets in a fan-shaped area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 3 shadows
--  Range: Front cone
--  Notes: Used only when wielding their initial sword, or the dagger on their backs.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getPool() == 9093 then -- (Tutankhamun - Arrapago Remnants Salvage Custom)
        return 0
    end
    if (mob:AnimationSub() == 0 or mob:AnimationSub() == 2) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.35
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
