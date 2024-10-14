-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacle Green
-- Pulling the Plug
-- !addkeyitem CENSER_OF_ACRIMONY
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.DONT_FOLLOW_TARGET, 1)
    mob:SetAutoAttackEnabled(false)
    mob:speed(0)
end

function onMobFight(mob, target)
    local rotationTimer = mob:getLocalVar("rotationTimer")
    if mob:getTP() > 0 then
        mob:setTP(0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local Red = GetMobByID(mob:getID() - 2)
    local Add = GetMobByID(mob:getID()+3)
    Add:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
    Add:spawn()
    Add:updateEnmity(player)
    Red:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
end
