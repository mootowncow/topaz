-----------------------------------
-- Area: Crawlers Nest
--   NM: Dreadbug
-- Used in Quests: A Boy's Dream
-- !pos -18 -8 124 197
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
