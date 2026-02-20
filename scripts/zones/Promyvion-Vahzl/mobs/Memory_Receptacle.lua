-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
end
function onMobSpawn(mob)
    tpz.promyvion.receptacleOnSpawn(mob)
end

function onMobFight(mob, target)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    tpz.promyvion.receptacleOnFight(mob, target)
end


function onMobDeath(mob, player, isKiller, noKiller)
    tpz.promyvion.receptacleOnDeath(mob, isKiller)
end
