-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Lesser Colibri
-- Note: Place holder Zoraal Ja's Pkuucha
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ZORAAL_JA_S_PKUUCHA_PH, 20, 7200) -- 2 hours
end
