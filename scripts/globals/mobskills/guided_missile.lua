---------------------------------------------
--  Guided_Missile
--
--  Description: Targeted 10'(?) AoE ~400-750 physical damage, absorbed by Utsusemi
--  Type: Physical
--  Wipes Shadows
--  Range: 5 yalms
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()
	if mob:getPool() == 2973 then
		if mobhp > 25 then
            if mob:AnimationSub() == 2 then
			    return 0
            end
		else
			return 1
		end
	end
    -- Only uses Laser Shower and Colossal Blow the final phase
    local currentForm = mob:getLocalVar("form") -- this var is only set for proto-omega
    if (currentForm == 2) and mob:AnimationSub() == 2 then
        return 1
    end
    if (mob:AnimationSub() <= 1) then -- omega four leg form
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.7
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.0
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.35
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_RANGED, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, info.hitslanded*math.random(2, 3))
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.RANGED)
    return dmg
end
