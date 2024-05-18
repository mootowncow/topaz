-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Maze Maker
-- Note: PH for Trembler Tabitha
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/worm")}
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 696, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TREMBLER_TABITHA_PH, 30, 3600) -- 1 hour
end
