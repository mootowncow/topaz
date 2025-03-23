-----------------------------------
-- Area: Garlaige Citadel
--   NM: Chandelier
-- Note: Spawned for quest "Hitting the Marquisate"
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
	mob:setDamage(250) -- Pre-Berserk melee damage of 250-350 with critical hits of 500+ against level-75 DDs.
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:addMod(tpz.mod.ATTP, 200)
    mob:addMod(tpz.mod.ACC, 30) 
    mob:addMod(tpz.mod.EVA, 30)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobSpawn(mob)
    GetMobByID(ID.mob.CHANDELIER):setRespawnTime(0)
end

function onMobEngaged(mob, target)
    local ce = mob:getCE(target)
    local ve = mob:getVE(target)
    if (ce==0 and ve==0) then
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:useMobAbility(511) -- self-destruct
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    GetNPCByID(ID.npc.CHANDELIER_QM):setLocalVar("chandelierCooldown", os.time() + 600) -- 10 minute timeout
end
