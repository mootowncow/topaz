-----------------------------------
-- Area: Sea Serpent Grotto (176)
--  Mob: Devil Manta
-- Note: Place holder Charybdis
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 810, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CHARYBDIS_PH, 30, math.random(28800, 43200)) -- 8 - 12 hours
end
