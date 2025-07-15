-----------------------------------
-- Area: Riverne - Site B01
--  Mob: Imdugud
-- !pos 655.263 20.664 651.320 29
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
