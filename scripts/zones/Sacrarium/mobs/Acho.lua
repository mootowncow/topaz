-----------------------------------
-- Area: Sacrarium
--   NM: Acho
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobRoam(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
