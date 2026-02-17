-----------------------------------
-- Area: Promyvion-Holla
--  MOB: Cerebrator
-----------------------------------
require("scripts/globals/promyvion")
mixins = {require("scripts/mixins/families/empty")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.REGAIN, 10)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    tpz.promyvion.setEmptyModel(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.promyvion.onEmptyDeath(mob)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end