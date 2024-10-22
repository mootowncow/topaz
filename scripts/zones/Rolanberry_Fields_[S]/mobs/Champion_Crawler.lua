-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Champion Crawler
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 100)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
