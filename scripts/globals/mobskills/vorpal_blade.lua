---------------------------------------------
-- Vorpal Blade
--
-- Description: Delivers a four-hit attack. Chance of critical varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: Shadow per hit
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    -- Check for Grah Family id 122, 123, 124, if not in Paladin form, then ignore.
    if ((mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) and mob:AnimationSub() ~= 1) then
        return 1
	end
    if (mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) then -- Ghrah
        if mob:AnimationSub() == 1 then
            return 0
        end
    end
    -- Check for the mamool ja family, if the mob is not a BLU, then ignore 
    if
        mob:getFamily() == 176 and
        mob:getMainJob() == tpz.job.BLU and
        mob:AnimationSub() == 0
    or
        mob:getFamily() == 176 and
        mob:getMainJob() == tpz.job.BLU and
        mob:AnimationSub() > 1
    then
        return 0
    end
	-- Raubahn Mythic Fight
	if mob:getFamily() == 919 and mob:getMainJob() == tpz.job.BLU then
        if mob:AnimationSub() == 0 or mob:AnimationSub() > 1 then
		    return 0
        end
    end
    -- BLU AF Fight
    if mob:getPool() == 1776 or mob:getPool() == 4468 then
        return 0
    end
	
    return 1
end


function onMobWeaponSkill(target, mob, skill)
    if (mob:getPool() == 4249) then -- Volker@Throne_Room only
        target:showText(mob, zones[tpz.zone.THRONE_ROOM].text.BLADE_ANSWER)
    end

    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.35
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys, 1.3, 1.5)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
  	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
