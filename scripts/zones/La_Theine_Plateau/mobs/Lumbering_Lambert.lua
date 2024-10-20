-----------------------------------
-- Area: La Theine Plateau
--  Mob: Lumbering Lambert
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 156)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BLOODTEAR_PH, 50, math.random(36000, 43200)) -- 21-24 hours
end
