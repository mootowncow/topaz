-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Foreseer Oramix
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(110)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 50)
    mob:addMod(tpz.mod.REGEN, 100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.STUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 399)
end
