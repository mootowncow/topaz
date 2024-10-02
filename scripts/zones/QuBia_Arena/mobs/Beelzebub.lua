-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Beelzebub 
-- BCNM: Infernal Swarm
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
     SetGenericNMStats(mob)
     mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
     mob:setMobMod(tpz.mobMod.HP_STANDBACK, 65)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
