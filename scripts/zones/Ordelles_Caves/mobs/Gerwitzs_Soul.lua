-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Soul
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.REFRESH, 400)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
	mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end


function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 25, power = math.random(150, 200)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player:getCharVar("darkPuppetCS") >= 4 then
        player:setCharVar("darkPuppetCS", 5)
    end
end
