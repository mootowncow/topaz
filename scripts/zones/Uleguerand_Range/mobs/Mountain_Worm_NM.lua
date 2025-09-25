-----------------------------------
-- Area: Uleguerand Range
--  Mob: Mountain Worm
-----------------------------------
mixins = {require("scripts/mixins/families/worm")}
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMod(tpz.mod.REGEN, 50)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:addMod(tpz.mod.SPELLINTERRUPT, 50)
    mob:addMod(tpz.mod.EEM_LIGHT_SLEEP, 20)
    mob:addMod(tpz.mod.EEM_DARK_SLEEP, 20)
	mob:addMod(tpz.mod.EEM_SILENCE, 5)
end

function onMobInitialize(mob)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end

function onMobDeath(mob, player, isKiller, noKiller)
end
