-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacle Teal
-- Pulling the Plug
-- !addkeyitem CENSER_OF_ACRIMONY
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/promyvion")
require("scripts/zones/Spire_of_Vahzl/globals")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setLocalVar("path", vahzl.PATH_RIGHT)
    mob:speed(0)
    tpz.promyvion.receptacleOnSpawn(mob)
end

function onMobFight(mob, target)
    if mob:getTP() > 0 then
        mob:setTP(0)
    end

    -- Paths between platforms every 30 second
    vahzl.StartPathing(mob)
    vahzl.StopPathing(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local Red = GetMobByID(mob:getID() - 3)
    local Add = GetMobByID(mob:getID()+1)
    Add:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
    Add:spawn()
    Add:updateEnmity(player)
    Red:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
end


