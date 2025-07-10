-----------------------------------
-- Area: Sacrarium
--  Mob: Indich
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 50)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
end

function onMobDeath(mob, player, isKiller, noKiller)
end