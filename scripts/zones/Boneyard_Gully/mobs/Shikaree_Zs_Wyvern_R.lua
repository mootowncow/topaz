-----------------------------------
-- Area: Boneyard_Gully
-- Name: Shikaree Z's Wyvern
-- ENM: Requiem of Sin  
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 5)
    mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end