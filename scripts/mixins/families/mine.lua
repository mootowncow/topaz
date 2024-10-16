require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}


g_mixins.families.mine = function(mob)
    mob:addListener("SPAWN", "MINE_SPAWN", function(mob)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
        mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
        mob:setStatus(tpz.status.INVISIBLE)
        mob:SetAutoAttackEnabled(false)
        mob:hideName(true)
        mob:untargetable(true)
        mob:hideHP(true)
    end)

    mob:addListener("ROAM_TICK", "MINE_LAYER_RTICK", function(mob)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
        mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
        mob:setStatus(tpz.status.INVISIBLE)
        mob:SetAutoAttackEnabled(false)
        mob:hideName(true)
        mob:untargetable(true)
        mob:hideHP(true)

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
    end)


    mob:addListener("COMBAT_TICK", "MINE_CTICK", function(mob)
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
    end)
end

return g_mixins.families.mine