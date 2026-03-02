-----------------------------------
-- Area: Monarch Linn
--  Mob: Watch Hippogryph
-- Beloved of the Atlantes
-- Key item ID: 674
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/mobs")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MDEF, 100)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 23)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")
    local Guard = GetMobByID(mob:getID()+1)

    if mob:getHPP() <= 75 and hitTrigger == 0 and not Guard:isSpawned() then
        utils.spawnPetInBattle(mob, Guard, true)
        mob:setLocalVar("TriggerHit", 1)
        --printf("Spawning Guard Hippo #1");
    end
    if mob:getHPP() <= 50 and hitTrigger == 1 and not Guard:isSpawned() then 
        utils.spawnPetInBattle(mob, Guard, true)
        mob:setLocalVar("TriggerHit", 2)
        --printf("Spawning Guard Hippo #2");
    end
    if mob:getHPP() <= 25 and hitTrigger == 2 and not Guard:isSpawned() then
        utils.spawnPetInBattle(mob, Guard, true)
        mob:setLocalVar("TriggerHit", 3)
        --printf("Spawning Guard Hippo #3");
    end
end


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 25, duration = 5})
end

function onMobDeath(mob, player, isKiller, noKiller)
    DespawnMob(mob:getID()+1)
end