------------------------------
-- Area: Ifrits Cauldron
--   NM: Lindwurm
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------
function onMobSpawn(mob)
    mob:setDamage(90)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 30) 
    mob:setMod(tpz.mod.REGEN, 200)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
    mob:addImmunity(tpz.immunity.SLEEP)
end

function onMobFight(mob, target)
    if mob:checkDistance(mob:getSpawnPos()) > 30 then
        mob:setMod(tpz.mod.REGEN, 0)
    else
        mob:setMod(tpz.mod.REGEN, 200)
    end
end


function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 401)
end
