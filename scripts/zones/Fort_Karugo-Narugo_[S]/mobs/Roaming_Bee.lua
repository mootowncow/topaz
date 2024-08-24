-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   ANNM
--   Involved in: Amaranth
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
-----------------------------------
local flags = tpz.path.flag.NONE

function onMobSpawn(mob)
    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -75)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    local amaranth = GetMobByID(17170650)
    local pos = amaranth:getPos()
    if amaranth:isAlive() then
        mob:pathTo(pos.x, pos.y, pos.z)
    end
    target:setAllegiance(tpz.allegiance.MOB)
end

function onMobRoam(mob, target)
    local amaranth = GetMobByID(17170650)
    local pos = amaranth:getPos()
    if amaranth:isAlive() then
        mob:pathTo(pos.x, pos.y, pos.z)
    end
end

function onMobFight(mob, target)
    local Allegiance = mob:getAllegiance()
    local amaranth = GetMobByID(17170650)
    local pos = amaranth:getPos()
    if amaranth:isAlive() then
        mob:pathTo(pos.x, pos.y, pos.z)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local amaranth = GetMobByID(17170650)
    amaranth:setLocalVar("beeTimer", os.time() + 45)
end

function onMobDespawn(mob)
end
