---------------------------------------------------
-- Earth Shatter
-- Deals Earth elemental damage to enemies within area of effect. Additional effect: Slow, Gravity, Rasp, Accuracy Down, and Evasion Down.
-- Very long cast time, easy to stun or run away from.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local result = 1
    local mobhp = mob:getHPP()
	
	if mob:getPool() == 504 then --Boompadu
		if mobhp > 33 then
		    return 1
		end
	end
    if (mob:getPool() == 178) then
        if (mobhp <= 25) then
            return 0
        end
    end

    
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (mob:getPool() == 178) then -- Antican Legatus
		MobStatusEffectMove(mob, target, tpz.effect.SLOW, 50, 0, 30)
		MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 25, 0, 30)
		MobStatusEffectMove(mob, target, tpz.effect.ACCURACY_DOWN, 50, 0, 30)
		MobStatusEffectMove(mob, target, tpz.effect.EVASION_DOWN, 50, 0, 30)
        local power = 25
        MobStatusEffectMoveSub(mob, target, tpz.effect.RASP, power, 3, 60, 0, 69, 0)

		local dmgmod = 1.5
        local params_phys = {}
        params_phys.multiplier = dmgmod
        params_phys.tp150 = 1
        params_phys.tp300 = 1
        params_phys.str_wsc = 0.0
        params_phys.dex_wsc = 0.0
        params_phys.vit_wsc = 0.0
        params_phys.agi_wsc = 0.0
        params_phys.int_wsc = 0.3
        params_phys.mnd_wsc = 0.0
        params_phys.chr_wsc = 0.0
		local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT, params_phys_phys)
		local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
		target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
		return dmg
	end
	
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
	local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)

	local typeEffect = tpz.effect.STUN

	target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 8)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
	
    return dmg
end
