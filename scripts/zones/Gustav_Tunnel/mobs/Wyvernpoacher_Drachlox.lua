-----------------------------------
-- Area: Gustav Tunnel
--   NM: Wyvernpoacher Drachlox
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 20)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:addImmunity(tpz.immunity.STUN) 
    mob:addImmunity(tpz.immunity.LIGHTSLEEP) 
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 4300)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
