------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------
function onMobSpawn(mob)
    mob:setDamage(125)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:addMod(tpz.mod.ACC, 50)
    mob:setMod(tpz.mod.REGAIN, 150)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 357)
end
