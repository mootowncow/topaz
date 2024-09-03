-----------------------------------
-- Area: Oztroja
--  NM: Odontotyrannus
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end