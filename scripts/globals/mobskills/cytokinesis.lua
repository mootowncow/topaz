---------------------------------------------
-- Cytokinesis
-- 20 yalm AOE Physical Damage
-- Additional effect: Causes severe knockback and gravity to anyone within a 20 yalm radius.
-- Calls forth reinforcements.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/world")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local typeEffect = tpz.effect.WEIGHT
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.2
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.2
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded*math.random(2, 3))
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 60)
    SpawnCytokinesisPets(mob, target, skill)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end

    return dmg
end

function SpawnCytokinesisPets(mob, target, skill)
    local zoneId = mob:getZoneID()
    local mobId = mob:getID()
    local weather = mob:getWeather()

    if zones[zoneId].pet and zones[zoneId].pet[mobId] then
        local petIds = zones[zoneId].pet[mobId]
        for i, petId in ipairs(petIds) do
            local pet = GetMobByID(petId)
            if pet and not pet:isSpawned() then
                pet:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(),  mob:getZPos() + math.random(1, 3))
                SpawnMob(pet:getID())
                -- Pets are not auto-engaged in rain weather
                if (weather ~= tpz.weather.RAIN and weather ~= tpz.weather.SQUALL) then
                    pet:updateEnmity(target)
                    pet:setMobMod(tpz.mobMod.ALLI_HATE, 30)
                end
            end
        end
    end
end