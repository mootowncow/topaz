------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Cheese Hoarder Gigiroon
-- Dropped by Cheese Hoarder when he runs around
------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------

function onMobSpawn(mob)
     mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
     mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
     mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
     mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
	 mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
     mob:setStatus(tpz.status.INVISIBLE)
	 mob:SetAutoAttackEnabled(false)
end

function onMobFight(mob, target)
    local nearbyEntityCheck = mob:getLocalVar("nearbyEntityCheck")
    if os.time() >= nearbyEntityCheck then
        mob:setLocalVar("nearbyEntityCheck", os.time() + 3)
        local NearbyEntities = mob:getNearbyEntities(5)
        if NearbyEntities == nil then return end
        if NearbyEntities then
            for _,entity in pairs(NearbyEntities) do
                if (entity:getAllegiance() ~= mob:getAllegiance()) then
                    mob:setStatus(tpz.status.UPDATE)
	                mob:useMobAbility(1838, entity) -- mine_blast
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
