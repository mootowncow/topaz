-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Spade
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    player:addTitle(tpz.title.NIGHTMARE_AWAKENER)
end
