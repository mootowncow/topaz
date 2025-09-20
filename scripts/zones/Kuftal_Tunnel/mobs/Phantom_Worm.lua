-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Morion Worm
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 1800)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:addMod(tpz.mod.SPELLINTERRUPT, 50)
    mob:addMod(tpz.mod.EEM_LIGHT_SLEEP, 20)
    mob:addMod(tpz.mod.EEM_DARK_SLEEP, 20)
	mob:addMod(tpz.mod.EEM_SILENCE, 5)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
