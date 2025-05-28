---------------------------------------------
--  Nocturnal Combustion
--
--  Description: Self-destructs, releasing dark energy at nearby targets.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 20'  radial
--  Notes: Damage is based on remaining HP and time of day (more damaging near midnight). The djinn will not use this until it has been affected by the current day's element.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:isNM() then
        return 1
    end
    mob:setLocalVar("self-destruct_hp", mob:getHP())
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- Deals 8-20% of mobs remaining HP based on time of day
    local hpPercent = 0.30
	local GameTime = VanadielHour()
	if GameTime <= 3 then
		hpPercent = 0.30
	elseif GameTime <= 6 then
		hpPercent = 0.28
	elseif GameTime <= 9 then
		hpPercent = 0.25
	elseif GameTime <= 12 then
		hpPercent = 0.22
	elseif GameTime > 12 then
		hpPercent = 0.20
	elseif GameTime >= 15 then
		hpPercent = 0.18
	elseif GameTime >= 18 then
		hpPercent = 0.25
	elseif GameTime >= 21 then
		hpPercent = 0.28
	elseif GameTime == 0 then
		hpPercent = 0.30
	end
	
    local damage = MobHPBasedMove(mob, target, hpPercent, 1, tpz.magic.ele.DARK, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    mob:setHP(0)
    return dmg
end
