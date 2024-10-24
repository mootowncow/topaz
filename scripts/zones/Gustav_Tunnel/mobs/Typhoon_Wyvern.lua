-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Typhoon Wyvern
-- Note: Place holder Ungur
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 769, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.UNGUR_PH, 30, 7200) -- 2 hours
end
