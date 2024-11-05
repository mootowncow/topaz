-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Tsetse Fly
-- Note: JP camp
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 100)
end

function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

