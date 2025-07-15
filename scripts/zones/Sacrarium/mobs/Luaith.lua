-----------------------------------
-- Area: Sacrarium
--  Mob: Luaith
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.TRIPLE_ATTACK, 10)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
end

function onMobDeath(mob, player, isKiller, noKiller)
end