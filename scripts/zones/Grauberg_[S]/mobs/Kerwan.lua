-----------------------------------
-- Area: Grauberg [S]
--  Mob: Kerwan
-- F-12 in Cave entrance @ G-12
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/moblinmazemongers")
-----------------------------------
local auraParams1 = {
    radius = 10,
    effect = tpz.effect.GEO_PARALYSIS,
    power = 25,
    duration = 45,
    auraNumber = 1
}

local auraParams2 = {
    radius = 10,
    effect = tpz.effect.AMNESIA,
    power = 1,
    duration = 45,
    auraNumber = 2
}

local auraParams3 = {
    radius = 10,
    effect = tpz.effect.MUTE,
    power = 1,
    duration = 45,
    auraNumber = 3
}

function onMobSpawn(mob)
    tpz.moblinmazemongers.MobMods(mob) 
    mob:setLocalVar("[rage]timer", 7200) -- 2 hrs
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 75},
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 50},
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 25},
        },
    })
end

function onMobRoam(mob)
    mob:setPos(-120.2638,9.7138,-497.8309,5)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    TickMobAura(mob, target, auraParams1)
    TickMobAura(mob, target, auraParams2)
    TickMobAura(mob, target, auraParams3)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 685 then -- Sprout Spin
        AddMobAura(mob, target, auraParams1)
    elseif skill:getID() == 686 then -- Slumber Powder
        AddMobAura(mob, target, auraParams2)
    elseif skill:getID() == 687 then -- Sprout Smack
        AddMobAura(mob, target, auraParams3)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(3510, mob)-- Silver Mirror 
	end
    tpz.moblinmazemongers.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
