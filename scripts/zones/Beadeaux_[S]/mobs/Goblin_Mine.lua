-- 250 fire damage
-- 15 yard radius on explosion-- MNK/MNK
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- Only kicks, always twice in a row, up to three times in a row
-- Can Guard
-- Uses Dragon Kick, Aegis schism, Barbed Crescent(all fomor moves?). Greatly favors Dragon Kick.
-- Used 100 fists at 55% HP.
-----------------------------------
-- Area: Beadeaux [S]
--   Goblin Mine
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    mob:SetAutoAttackEnabled(false)
end

function onMobRoam(mob)
    local nearbyEntityCheck = mob:getLocalVar("nearbyEntityCheck")
    if os.time() >= nearbyEntityCheck then
        mob:setLocalVar("nearbyEntityCheck", os.time() + 3)
        local NearbyEntities = mob:getNearbyEntities(5)
        if NearbyEntities == nil then return end
        if NearbyEntities then
            for _,entity in pairs(NearbyEntities) do
                if (entity:getAllegiance() ~= mob:getAllegiance()) then
	                mob:useMobAbility(2366, entity) -- mine_blast
                end
            end
        end
    end
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
	                mob:useMobAbility(2366, entity) -- mine_blast
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
