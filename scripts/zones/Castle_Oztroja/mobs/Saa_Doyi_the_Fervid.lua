-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Saa Doyi the Fervid
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    tpz.hunts.checkHunt(mob, player, 304)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end
