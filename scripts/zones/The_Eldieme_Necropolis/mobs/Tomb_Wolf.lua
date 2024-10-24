-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Tomb Wolf
-- Note: PH for Cwn Cyrff
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 675, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CWN_CYRFF_PH, 30, math.random(3600, 14400)) -- 1-4 hours
end
