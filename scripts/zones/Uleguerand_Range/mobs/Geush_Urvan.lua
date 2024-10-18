-----------------------------------
-- Area: Uleguerand Range
--   NM: Frost Flambeau
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.ACC, 15) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMod(tpz.mod.REFRESH, 40)
    mob:setMod(tpz.mod.MOVE, 12)
    mob:SetMobSkillAttack(6079) -- Knockback on auto-attacks
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end
    

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

